import 'dart:convert';

class Requests {
  String? title;
  int? count;

  Requests({this.title, this.count});

  @override
  String toString() => 'Requests(title: $title, count: $count)';

  factory Requests.fromMap(Map<String, dynamic> data) =>
      Requests(title: data['title'] as String?, count: data['count'] as int?);

  Map<String, dynamic> toMap() => {'title': title, 'count': count};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Requests].
  factory Requests.fromJson(String data) {
    return Requests.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Requests] to a JSON string.
  String toJson() => json.encode(toMap());
}
