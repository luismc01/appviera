import 'package:flutter/material.dart';
import 'package:arquiapp/paginas/digitales.dart';
import 'package:arquiapp/paginas/fisicos.dart';
import 'package:arquiapp/paginas/home.dart';
import 'package:arquiapp/paginas/login.dart';
import 'package:arquiapp/paginas/maquetas.dart';
import 'package:arquiapp/rutas/routes.dart';

abstract class Paginas {
  static Map<String, Widget Function(BuildContext)> route = {
    Routes.digitales: (BuildContext) => const Digitales(),
    Routes.fisicos: (BuildContext) => const Fisicos(),
    Routes.home: (BuildContext) => const Home(),
    Routes.login: (BuildContext) => const Login(),
    Routes.maquetas: (BuildContext) => const Maquetas()
  };
}
