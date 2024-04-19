import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PaysDetailsPage extends StatefulWidget {
  final String nomPays;

  PaysDetailsPage(this.nomPays);

  @override
  _PaysDetailsPageState createState() => _PaysDetailsPageState();
}

class _PaysDetailsPageState extends State<PaysDetailsPage> {
  Map<String, dynamic>? paysData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _getPaysData();
  }

  Future<void> _getPaysData() async {
    String apiUrl = "https://restcountries.com/v2/name/${widget.nomPays}";

    http.Response response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      setState(() {
        List<dynamic> paysList = json.decode(response.body);
        if (paysList.isNotEmpty) {
          paysData = paysList[0];
          isLoading = false;
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Aucune donnée n'a été trouvée pour ce pays."),
          ));
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Erreur lors de la récupération des données du pays."),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Détails du pays : ${paysData != null && paysData!.containsKey('name') ? paysData!['name'] : widget.nomPays}",
          style: TextStyle(fontWeight: FontWeight.w800, color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ),
      backgroundColor: Colors.green[50],
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 10),
              paysData!['flags'] != null && paysData!['flags'].containsKey('png')
                  ? Image.network(
                paysData!['flags']['png'],
                height: 200,
              )
                  : Text("Drapeau non disponible"),

            SizedBox(height: 20),
            Text(
              "Informations",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center, // Centre les éléments horizontalement
              children: [
                Text("Capitale:"),
                SizedBox(width: 10),
                Text(paysData?['capital'] ?? "N/A"),
              ],
            ),
            SizedBox(height: 5),
            Text(
              "Langue(s):",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Arabe, Berbère"),
                SizedBox(width: 10),
                Text(paysData?['languages'][0]['name'] ?? "N/A"),
              ],
            ),
            SizedBox(height: 20),
            Text(
              "Géographie",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Région:"),
                SizedBox(width: 10),
                Text(paysData?['region'] ?? "N/A"),
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Superficie:"),
                SizedBox(width: 10),
                Text(paysData?['area']?.toString() ?? "N/A"),
              ],
            ),
            SizedBox(height: 20),
            Text(
              "Démographie",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Fuseau Horaire:"),
                SizedBox(width: 10),
                Text(paysData?['timezones'][0] ?? "N/A"),
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Population:"),
                SizedBox(width: 10),
                Text(paysData?['population']?.toString() ?? "N/A"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
