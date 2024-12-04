class Contact {
  String id;
  String name;
  String phone;
  String description;
  DateTime lastModified; // New field for date/time of save or modify

  Contact({
    required this.id,
    required this.name,
    required this.phone,
    required this.description,
    required this.lastModified,
  });

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      description: json['description'],
      lastModified: DateTime.parse(json['lastModified']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'description': description,
      'lastModified': lastModified.toIso8601String(),
    };
  }
}
