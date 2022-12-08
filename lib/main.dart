import 'package:arquiapp/paginas/login.dart';
import 'package:flutter/material.dart';
import 'package:arquiapp/rutas/paginas.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Arqui App',
      theme: ThemeData(primarySwatch: Colors.purple),
      home: const Login(),
      routes: Paginas.route,
    );
  }
}

class MyAppHome extends StatefulWidget {
  const MyAppHome({super.key});

  @override
  State<MyAppHome> createState() => _MyAppHomeState();
}

class _MyAppHomeState extends State<MyAppHome> {
  @override
  Widget build(BuildContext context) {
    return const Center();
  }
}
