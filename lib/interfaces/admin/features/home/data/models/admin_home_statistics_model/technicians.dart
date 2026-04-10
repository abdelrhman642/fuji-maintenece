import 'dart:convert';

class Technicians {
  String? title;
  int? count;

  Technicians({this.title, this.count});

  @override
  String toString() => 'Technicians(title: $title, count: $count)';

  factory Technicians.fromMap(Map<String, dynamic> data) => Technicians(
    title: data['title'] as String?,
    count: data['count'] as int?,
  );

  Map<String, dynamic> toMap() => {'title': title, 'count': count};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Technicians].
  factory Technicians.fromJson(String data) {
    return Technicians.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Technicians] to a JSON string.
  String toJson() => json.encode(toMap());
}
