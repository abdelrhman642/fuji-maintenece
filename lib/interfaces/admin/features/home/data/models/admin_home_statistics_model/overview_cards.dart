import 'dart:convert';

import 'clients.dart';
import 'reports.dart';
import 'requests.dart';
import 'technicians.dart';

class OverviewCards {
  Reports? reports;
  Technicians? technicians;
  Requests? requests;
  Clients? clients;

  OverviewCards({this.reports, this.technicians, this.requests, this.clients});

  @override
  String toString() {
    return 'OverviewCards(reports: $reports, technicians: $technicians, requests: $requests, clients: $clients)';
  }

  factory OverviewCards.fromMap(Map<String, dynamic> data) => OverviewCards(
    reports:
        data['reports'] == null
            ? null
            : Reports.fromMap(data['reports'] as Map<String, dynamic>),
    technicians:
        data['technicians'] == null
            ? null
            : Technicians.fromMap(data['technicians'] as Map<String, dynamic>),
    requests:
        data['requests'] == null
            ? null
            : Requests.fromMap(data['requests'] as Map<String, dynamic>),
    clients:
        data['clients'] == null
            ? null
            : Clients.fromMap(data['clients'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toMap() => {
    'reports': reports?.toMap(),
    'technicians': technicians?.toMap(),
    'requests': requests?.toMap(),
    'clients': clients?.toMap(),
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [OverviewCards].
  factory OverviewCards.fromJson(String data) {
    return OverviewCards.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [OverviewCards] to a JSON string.
  String toJson() => json.encode(toMap());
}
