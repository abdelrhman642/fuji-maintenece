import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuji_maintenance_system/core/helper/context_notification_extension.dart';
import 'package:fuji_maintenance_system/core/models/client_model.dart';
import 'package:fuji_maintenance_system/core/routing/routes.dart';
import 'package:fuji_maintenance_system/core/theme/app_font.dart';
import 'package:fuji_maintenance_system/core/translation/app_strings.dart';
import 'package:fuji_maintenance_system/core/widgets/show_loading_dialog.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/customers/data/models/edit_client_location_request.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/customers/presentation/cubit/customers_cubit.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

showAndUpdateClientLocationDialog(
  BuildContext context,
  ClientModel client,
  CustomersCubit cubit,
) {
  final TextEditingController addressController = TextEditingController(
    text: client.location ?? '',
  );

  double? pickedLat =
      (client.latitude != null) ? double.tryParse(client.latitude!) : null;
  double? pickedLng =
      (client.longitude != null) ? double.tryParse(client.longitude!) : null;

  final dialogFuture = showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            icon: Icon(
              Icons.location_on,
              size: 100,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text(AppStrings.editLocation.tr),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Manual address input
                  TextField(
                    controller: addressController,
                    decoration: InputDecoration(
                      labelText: AppStrings.location.tr,
                    ),
                  ),
                  SizedBox(height: 12),
                  // lat / lng preview
                  IconTextWidget(
                    text:
                        '${AppStrings.location.tr}: ${addressController.text}',
                    icon: Icons.location_city,
                  ),
                  IconTextWidget(
                    text: 'latitude: ${pickedLat ?? "-"}',
                    icon: Icons.place,
                  ),
                  IconTextWidget(
                    text: 'longitude: ${pickedLng ?? "-"}',
                    icon: Icons.place,
                  ),
                  SizedBox(height: 8),
                  // Button to pick location on map
                  TextButton.icon(
                    onPressed: () {
                      final LatLng? extraLatLng =
                          (pickedLat != null && pickedLng != null)
                              ? LatLng(pickedLat!, pickedLng!)
                              : null;

                      context
                          .push(Routes.pickLocationScreen, extra: extraLatLng)
                          .then((pickedPosition) {
                            if (pickedPosition != null &&
                                pickedPosition is LatLng) {
                              setState(() {
                                pickedLat = pickedPosition.latitude;
                                pickedLng = pickedPosition.longitude;
                              });
                            }
                          });
                    },
                    icon: Icon(Icons.map),
                    label: Text(AppStrings.pickLocation.tr),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(AppStrings.cancel.tr),
              ),
              BlocListener<CustomersCubit, CustomersState>(
                bloc: cubit,
                listener: (context, state) {
                  if (state is ClientLocationUpdating) {
                    showLoadingDialog(context);
                  }
                  if (state is ClientLocationUpdated) {
                    Navigator.of(context).pop(); // Close loading dialog

                    Navigator.of(context).pop(); // Close the edit dialog
                  }
                  if (state is ClientLocationUpdateError) {
                    context.showError(state.message);
                  }
                },
                child: TextButton(
                  onPressed: () async {
                    // Build request with updated values
                    final request = EditClientLocationRequest(
                      clientId: client.id!,
                      latitude:
                          pickedLat ??
                          double.tryParse(client.latitude ?? '0') ??
                          0,
                      longitude:
                          pickedLng ??
                          double.tryParse(client.longitude ?? '0') ??
                          0,
                      location:
                          addressController.text.trim().isEmpty
                              ? client.location
                              : addressController.text.trim(),
                    );

                    await cubit.editClientLocation(request);
                  },
                  child: Text(AppStrings.save.tr),
                ),
              ),
            ],
          );
        },
      );
    },
  );

  dialogFuture.then((_) => addressController.dispose());
}

class IconTextWidget extends StatelessWidget {
  const IconTextWidget({super.key, required this.text, required this.icon});
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColor.primary),
        SizedBox(width: 8),
        Text(text),
      ],
    );
  }
}
