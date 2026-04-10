import 'package:flutter/material.dart';
import 'package:fuji_maintenance_system/core/theme/app_font.dart';

class ServiceTicketCard extends StatelessWidget {
  const ServiceTicketCard({
    super.key,
    required this.statusText,
    this.statusColor = AppColor.backroyndIcon,
    this.statusTextColor = AppColor.green,
    required this.customerName,
    required this.ticketNo,
    required this.dueDate,
    required this.serviceType,

    this.iconAction,
    this.action1,
    this.action2,
  });

  final String statusText;
  final Color statusColor;
  final Color statusTextColor;
  final String customerName;
  final String ticketNo;
  final String dueDate;
  final String serviceType;
  final String? action1;
  final String? action2;

  final IconData? iconAction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.only(bottom: 12, left: 20, right: 20),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: AppColor.blackColor.withOpacity(.08)),
      ),

      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top row: status chip + customer name
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    'Customer Name: $customerName',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                _StatusChip(
                  text: statusText,
                  bg: statusColor,
                  fg: statusTextColor,
                ),
              ],
            ),

            // Row with ticket no, date, service type
            Wrap(
              spacing: 18,
              runSpacing: 12,
              children: [
                _IconLabel(
                  icon: Icons.confirmation_number,
                  iconColor: AppColor.primary,
                  text: '#$ticketNo',
                ),
                _IconLabel(
                  icon: Icons.event,
                  iconColor: AppColor.primary,
                  text: dueDate,
                ),
                _IconLabel(
                  icon: Icons.build,
                  iconColor: AppColor.primary,
                  text: serviceType,
                ),
              ],
            ),

            SizedBox(height: 14),

            // Actions / statuses
            Wrap(
              spacing: 18,
              runSpacing: 12,
              children: [
                CheckLabel(text: action1 ?? '', icon: iconAction),
                CheckLabel(text: action2 ?? '', icon: iconAction),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.text, required this.bg, required this.fg});
  final String text;
  final Color bg;
  final Color fg;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Text(
        text,
        style: TextStyle(color: fg, fontWeight: FontWeight.w700),
      ),
    );
  }
}

class _IconLabel extends StatelessWidget {
  const _IconLabel({
    required this.icon,
    required this.iconColor,
    required this.text,
    // ignore: unused_element_parameter
    this.underline = false,
  });

  final IconData icon;
  final Color iconColor;
  final String text;
  final bool underline;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.bodyLarge?.copyWith(
      decoration: underline ? TextDecoration.underline : TextDecoration.none,
      decorationThickness: 2,
    );
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 22, color: iconColor),
        const SizedBox(width: 8),
        Text(text, style: style),
      ],
    );
  }
}

class CheckLabel extends StatelessWidget {
  const CheckLabel({super.key, required this.text, this.icon});
  final String text;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) Icon(icon, color: AppColor.green, size: 22),
        if (icon != null) const SizedBox(width: 8),
        Text(
          text,
          style: Theme.of(context).textTheme.bodyLarge,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
