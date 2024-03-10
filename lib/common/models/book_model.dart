class BooksModel {
  String? title;
  String? author;
  double? price;
  String? classification;
  String? coverbook;

  BooksModel(
      {this.title,
      this.author,
      this.price,
      this.classification,
      this.coverbook});

  BooksModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    author = json['author'];
    price = json['price'];
    classification = json['classification'];
    coverbook = json['coverbook'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['author'] = author;
    data['price'] = price;
    data['classification'] = classification;
    data['coverbook'] = coverbook;
    return data;
  }
}
