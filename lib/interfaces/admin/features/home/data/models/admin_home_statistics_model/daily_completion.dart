import 'dart:convert';

import 'reports.dart';
import 'visits.dart';

class DailyCompletion {
  Reports? reports;
  Visits? visits;

  DailyCompletion({this.reports, this.visits});

  @override
  String toString() => 'DailyCompletion(reports: $reports, visits: $visits)';

  factory DailyCompletion.fromMap(Map<String, dynamic> data) {
    return DailyCompletion(
      reports:
          data['reports'] == null
              ? null
              : Reports.fromMap(data['reports'] as Map<String, dynamic>),
      visits:
          data['visits'] == null
              ? null
              : Visits.fromMap(data['visits'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toMap() => {
    'reports': reports?.toMap(),
    'visits': visits?.toMap(),
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [DailyCompletion].
  factory DailyCompletion.fromJson(String data) {
    return DailyCompletion.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [DailyCompletion] to a JSON string.
  String toJson() => json.encode(toMap());
}
