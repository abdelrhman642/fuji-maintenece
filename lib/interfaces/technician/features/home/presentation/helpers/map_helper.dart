import 'package:fuji_maintenance_system/interfaces/technician/features/home/data/models/contract_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapHelper {
  static Marker createCurrentLocationMarker(Position position) {
    return Marker(
      markerId: MarkerId('current_location'),
      position: LatLng(position.latitude, position.longitude),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      infoWindow: InfoWindow(title: 'موقعي الحالي'),
    );
  }

  static Marker? createContractMarker(
    ContractModel contract,
    Function(ContractModel) onTap,
  ) {
    if (contract.latitude == null || contract.longitude == null) return null;

    double? lat = double.tryParse(contract.latitude!);
    double? lng = double.tryParse(contract.longitude!);

    if (lat == null || lng == null) return null;

    return Marker(
      markerId: MarkerId('contract_${contract.id}'),
      position: LatLng(lat, lng),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      infoWindow: InfoWindow(
        title: contract.contractNumber ?? 'عقد ${contract.id}',
        snippet: 'اضغط لعرض التفاصيل',
      ),
      onTap: () => onTap(contract),
    );
  }

  static Set<Marker> createAllMarkers(
    Position? currentPosition,
    List<ContractModel> contracts,
    Function(ContractModel) onContractTap,
  ) {
    Set<Marker> markers = {};

    if (currentPosition != null) {
      markers.add(createCurrentLocationMarker(currentPosition));
    }

    for (var contract in contracts) {
      final marker = createContractMarker(contract, onContractTap);
      if (marker != null) markers.add(marker);
    }

    return markers;
  }
}
