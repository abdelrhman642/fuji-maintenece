import 'package:flutter/material.dart';
import 'package:fuji_maintenance_system/core/theme/app_color.dart';
import 'package:fuji_maintenance_system/core/translation/app_strings.dart';
import 'package:fuji_maintenance_system/core/widgets/custom_text_field.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/cities_and_neighborhoods/data/models/cities_response_model/city_model.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/cities_and_neighborhoods/data/models/neighborhood_response_model/neighborhood_model.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/cities_and_neighborhoods/data/models/store_neighborhood_request_model.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

typedef NeighborhoodSubmit =
    Future<void> Function(StoreNeighborhoodRequestModel request);

typedef NeighborhoodUpdateSubmit =
    Future<void> Function(int id, StoreNeighborhoodRequestModel request);

Future<void> showNeighborhoodFormBottomSheet({
  required BuildContext context,
  required List<CityModel> cities,
  NeighborhoodModel? initial,
  int? initialCityId,
  required NeighborhoodSubmit onCreate,
  required NeighborhoodUpdateSubmit onUpdate,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColor.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (ctx) {
      return _NeighborhoodFormSheet(
        cities: cities,
        initial: initial,
        initialCityId: initialCityId,
        onCreate: onCreate,
        onUpdate: onUpdate,
      );
    },
  );
}

class _NeighborhoodFormSheet extends StatefulWidget {
  const _NeighborhoodFormSheet({
    required this.cities,
    required this.initial,
    required this.initialCityId,
    required this.onCreate,
    required this.onUpdate,
  });

  final List<CityModel> cities;
  final NeighborhoodModel? initial;
  final int? initialCityId;
  final NeighborhoodSubmit onCreate;
  final NeighborhoodUpdateSubmit onUpdate;

  @override
  State<_NeighborhoodFormSheet> createState() => _NeighborhoodFormSheetState();
}

class _NeighborhoodFormSheetState extends State<_NeighborhoodFormSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameArController;
  late final TextEditingController _nameEnController;
  int? _cityId;

  @override
  void initState() {
    super.initState();
    _nameArController = TextEditingController(
      text: widget.initial?.nameAr ?? '',
    );
    _nameEnController = TextEditingController(
      text: widget.initial?.nameEn ?? '',
    );
    _cityId = widget.initial?.cityId ?? widget.initialCityId;
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
            Text(
              'المدينة',
              style: TextStyle(
                color: AppColor.black,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<int>(
              value: _cityId,
              items:
                  widget.cities
                      .where((c) => c.id != null)
                      .map(
                        (c) => DropdownMenuItem<int>(
                          value: c.id,
                          child: Text(c.nameAr ?? c.nameEn ?? '-'),
                        ),
                      )
                      .toList(),
              onChanged: (value) => setState(() => _cityId = value),
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColor.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColor.primary),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColor.primary),
                ),
              ),
              validator: (v) => v == null ? 'اختاري المدينة' : null,
            ),
            const SizedBox(height: 12),
            CustomTextField(
              controller: _nameArController,
              labelText: 'اسم الحي (عربي)',
              hintText: 'مثال: المعادي',
            ),
            const SizedBox(height: 12),
            CustomTextField(
              controller: _nameEnController,
              labelText: 'Neighborhood name (English)',
              hintText: 'Example: Maadi',
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
                  final cityId = _cityId;
                  if (cityId == null) return;

                  final request = StoreNeighborhoodRequestModel(
                    nameEn: _nameEnController.text.trim(),
                    nameAr: _nameArController.text.trim(),
                    cityId: cityId,
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
