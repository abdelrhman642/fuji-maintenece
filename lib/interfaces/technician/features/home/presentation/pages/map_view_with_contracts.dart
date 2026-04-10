import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuji_maintenance_system/core/theme/app_color.dart';
import 'package:fuji_maintenance_system/core/translation/app_strings.dart';
import 'package:fuji_maintenance_system/core/widgets/show_loading_dialog.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/home/data/models/contract_model.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/home/data/services/directions_service.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/home/data/services/places_service.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/home/presentation/helpers/map_helper.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/home/presentation/manager/location_service/location_service_cubit.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/home/presentation/widgets/contract_details_bottom_sheet_body.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/home/presentation/widgets/contracts_counter_card.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logger/logger.dart';

class MapViewWithContracts extends StatefulWidget {
  const MapViewWithContracts({
    super.key,
    required this.contracts,
    this.onPermissionGranted,
  });

  final List<ContractModel> contracts;
  final Future<void> Function()? onPermissionGranted;

  @override
  State<MapViewWithContracts> createState() => _MapViewWithContractsState();
}

class _MapViewWithContractsState extends State<MapViewWithContracts> {
  GoogleMapController? mapController;
  Position? currentPosition;
  Set<Marker> markers = {};
  List<ContractModel> filteredContracts = [];
  TextEditingController searchController = TextEditingController();
  FocusNode searchFocusNode = FocusNode();
  Set<Polyline> polylines = {};

  // Place search state
  List<PlacePrediction> placePredictions = [];
  Timer? _debounceTimer;
  bool _isSearchingPlaces = false;
  bool _showPlaceSuggestions = false;
  final LayerLink _layerLink = LayerLink();
  static final Logger _logger = Logger();

  late final LocationServiceCubit _locationCubit;

  @override
  void initState() {
    super.initState();
    _locationCubit = LocationServiceCubit();
    _locationCubit.initialize();
    searchFocusNode.addListener(_onSearchFocusChanged);
  }

  void _onSearchFocusChanged() {
    if (!searchFocusNode.hasFocus) {
      // Hide suggestions when search field loses focus
      Future.delayed(const Duration(milliseconds: 200), () {
        if (mounted) {
          setState(() {
            _showPlaceSuggestions = false;
          });
        }
      });
    }
  }

  void setupMarkers([List<ContractModel>? contracts]) {
    final allMarkers = MapHelper.createAllMarkers(
      currentPosition,
      contracts ?? widget.contracts,
      showContractDetails,
    );
    setState(() => markers = allMarkers);
  }

