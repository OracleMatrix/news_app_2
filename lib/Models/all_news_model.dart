class AllNewsModel {
  String? status;
  int? totalResults;
  List<Article>? articles;

  AllNewsModel({
    this.status,
    this.totalResults,
    this.articles,
  });

  factory AllNewsModel.fromJson(Map<String, dynamic> json) {
    return AllNewsModel(
      status: json['status'],
      totalResults: json['totalResults'],
      articles: (json['articles'] as List<dynamic>?)
          ?.map(
            (e) => Article.fromJson(e),
          )
          .toList(),
    );
  }
}

class Article {
  Article({
    this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  Source? source;
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  DateTime? publishedAt;
  String? content;

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      source: Source.fromJson(json["source"]),
      author: json['author'],
      title: json['title'],
      description: json['description'],
      url: json['url'],
      urlToImage: json['urlToImage'],
      publishedAt: json['publishedAt'] != null
          ? DateTime.parse(json['publishedAt'])
          : null,
      content: json['content'],
    );
  }
}

class Source {
  Source({
    this.id,
    this.name,
  });

  String? id;
  String? name;

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(
      id: json['id'] ?? '',
      name: json['name'],
    );
  }
}
