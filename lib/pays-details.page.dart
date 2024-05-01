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
                ? Column(
              children: [
                Image.network(
                  paysData!['flags']['png'],
                  height: 200,
                ),
                SizedBox(height: 5),
                Text(
                  "${paysData?['translations']['fr'] ?? "N/A"}",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ],
            )
                : Text("Drapeau non disponible"),

            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Administration",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.teal[800],),
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center, // Centre les éléments horizontalement
              children: [
                Text("Capitale:" ,style: TextStyle(fontSize: 18, color: Colors.grey,),),
                SizedBox(width: 10),
                Text(paysData?['capital'] ?? "N/A",style: TextStyle(fontSize: 18),),
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Langue:",style: TextStyle(fontSize: 18, color: Colors.grey,),),
                SizedBox(width: 10),
                Text(paysData?['languages'][0]['name'] ?? "N/A",style: TextStyle(fontSize: 18),),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Géographie",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.teal[800],),
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Région:",style: TextStyle(fontSize: 18, color: Colors.grey,),),
                SizedBox(width: 10),
                Text(paysData?['region'] ?? "N/A",style: TextStyle(fontSize: 18),),
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Superficie:",style: TextStyle(fontSize: 18, color: Colors.grey,),),
                SizedBox(width: 10),
                Text(paysData?['area']?.toString() ?? "N/A",style: TextStyle(fontSize: 18),),
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Fuseau Horaire:",style: TextStyle(fontSize: 18, color: Colors.grey,),),
                SizedBox(width: 10),
                Text(paysData?['timezones'][0] ?? "N/A",style: TextStyle(fontSize: 18),),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Démographie",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.teal[800],),
                ),
              ],
            ),

            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Population:",style: TextStyle(fontSize: 18, color: Colors.grey,),),
                SizedBox(width: 10),
                Text(paysData?['population']?.toString() ?? "N/A",style: TextStyle(fontSize: 18),),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
