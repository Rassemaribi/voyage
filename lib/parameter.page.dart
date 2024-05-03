import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ParameterPage extends StatefulWidget {
  @override
  _ParametresPageState createState() => _ParametresPageState();
}

class _ParametresPageState extends State<ParameterPage> {
  String mode = "Jour";
  final DatabaseReference ref = FirebaseDatabase.instance.reference(); // Référence à la base de données Firebase

  void _onSaveMode() async {
    await ref.child('mode').set(mode); // Enregistrer la valeur de mode dans la base de données
    print("Mode appliqué: $mode");
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Paramètres"),
        backgroundColor: Colors.green,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text('Mode', style: TextStyle(fontSize: 22)),
          Column(
            children: [
              ListTile(
                title: const Text('Jour'),
                leading: Radio<String>(
                  value: "Jour",
                  groupValue: mode,
                  onChanged: (value) {
                    setState(() {
                      mode = value!;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Nuit'),
                leading: Radio<String>(
                  value: "Nuit",
                  groupValue: mode,
                  onChanged: (value) {
                    setState(() {
                      mode = value!;
                    });
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                  ),
                  onPressed: () {
                    _onSaveMode();
                  },
                  child: Text("Enregistrer", style: TextStyle(fontSize: 22)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
