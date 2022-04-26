import 'package:news_app/models/source_model.dart';

class NewsModel {
  late Source? source;
   late String? author;
   late String? title;
   late String? description;
   late String? url;
   late String? urlToImage;
   late String? publishedAt;
   late String? content;

  NewsModel({
     this.source,
     this.author,
    
     this.title,
     this.description,
     this.url,
     this.urlToImage,
     this.publishedAt,
     this.content,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      source: Source.fromJson(json['source']),
      author: json['author'],
      title: json['title'],
      description: json['description'],
      url: json['url'],
      urlToImage: json['urlToImage'],
      publishedAt: json['publishedAt'],
      content: json['content'],
    );
  }
}
