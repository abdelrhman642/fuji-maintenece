import 'dart:convert';

class Clients {
  String? title;
  int? count;

  Clients({this.title, this.count});

  @override
  String toString() => 'Clients(title: $title, count: $count)';

  factory Clients.fromMap(Map<String, dynamic> data) =>
      Clients(title: data['title'] as String?, count: data['count'] as int?);

  Map<String, dynamic> toMap() => {'title': title, 'count': count};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Clients].
  factory Clients.fromJson(String data) {
    return Clients.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Clients] to a JSON string.
  String toJson() => json.encode(toMap());
}
