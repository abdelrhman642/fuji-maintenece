import 'dart:convert';

class Dataset {
  String? label;
  List<dynamic>? data;

  Dataset({this.label, this.data});

  @override
  String toString() => 'Dataset(label: $label, data: $data)';

  factory Dataset.fromMap(Map<String, dynamic> data) => Dataset(
    label: data['label'] as String?,
    data: data['data'] as List<dynamic>?,
  );

  Map<String, dynamic> toMap() => {'label': label, 'data': data};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Dataset].
  factory Dataset.fromJson(String data) {
    return Dataset.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Dataset] to a JSON string.
  String toJson() => json.encode(toMap());
}
