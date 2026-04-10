# Map Implementation TODO

## Location Picker Map Integration

### Current Status
- ✅ UI for location picker is implemented
- ✅ Bottom sheet with search functionality
- ✅ Placeholder map view with TODO indicator
- ✅ Location selection flow
- ❌ **TODO: Google Maps integration**

### Required Implementation

#### 1. Add Google Maps Dependencies
```yaml
dependencies:
  google_maps_flutter: ^2.5.0
  google_maps_webservice: ^0.0.20-nullsafety.5
```

#### 2. API Key Setup
- Add Google Maps API key to `android/app/src/main/AndroidManifest.xml`
- Add Google Maps API key to `ios/Runner/AppDelegate.swift`

#### 3. Map Integration Features
- [ ] Interactive Google Maps view
- [ ] Current location detection
- [ ] Pin placement and dragging
- [ ] Location search with Google Places API
- [ ] Reverse geocoding for address display
- [ ] Coordinate extraction from pin position

#### 4. Implementation Steps

##### Step 1: Add Google Maps Widget
Replace the placeholder map in `LocationPickerBottomSheet` with:
```dart
GoogleMap(
  initialCameraPosition: CameraPosition(
    target: LatLng(_selectedLatitude, _selectedLongitude),
    zoom: 15,
  ),
  markers: Set<Marker>.from([
    Marker(
      markerId: MarkerId('selected_location'),
      position: LatLng(_selectedLatitude, _selectedLongitude),
      draggable: true,
      onDragEnd: (LatLng newPosition) {
        setState(() {
          _selectedLatitude = newPosition.latitude;
          _selectedLongitude = newPosition.longitude;
        });
        _reverseGeocode(newPosition);
      },
    ),
  ]),
  onTap: (LatLng position) {
    setState(() {
      _selectedLatitude = position.latitude;
      _selectedLongitude = position.longitude;
    });
    _reverseGeocode(position);
  },
)
```

##### Step 2: Add Location Services
```dart
import 'package:geolocator/geolocator.dart';

Future<void> _getCurrentLocation() async {
  Position position = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );
  
  setState(() {
    _selectedLatitude = position.latitude;
    _selectedLongitude = position.longitude;
  });
  
  _reverseGeocode(LatLng(position.latitude, position.longitude));
}
```

##### Step 3: Add Reverse Geocoding
```dart
import 'package:google_maps_webservice/geocoding.dart';

final geocoding = GoogleMapsGeocoding(apiKey: "YOUR_API_KEY");

Future<void> _reverseGeocode(LatLng position) async {
  GeocodingResponse response = await geocoding.searchByLocation(
    Location(position.latitude, position.longitude),
  );
  
  if (response.results.isNotEmpty) {
    setState(() {
      _selectedLocation = response.results.first.formattedAddress;
    });
  }
}
```

##### Step 4: Add Places Search
```dart
import 'package:google_maps_webservice/places.dart';

final places = GoogleMapsPlaces(apiKey: "YOUR_API_KEY");

Future<void> _searchPlaces(String query) async {
  PlacesSearchResponse response = await places.searchByText(query);
  
  // Update search results list
  // Handle place selection
}
```

### 5. Permissions Required

#### Android (`android/app/src/main/AndroidManifest.xml`)
```xml
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
<uses-permission android:name="android.permission.INTERNET" />
```

#### iOS (`ios/Runner/Info.plist`)
```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>This app needs access to location when open to show your current location on the map.</string>
<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
<string>This app needs access to location to show your current location on the map.</string>
```

### 6. Current UI Features Ready
- ✅ Search bar for location input
- ✅ Map placeholder with proper styling
- ✅ Selected location display with coordinates
- ✅ Confirm/Cancel buttons
- ✅ Responsive bottom sheet design
- ✅ Integration with edit profile form

### 7. Testing Checklist
- [ ] Map loads correctly
- [ ] Current location detection works
- [ ] Pin dragging updates coordinates
- [ ] Search functionality works
- [ ] Reverse geocoding displays correct address
- [ ] Location selection updates form fields
- [ ] Proper error handling for location services
- [ ] Works on both Android and iOS

### 8. Notes
- The current UI is fully functional and ready for map integration
- All form validation and data flow is already implemented
- Only the map widget needs to be replaced with Google Maps
- Consider adding loading states for async operations
- Add proper error handling for location permission denials
