import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

import '../services/contact.service.dart';
import 'model/contact.model.dart';


class AjoutModifContactPage extends StatefulWidget {
  final Contact? contactToUpdate;

  AjoutModifContactPage({Key? key, this.contactToUpdate}) : super(key: key);

  @override
  _AjoutModifContactPageState createState() => _AjoutModifContactPageState();
}

class _AjoutModifContactPageState extends State<AjoutModifContactPage> {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  late Contact contact;
  ContactService contactService = ContactService();
  bool isAdding = true;

  @override
  void initState() {
    super.initState();
    if (widget.contactToUpdate != null) {
      contact = widget.contactToUpdate!;
      isAdding = false;
    } else {
      contact = Contact();
      isAdding = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    String appBarTitle = isAdding ? "Ajouter Contact" : "Modifier Contact";
    String buttonLabel = isAdding ? "Enregistrer" : "Modifier";
    return Scaffold(
      appBar: AppBar(
        title: Text(
          appBarTitle,
          style: TextStyle(fontWeight: FontWeight.w800, color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ),
      body: Form(
        key: globalKey,
        child: _formUI(context),
      ),
      bottomNavigationBar: SizedBox(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FormHelper.submitButton(
              buttonLabel,
                  () {
                if (validateAndSave()) {
                  if (isAdding) {
                    contactService.ajouterContact(contact).then((value) {
                      Navigator.pop(context);
                    });
                  } else {
                    contactService.modifierContact(contact).then((value) {
                      Navigator.pop(context);
                    });
                  }
                }
              },
              borderRadius: 10,
              btnColor: Colors.green,
              borderColor: Colors.green,
            ),
            FormHelper.submitButton(
              "Annuler",
                  () {
                Navigator.pop(context);
              },
              borderRadius: 10,
              btnColor: Colors.grey,
              borderColor: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  Widget _formUI(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            FormHelper.inputFieldWidgetWithLabel(
              context,
              "nom",
              "Nom",
              "*",
                  (onValidate) {
                if (onValidate.isEmpty) {
                  return "* Champ requis";
                }
                return null;
              },
                  (onSaved) {
                contact.nom = onSaved.toString().trim();
              },
              initialValue: contact.nom ?? "",
              showPrefixIcon: true,
              prefixIcon: Icon(Icons.text_fields),
              borderRadius: 10,
              contentPadding: 15,
              fontSize: 14,
              labelFontSize: 14,
              paddingLeft: 0,
              paddingRight: 0,
              prefixIconPaddingLeft: 10,
            ),
            FormHelper.inputFieldWidgetWithLabel(
              context,
              "telephone",
              "Téléphone",
              "*",
                  (onValidate) {
                if (onValidate.isEmpty) {
                  return "* Champ requis";
                }
                return null;
              },
                  (onSaved) {
                contact.tel = int.parse(onSaved.toString().trim());
              },
              initialValue: contact.tel?.toString() ?? "",
              showPrefixIcon: true,
              prefixIcon: Icon(Icons.phone),
              borderRadius: 10,
              contentPadding: 15,
              fontSize: 14,
              labelFontSize: 14,
              paddingLeft: 0,
              paddingRight: 0,
              prefixIconPaddingLeft: 10,
              isNumeric: true,
            ),
          ],
        ),
      ),
    );
  }

  bool validateAndSave() {
    final form = globalKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
