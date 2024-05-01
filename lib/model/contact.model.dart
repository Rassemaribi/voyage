class Contact {
  static String table = "contact";
  int? id;
  String? nom;
  int? tel;

  Contact({this.id, this.nom, this.tel});

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      id: json['id'],
      nom: json['nom'],
      tel: json['tel'] != null ? int.tryParse(json['tel']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nom': nom,
      'tel': tel,
    };
  }
}
