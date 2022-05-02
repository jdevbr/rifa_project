import 'dart:convert';

class Owner {
  int number;

  String name;

  Owner({
    required this.number,
    required this.name,
  });

  factory Owner.fromMap(Map<String, dynamic> map) {
    return Owner(number: map['number'], name: map['name']);
  }

  factory Owner.fromJson(String json) {
    return Owner.fromMap(jsonDecode(json));
  }

  static fromJsonList(String json) {
    return jsonDecode(json).map<Owner>((e) => Owner.fromMap(e)).toList();
  }

  Map<String, dynamic> toMap() {
    return {
      'number': number,
      'name': name,
    };
  }

  String toJson() {
    return jsonEncode(toMap());
  }
}
