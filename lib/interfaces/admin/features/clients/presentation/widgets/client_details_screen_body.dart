import 'package:flutter/material.dart';
import 'package:fuji_maintenance_system/core/theme/app_color.dart';
import 'package:fuji_maintenance_system/core/translation/app_strings.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/contracts/data/models/contract_model/contract_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ClientDetailsScreenBody extends StatelessWidget {
  const ClientDetailsScreenBody({super.key, required this.contracts});
  final List<ContractModel> contracts;

  @override
  Widget build(BuildContext context) {
    final client = contracts.first.client;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Client Information Card
        _buildClientInfoCard(client),
        const SizedBox(height: 16),

        // Contracts Section Header
        Row(
          children: [
            Icon(Icons.assignment, color: AppColor.primaryDark),
            const SizedBox(width: 8),
            Text(
              '${AppStrings.contracts.tr} (${contracts.length})',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Contracts List
        ...contracts.map((contract) => _buildContractCard(context, contract)),
      ],
    );
  }

  Widget _buildClientInfoCard(client) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [AppColor.primaryDark, AppColor.primaryDark.withAlpha(95)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.white,
                    child:
                        client?.image != null
                            ? ClipOval(
                              child: Image.network(
                                client!.image!,
                                width: 70,
                                height: 70,
                                fit: BoxFit.cover,
                                errorBuilder:
                                    (context, error, stackTrace) => const Icon(
                                      Icons.person,
                                      size: 35,
                                      color: AppColor.primaryDark,
                                    ),
                              ),
                            )
                            : const Icon(
                              Icons.person,
                              size: 35,
                              color: AppColor.primaryDark,
                            ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          client?.name ?? AppStrings.noDataLabel.tr,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: _getStatusColor(client?.status),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            _getStatusText(client?.status),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(color: Colors.white70, height: 32),
              _buildClientInfoRow(
                Icons.phone,
                AppStrings.phone.tr,
                client?.phone ?? AppStrings.noDataLabel.tr,
              ),
              const SizedBox(height: 12),
              _buildClientInfoRow(
                Icons.email,
                AppStrings.email.tr,
                client?.email ?? AppStrings.noDataLabel.tr,
              ),
              const SizedBox(height: 12),
              _buildClientInfoRow(
                Icons.location_on,
                AppStrings.location.tr,
                client?.location ?? AppStrings.noDataLabel.tr,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildClientInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.white, size: 20),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(color: Colors.white70, fontSize: 12),
              ),
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContractCard(BuildContext context, ContractModel contract) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        childrenPadding: const EdgeInsets.all(16),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _getContractStatusColor(contract.status).withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            Icons.description,
            color: _getContractStatusColor(contract.status),
          ),
        ),
        title: Text(
          '${AppStrings.contractNumber.tr}: ${contract.contractNumber ?? contract.id}',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Row(
            children: [
              Icon(
                _getContractStatusIcon(contract.status),
                size: 16,
                color: _getContractStatusColor(contract.status),
              ),
              const SizedBox(width: 4),
              Text(
                _getContractStatusText(contract),
                style: TextStyle(
                  color: _getContractStatusColor(contract.status),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.green.shade200),
          ),
          child: Text(
            '${contract.contractPrice ?? '0'} \$', //TODO Updated currency symbol
            style: TextStyle(
              color: Colors.green.shade700,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
        children: [
          // Contract Details
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                _buildDetailRow(
                  AppStrings.maintenanceContractSection.tr,
                  contract.contractSection?.nameAr ?? AppStrings.noDataLabel.tr,
                  Icons.category,
                  Colors.purple,
                ),
                const Divider(height: 20),
                _buildDetailRow(
                  AppStrings.contractDuration.tr,
                  contract.contractDuration?.nameAr ??
                      AppStrings.noDataLabel.tr,
                  Icons.schedule,
                  Colors.orange,
                ),
                const Divider(height: 20),
                _buildDetailRow(
                  AppStrings.startDate.tr,
                  contract.startDate != null
                      ? DateFormat('dd/MM/yyyy').format(contract.startDate!)
                      : AppStrings.noDataLabel.tr,
                  Icons.calendar_today,
                  Colors.blue,
                ),
                const Divider(height: 20),
                _buildDetailRow(
                  AppStrings.endDate.tr,
                  contract.endDate != null
                      ? DateFormat('dd/MM/yyyy').format(contract.endDate!)
                      : AppStrings.noDataLabel.tr,
                  Icons.event,
                  Colors.red,
                ),
                const Divider(height: 20),
                _buildDetailRow(
                  AppStrings.elevatorType.tr,
                  contract.elevatorType?.nameAr ?? AppStrings.noDataLabel.tr,
                  Icons.elevator,
                  Colors.indigo,
                ),
                const Divider(height: 20),
                _buildDetailRow(
                  AppStrings.elevatorBrand.tr,
                  contract.elevatorModel?.nameAr ?? AppStrings.noDataLabel.tr,
                  Icons.settings,
                  Colors.teal,
                ),
                if (contract.location != null) ...[
                  const Divider(height: 20),
                  _buildDetailRow(
                    AppStrings.location.tr,
                    contract.location!,
                    Icons.location_on,
                    Colors.green,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 20, color: color),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'active':
        return Colors.green;
      case 'inactive':
        return Colors.red;
      case 'pending':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  String _getStatusText(String? status) {
    switch (status?.toLowerCase()) {
      case 'active':
        return AppStrings.activeLabel.tr;
      case 'inactive':
        return AppStrings.inactiveLabel.tr;
      case 'pending':
        return AppStrings.pending.tr;
      default:
        return AppStrings.noDataLabel.tr;
    }
  }

  Color _getContractStatusColor(String? status) {
    if (status?.toLowerCase() == 'current') {
      return Colors.green;
    } else if (status?.toLowerCase() == 'expired') {
      return Colors.red;
    } else if (status?.toLowerCase() == 'pending') {
      return Colors.orange;
    }
    return Colors.grey;
  }

  IconData _getContractStatusIcon(String? status) {
    if (status?.toLowerCase() == 'current') {
      return Icons.check_circle;
    } else if (status?.toLowerCase() == 'expired') {
      return Icons.cancel;
    } else if (status?.toLowerCase() == 'pending') {
      return Icons.pending;
    }
    return Icons.info;
  }

  String _getContractStatusText(ContractModel contract) {
    if (contract.isEnded == true) {
      return AppStrings.expired.tr;
    } else if (contract.isCurrent == true) {
      return AppStrings.valid.tr;
    } else if (contract.status?.toLowerCase() == 'active') {
      return AppStrings.activeLabel.tr;
    } else if (contract.status?.toLowerCase() == 'pending') {
      return AppStrings.pending.tr;
    }
    return AppStrings.noDataLabel.tr;
  }
}
