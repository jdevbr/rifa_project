import 'package:flutter/material.dart';
import 'package:rifa/entity/owner.dart';
import 'package:rifa/entity/rifa.dart';
import 'package:rifa/service/rifa_service.dart';

class RifaView extends StatefulWidget {
  const RifaView({Key? key, required this.rifa}) : super(key: key);
  final Rifa rifa;

  @override
  State<RifaView> createState() => _RifaViewState();
}

class _RifaViewState extends State<RifaView> {
  final TextEditingController _nameController = TextEditingController();
  final RifaService _rifaService = RifaService();
  late Rifa _rifa;

  @override
  void initState() {
    super.initState();
    _rifa = widget.rifa;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_rifa.title),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Card(
          margin: const EdgeInsets.all(5),
          child: Container(
            padding: const EdgeInsets.all(8),
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      _rifa.title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 26),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      _rifa.description,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                const Divider(),
                Wrap(
                  runSpacing: 5,
                  spacing: 5,
                  children: numberList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  numberList() {
    List<Widget> list = [];
    for (var i = 0; i < _rifa.length; i++) {
      var currentIndex = i + 1;
      list.add(numberItem(currentIndex, ownerByNumber(currentIndex)));
    }
    return list;
  }

  ownerByNumber(int number) {
    try {
      return _rifa.owners.singleWhere((owner) => owner.number == number);
    } catch (e) {
      return null;
    }
  }

  numberItem(int number, Owner? owner) {
    return GestureDetector(
      onTap: () {
        addOwner(number);
      },
      child: Container(
        width: 60,
        height: 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$number',
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            if (owner != null)
              FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  owner.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
          ],
        ),
        decoration: BoxDecoration(
          color: owner != null ? Colors.red[100] : Colors.green[100],
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }

  addOwner(number) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Adicionar dono"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  child: Text(
                    '$number',
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            customInput('Nome', _nameController),
          ],
        ),
        actions: [
          btnCancelar(context),
          btnSalvar(context),
        ],
      ),
    ).then((value) {
      if (value) {
        Owner owner = Owner(number: number, name: _nameController.text);
        _nameController.clear();
        setState(() {
          _rifa.owners.add(owner);
        });
        _rifaService.update(_rifa);
      }
    });
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

  Widget btnCancelar(context) => TextButton(
        child: const Text("Cancelar"),
        onPressed: () {
          Navigator.of(context).pop(false);
        },
      );

  Widget btnSalvar(context) => TextButton(
        child: const Text("Salvar"),
        onPressed: () {
          Navigator.of(context).pop(true);
        },
      );
}
