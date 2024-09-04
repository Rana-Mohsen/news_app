import 'package:intl/intl.dart';

class ArticleModel {
    Source? source;
    String? author;
    String? title;
    String? description;
    String? url;
    String? urlToImage;
    String? publishedAt;
    String? content;

    ArticleModel({
        this.source,
        this.author,
        this.title,
        this.description,
        this.url,
        this.urlToImage,
        this.publishedAt,
        this.content,
    });

    factory ArticleModel.fromJson(Map<String, dynamic> json) => ArticleModel(
        source: json["source"] == null ? null : Source.fromJson(json["source"]),
        author: json["author"],
        title: json["title"],
        description: json["description"],
        url: json["url"],
        urlToImage: json["urlToImage"],
        publishedAt: json["publishedAt"],
        content: json["content"],
    );

    Map<String, dynamic> toJson() => {
        "source": source?.toJson(),
        "author": author,
        "title": title,
        "description": description,
        "url": url,
        "urlToImage": urlToImage,
        "publishedAt": publishedAt,
        "content": content,
    };

    String getFormattedDate() {
        if (publishedAt == null) return '';
        DateTime dateTime = DateTime.parse(publishedAt!);
        return DateFormat('EEEE, d MMMM yyyy').format(dateTime);
    }
}

class Source {
    String? id;
    String? name;

    Source({
        this.id,
        this.name,
    });

    factory Source.fromJson(Map<String, dynamic> json) => Source(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
