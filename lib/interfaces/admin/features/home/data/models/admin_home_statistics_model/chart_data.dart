import 'dart:convert';

import 'dataset.dart';

class ChartData {
  List<String>? labels;
  List<Dataset>? datasets;

  ChartData({this.labels, this.datasets});

  @override
  String toString() => 'ChartData(labels: $labels, datasets: $datasets)';

  factory ChartData.fromMap(Map<String, dynamic> data) => ChartData(
    // `labels` comes from decoded JSON as List<dynamic>. Coerce to List<String> safely.
    labels:
        (data['labels'] as List<dynamic>?)
            ?.map((e) => e?.toString() ?? '')
            .toList(),
    datasets:
        (data['datasets'] as List<dynamic>?)
            ?.map((e) => Dataset.fromMap(e as Map<String, dynamic>))
            .toList(),
  );

  Map<String, dynamic> toMap() => {
    'labels': labels,
    'datasets': datasets?.map((e) => e.toMap()).toList(),
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ChartData].
  factory ChartData.fromJson(String data) {
    return ChartData.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ChartData] to a JSON string.
  String toJson() => json.encode(toMap());
}
