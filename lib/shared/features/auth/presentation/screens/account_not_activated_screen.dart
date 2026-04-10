import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fuji_maintenance_system/core/helper/context_notification_extension.dart';
import 'package:fuji_maintenance_system/core/theme/app_color.dart';

class AccountNotActivatedScreen extends StatelessWidget {
  const AccountNotActivatedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('الحساب غير مفعل'), centerTitle: true),
        body: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColor.primaryLightest, AppColor.primaryLighter],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Center(
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 28.0,
                  horizontal: 20.0,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.lock_outline,
                      size: 64,
                      color: AppColor.primary.withAlpha(200),
                    ),
                    const SizedBox(height: 14),
                    const Text(
                      'الحساب غير مفعل بعد',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'حسابك لم يُفعّل حتى الآن. يرجى الرجوع إلى المشرف (الآدمن) ليقوم بتفعيله.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                    const SizedBox(height: 18),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder:
                                  (ctx) => Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: AlertDialog(
                                      title: const Text('معلومات التواصل'),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          ListTile(
                                            leading: Icon(
                                              Icons.email,
                                              color: AppColor.primary,
                                            ),
                                            title: GestureDetector(
                                              onTap: () {
                                                Clipboard.setData(
                                                  const ClipboardData(
                                                    text:
                                                        "info@royallift-ksa.com",
                                                  ),
                                                );

                                                context.showSuccess(
                                                  "تم نسخ الإيميل بنجاح ✅",
                                                );
                                              },
                                              child: Text(
                                                "info@royallift-ksa.com",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  decoration:
                                                      TextDecoration.underline,
                                                ),
                                              ),
                                            ),
                                          ),
                                          ListTile(
                                            leading: Icon(
                                              Icons.phone,
                                              color: AppColor.green,
                                            ),
                                            title: GestureDetector(
                                              onTap: () {
                                                Clipboard.setData(
                                                  const ClipboardData(
                                                    text: "+966543090780",
                                                  ),
                                                );

                                                context.showSuccess(
                                                  "تم نسخ رقم الجوال بنجاح ✅",
                                                );
                                              },
                                              child: Text(
                                                "+966543090780",
                                                style: TextStyle(
                                                  color: Colors.green,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed:
                                              () => Navigator.of(ctx).pop(),
                                          child: const Text('حسناً'),
                                        ),
                                      ],
                                    ),
                                  ),
                            );
                          },
                          icon: const Icon(Icons.mail_outline),
                          label: const Text('تواصل مع المشرف'),
                        ),
                        const SizedBox(width: 12),
                        OutlinedButton(
                          onPressed: () => Navigator.of(context).maybePop(),
                          child: const Text('حاول مرة أخرى'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
