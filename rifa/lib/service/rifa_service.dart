import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:rifa/entity/rifa.dart';
import 'package:rifa/entity/rifa_dto.dart';

class RifaService {
  final String url = 'url';
  final String key = 'key';

  Future<List<Rifa>> findAll() async {
    final response = await http.get(Uri.parse(url), headers: {
      'Authorization': key,
    });
    if (response.statusCode == 200) {
      return Rifa.fromJsonList(response.body);
    } else {
      throw Fluttertoast.showToast(msg: 'Falha ao carregar rifas');
    }
  }

  Future<Rifa> create(RifaDTO rifa) async {
    final response = await http.post(Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': key,
        },
        body: rifa.toJson());
    if (response.statusCode == 200) {
      return Rifa.fromJson(response.body);
    } else {
      throw Fluttertoast.showToast(msg: 'Falha ao criar rifa');
    }
  }

  Future<Rifa> update(Rifa rifa) async {
    final response = await http.put(Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': key,
        },
        body: rifa.toJson());
    if (response.statusCode == 200) {
      return Rifa.fromJson(response.body);
    } else {
      throw Fluttertoast.showToast(msg: 'Falha ao atualizar rifa');
    }
  }

  Future<void> delete(Rifa rifa) async {
    await http.delete(Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': key,
        },
        body: rifa.toJson());
  }
}
