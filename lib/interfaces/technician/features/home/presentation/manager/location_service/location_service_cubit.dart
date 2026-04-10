import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fuji_maintenance_system/core/service/location_service.dart';
import 'package:geolocator/geolocator.dart';

part 'location_service_state.dart';

class LocationServiceCubit extends Cubit<LocationServiceState> {
  LocationServiceCubit() : super(LocationServiceInitial());

  StreamSubscription<Position>? _locationSubscription;

  /// Initialize: checks service + permission and starts location updates when possible.
  Future<void> initialize() async {
    emit(LocationServiceLoading());
    try {
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        emit(LocationServiceLocationDisabled());
        return;
      }

      final permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        emit(const LocationServicePermissionDenied(permanentlyDenied: false));
        return;
      }
      if (permission == LocationPermission.deniedForever) {
        emit(const LocationServicePermissionDenied(permanentlyDenied: true));
        return;
      }

      final pos = await LocationService.getCurrentLocation();
      if (pos == null) {
        emit(const LocationServiceError('Unable to obtain current location'));
        return;
      }

      emit(LocationServicePermissionGranted(pos));

      // start listening for updates
      _locationSubscription?.cancel();
      _locationSubscription = LocationService.getLocationStream().listen((
        position,
      ) {
        emit(LocationServiceLocationUpdated(position));
      });
    } catch (e) {
      emit(LocationServiceError(e.toString()));
    }
  }

  Future<void> requestPermission() async {
    emit(LocationServiceLoading());
    try {
      final permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        emit(const LocationServicePermissionDenied(permanentlyDenied: false));
        return;
      }
      if (permission == LocationPermission.deniedForever) {
        emit(const LocationServicePermissionDenied(permanentlyDenied: true));
        final opened = await Geolocator.openAppSettings();
        if (opened) {
          await initialize();
        }
        return;
      }

      // permissions granted — reinitialize to fetch position + start tracking
      await initialize();
    } catch (e) {
      emit(LocationServiceError(e.toString()));
    }
  }

  Future<void> openLocationSettingsAndRefresh() async {
    final opened = await Geolocator.openLocationSettings();
    if (opened) {
      await initialize();
    } else {
      emit(LocationServiceLocationDisabled());
    }
  }

  Future<void> retry() async => initialize();

  @override
  Future<void> close() {
    _locationSubscription?.cancel();
    return super.close();
  }
}
