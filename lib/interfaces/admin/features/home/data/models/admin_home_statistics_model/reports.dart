import 'dart:convert';

class Reports {
  String? title;
  int? count;

  Reports({this.title, this.count});

  @override
  String toString() => 'Reports(title: $title, count: $count)';

  factory Reports.fromMap(Map<String, dynamic> data) {
    // The backend sometimes uses `count` and other times `value` for the same field.
    // Accept either and coerce to int when possible.
    final dynamic rawCount = data['count'] ?? data['value'];
    int? parsedCount;
    if (rawCount != null) {
      if (rawCount is int) {
        parsedCount = rawCount;
      } else {
        parsedCount = int.tryParse(rawCount.toString());
      }
    }

    return Reports(title: data['title'] as String?, count: parsedCount);
  }

  Map<String, dynamic> toMap() => {'title': title, 'count': count};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Reports].
  factory Reports.fromJson(String data) {
    return Reports.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Reports] to a JSON string.
  String toJson() => json.encode(toMap());
}
