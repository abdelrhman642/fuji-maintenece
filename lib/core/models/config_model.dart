import 'dart:convert';

class ConfigModel {
  final String? appName;
  final String? appVersion;
  final String? privacyPolicyUrl;
  final String? termsOfServiceUrl;
  final String? supportEmail;
  final String? supportPhone;
  final Map<String, dynamic>? settings;

  ConfigModel({
    this.appName,
    this.appVersion,
    this.privacyPolicyUrl,
    this.termsOfServiceUrl,
    this.supportEmail,
    this.supportPhone,
    this.settings,
  });

  factory ConfigModel.fromMap(Map<String, dynamic> json) {
    return ConfigModel(
      appName: json['app_name'] as String?,
      appVersion: json['app_version'] as String?,
      privacyPolicyUrl: json['privacy_policy_url'] as String?,
      termsOfServiceUrl: json['terms_of_service_url'] as String?,
      supportEmail: json['support_email'] as String?,
      supportPhone: json['support_phone'] as String?,
      settings: json['settings'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'app_name': appName,
      'app_version': appVersion,
      'privacy_policy_url': privacyPolicyUrl,
      'terms_of_service_url': termsOfServiceUrl,
      'support_email': supportEmail,
      'support_phone': supportPhone,
      'settings': settings,
    };
  }

  factory ConfigModel.fromJson(String source) =>
      ConfigModel.fromMap(json.decode(source) as Map<String, dynamic>);

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'ConfigModel(appName: $appName, appVersion: $appVersion, privacyPolicyUrl: $privacyPolicyUrl, termsOfServiceUrl: $termsOfServiceUrl, supportEmail: $supportEmail, supportPhone: $supportPhone, settings: $settings)';
  }
}
