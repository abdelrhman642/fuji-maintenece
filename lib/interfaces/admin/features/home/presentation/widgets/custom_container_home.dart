import 'package:flutter/material.dart';
import 'package:fuji_maintenance_system/core/theme/app_font.dart';

class CustomContainerHome extends StatelessWidget {
  final String title;
  final String value;
  final String percentage;
  final Color backgroundColor;
  final Color textColor;
  final IconData icon;
  final bool isPositive;

  const CustomContainerHome({
    super.key,
    required this.title,
    required this.value,
    required this.percentage,
    required this.backgroundColor,
    required this.textColor,
    this.icon = Icons.trending_up,
    this.isPositive = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColor.secondary,
            blurRadius: 1,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColor.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: textColor, size: 24),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: textColor.withOpacity(0.9),
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  value,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -1,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(width: 8),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                    color: textColor,
                    size: 16,
                  ),
                  SizedBox(width: 4),
                  Text(
                    percentage,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          // Percentage with trend indicator
        ],
      ),
    );
  }
}
