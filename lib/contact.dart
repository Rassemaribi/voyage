import 'package:flutter/material.dart';
import 'package:repository/mydawer/MyDrawer.dart';
import '../services/contact.service.dart';
import '../model/contact.model.dart';
import 'ajout_modif_contact.page.dart';

class ContactPage extends StatefulWidget {
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  ContactService contactService = ContactService();
  List<Contact> contacts = [];

  @override
  void initState() {
    super.initState();
    _chargerContacts();

  }

  // Méthode pour charger les contacts depuis le service
  void _chargerContacts() {
    contactService.listeContacts().then((liste) {
      setState(() {
        contacts = liste;
      });
      print("Nombre de contacts chargés : ${contacts.length}");
    }).catchError((error) {
      print("Erreur lors du chargement des contacts: $error");
    });
  }

  void _supprimerContact(Contact contact) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Supprimer Contact"),
          content: Text("Êtes-vous sûr de vouloir supprimer ce contact?"),
          actions: [
            TextButton(
              onPressed: () {
                contactService.supprimerContact(contact).then((value) {
                  setState(() {
                    Navigator.of(context).pop();
                    _chargerContacts();
                  });
                });
              },
              child: Text("Oui"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Non"),
            ),
          ],
        );
      },
    );
  }

  void _modifierContact(Contact contact) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AjoutModifContactPage(contactToUpdate: contact),
      ),
    ).then((_) {
      _chargerContacts();
    });
  }

  void _ajouterContact() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AjoutModifContactPage(),
      ),
    ).then((_) {
      _chargerContacts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Contact",
          style: TextStyle(fontWeight: FontWeight.w800, color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ),
      drawer: MyDrawer(),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('image/background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.2),
              BlendMode.dstATop,
            ),
          ),
        ),
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: _ajouterContact,
                  child: Text("Ajout"),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    primary: Colors.green,
                    onPrimary: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: DataTable(
                  headingRowColor: MaterialStateColor.resolveWith((states) => Colors.green),
                  columns: const [
                    DataColumn(
                      label: Text(
                        'Nom',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Téléphone',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Actions',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ), // Colonnes pour les actions
                  ],
                  rows: contacts.map((contact) {
                    return DataRow(cells: [
                      DataCell(Text(contact.nom ?? '')),
                      DataCell(Text(contact.tel?.toString() ?? '')),
                      DataCell(
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                _supprimerContact(contact);
                              },
                              color: Colors.red,
                            ),
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                _modifierContact(contact);
                              },
                              color: Colors.blue,
                            ),
                          ],
                        ),
                      ),
                    ]);
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
