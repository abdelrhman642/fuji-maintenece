import 'package:flutter/material.dart';

import '../../../../../core/theme/app_color.dart';

/// Location picker bottom sheet with map placeholder
class LocationPickerBottomSheet extends StatefulWidget {
  final String currentLocation;
  final String currentLongitude;
  final String currentLatitude;
  final Function(String location, double longitude, double latitude)
  onLocationSelected;

  const LocationPickerBottomSheet({
    super.key,
    required this.currentLocation,
    required this.currentLongitude,
    required this.currentLatitude,
    required this.onLocationSelected,
  });

  @override
  State<LocationPickerBottomSheet> createState() =>
      _LocationPickerBottomSheetState();
}

class _LocationPickerBottomSheetState extends State<LocationPickerBottomSheet> {
  late TextEditingController _searchController;
  String _selectedLocation = '';
  double _selectedLongitude = 0.0;
  double _selectedLatitude = 0.0;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _selectedLocation = widget.currentLocation;
    _selectedLongitude = double.tryParse(widget.currentLongitude) ?? 0.0;
    _selectedLatitude = double.tryParse(widget.currentLatitude) ?? 0.0;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: AppColor.grey3,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Text(
                  'Select Location',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColor.black,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: AppColor.grey2, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Search bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search for location...',
                prefixIcon: Icon(Icons.search, color: AppColor.primary),
                suffixIcon:
                    _searchController.text.isNotEmpty
                        ? IconButton(
                          icon: Icon(Icons.clear, color: AppColor.grey2),
                          onPressed: () {
                            _searchController.clear();
                            setState(() {});
                          },
                        )
                        : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColor.grey3, width: 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColor.grey3, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColor.primary, width: 2),
                ),
                filled: true,
                fillColor: AppColor.white,
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),

          const SizedBox(height: 16),

          // Map placeholder
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: AppColor.grey3.withOpacity(0.3),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColor.grey3, width: 1),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.map, size: 64, color: AppColor.primary),
                  const SizedBox(height: 16),
                  Text(
                    'Map View',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColor.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Interactive map will be implemented here',
                    style: TextStyle(fontSize: 14, color: AppColor.grey2),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: AppColor.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'TODO: Implement Google Maps integration',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColor.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Selected location info
          if (_selectedLocation.isNotEmpty)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColor.primaryLight.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColor.primaryLight, width: 1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: AppColor.primary,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Selected Location',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColor.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _selectedLocation,
                    style: TextStyle(fontSize: 14, color: AppColor.grey2),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Coordinates: ${_selectedLatitude.toStringAsFixed(6)}, ${_selectedLongitude.toStringAsFixed(6)}',
                    style: TextStyle(fontSize: 12, color: AppColor.grey2),
                  ),
                ],
              ),
            ),

          const SizedBox(height: 16),

          // Action buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: AppColor.grey3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: AppColor.grey2,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed:
                        _selectedLocation.isNotEmpty ? _confirmLocation : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.primary,
                      foregroundColor: AppColor.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      elevation: 0,
                    ),
                    child: Text(
                      'Confirm',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  void _confirmLocation() {
    widget.onLocationSelected(
      _selectedLocation,
      _selectedLongitude,
      _selectedLatitude,
    );
    Navigator.pop(context);
  }
}
