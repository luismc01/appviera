import 'package:arquiapp/paginas/digitales.dart';
import 'package:arquiapp/rutas/routes.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                accountName: const Text('Luis Mariscal'),
                accountEmail: const Text('luismar@gmail.com'),
                currentAccountPicture: CircleAvatar(
                  child: ClipOval(
                    child: Image.network(
                      'https://images.unsplash.com/photo-1623912279015-d748d9cd8978?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            'https://images.unsplash.com/photo-1532040683343-edbde6dd500d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1176&q=80'),
                        fit: BoxFit.cover)),
              ),
              ListTile(
                leading: const Icon(Icons.cake),
                title: const Text('Vitrina'),
                subtitle: const Text('Postres de Vitrinas'),
                onTap: () {
                  Navigator.popAndPushNamed(context, Routes.maquetas);
                },
              ),
              ListTile(
                leading: const Icon(Icons.breakfast_dining_outlined),
                title: const Text('Temporada'),
                subtitle: const Text('Pastel de temporada'),
                onTap: () {
                  Navigator.popAndPushNamed(context, Routes.fisicos);
                },
              ),
              ListTile(
                leading: const Icon(Icons.cake_outlined),
                title: const Text('Pasteles especiales'),
                subtitle: const Text('Pasteles por pedido'),
                onTap: () {
                  Navigator.popAndPushNamed(context, Routes.digitales);
                },
              ),
              const Divider(),
              ListTile(
                  leading: const Icon(
                    Icons.logout,
                    color: Colors.black,
                    size: 30,
                  ),
                  title: const Text('Cerrar sesión'),
                  onTap: () {
                    Navigator.popAndPushNamed(context, Routes.login);
                  }),
            ],
          ),
        ),
        appBar: AppBar(
          title: const Text('Inicio'),
          centerTitle: true,
          backgroundColor: ColorTheme.black,
        ),
        body: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(5),
            ),
            Expanded(
              child: Image.asset('assets/images/logo.png'),
            ),
            const Padding(
              padding: EdgeInsets.all(10),
            ),
            const Expanded(
              child: Text(
                'Pasteles y postres 100% personalizados a la temática de tu evento, con servicio a domicilio.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.purple,
                  backgroundColor: Colors.white70,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  letterSpacing: 2,
                ),
              ),
            )
          ],
        ));
  }
}
