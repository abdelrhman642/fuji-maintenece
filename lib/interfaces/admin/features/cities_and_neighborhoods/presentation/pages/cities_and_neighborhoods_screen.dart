import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuji_maintenance_system/core/theme/app_color.dart';
import 'package:fuji_maintenance_system/core/translation/app_strings.dart';
import 'package:fuji_maintenance_system/core/widgets/custom_app_bar_widget.dart';
import 'package:fuji_maintenance_system/core/widgets/tab_buttons_widget.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/cities_and_neighborhoods/data/models/cities_response_model/city_model.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/cities_and_neighborhoods/presentation/manager/cities_cubit/cities_cubit.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/cities_and_neighborhoods/presentation/widgets/cities_tab_view.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/cities_and_neighborhoods/presentation/widgets/neighborhoods_tab_view.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class CitiesAndNeighborhoodsScreen extends StatefulWidget {
  const CitiesAndNeighborhoodsScreen({super.key});

  @override
  State<CitiesAndNeighborhoodsScreen> createState() =>
      _CitiesAndNeighborhoodsScreenState();
}

class _CitiesAndNeighborhoodsScreenState
    extends State<CitiesAndNeighborhoodsScreen> {
  int _selectedTab = 0;

  List<CityModel> _extractCities(CitiesState state) {
    if (state is CitiesLoaded) return state.cities;
    return const <CityModel>[];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: CustomAppBarWidget(
        title: AppStrings.manageCitiesAndNeighborhood.tr,
        backgroundColor: AppColor.primaryDark,
        textColor: AppColor.white,
      ),
      body: Column(
        children: [
          TabButtonsWidget(
            selectedIndex: _selectedTab,
            onTabSelected: (index) => setState(() => _selectedTab = index),
            tabNames: const ['المدن', 'الأحياء'],
          ),
          Expanded(
            child: BlocBuilder<CitiesCubit, CitiesState>(
              buildWhen:
                  (prev, curr) =>
                      curr is CitiesLoaded ||
                      curr is CitiesLoading ||
                      curr is CitiesError,
              builder: (context, state) {
                final cities = _extractCities(state);

                return IndexedStack(
                  index: _selectedTab,
                  children: [
                    const CitiesTabView(),
                    NeighborhoodsTabView(cities: cities),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
