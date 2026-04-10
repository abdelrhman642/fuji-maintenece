import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuji_maintenance_system/core/helper/context_notification_extension.dart';
import 'package:fuji_maintenance_system/core/theme/app_font.dart';
import 'package:fuji_maintenance_system/core/translation/app_strings.dart';
import 'package:fuji_maintenance_system/core/widgets/custom_app_bar_widget.dart';
import 'package:fuji_maintenance_system/core/widgets/no_data_fount_widget.dart';
import 'package:fuji_maintenance_system/core/widgets/show_loading_dialog.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/maintenance%20contract%20sections/presentation/cubit/maintenance_contract_sections_cubit.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/maintenance%20contract%20sections/presentation/widgets/maintenance_contract_sections_screen_body.dart';
import 'package:get/get.dart';

import '../../data/models/maintenance_contract_section_model.dart';

class MaintenanceContractSectionsScreen extends StatefulWidget {
  const MaintenanceContractSectionsScreen({super.key});

  @override
  State<MaintenanceContractSectionsScreen> createState() =>
      _MaintenanceContractSectionsScreenState();
}

class _MaintenanceContractSectionsScreenState
    extends State<MaintenanceContractSectionsScreen> {
  List<MaintenanceContractSectionModel> sections = [];
  bool isFirst = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColor.background,
      appBar: CustomAppBarWidget(
        title: AppStrings.maintenanceContractSections.tr,
      ),
      body: BlocConsumer<
        MaintenanceContractSectionsCubit,
        MaintenanceContractSectionsState
      >(
        listener: (context, state) {
          if (state is MaintenanceContractSectionsLoaded) {
            sections = state.sections;
          }
          if (state is MaintenanceContractSectionActionSuccess) {
            context.read<MaintenanceContractSectionsCubit>().fetchSections();
          } else if (state is MaintenanceContractSectionActionError) {
            context.showError(state.message);
          }
        },
        builder: (context, state) {
          if (state is MaintenanceContractSectionsError) {
            return Center(
              child: Text(state.message, style: AppFont.font16W600Gray2),
            );
          } else if (state is MaintenanceContractSectionsLoading && isFirst) {
            isFirst = false;
            return const CustomLoadingIndicator();
          }
          {
            if (sections.isEmpty) {
              return NoDataFoundWidget();
            }
            final cubit = context.read<MaintenanceContractSectionsCubit>();
            return MaintenanceContractSectionsScreenBody(
              sections: sections,
              cubit: cubit,
            );
          }
        },
      ),
    );
  }
}
