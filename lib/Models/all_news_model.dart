class AllNewsModel {
  int? totalArticles;
  List<Article>? articles;

  AllNewsModel({
    this.totalArticles,
    this.articles,
  });

  factory AllNewsModel.fromJson(Map<String, dynamic> json) {
    return AllNewsModel(
      totalArticles: json['totalArticles'],
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
    this.title,
    this.description,
    this.url,
    this.image,
    this.publishedAt,
    this.content,
  });

  Source? source;
  String? title;
  String? description;
  String? url;
  String? image;
  DateTime? publishedAt;
  String? content;

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      source: Source.fromJson(json["source"]),
      title: json['title'],
      description: json['description'],
      url: json['url'],
      image: json['image'],
      publishedAt: json['publishedAt'] != null
          ? DateTime.parse(json['publishedAt'])
          : null,
      content: json['content'],
    );
  }
}

class Source {
  Source({
    this.url,
    this.name,
  });

  String? url;
  String? name;

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(
      url: json['url'] ?? '',
      name: json['name'],
    );
  }
}
