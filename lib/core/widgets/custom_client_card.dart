import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fuji_maintenance_system/core/models/client_model.dart';
import 'package:fuji_maintenance_system/core/theme/app_color.dart';
import 'package:fuji_maintenance_system/core/translation/app_strings.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class CustomClientCard extends StatelessWidget {
  const CustomClientCard({
    super.key,
    required this.clientModel,
    this.onTap,
    this.onPressAction,
    this.actionText,
    this.onEdit,
  });

  final ClientModel clientModel;
  final void Function()? onTap;
  final void Function()? onPressAction;
  final String? actionText;
  final void Function()? onEdit;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: const [
            BoxShadow(
              color: AppColors.secondary,
              blurRadius: 2,
              spreadRadius: 0,
              blurStyle: BlurStyle.outer,
              offset: Offset(0, 2),
            ),
          ],
          border: Border.all(color: AppColors.white, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Name, location and Avatar
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CachedNetworkImage(
                  imageUrl: clientModel.image ?? '',
                  imageBuilder:
                      (context, imageProvider) => CircleAvatar(
                        radius: 22,
                        backgroundColor: AppColors.white,
                        backgroundImage: imageProvider,
                      ),
                  errorWidget:
                      (context, url, error) => CircleAvatar(
                        radius: 22,
                        backgroundColor: AppColors.gray_3,
                        child: Icon(Icons.person, color: AppColors.white),
                      ),
                ),

                SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              clientModel.name ?? '',
                              style: textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w800,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (onEdit != null)
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  onEdit?.call();
                                },
                                borderRadius: BorderRadius.circular(20),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.edit_outlined,
                                    size: 26,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      Text(
                        clientModel.location ?? '',
                        style: textTheme.bodyMedium?.copyWith(
                          color: Colors.black54,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Wrap(
              spacing: 24,
              runSpacing: 8,
              children: [
                // iconText(
                //   icon: Icons.tag,
                //   text: clientModel.id.toString(),
                // ),
                iconText(icon: Icons.phone, text: clientModel.phone ?? ''),
                iconText(
                  icon: Icons.bar_chart_rounded,
                  text:
                      "${AppStrings.reportCount.tr}:${clientModel.reportsCount}",
                ),
                iconText(
                  icon: Icons.description_rounded,
                  text:
                      "${AppStrings.contractCount.tr}:${clientModel.contractsCount}",
                ),
              ],
            ),

            if (onPressAction != null && actionText != null) ...[
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: onPressAction,
                      child: Text(actionText!),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget iconText({required IconData icon, required String text}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 18, color: AppColors.primary),
        const SizedBox(width: 6),
        Flexible(
          child: Text(
            text,
            style: const TextStyle(fontSize: 13.5),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
