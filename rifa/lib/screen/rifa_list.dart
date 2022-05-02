import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rifa/entity/rifa.dart';
import 'package:rifa/screen/rifa_create.dart';
import 'package:rifa/screen/rifa_view.dart';
import 'package:rifa/service/rifa_service.dart';

class RifaList extends StatefulWidget {
  const RifaList({Key? key}) : super(key: key);

  @override
  State<RifaList> createState() => _RifaListState();
}

class _RifaListState extends State<RifaList> {
  final RifaService _rifaService = RifaService();
  List<Rifa> _rifas = [];

  @override
  void initState() {
    super.initState();
    fetchAll(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RIFAS'),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: _rifas.length,
          itemBuilder: (context, index) {
            final Rifa rifa = _rifas[index];
            return Card(
              margin: const EdgeInsets.only(top: 8, left: 8, right: 8),
              elevation: 3,
              child: ListTile(
                title: Text(rifa.title),
                subtitle: Text(rifa.description),
                trailing: Text('${rifa.owners.length}/${rifa.length}'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RifaView(rifa: rifa),
                    ),
                  ).then((value) => fetchAll(false));
                },
                onLongPress: () {
                  deleteRifa(rifa);
                },
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const RifaCreate(),
            ),
          ).then((value) => fetchAll(false));
        },
        child: const Icon(Icons.add_rounded),
      ),
    );
  }

  fetchAll(show) {
    _rifaService.findAll().then((rifas) {
      setState(() {
        _rifas = rifas;
      });
      if (show) {
        Fluttertoast.showToast(
          msg: '${rifas.length} rifas encontradas',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    });
  }

  deleteRifa(rifa) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Aviso!!!"),
        content: const Text('Deseja deletar a rifa?'),
        actions: [
          btnCancelar(context),
          btnSim(context),
        ],
      ),
    ).then((value) async {
      if (value) {
        await _rifaService.delete(rifa);
        fetchAll(false);
      }
    });
  }

  Widget btnCancelar(context) => TextButton(
        child: const Text("Cancelar"),
        onPressed: () {
          Navigator.of(context).pop(false);
        },
      );

  Widget btnSim(context) => TextButton(
        child: const Text("Sim"),
        onPressed: () {
          Navigator.of(context).pop(true);
        },
      );
}
