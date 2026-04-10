import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuji_maintenance_system/core/theme/app_font.dart';
import 'package:fuji_maintenance_system/core/translation/app_strings.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/location%20update%20requests/data/models/location_update_request_model/location_update_request_model.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/location%20update%20requests/presentation/cubit/location_update_requests_cubit.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationUpdateCard extends StatelessWidget {
  const LocationUpdateCard({super.key, required this.model});
  final LocationUpdateRequestModel model;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.only(bottom: 12, left: 20, right: 20),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: AppColor.blackColor.withOpacity(.08)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    AppStrings.requestToEditContractLocationOnMap.tr,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                    ),
                  ),
                ),
                SizedBox(width: 12),
                IdChip(text: model.id.toString()),
              ],
            ),
            SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: Text(
                    "${AppStrings.clientName.tr}: ${model.client?.name ?? ''}",
                    style: AppFont.font16W700Black,
                  ),
                ),

                Expanded(
                  child: TextButton.icon(
                    onPressed: () {
                      _showLocationOnMapDialog(
                        context,
                        model.requestedLatitude ?? '',
                        model.requestedLongitude ?? '',
                      );
                    },
                    icon: Icon(Icons.location_on_rounded),
                    label: Text(AppStrings.locationOnMap.tr),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () async {
                      final reason = await showTextInputDialog(
                        context,
                        title: AppStrings.acceptLocationUpdateReason.tr,
                        hint: AppStrings.enterReason.tr,
                      );
                      if (context.mounted && reason != null) {
                        context
                            .read<LocationUpdateRequestsCubit>()
                            .approveRequest(model.id!, reason);
                      }
                    },
                    style: TextButton.styleFrom(
                      iconColor: AppColor.background,
                      backgroundColor: AppColor.primaryDark,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      AppStrings.accept.tr,
                      style: TextStyle(
                        color: AppColor.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: TextButton(
                    onPressed: () async {
                      final reason = await showTextInputDialog(
                        context,
                        title: AppStrings.rejectLocationUpdateReason.tr,
                        hint: AppStrings.enterReason.tr,
                      );
                      if (context.mounted && reason != null) {
                        context
                            .read<LocationUpdateRequestsCubit>()
                            .rejectRequest(model.id!, reason);
                      }
                    },
                    style: TextButton.styleFrom(
                      side: BorderSide(color: AppColor.primary),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      AppStrings.reject.tr,
                      style: TextStyle(
                        color: AppColor.blackColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> _showLocationOnMapDialog(
    BuildContext context,
    String lat,
    String lng,
  ) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(child: Text(AppStrings.locationOnMap.tr)),
          titleTextStyle: AppFont.font20W700Black,
          content: GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(double.parse(lat), double.parse(lng)),
              zoom: 15,
            ),
            markers: {
              Marker(
                markerId: const MarkerId('picked'),
                position: LatLng(double.parse(lat), double.parse(lng)),
              ),
            },
          ),
          actions: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(AppStrings.close.tr),
              ),
            ),
          ],
        );
      },
    );
  }
}

class IdChip extends StatelessWidget {
  const IdChip({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColor.primaryLight.withOpacity(0.1),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Text(
        "#$text",
        style: TextStyle(
          color: AppColor.primaryLight,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

Future<String?> showTextInputDialog(
  BuildContext context, {
  required String title,
  String? hint,
  String emptyError = 'من فضلك ادخل قيمة صحيحة',
}) {
  final controller = TextEditingController();
  final formKey = GlobalKey<FormState>();

  return showDialog<String>(
    context: context,
    barrierDismissible: false,
    builder:
        (ctx) => AlertDialog(
          title: Text(title),
          content: Form(
            key: formKey,
            child: TextFormField(
              controller: controller,
              autofocus: true,
              decoration: InputDecoration(hintText: hint),
              validator: (v) {
                if (v == null || v.trim().isEmpty) return emptyError;
                return null;
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(null),
              child: Text(AppStrings.cancel.tr),
            ),
            TextButton(
              onPressed: () {
                if (formKey.currentState?.validate() ?? false) {
                  Navigator.of(ctx).pop(controller.text.trim());
                }
              },
              child: Text(AppStrings.submit.tr),
            ),
          ],
        ),
  );
}
