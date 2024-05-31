// class BooksModel {
//   String? title;
//   String? author;
//   double? price;
//   String? classification;
//   String? coverbook;
//   List<String>? pages;

//   BooksModel({this.title, this.author, this.price, this.classification, this.coverbook, this.pages});

//   BooksModel.fromJson(Map<String, dynamic> json) {
//     title = json['title'];
//     author = json['author'];
//     price = json['price'];
//     classification = json['classification'];
//     coverbook = json['coverbook'];
//     pages = json['pages'].cast<String>();
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['title'] = title;
//     data['author'] = author;
//     data['price'] = price;
//     data['classification'] = classification;
//     data['coverbook'] = coverbook;
//     data['pages'] = pages;
//     return data;
//   }
// }
class BooksModel {
  int? id;
  String? title;
  String? author;
  double? price;
  String? classification;
  String? coverbook;
  List<String>? pages;

  BooksModel({this.id, this.title, this.author, this.price, this.classification, this.coverbook, this.pages});

  BooksModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    author = json['author'];
    price = json['price'];
    classification = json['classification'];
    coverbook = json['coverbook'];
    pages = json['pages'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['author'] = author;
    data['price'] = price;
    data['classification'] = classification;
    data['coverbook'] = coverbook;
    data['pages'] = pages;
    return data;
  }
}
