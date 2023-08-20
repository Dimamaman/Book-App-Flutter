class BookModel {
  final String id;
  final String name;
  final String author;
  final String biography;
  final String overview;
  final String image;
  final String pdf;

  const BookModel._({
    required this.id,
    required this.name,
    required this.author,
    required this.biography,
    required this.overview,
    required this.image,
    required this.pdf,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel._(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      author: json["author"] ?? "",
      biography: json["biography"] ?? "",
      overview: json["overview"] ?? "",
      image: json["image"] ?? "",
      pdf: json["pdf"] ?? "",
    );
  }

  factory BookModel.empty() {
    return BookModel.fromJson({});
  }
}
