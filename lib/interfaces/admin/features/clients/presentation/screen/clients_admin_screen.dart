import 'package:flutter/material.dart';
import 'package:fuji_maintenance_system/core/theme/app_font.dart';
import 'package:fuji_maintenance_system/core/translation/app_strings.dart';
import 'package:fuji_maintenance_system/core/widgets/custom_app_bar_widget.dart';
import 'package:fuji_maintenance_system/core/widgets/custom_text_field.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/clients/presentation/manager/clients%20cubit/clients_cubit.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/clients/presentation/widgets/clients_screen_body.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/clients/presentation/widgets/clinets_filteration_sheet.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ClientsAdminScreen extends StatefulWidget {
  const ClientsAdminScreen({super.key});

  @override
  State<ClientsAdminScreen> createState() => _ClientsAdminScreenState();
}

class _ClientsAdminScreenState extends State<ClientsAdminScreen> {
  final controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: Column(
        children: [
          CustomAppBarWidget(
            title: AppStrings.clients.tr,
            textColor: AppColor.black,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            alignment: Alignment.center,
            child: CustomTextField(
              controller: controller,
              hintText: AppStrings.search.tr,
              prefixIcon: Icons.search,
              suffixIcon: IconButton(
                onPressed: () async {
                  await showClientsFilterationSheet(
                    context,
                    context.read<ClientsCubit>(),
                  );
                },
                icon: Icon(
                  Icons.filter_alt_outlined,
                  color: AppColor.secondary,
                ),
              ),
              contentPadding: EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 16,
              ),
              onChanged: (value) {
                context.read<ClientsCubit>().searchClientsByName(value);
              },
            ),
          ),
          Expanded(child: ClientsScreenBody()),
        ],
      ),
    );
  }
}
