import 'package:flutter/material.dart';
import 'package:fuji_maintenance_system/core/helper/context_notification_extension.dart';
import 'package:fuji_maintenance_system/core/routing/routes.dart';
import 'package:fuji_maintenance_system/core/service/location_service.dart';
import 'package:fuji_maintenance_system/core/theme/app_color.dart';
import 'package:fuji_maintenance_system/core/translation/app_strings.dart';
import 'package:fuji_maintenance_system/core/widgets/custom_text_bottom.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/home/data/models/contract_details_model/contract_details_model.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/home/presentation/widgets/labeled_value_field.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class ContractDetailsSheet extends StatefulWidget {
  const ContractDetailsSheet({super.key, required this.contractDetailsModel});
  final ContractDetailsModel contractDetailsModel;

  @override
  State<ContractDetailsSheet> createState() => _ContractDetailsSheetState();
}

class _ContractDetailsSheetState extends State<ContractDetailsSheet> {
  bool _isAtLocation = false;
  bool _isCheckingLocation = true;

  @override
  void initState() {
    super.initState();
    _checkLocation();
  }

  Future<void> _checkLocation() async {
    if (widget.contractDetailsModel.latitude == null ||
        widget.contractDetailsModel.longitude == null) {
      setState(() {
        _isAtLocation = true;
        _isCheckingLocation = false;
      });
      return;
    }

    final currentPosition = await LocationService.getCurrentLocation();
    if (currentPosition != null) {
      final contractLat = double.tryParse(
        widget.contractDetailsModel.latitude!,
      );
      final contractLng = double.tryParse(
        widget.contractDetailsModel.longitude!,
      );

      if (contractLat == null || contractLng == null) {
        setState(() {
          _isAtLocation = true;
          _isCheckingLocation = false;
        });
        return;
      }

      final distance = Geolocator.distanceBetween(
        currentPosition.latitude,
        currentPosition.longitude,
        contractLat,
        contractLng,
      );

      setState(() {
        _isAtLocation = distance <= 50;
        _isCheckingLocation = false;
      });
    } else {
      setState(() {
        _isAtLocation = false;
        _isCheckingLocation = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LabeledValueField(
            title: AppStrings.client.tr,
            value: widget.contractDetailsModel.client?.name ?? '',
          ),
          LabeledValueField(
            title: AppStrings.phone.tr,
            value: widget.contractDetailsModel.client?.phone ?? '',
          ),
          LabeledValueField(
            title: AppStrings.contractNumber.tr,
            value: widget.contractDetailsModel.contractNumber ?? '',
          ),
          LabeledValueField(
            title: AppStrings.address.tr,
            value: widget.contractDetailsModel.location ?? '',
          ),
          LabeledValueField(
            title: AppStrings.maintenanceType.tr,
            value: widget.contractDetailsModel.contractSection?.nameEn ?? '',
          ),
          LabeledValueField(
            title: AppStrings.maintenanceContract.tr,
            value: widget.contractDetailsModel.contractDuration?.nameEn ?? '',
          ),
          Row(
            children: [
              Expanded(
                child: LabeledValueField(
                  icon: Icons.date_range,
                  title: AppStrings.startDate.tr,
                  value:
                      "${widget.contractDetailsModel.startDate!.day}/ ${widget.contractDetailsModel.startDate!.month}/ ${widget.contractDetailsModel.startDate!.year}",
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: LabeledValueField(
                  icon: Icons.date_range,
                  title: AppStrings.endDate.tr,
                  value:
                      "${widget.contractDetailsModel.endDate!.day}/ ${widget.contractDetailsModel.endDate!.month}/ ${widget.contractDetailsModel.endDate!.year}",
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child:
                    _isCheckingLocation
                        ? CustomTextBottom(
                          text: AppStrings.newReport.tr,
                          backgroundColor: AppColor.disabled,
                          textColor: AppColor.white,
                          onPressed: () {},
                        )
                        : CustomTextBottom(
                          text: AppStrings.newReport.tr,
                          backgroundColor:
                              _isAtLocation
                                  ? AppColor.black
                                  : AppColor.disabled,
                          textColor: AppColor.white,
                          onPressed:
                              _isAtLocation
                                  ? () {
                                    context.push(
                                      Routes.maintenanceType,
                                      extra: widget.contractDetailsModel.id,
                                    );
                                  }
                                  : () {
                                    context.showError(
                                      AppStrings.notAtLocation.tr,
                                    );
                                  },
                        ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: CustomTextBottom(
                  text: AppStrings.historyReports.tr,
                  backgroundColor: AppColor.primary,
                  textColor: AppColor.white,
                  onPressed: () {
                    context.push(
                      Routes.reportTechnicalScreen,
                      extra: widget.contractDetailsModel.id,
                    );
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
