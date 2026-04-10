import 'package:flutter/material.dart';
import 'package:fuji_maintenance_system/core/theme/app_color.dart';
import 'package:fuji_maintenance_system/core/translation/app_strings.dart';
import 'package:fuji_maintenance_system/core/widgets/custom_text_field.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/cities_and_neighborhoods/data/models/cities_response_model/city_model.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/cities_and_neighborhoods/data/models/store_city_request_model.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

typedef CitySubmit = Future<void> Function(StoreCityRequestModel request);

typedef CityUpdateSubmit =
    Future<void> Function(int id, StoreCityRequestModel request);

Future<void> showCityFormBottomSheet({
  required BuildContext context,
  CityModel? initial,
  required CitySubmit onCreate,
  required CityUpdateSubmit onUpdate,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColor.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (ctx) {
      return _CityFormSheet(
        initial: initial,
        onCreate: onCreate,
        onUpdate: onUpdate,
      );
    },
  );
}

class _CityFormSheet extends StatefulWidget {
  const _CityFormSheet({
    required this.initial,
    required this.onCreate,
    required this.onUpdate,
  });

  final CityModel? initial;
  final CitySubmit onCreate;
  final CityUpdateSubmit onUpdate;

  @override
  State<_CityFormSheet> createState() => _CityFormSheetState();
}

class _CityFormSheetState extends State<_CityFormSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameArController;
  late final TextEditingController _nameEnController;

  @override
  void initState() {
    super.initState();
    _nameArController = TextEditingController(
      text: widget.initial?.nameAr ?? '',
    );
    _nameEnController = TextEditingController(
      text: widget.initial?.nameEn ?? '',
    );
  }

  @override
  void dispose() {
    _nameArController.dispose();
    _nameEnController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 12,
        bottom: 16 + bottomInset,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    widget.initial == null
                        ? AppStrings.addNew.tr
                        : AppStrings.edit.tr,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 12),
            CustomTextField(
              controller: _nameArController,
              labelText: 'اسم المدينة (عربي)',
              hintText: 'مثال: القاهرة',
            ),
            const SizedBox(height: 12),
            CustomTextField(
              controller: _nameEnController,
              labelText: 'City name (English)',
              hintText: 'Example: Cairo',
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                style: FilledButton.styleFrom(
                  backgroundColor: AppColor.primary,
                ),
                onPressed: () async {
                  if (!(_formKey.currentState?.validate() ?? false)) return;

                  final request = StoreCityRequestModel(
                    nameEn: _nameEnController.text.trim(),
                    nameAr: _nameArController.text.trim(),
                  );

                  if (widget.initial?.id != null) {
                    await widget.onUpdate(widget.initial!.id!, request);
                  } else {
                    await widget.onCreate(request);
                  }

                  if (context.mounted) Navigator.of(context).pop();
                },
                icon: const Icon(Icons.save),
                label: Text(AppStrings.save.tr),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
