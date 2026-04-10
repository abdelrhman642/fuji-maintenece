import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuji_maintenance_system/core/config/app_assets.dart';
import 'package:fuji_maintenance_system/core/helper/context_notification_extension.dart';
import 'package:fuji_maintenance_system/core/routing/routes.dart';
import 'package:fuji_maintenance_system/core/service/local_data_service/local_data_manager.dart';
import 'package:fuji_maintenance_system/core/service/local_data_service/local_data_manager_key.dart';
import 'package:fuji_maintenance_system/core/theme/app_color.dart';
import 'package:fuji_maintenance_system/core/translation/app_strings.dart';
import 'package:fuji_maintenance_system/core/widgets/custom_app_bar_widget.dart';
import 'package:fuji_maintenance_system/core/widgets/custom_text_field.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/new_report/malfunctionMaintenance/presentation/cubit/report_question_malfunction_cubit.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/new_report/malfunctionMaintenance/presentation/cubit/report_question_malfunction_state.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/new_report/model/store_report_request_model.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/new_report/views/widgets/custom_bottom.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class MalfunctionReportScreen extends StatefulWidget {
  const MalfunctionReportScreen({
    super.key,
    required this.storeReportRequestModel,
  });
  final StoreReportRequestModel storeReportRequestModel;

  @override
  State<MalfunctionReportScreen> createState() =>
      _MalfunctionReportScreenState();
}

class _MalfunctionReportScreenState extends State<MalfunctionReportScreen> {
  File? _imageFile;

  final ImagePicker _picker = ImagePicker();
  final TextEditingController _costController = TextEditingController();
  final TextEditingController _taxController = TextEditingController();
  final TextEditingController _totalController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  void initState() {
    _taxController.text =
        LocalDataManager.instance.getInt(LocalDataManagerKey.vat).toString();
    super.initState();
  }

  @override
  void dispose() {
    _costController.dispose();
    _taxController.dispose();
    _totalController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: CustomAppBarWidget(title: AppStrings.malfunctionReport.tr),
      body: BlocConsumer<
        ReportQuestionMalfunctionCubit,
        ReportQuestionMalfunctionState
      >(
        listener: _handleStateChanges,
        buildWhen:
            (previous, current) =>
                current is! ReportQuestionMalfunctionSubmitInProgress &&
                current is! ReportQuestionMalfunctionSubmitSuccess &&
                current is! ReportQuestionMalfunctionSubmitFailure,
        builder: (context, state) {
          return Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(16, 40, 16, 16),
                        padding: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: AppColor.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: AppColor.black.withOpacity(0.12),
                              blurRadius: 24,
                              offset: Offset(0, 12),
                            ),
                            BoxShadow(
                              color: AppColor.black.withOpacity(0.06),
                              blurRadius: 8,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 50),
                            Row(
                              textDirection: TextDirection.ltr,
                              children: [
                                Expanded(
                                  child: CustomTextField(
                                    controller: _costController,
                                    onChanged: (val) {
                                      final cost =
                                          int.tryParse(_costController.text) ??
                                          0;
                                      final tax =
                                          int.tryParse(_taxController.text) ??
                                          1;
                                      _totalController.text =
                                          (cost + (cost * tax * (1 / 100)))
                                              .toString();
                                      widget.storeReportRequestModel.price =
                                          num.tryParse(_totalController.text);
                                    },
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                        RegExp(r'^\d*\.?\d*$'),
                                      ),
                                    ],
                                    labelText: AppStrings.cost.tr,
                                    hintText: AppStrings.enterCost.tr,
                                    readOnly: false,
                                  ),
                                ),
                                SizedBox(width: 10),

                                SizedBox(
                                  width: 66,
                                  child: CustomTextField(
                                    controller: _taxController,
                                    readOnly: true,
                                    labelText: 'tax'.tr,
                                  ),
                                ),
                              ],
                            ),

                            CustomTextField(
                              controller: _totalController,
                              readOnly: true,
                              labelText: 'total'.tr,
                            ),

                            CustomTextField(
                              readOnly: true,
                              keyboardType: TextInputType.multiline,
                              controller: _notesController,
                              maxLines: 2,
                              labelText: 'notes'.tr,
                              hintText: 'enter_note'.tr,
                            ),
                            InkWell(
                              onTap: _pickImage,
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                width: double.infinity,
                                height: 200,
                                decoration: BoxDecoration(
                                  color: AppColor.white,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColor.black.withOpacity(0.1),
                                      blurRadius: 5,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child:
                                      _imageFile == null
                                          ? Center(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Image.asset(
                                                  AppAssets.addImage,
                                                  fit: BoxFit.contain,
                                                ),
                                                const SizedBox(height: 8),
                                                Text(
                                                  'press_to_add_image'.tr,
                                                  style: TextStyle(
                                                    color: AppColor.black
                                                        .withOpacity(0.6),
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                          : Image.file(
                                            _imageFile!,
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                            height: double.infinity,
                                          ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Positioned(
                        top: -30,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: ClipOval(
                            child: Container(
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColor.primaryDark,

                                  width: 1,
                                ),
                                color: AppColor.white,
                                shape: BoxShape.circle,
                              ),

                              child: Padding(
                                padding: EdgeInsets.all(20),
                                child: Image.asset(
                                  AppAssets.darkLogo,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  CustomBottom(
                    title: AppStrings.sent.tr,
                    backgroundColor: AppColor.primaryDark,
                    onPressed: () {
                      _submitReport();
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _submitReport() {
    context.read<ReportQuestionMalfunctionCubit>().submitReport(
      widget.storeReportRequestModel,
    );
  }

  void _handleStateChanges(
    BuildContext context,
    ReportQuestionMalfunctionState state,
  ) {
    if (state is ReportQuestionMalfunctionSubmitFailure) {
      context.showError(state.error);
    }
    if (state is ReportQuestionMalfunctionSubmitSuccess) {
      context.pushReplacement(
        Routes.sendReport,
        extra: state.submitReportModel,
      );
    }
    if (state is ReportQuestionMalfunctionSubmitInProgress) {}
  }
}
