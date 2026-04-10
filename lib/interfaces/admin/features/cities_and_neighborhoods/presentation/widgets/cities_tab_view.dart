import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuji_maintenance_system/core/helper/context_notification_extension.dart';
import 'package:fuji_maintenance_system/core/theme/app_color.dart';
import 'package:fuji_maintenance_system/core/translation/app_strings.dart';
import 'package:fuji_maintenance_system/core/widgets/empty_data_widget.dart';
import 'package:fuji_maintenance_system/core/widgets/loading_widget.dart';
import 'package:fuji_maintenance_system/core/widgets/show_loading_dialog.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/cities_and_neighborhoods/data/models/cities_response_model/city_model.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/cities_and_neighborhoods/data/models/store_city_request_model.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/cities_and_neighborhoods/presentation/dialogs/city_form_bottom_sheet.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/cities_and_neighborhoods/presentation/dialogs/confirm_delete_dialog.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/cities_and_neighborhoods/presentation/manager/cities_cubit/cities_cubit.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/cities_and_neighborhoods/presentation/widgets/cities_neighborhoods_error_view.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/cities_and_neighborhoods/presentation/widgets/city_tile.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class CitiesTabView extends StatefulWidget {
  const CitiesTabView({super.key});

  @override
  State<CitiesTabView> createState() => _CitiesTabViewState();
}

class _CitiesTabViewState extends State<CitiesTabView> {
  bool _activeOnly = false;
  bool _operationDialogShown = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CitiesCubit>().getCities();
    });
  }

  void _refresh() {
    if (_activeOnly) {
      context.read<CitiesCubit>().getActiveCities();
    } else {
      context.read<CitiesCubit>().getCities();
    }
  }

  bool _isActiveStatus(String? status) {
    final s = (status ?? '').trim().toLowerCase();
    return s == 'active' || s == '1' || s == 'true' || s == 'enabled';
  }

  Future<void> _openForm({CityModel? initial}) async {
    await showCityFormBottomSheet(
      context: context,
      initial: initial,
      onCreate:
          (StoreCityRequestModel request) =>
              context.read<CitiesCubit>().storeCity(request),
      onUpdate:
          (int id, StoreCityRequestModel request) =>
              context.read<CitiesCubit>().updateCity(id, request),
    );
  }

  Future<void> _deleteCity(int id) async {
    final confirm = await showConfirmDeleteDialog(context);
    if (confirm == true && mounted) {
      await context.read<CitiesCubit>().deleteCity(id);
    }
  }

  Future<void> _toggleCity(int id) async {
    await context.read<CitiesCubit>().toggleCity(id);
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
    return BlocConsumer<CitiesCubit, CitiesState>(
      listenWhen:
          (prev, curr) =>
              curr is CityOperationLoading ||
              curr is CityOperationSuccess ||
              curr is CityOperationFailure,
      buildWhen:
          (prev, curr) =>
              curr is CitiesInitial ||
              curr is CitiesLoading ||
              curr is CitiesLoaded ||
              curr is CitiesError,
      listener: (context, state) {
        if (state is CityOperationLoading) {
          _showOperationLoading();
        } else if (state is CityOperationSuccess) {
          _hideOperationLoading();
          context.showSuccess(state.message);
          _refresh();
        } else if (state is CityOperationFailure) {
          _hideOperationLoading();
          context.showError(state.message);
        }
      },
      builder: (context, state) {
        final Widget content;

        if (state is CitiesLoading || state is CitiesInitial) {
          content = const Center(child: LoadingWidget());
        } else if (state is CitiesError) {
          content = CitiesNeighborhoodsErrorView(
            message: state.message,
            onRetry: _refresh,
          );
        } else if (state is CitiesLoaded) {
          final cities = List<CityModel>.from(state.cities);
          if (_activeOnly) {
            cities.removeWhere((c) => !_isActiveStatus(c.status));
          }
          if (cities.isEmpty) {
            content = const EmptyDataWidget();
          } else {
            content = ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              itemCount: cities.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final city = cities[index];
                final cityId = city.id;
                return CityTile(
                  city: city,
                  isActive: _isActiveStatus(city.status),
                  onEdit: () => _openForm(initial: city),
                  onToggle: cityId == null ? () {} : () => _toggleCity(cityId),
                  onDelete: cityId == null ? () {} : () => _deleteCity(cityId),
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
              child: Row(
                children: [
                  Expanded(
                    child: Container(
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
                          Icon(
                            Icons.filter_alt_outlined,
                            color: AppColor.primary,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              _activeOnly
                                  ? AppStrings.activeLabel.tr
                                  : AppStrings.all.tr,
                              style: TextStyle(
                                color: AppColor.primaryDark,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
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
                  ),
                  const SizedBox(width: 10),
                  IconButton.filled(
                    style: IconButton.styleFrom(
                      backgroundColor: AppColor.primary,
                    ),
                    onPressed: () => _openForm(),
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
            ),
            const SizedBox(height: 6),
            Expanded(child: content),
          ],
        );
      },
    );
  }
}