  void _onSearchChanged(String value) {
    value = value.trim();

    // Cancel previous debounce timer
    _debounceTimer?.cancel();

    if (value.isEmpty) {
      filteredContracts = widget.contracts;
      setupMarkers();
      setState(() {
        placePredictions = [];
        _showPlaceSuggestions = false;
        _isSearchingPlaces = false;
      });
      return;
    }

    // Search contracts first (immediate)
    filteredContracts =
        widget.contracts.where((contract) {
          final contractNumber = contract.contractNumber?.toLowerCase() ?? '';
          final search = value.toLowerCase();
          return contractNumber.contains(search);
        }).toList();
    setupMarkers(filteredContracts);

    // Debounce place search to avoid too many API calls
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      _searchPlaces(value);
    });

    setState(() {});

    // Move camera to first contract result if exists
    if (filteredContracts.isNotEmpty && mapController != null) {
      final lat = double.tryParse(filteredContracts.first.latitude ?? '');
      final lng = double.tryParse(filteredContracts.first.longitude ?? '');
      if (lat != null && lng != null) {
        mapController!.animateCamera(CameraUpdate.newLatLng(LatLng(lat, lng)));
      }
    }
  }

  /// Search for places using Google Places API
  Future<void> _searchPlaces(String query) async {
    if (query.isEmpty) {
      setState(() {
        placePredictions = [];
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
          placePredictions = predictions;
          _isSearchingPlaces = false;
        });
      }
    } catch (e) {
      _logger.e('Error searching places: $e');
      if (mounted) {
        setState(() {
          _isSearchingPlaces = false;
        });
      }
    }
  }

  /// Handle place selection and move camera to the selected place
  Future<void> _onPlaceSelected(PlacePrediction prediction) async {
    setState(() {
      _showPlaceSuggestions = false;
      searchController.text = prediction.description;
      searchFocusNode.unfocus();
    });

    try {
      final location = await PlacesService.getPlaceDetails(prediction.placeId);
      if (location != null && mapController != null) {
        mapController!.animateCamera(CameraUpdate.newLatLngZoom(location, 12));
      }
    } catch (e) {
      _logger.e('Error getting place details: $e');
    }
  }

  void showContractDetails(ContractModel contract) {
    drawRouteToContract(contract);
    showModalBottomSheet(
      context: context,
      builder:
          (context) => SizedBox(
            height: MediaQuery.of(context).size.height * 0.65,
            child: ContractDetailsBottomSheetBody(contract: contract),
          ),
      isScrollControlled: true,
    );
  }

  Future<void> drawRouteToContract(ContractModel contract) async {
    if (currentPosition == null ||
        contract.latitude == null ||
        contract.longitude == null) {
      return;
    }

    double? lat = double.tryParse(contract.latitude!);
    double? lng = double.tryParse(contract.longitude!);

    if (lat == null || lng == null) return;

    final origin = LatLng(
      currentPosition!.latitude,
      currentPosition!.longitude,
    );
    final destination = LatLng(lat, lng);

    final routePoints = await DirectionsService.getDirections(
      origin: origin,
      destination: destination,
    );

    if (routePoints != null && routePoints.isNotEmpty) {
      final polyline = Polyline(
        polylineId: PolylineId('route_${contract.id}'),
        points: routePoints,
        color: Colors.red,
        width: 4,
      );

      setState(() {
        polylines.clear();
        polylines.add(polyline);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _locationCubit,
      child: BlocConsumer<LocationServiceCubit, LocationServiceState>(
        listener: (context, state) {
          if (state is LocationServicePermissionGranted) {
            currentPosition = state.position;
            setupMarkers();
            // inform parent to fetch contracts if provided
            widget.onPermissionGranted?.call();
          }

          if (state is LocationServiceLocationUpdated) {
            currentPosition = state.position;
            setupMarkers();
          }
        },
        builder: (context, state) {
          if (state is LocationServiceLoading) {
            return const CustomLoadingIndicator();
          }

          if (state is LocationServicePermissionDenied) {
            return LocationServicePermissionDeniedWidget(
              locationCubit: _locationCubit,
            );
          }

          if (state is LocationServiceLocationDisabled) {
            return LocationServiceLocationDisabledWidget(
              locationCubit: _locationCubit,
            );
          }

          if (state is LocationServiceError) {
            return LocationServiceErrorWidget(
              locationCubit: _locationCubit,
              message: state.message,
            );
          }

          // If we have a position (either initial granted or updated), show the map
          final pos = currentPosition;
          if (pos == null) {
            return const CustomLoadingIndicator();
          }

          return _buildMapView(pos);
        },
      ),
    );
  }

  Stack _buildMapView(Position pos) {
    List<ContractModel> contracts =
        filteredContracts.isNotEmpty || searchController.text.isNotEmpty
            ? filteredContracts
            : widget.contracts;

    return Stack(
      children: [
        GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(pos.latitude, pos.longitude),
            zoom: 12,
          ),
          markers: markers,
          polylines: polylines,
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
          onMapCreated: (controller) => mapController = controller,
        ),
        Positioned(
          top: 16,
          left: 16,
          right: 16,
          child: Column(
            children: [
              ContractsCounterCard(count: contracts.length),
              const SizedBox(height: 8),
              CompositedTransformTarget(
                link: _layerLink,
                child: TextField(
                  controller: searchController,
                  focusNode: searchFocusNode,
                  decoration: InputDecoration(
                    hintText: AppStrings.searchByContractOrCustomerOrArea.tr,
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon:
                        _isSearchingPlaces
                            ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: Padding(
                                padding: EdgeInsets.all(12.0),
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              ),
                            )
                            : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                  ),
                  onChanged: _onSearchChanged,
                  onTap: () {
                    if (placePredictions.isNotEmpty) {
                      setState(() {
                        _showPlaceSuggestions = true;
                      });
                    }
                  },
                ),
              ),
            ],
          ),
        ),
        // Place suggestions overlay
        if (_showPlaceSuggestions && placePredictions.isNotEmpty)
          Positioned(
            top: 120,
            left: 16,
            right: 16,
            child: CompositedTransformFollower(
              link: _layerLink,
              showWhenUnlinked: false,
              offset: const Offset(0, 48),
              child: Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  constraints: const BoxConstraints(maxHeight: 300),
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: placePredictions.length,
                    itemBuilder: (context, index) {
                      final prediction = placePredictions[index];
                      return ListTile(
                        leading: const Icon(Icons.location_on),
                        title: Text(
                          prediction.mainText,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          prediction.secondaryText,
                          style: TextStyle(fontSize: 12, color: AppColor.grey2),
                        ),
                        onTap: () => _onPlaceSelected(prediction),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        // Custom location button
        Positioned(
          bottom: 40.h,
          right: 40.w,
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
            child: InkWell(
              onTap: _moveToCurrentLocation,
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: Icon(
                  Icons.my_location,
                  color: AppColor.primary,
                  size: 24,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Move camera to current location
  Future<void> _moveToCurrentLocation() async {
    if (currentPosition != null && mapController != null) {
      await mapController!.animateCamera(
        CameraUpdate.newLatLngZoom(
          LatLng(currentPosition!.latitude, currentPosition!.longitude),
          15,
        ),
      );
    }
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    searchController.dispose();
    searchFocusNode.removeListener(_onSearchFocusChanged);
    searchFocusNode.dispose();
    mapController?.dispose();
    _locationCubit.close();
    super.dispose();
  }
}

class LocationServiceErrorWidget extends StatelessWidget {
  const LocationServiceErrorWidget({
    super.key,
    required LocationServiceCubit locationCubit,
    required this.message,
  }) : _locationCubit = locationCubit;

  final LocationServiceCubit _locationCubit;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64, color: AppColor.gray_3),
          const SizedBox(height: 16),
          Text(message),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () => _locationCubit.retry(),
            child: Text(AppStrings.retry.tr),
          ),
        ],
      ),
    );
  }
}

class LocationServiceLocationDisabledWidget extends StatelessWidget {
  const LocationServiceLocationDisabledWidget({
    super.key,
    required LocationServiceCubit locationCubit,
  }) : _locationCubit = locationCubit;

  final LocationServiceCubit _locationCubit;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.location_off, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          Text(AppStrings.locationServicesDisabled.tr),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () => _locationCubit.openLocationSettingsAndRefresh(),
            child: Text(AppStrings.openSettings.tr),
          ),
        ],
      ),
    );
  }
}

class LocationServicePermissionDeniedWidget extends StatelessWidget {
  const LocationServicePermissionDeniedWidget({
    super.key,
    required LocationServiceCubit locationCubit,
  }) : _locationCubit = locationCubit;

  final LocationServiceCubit _locationCubit;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.location_off, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          Text(AppStrings.cannotAccessLocation.tr),
          Text(AppStrings.enableLocationPermission.tr),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () => _locationCubit.requestPermission(),
            child: Text(AppStrings.retry.tr),
          ),
        ],
      ),
    );
  }
}
