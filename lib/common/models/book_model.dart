class BooksModel {
  int? id;
  String? title;
  String? author;
  String? classification;
  String? coverbook;
  String? pages;

  BooksModel({this.id, this.title, this.author, this.classification, this.coverbook, this.pages});

  BooksModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    author = json['author'];
    classification = json['classification'];
    coverbook = json['coverbook'];
    pages = json['pages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['author'] = author;
    data['classification'] = classification;
    data['coverbook'] = coverbook;
    data['pages'] = pages;
    return data;
  }
}
