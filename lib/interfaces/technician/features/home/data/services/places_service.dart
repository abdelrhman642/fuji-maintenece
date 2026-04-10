import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

/// Service for interacting with Google Places API
/// Provides functionality to search for places and regions
class PlacesService {
  static final Logger _logger = Logger();

  /// Search for places using Google Places Autocomplete API
  /// Returns a list of place predictions
  static Future<List<PlacePrediction>> searchPlaces(String query) async {
    try {
      final apiKey = dotenv.env['GOOGLE_MAPS_API_KEY'] ?? '';

      if (apiKey.isEmpty) {
        _logger.w('Google Maps API key is not configured');
        return [];
      }

      final String url =
          'https://maps.googleapis.com/maps/api/place/autocomplete/json?'
          'input=${Uri.encodeComponent(query)}&'
          'key=$apiKey&'
          'types=geocode';

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['status'] == 'OK' && data['predictions'] != null) {
          final List<dynamic> predictions = data['predictions'];
          return predictions
              .map((prediction) => PlacePrediction.fromJson(prediction))
              .toList();
        } else if (data['status'] == 'ZERO_RESULTS') {
          return [];
        } else {
          _logger.w('Places API error: ${data['status']}');
          return [];
        }
      }
      return [];
    } catch (e) {
      _logger.e('Error searching places: $e');
      return [];
    }
  }

  /// Get place details including coordinates
  /// Returns the location (LatLng) of the place
  static Future<LatLng?> getPlaceDetails(String placeId) async {
    try {
      final apiKey = dotenv.env['GOOGLE_MAPS_API_KEY'] ?? '';

      if (apiKey.isEmpty) {
        _logger.w('Google Maps API key is not configured');
        return null;
      }

      final String url =
          'https://maps.googleapis.com/maps/api/place/details/json?'
          'place_id=$placeId&'
          'fields=geometry&'
          'key=$apiKey';

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['status'] == 'OK' && data['result'] != null) {
          final result = data['result'];
          final geometry = result['geometry'];
          final location = geometry['location'];

          final lat = location['lat'] as double?;
          final lng = location['lng'] as double?;

          if (lat != null && lng != null) {
            return LatLng(lat, lng);
          }
        }
      }
      return null;
    } catch (e) {
      _logger.e('Error getting place details: $e');
      return null;
    }
  }
}

/// Model representing a place prediction from Google Places API
class PlacePrediction {
  final String placeId;
  final String description;
  final String mainText;
  final String secondaryText;

  PlacePrediction({
    required this.placeId,
    required this.description,
    required this.mainText,
    required this.secondaryText,
  });

  factory PlacePrediction.fromJson(Map<String, dynamic> json) {
    final structuredFormatting = json['structured_formatting'] ?? {};
    return PlacePrediction(
      placeId: json['place_id'] ?? '',
      description: json['description'] ?? '',
      mainText: structuredFormatting['main_text'] ?? '',
      secondaryText: structuredFormatting['secondary_text'] ?? '',
    );
  }
}
