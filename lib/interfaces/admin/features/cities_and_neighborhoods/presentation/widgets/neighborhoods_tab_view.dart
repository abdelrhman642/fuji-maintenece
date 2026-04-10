import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuji_maintenance_system/core/helper/context_notification_extension.dart';
import 'package:fuji_maintenance_system/core/theme/app_color.dart';
import 'package:fuji_maintenance_system/core/translation/app_strings.dart';
import 'package:fuji_maintenance_system/core/widgets/empty_data_widget.dart';
import 'package:fuji_maintenance_system/core/widgets/loading_widget.dart';
import 'package:fuji_maintenance_system/core/widgets/show_loading_dialog.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/cities_and_neighborhoods/data/models/cities_response_model/city_model.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/cities_and_neighborhoods/data/models/neighborhood_response_model/neighborhood_model.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/cities_and_neighborhoods/data/models/store_neighborhood_request_model.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/cities_and_neighborhoods/presentation/dialogs/confirm_delete_dialog.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/cities_and_neighborhoods/presentation/dialogs/neighborhood_form_bottom_sheet.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/cities_and_neighborhoods/presentation/manager/neighborhood_cubit/neighborhood_cubit.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/cities_and_neighborhoods/presentation/widgets/cities_neighborhoods_error_view.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/cities_and_neighborhoods/presentation/widgets/neighborhood_tile.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class NeighborhoodsTabView extends StatefulWidget {
  const NeighborhoodsTabView({super.key, required this.cities});

  final List<CityModel> cities;

  @override
  State<NeighborhoodsTabView> createState() => _NeighborhoodsTabViewState();
}

