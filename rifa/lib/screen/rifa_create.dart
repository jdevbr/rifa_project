import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rifa/entity/rifa_dto.dart';
import 'package:rifa/service/rifa_service.dart';

class RifaCreate extends StatefulWidget {
  const RifaCreate({Key? key}) : super(key: key);

  @override
  State<RifaCreate> createState() => _RifaCreateState();
}

class _RifaCreateState extends State<RifaCreate> {
  final RifaService _rifaService = RifaService();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _lengthController = TextEditingController();
  int _rifaLength = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ADD RIFA'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          customInput('Titulo', _titleController),
          customInput('Descrição', _descriptionController),
          customInput('Tamanho (min 10, max 100)', _lengthController,
              number: true),
          ElevatedButton(
            child: const Text('CADASTRAR RIFA'),
            onPressed: () {
              createRifa();
            },
          ),
        ],
      ),
    );
  }

  customInput(String label, TextEditingController controller,
      {bool number = false}) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
      child: TextField(
        controller: controller,
        keyboardType: number ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          filled: true,
          labelText: label,
          isDense: true,
          contentPadding: const EdgeInsets.all(10),
        ),
      ),
    );
  }

  createRifa() {
    if (_titleController.text.isEmpty ||
        _descriptionController.text.isEmpty ||
        _lengthController.text.isEmpty) {
      Fluttertoast.showToast(msg: 'Please fill all fields');
      return;
    }
    try {
      _rifaLength = int.parse(_lengthController.text);
      if (_rifaLength < 10 || _rifaLength > 100) {
        Fluttertoast.showToast(msg: 'Length must be between 10 and 100');
        return;
      }
      RifaDTO rifa = RifaDTO(
        title: _titleController.text,
        description: _descriptionController.text,
        length: _rifaLength,
        owners: [],
      );
      _rifaService.create(rifa).then((rifa) {
        Fluttertoast.showToast(msg: 'Rifa created');
        Navigator.pop(context);
      });
    } catch (e) {
      Fluttertoast.showToast(msg: 'Length must be a number');
      return;
    }
  }
}
