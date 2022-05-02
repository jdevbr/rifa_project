import 'dart:convert';

import 'package:rifa/entity/owner.dart';

class RifaDTO {
  String title;

  String description;

  int length;

  List<Owner> owners;

  RifaDTO({
    required this.title,
    required this.description,
    required this.length,
    required this.owners,
  });

  factory RifaDTO.fromMap(Map<String, dynamic> map) {
    return RifaDTO(
        title: map['title'],
        description: map['description'],
        length: map['length'],
        owners: Owner.fromJsonList(jsonEncode(map['owners'])));
  }

  factory RifaDTO.fromJson(String json) {
    return RifaDTO.fromMap(jsonDecode(json));
  }

  static fromJsonList(String json) {
    return jsonDecode(json).map<RifaDTO>((e) => RifaDTO.fromMap(e)).toList();
  }

  Map<String, dynamic> toMap() {
    return {
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
