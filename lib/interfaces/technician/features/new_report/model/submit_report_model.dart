import 'package:fuji_maintenance_system/interfaces/admin/features/contract%20renew%20requests/data/models/contract_renew_model/client.dart';

class SubmitReportModel {
  final String? pdfDownloadLink;
  final Client? client;

  SubmitReportModel({required this.pdfDownloadLink, required this.client});
  factory SubmitReportModel.fromJson(Map<String, dynamic> json) {
    return SubmitReportModel(
      pdfDownloadLink: json['pdf_download_url'],
      client: Client.fromMap(json['client_data']),
    );
  }
}
