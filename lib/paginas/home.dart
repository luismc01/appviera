import 'package:arquiapp/paginas/digitales.dart';
import 'package:arquiapp/rutas/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final widthSize = MediaQuery.of(context).size.width;
    final hightSize = MediaQuery.of(context).size.height;

    bool isDesktop(BuildContext context) => widthSize >= 600;

    return Scaffold(
        drawer: Drawer(
          child: ListView(
            children: [
              // https://ichef.bbci.co.uk/news/800/cpsprodpb/C130/production/_110665494_gettyimages-1188309781.jpg
              UserAccountsDrawerHeader(
                accountName: const Text('Luis Mariscal'),
                accountEmail: const Text('luismar@gmail.com'),
                currentAccountPicture: CircleAvatar(
                  child: ClipOval(
                    child: Image.network(
                      isDesktop(context)
                          ? 'https://images.unsplash.com/photo-1623912279015-d748d9cd8978?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80'
                          : 'https://ichef.bbci.co.uk/news/800/cpsprodpb/C130/production/_110665494_gettyimages-1188309781.jpg',
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
                // textColor: Colors.amber,
                leading: const Icon(Icons.cake),
                title: Text(AppLocalizations.of(context).drawerVitrina1),
                subtitle: Text(AppLocalizations.of(context).drawerVitrina2),
                onTap: () {
                  Navigator.popAndPushNamed(context, Routes.maquetas);
                },
              ),
              ListTile(
                leading: const Icon(Icons.breakfast_dining_outlined),
                title: Text(AppLocalizations.of(context).drawerTemp1),
                subtitle: Text(AppLocalizations.of(context).drawerTemp2),
                onTap: () {
                  Navigator.popAndPushNamed(context, Routes.fisicos);
                },
              ),
              ListTile(
                leading: const Icon(Icons.cake_outlined),
                title: Text(AppLocalizations.of(context).drawerSpec1),
                subtitle: Text(AppLocalizations.of(context).drawerSpec2),
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
                  title: Text(AppLocalizations.of(context).drawerSesion),
                  onTap: () {
                    Navigator.popAndPushNamed(context, Routes.login);
                  }),
            ],
          ),
        ),
        appBar: AppBar(
          title: Text(AppLocalizations.of(context).appBar1),
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
            Expanded(
              child: Text(
                AppLocalizations.of(context).cakesAndSesserts,
                textAlign: TextAlign.center,
                style: const TextStyle(
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
