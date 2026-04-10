import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fuji_maintenance_system/core/translation/app_strings.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/home/data/services/places_service.dart';

class PickLocationScreen extends StatefulWidget {
  const PickLocationScreen({super.key, this.initialLocation});
  final LatLng? initialLocation;

  @override
  State<PickLocationScreen> createState() => _PickLocationScreenState();
}

class _PickLocationScreenState extends State<PickLocationScreen> {
  GoogleMapController? _mapController;
  LatLng? _currentPosition;
  LatLng? _pickedPosition;
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  List<PlacePrediction> _placePredictions = [];
  bool _showPlaceSuggestions = false;
  bool _isSearchingPlaces = false;
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    if (widget.initialLocation != null) {
      _currentPosition = widget.initialLocation;
      _pickedPosition = widget.initialLocation;
    } else {
      _getCurrentLocation();
    }
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  Future<void> _getCurrentLocation() async {
    if (widget.initialLocation != null) return;
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      final shouldOpen = await showDialog<bool>(
        context: context,
        builder:
            (context) => AlertDialog(
              icon: Icon(
                Icons.location_disabled,
                size: 100,
                color: Theme.of(context).colorScheme.error,
              ),
              title: Text(AppStrings.enableLocation.tr),
              content: Text(AppStrings.locationServicesDisabled.tr),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(AppStrings.cancel.tr),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text(AppStrings.openSettings.tr),
                ),
              ],
            ),
      );

      if (shouldOpen == true) {
        await Geolocator.openLocationSettings();
        serviceEnabled = await Geolocator.isLocationServiceEnabled();
        if (!serviceEnabled) return;
      }
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.deniedForever) return;

    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
      _pickedPosition = _currentPosition;
    });

    _mapController?.animateCamera(CameraUpdate.newLatLng(_pickedPosition!));
  }

  void _onMapTapped(LatLng position) {
    setState(() {
      _pickedPosition = position;
      _showPlaceSuggestions = false;
    });
    _searchFocusNode.unfocus();
  }

  void _onSearchChanged() {
    final value = _searchController.text.trim();

    // Cancel previous debounce timer
    _debounceTimer?.cancel();

    if (value.isEmpty) {
      setState(() {
        _placePredictions = [];
        _showPlaceSuggestions = false;
        _isSearchingPlaces = false;
      });
      return;
    }

    // Debounce place search to avoid too many API calls
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      _searchPlaces(value);
    });
  }

  Future<void> _searchPlaces(String query) async {
    if (query.isEmpty) {
      setState(() {
        _placePredictions = [];
        _showPlaceSuggestions = false;
        _isSearchingPlaces = false;
      });
      return;
    }

    setState(() {
      _isSearchingPlaces = true;
      _showPlaceSuggestions = true;
    });

    try {
      final predictions = await PlacesService.searchPlaces(query);
      if (mounted) {
        setState(() {
          _placePredictions = predictions;
          _isSearchingPlaces = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isSearchingPlaces = false;
        });
      }
    }
  }

  Future<void> _onPlaceSelected(PlacePrediction prediction) async {
    setState(() {
      _showPlaceSuggestions = false;
      _searchController.text = prediction.description;
      _searchFocusNode.unfocus();
    });

    try {
      final location = await PlacesService.getPlaceDetails(prediction.placeId);
      if (location != null && _mapController != null) {
        setState(() {
          _pickedPosition = location;
        });
        _mapController!.animateCamera(CameraUpdate.newLatLngZoom(location, 15));
      }
    } catch (e) {
      // Handle error
    }
  }

  void _onSave() {
    if (_pickedPosition != null) {
      Navigator.pop(context, _pickedPosition);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.pickLocation.tr),
        actions: [
          TextButton(
            onPressed: _onSave,
            child: Text(
              AppStrings.save.tr,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (controller) => _mapController = controller,
            initialCameraPosition: CameraPosition(
              target:
                  widget.initialLocation ??
                  _pickedPosition ??
                  const LatLng(0, 0),
              zoom: 15,
            ),
            markers:
                _pickedPosition == null
                    ? {}
                    : {
                      Marker(
                        markerId: const MarkerId('picked'),
                        position: _pickedPosition!,
                      ),
                    },
            onTap: _onMapTapped,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
          ),
          // Search Bar
          Positioned(
            top: 16,
            left: 16,
            right: 16,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                focusNode: _searchFocusNode,
                decoration: InputDecoration(
                  hintText: AppStrings.search.tr,
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon:
                      _isSearchingPlaces
                          ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: Padding(
                              padding: EdgeInsets.all(12.0),
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          )
                          : _searchController.text.isNotEmpty
                          ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _searchController.clear();
                              setState(() {
                                _showPlaceSuggestions = false;
                              });
                            },
                          )
                          : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
                onTap: () {
                  if (_placePredictions.isNotEmpty) {
                    setState(() {
                      _showPlaceSuggestions = true;
                    });
                  }
                },
              ),
            ),
          ),
          // Place suggestions overlay
          if (_showPlaceSuggestions && _placePredictions.isNotEmpty)
            Positioned(
              top: 80,
              left: 16,
              right: 16,
              child: Container(
                constraints: const BoxConstraints(maxHeight: 300),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _placePredictions.length,
                  itemBuilder: (context, index) {
                    final prediction = _placePredictions[index];
                    return ListTile(
                      leading: const Icon(Icons.place),
                      title: Text(prediction.mainText),
                      subtitle: Text(prediction.secondaryText),
                      onTap: () => _onPlaceSelected(prediction),
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}
