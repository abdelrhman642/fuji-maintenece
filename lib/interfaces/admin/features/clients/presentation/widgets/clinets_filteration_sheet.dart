import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/add%20client/presentation/widgets/custom_drop_down.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/clients/presentation/manager/clients%20cubit/clients_cubit.dart';
import 'package:fuji_maintenance_system/shared/features/auth/presentation/widgets/custom_filled_button.dart';
import 'package:get/get_utils/get_utils.dart';

Future<void> showClientsFilterationSheet(
  BuildContext context,
  ClientsCubit cubit,
) {
  return showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
    ),
    builder:
        (context) => BlocProvider.value(
          value: cubit..fetchCities(),
          child: const ClinetsFilterationSheet(),
        ),
  );
}

class ClinetsFilterationSheet extends StatelessWidget {
  const ClinetsFilterationSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final cities = context.watch<ClientsCubit>().cities;
    final neighborhoods = context.watch<ClientsCubit>().neighborhoods;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildHeader(context),
        Spacer(),
        CustomDropdown(
          hintText: 'اخنر المدينة',
          selectedValue: context.watch<ClientsCubit>().cityId,
          items:
              cities.map((city) {
                return DropdownMenuItem<int>(
                  value: city.id,
                  child: Text(city.nameAr ?? ''),
                );
              }).toList(),
          onChanged: (value) {
            context.read<ClientsCubit>().setCityId(value);
            context.read<ClientsCubit>().fetchNeighborhoods(value!);
          },
        ),
        CustomDropdown(
          hintText: 'اختر الحي',
          selectedValue: context.watch<ClientsCubit>().neighborhoodId,
          items:
              neighborhoods.map((neighborhood) {
                return DropdownMenuItem<int>(
                  value: neighborhood.id,
                  child: Text(neighborhood.nameAr ?? ''),
                );
              }).toList(),
          onChanged: (value) {
            context.read<ClientsCubit>().setNeighborhoodId(value);
          },
        ),
        Spacer(),
        CustomFilledButton(
          text: 'تطبيق التصفية',
          onPressed: () {
            context.read<ClientsCubit>().fetchClients();
            Navigator.of(context).pop();
          },
        ),
      ],
    ).paddingAll(16);
  }

  Row _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            context.read<ClientsCubit>().clearFilters();
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.delete_outline_rounded),
        ),
        Column(
          children: [
            Text(
              'تصفية العملاء',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              'اختر المدينة والحي لتصفية العملاء',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
        IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
