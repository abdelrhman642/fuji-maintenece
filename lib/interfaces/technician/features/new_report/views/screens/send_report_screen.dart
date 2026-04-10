import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fuji_maintenance_system/core/theme/app_font.dart';
import 'package:fuji_maintenance_system/core/translation/app_strings.dart';
import 'package:fuji_maintenance_system/core/widgets/custom_app_bar_widget.dart';
import 'package:fuji_maintenance_system/core/widgets/custom_text_field.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/new_report/model/submit_report_model.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/new_report/views/widgets/custom_bottom.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/new_report/views/widgets/success_container.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:url_launcher/url_launcher.dart';

class SendReportScreen extends StatefulWidget {
  const SendReportScreen({super.key, required this.reportModel});
  final SubmitReportModel reportModel;

  @override
  State<SendReportScreen> createState() => _SendReportScreenState();
}

class _SendReportScreenState extends State<SendReportScreen> {
  final TextEditingController _numberController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  late String pdfDownloadUrl;

  @override
  void dispose() {
    _numberController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  /// Send report via WhatsApp
  Future<void> _sendWhatsApp() async {
    try {
      final phone = _numberController.text.trim();
      if (phone.isEmpty) {
        _showToast('Phone number is required');
        return;
      }

      // Remove any non-numeric characters and format the phone number
      String formattedPhone = phone.replaceAll(RegExp(r'[^0-9]'), '');

      // Remove leading zero if exists (for international format)
      if (formattedPhone.startsWith('0')) {
        formattedPhone = formattedPhone.substring(1);
      }

      // Prepare the message
      final message = 'Hello! Here is your maintenance report: $pdfDownloadUrl';
      final encodedMessage = Uri.encodeComponent(message);

      // Create WhatsApp URL using wa.me (works better on all devices)
      final whatsappUrl = Uri.parse(
        'https://wa.me/$formattedPhone?text=$encodedMessage',
      );

      if (await canLaunchUrl(whatsappUrl)) {
        await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
      } else {
        _showToast('WhatsApp is not installed');
      }
    } catch (e) {
      _showToast('Error sending WhatsApp: ${e.toString()}');
    }
  }

  /// Send report via Email
  Future<void> _sendEmail() async {
    try {
      final email = _emailController.text.trim();
      if (email.isEmpty) {
        _showToast('Email address is required');
        return;
      }

      // Prepare email content
      final subject = 'Maintenance Report';
      final body =
          'Hello,\n\nPlease find your maintenance report using the following link:\n\n$pdfDownloadUrl\n\nBest regards,\nFuji Maintenance Team';

      final emailUrl = Uri.parse(
        'mailto:$email?subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(body)}',
      );

      if (await canLaunchUrl(emailUrl)) {
        await launchUrl(emailUrl, mode: LaunchMode.externalApplication);
      } else {
        _showToast('Could not open email client');
      }
    } catch (e) {
      _showToast('Error sending email: ${e.toString()}');
    }
  }

  /// Send report via both WhatsApp and Email
  Future<void> _sendReport() async {
    if (pdfDownloadUrl.isEmpty) {
      _showToast('PDF download link is not available');
      return;
    }

    // Send via WhatsApp
    await _sendWhatsApp();

    // Wait a bit before sending email
    await Future.delayed(const Duration(milliseconds: 500));

    // Send via Email
    await _sendEmail();
  }

  /// Show toast message
  void _showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: AppColor.primaryDark,
      textColor: Colors.white,
    );
  }

  @override
  void initState() {
    _numberController.text = widget.reportModel.client?.phone ?? '';
    _emailController.text = widget.reportModel.client?.email ?? '';
    pdfDownloadUrl = widget.reportModel.pdfDownloadLink ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: CustomAppBarWidget(title: AppStrings.sendReport.tr),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24.0),
            child: Column(
              children: [
                SuccessContainer(
                  message: AppStrings.successMessage.tr,
                  bgColor: AppColor.white,
                  accent: AppColor.primaryDark,
                ),
                Padding(
                  padding: EdgeInsets.all(32.0),
                  child: Text(
                    AppStrings.shareReport.tr,
                    style: AppFont.font20W700Black.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColor.primaryDark,
                    ),
                  ),
                ),
                CustomTextField(
                  enabled: false,
                  prefixIcon: Icons.phone,
                  labelText: AppStrings.numberOfWhatUp.tr,
                  borderColor: AppColor.primaryDark,
                  controller: _numberController,
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 8.0),
                CustomTextField(
                  enabled: false,
                  textAlign: TextAlign.left,
                  prefixIcon: Icons.email,
                  labelText: AppStrings.email.tr,
                  borderColor: AppColor.primaryDark,
                  controller: _emailController,
                ),
                SizedBox(height: 16.0),
                CustomBottom(
                  title: AppStrings.sendReport.tr,
                  backgroundColor: AppColor.primaryDark,
                  onPressed: _sendReport,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
