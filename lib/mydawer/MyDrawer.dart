import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.white, Colors.green],
              ),
            ),
            child: Center(
              child: CircleAvatar(
                backgroundImage: AssetImage("image/racem.png"),
                radius: 80,
              ),
            ),
          ),
          ListTile(
            title: Text('Accueil', style: TextStyle(fontSize: 22)),
            leading: Icon(Icons.home, color: Colors.green),
            trailing: Icon(Icons.arrow_right, color: Colors.lightGreen),
            onTap: () {
              Navigator.pop(context); // Ferme le tiroir
              Navigator.pushNamed(context, '/home'); // Navigue vers la page d'accueil
            },
          ),
          ListTile(
            title: Text('Météo', style: TextStyle(fontSize: 22)),
            leading: Icon(Icons.ac_unit, color: Colors.green),
            trailing: Icon(Icons.arrow_right, color: Colors.lightGreen),
            onTap: () {
              Navigator.pop(context); // Ferme le tiroir
              Navigator.pushNamed(context, '/meteo'); // Navigue vers la page de météo
            },
          ),
          ListTile(
            title: Text('Galerie', style: TextStyle(fontSize: 22)),
            leading: Icon(Icons.add_a_photo, color: Colors.green),
            trailing: Icon(Icons.arrow_right, color: Colors.lightGreen),
            onTap: () {
              Navigator.pop(context); // Ferme le tiroir
              Navigator.pushNamed(context, '/gallerie'); // Navigue vers la page de la galerie
            },
          ),
          ListTile(
            title: Text('Pays', style: TextStyle(fontSize: 22)),
            leading: Icon(Icons.account_balance, color: Colors.green),
            trailing: Icon(Icons.arrow_right, color: Colors.lightGreen),
            onTap: () {
              Navigator.pop(context); // Ferme le tiroir
              Navigator.pushNamed(context, '/pays'); // Navigue vers la page des pays
            },
          ),
          ListTile(
            title: Text('Contact', style: TextStyle(fontSize: 22)),
            leading: Icon(Icons.account_box_outlined, color: Colors.green),
            trailing: Icon(Icons.arrow_right, color: Colors.lightGreen),
            onTap: () {
              Navigator.pop(context); // Ferme le tiroir
              Navigator.pushNamed(context, '/contact'); // Navigue vers la page de contact
            },
          ),
          ListTile(
            title: Text('Paramètre', style: TextStyle(fontSize: 22)),
            leading: Icon(Icons.adb, color: Colors.green),
            trailing: Icon(Icons.arrow_right, color: Colors.lightGreen),
            onTap: () {
              Navigator.pop(context); // Ferme le tiroir
              Navigator.pushNamed(context, '/parameter'); // Navigue vers la page des paramètres
            },
          ),
          ListTile(
            title: Text('Déconnexion', style: TextStyle(fontSize: 22)),
            leading: Icon(Icons.logout, color: Colors.lightGreen),
            onTap: () {
              _onDeconnexion(context); // Appelle la fonction de déconnexion
            },
          ),
        ],
      ),
    );
  }

  Future<void> _onDeconnexion(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("connecte", false);
    Navigator.pop(context); // Ferme le tiroir
    Navigator.pushNamedAndRemoveUntil(context, '/authentification', (route) => false);
  }
}
