import 'dart:convert';

class Visits {
  String? title;
  int? value;

  Visits({this.title, this.value});

  @override
  String toString() => 'Visits(title: $title, value: $value)';

  factory Visits.fromMap(Map<String, dynamic> data) =>
      Visits(title: data['title'] as String?, value: data['value'] as int?);

  Map<String, dynamic> toMap() => {'title': title, 'value': value};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Visits].
  factory Visits.fromJson(String data) {
    return Visits.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Visits] to a JSON string.
  String toJson() => json.encode(toMap());
}