class _NeighborhoodsTabViewState extends State<NeighborhoodsTabView> {
  bool _activeOnly = false;
  int? _selectedCityId;
  bool _operationDialogShown = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NeighborhoodCubit>().getNeighborhoods();
    });
  }

  bool _isActiveStatus(String? status) {
    final s = (status ?? '').trim().toLowerCase();
    return s == 'active' || s == '1' || s == 'true' || s == 'enabled';
  }

  void _refresh() {
    final cityId = _selectedCityId;
    if (cityId != null) {
      context.read<NeighborhoodCubit>().getNeighborhoodsByCity(cityId);
      return;
    }

    if (_activeOnly) {
      context.read<NeighborhoodCubit>().getActiveNeighborhoods();
    } else {
      context.read<NeighborhoodCubit>().getNeighborhoods();
    }
  }

  Future<void> _openForm({NeighborhoodModel? initial}) async {
    await showNeighborhoodFormBottomSheet(
      context: context,
      cities: widget.cities,
      initial: initial,
      initialCityId: _selectedCityId,
      onCreate:
          (StoreNeighborhoodRequestModel request) =>
              context.read<NeighborhoodCubit>().storeNeighborhood(request),
      onUpdate:
          (int id, StoreNeighborhoodRequestModel request) =>
              context.read<NeighborhoodCubit>().updateNeighborhood(id, request),
    );
  }

  Future<void> _deleteNeighborhood(int id) async {
    final confirm = await showConfirmDeleteDialog(context);
    if (confirm == true && mounted) {
      await context.read<NeighborhoodCubit>().deleteNeighborhood(id);
    }
  }

  Future<void> _toggleNeighborhood(int id) async {
    await context.read<NeighborhoodCubit>().toggleNeighborhood(id);
  }

  void _showOperationLoading() {
    if (_operationDialogShown) return;
    _operationDialogShown = true;
    showLoadingDialog(context);
  }

  void _hideOperationLoading() {
    if (!_operationDialogShown) return;
    _operationDialogShown = false;
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final citiesWithIds = widget.cities.where((c) => c.id != null).toList();

    return BlocConsumer<NeighborhoodCubit, NeighborhoodState>(
      listenWhen:
          (prev, curr) =>
              curr is NeighborhoodOperationLoading ||
              curr is NeighborhoodOperationSuccess ||
              curr is NeighborhoodOperationFailure,
      buildWhen:
          (prev, curr) =>
              curr is NeighborhoodInitial ||
              curr is NeighborhoodLoading ||
              curr is NeighborhoodLoaded ||
              curr is NeighborhoodError,
      listener: (context, state) {
        if (state is NeighborhoodOperationLoading) {
          _showOperationLoading();
        } else if (state is NeighborhoodOperationSuccess) {
          _hideOperationLoading();
          context.showSuccess(state.message);
          _refresh();
        } else if (state is NeighborhoodOperationFailure) {
          _hideOperationLoading();
          context.showError(state.message);
        }
      },
      builder: (context, state) {
        final Widget content;

        if (state is NeighborhoodLoading || state is NeighborhoodInitial) {
          content = const Center(child: LoadingWidget());
        } else if (state is NeighborhoodError) {
          content = CitiesNeighborhoodsErrorView(
            message: state.message,
            onRetry: _refresh,
          );
        } else if (state is NeighborhoodLoaded) {
          final neighborhoods = List<NeighborhoodModel>.from(
            state.neighborhoods,
          );

          if (_activeOnly) {
            neighborhoods.removeWhere((n) => !_isActiveStatus(n.status));
          }

          if (_selectedCityId != null) {
            neighborhoods.removeWhere((n) => n.cityId != _selectedCityId);
          }

          if (neighborhoods.isEmpty) {
            content = const EmptyDataWidget();
          } else {
            content = ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              itemCount: neighborhoods.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final n = neighborhoods[index];
                final id = n.id;
                return NeighborhoodTile(
                  neighborhood: n,
                  isActive: _isActiveStatus(n.status),
                  onEdit: () => _openForm(initial: n),
                  onToggle: id == null ? () {} : () => _toggleNeighborhood(id),
                  onDelete: id == null ? () {} : () => _deleteNeighborhood(id),
                );
              },
            );
          }
        } else {
          content = const SizedBox.shrink();
        }

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: AppColor.primary.withOpacity(0.12),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.location_city, color: AppColor.primary),
                        const SizedBox(width: 8),
                        Expanded(
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<int?>(
                              value: _selectedCityId,
                              isExpanded: true,
                              hint: Text(
                                AppStrings.all.tr,
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  color: AppColor.primaryDark,
                                ),
                              ),
                              items: [
                                DropdownMenuItem<int?>(
                                  value: null,
                                  child: Text(AppStrings.all.tr),
                                ),
                                ...citiesWithIds.map(
                                  (c) => DropdownMenuItem<int?>(
                                    value: c.id,
                                    child: Text(c.nameAr ?? c.nameEn ?? '-'),
                                  ),
                                ),
                              ],
                              onChanged: (value) {
                                setState(() => _selectedCityId = value);
                                _refresh();
                              },
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Switch.adaptive(
                          value: _activeOnly,
                          activeColor: AppColor.primary,
                          onChanged: (v) {
                            setState(() => _activeOnly = v);
                            _refresh();
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          _selectedCityId == null
                              ? 'عرض الأحياء لكل المدن'
                              : 'عرض الأحياء حسب المدينة',
                          style: TextStyle(
                            color: AppColor.secondary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      IconButton.filled(
                        style: IconButton.styleFrom(
                          backgroundColor: AppColor.primary,
                        ),
                        onPressed:
                            widget.cities.isEmpty ? null : () => _openForm(),
                        icon: const Icon(Icons.add),
                      ),
                      const SizedBox(width: 8),
                      IconButton.outlined(
                        style: IconButton.styleFrom(
                          foregroundColor: AppColor.primary,
                        ),
                        onPressed: _refresh,
                        icon: const Icon(Icons.refresh),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 6),
            Expanded(child: content),
          ],
        );
      },
    );
  }
}
