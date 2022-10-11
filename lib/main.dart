import 'package:flutter/material.dart';
import 'package:objectbox_example/helpers/object_box.dart';
import 'package:objectbox_example/pages/home_page.dart';

late ObjectBox objectBox;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  objectBox = await ObjectBox.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}
