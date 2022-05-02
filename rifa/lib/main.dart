import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rifa/screen/rifa_list.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    const MaterialApp(
      title: 'RIFA APP',
      home: RifaList(),
      debugShowCheckedModeBanner: false,
    ),
  );
}
