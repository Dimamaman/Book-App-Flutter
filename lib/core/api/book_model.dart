class BookModel {
  final String id;
  final String name;
  final String author;
  final String image;
  final String pdf;
  final String author_desc;

  const BookModel._({
    required this.id,
    required this.name,
    required this.author,
    required this.image,
    required this.pdf,
    required this.author_desc
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel._(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      author: json["author"] ?? "",
      image: json["image"] ?? "",
      pdf: json["pdf"] ?? "",
      author_desc: json["author_desc"] ?? ""
    );
  }

  factory BookModel.empty() {
    return BookModel.fromJson({});
  }
}
