
class Categorie {
  final int id;
  final String name;

  const Categorie({
    required this.id,
    required this.name,
  });

  factory Categorie.fromJson(Map<String, dynamic> json) {
    return Categorie(
      id: json["id"] ?? 0,
      name: json["name"] ?? "Sans nom",
    );
  }
}