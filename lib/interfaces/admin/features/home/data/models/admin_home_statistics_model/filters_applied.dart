import 'dart:convert';

class FiltersApplied {
  String? startDate;
  String? endDate;
  String? period;
  dynamic clientId;
  dynamic technicianId;
  dynamic reportType;

  FiltersApplied({
    this.startDate,
    this.endDate,
    this.period,
    this.clientId,
    this.technicianId,
    this.reportType,
  });

  @override
  String toString() {
    return 'FiltersApplied(startDate: $startDate, endDate: $endDate, period: $period, clientId: $clientId, technicianId: $technicianId, reportType: $reportType)';
  }

  factory FiltersApplied.fromMap(Map<String, dynamic> data) {
    return FiltersApplied(
      startDate: data['start_date'] as String?,
      endDate: data['end_date'] as String?,
      period: data['period'] as String?,
      clientId: data['client_id'] as dynamic,
      technicianId: data['technician_id'] as dynamic,
      reportType: data['report_type'] as dynamic,
    );
  }

  Map<String, dynamic> toMap() => {
    'start_date': startDate,
    'end_date': endDate,
    'period': period,
    'client_id': clientId,
    'technician_id': technicianId,
    'report_type': reportType,
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [FiltersApplied].
  factory FiltersApplied.fromJson(String data) {
    return FiltersApplied.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [FiltersApplied] to a JSON string.
  String toJson() => json.encode(toMap());
}
