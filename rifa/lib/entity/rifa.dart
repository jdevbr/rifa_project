import 'dart:convert';

import 'package:rifa/entity/owner.dart';

class Rifa {
  int id;

  String title;

  String description;

  int length;

  List<Owner> owners;

  bool ended;

  Rifa({
    required this.id,
    required this.title,
    required this.description,
    required this.length,
    required this.owners,
    required this.ended,
  });

  factory Rifa.fromMap(Map<String, dynamic> map) {
    return Rifa(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      length: map['length'],
      owners: Owner.fromJsonList(jsonEncode(map['owners'])),
      ended: map['ended'] ?? false,
    );
  }

  factory Rifa.fromJson(String json) {
    return Rifa.fromMap(jsonDecode(json));
  }

  static fromJsonList(String json) {
    return jsonDecode(json).map<Rifa>((e) => Rifa.fromMap(e)).toList();
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'length': length,
      'owners': owners.map((e) => e.toMap()).toList(),
    };
  }

  String toJson() {
    return jsonEncode(toMap());
  }
}
