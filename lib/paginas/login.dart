import 'package:arquiapp/rutas/routes.dart';
import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Repostería Asael'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: (cuerpo(context)),
    );
  } // fin del metodo build
} //fin de la clase ingreso

Widget cuerpo(BuildContext context) {
  return Container(
    //imagen de fondo de la pantalla
    decoration: const BoxDecoration(
      image: DecorationImage(
          image: NetworkImage(
              'https://images.unsplash.com/photo-1516054575922-f0b8eeadec1a?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80'),
          fit: BoxFit.cover),
    ),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          inicio(context),
          campoUsuario(),
          campoClave(),
          botonEntrar(context),
        ],
      ),
    ),
  );
} //fin del widget cuerpo

Widget inicio(BuildContext context) {
  return Text(
    AppLocalizations.of(context).welcome,
    style: const TextStyle(
        color: Colors.white, fontSize: 50, fontWeight: FontWeight.bold),
  );
} //fin del widget inicio

Widget campoUsuario() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: const TextField(
      decoration: InputDecoration(
          hintText: "Ingresa tu correo", filled: true, fillColor: Colors.white),
    ),
  );
} //fin del widget campoUsuario

Widget campoClave() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: const TextField(
      obscureText: true,
      decoration: InputDecoration(
          hintText: "Escribe tu clave", filled: true, fillColor: Colors.white),
    ),
  );
} //fin de la clale

Widget botonEntrar(BuildContext context) {
  return ElevatedButton(
    onPressed: () {
      Navigator.pushNamed(context, Routes.home);
    },
    style: TextButton.styleFrom(
      foregroundColor: Colors.black,
      backgroundColor: Colors.white,
    ),
    child: const Text('Ingresar'),
  );
}//fin del botonEntrar
