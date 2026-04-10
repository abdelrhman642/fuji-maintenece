import 'package:flutter/material.dart';
import 'package:fuji_maintenance_system/core/theme/app_color.dart';

class CustomDropdown<T> extends StatelessWidget {
  final String? title;
  final String hintText;
  final List<DropdownMenuItem<T>>? items;
  final T? selectedValue;
  final void Function(T?)? onChanged;
  final String? Function(T?)? validator;

  const CustomDropdown({
    super.key,
    this.title,
    required this.hintText,
    required this.items,
    this.selectedValue,
    this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Text(
              title!,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColor.blackColor,
              ),
            ),
            const SizedBox(height: 8),
          ],
          DropdownButtonFormField<T>(
            isExpanded: true,
            validator: validator,
            value: selectedValue,
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(fontSize: 16, color: Colors.grey),
              filled: true,
              fillColor: AppColor.primaryLight.withOpacity(0.2),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 12,
              ),
              border: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: AppColor.primaryDark, width: 2),
              ),
              enabledBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: AppColor.primaryDark, width: 2),
              ),
              focusedBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: AppColor.primaryDark, width: 2),
              ),
              disabledBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: AppColor.primaryDark, width: 2),
              ),
            ),
            items: items,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: AppColor.blackColor,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
