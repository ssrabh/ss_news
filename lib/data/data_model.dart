class NewsArticleModel {
  final String? category;
  final String? title;
  final String? subtitle;
  final String? author;
  final String? location;
  final DateTime? publishedDate;
  final String? publishedTime;
  final int? readersCount;
  final String? imageUrl;
  final String? content;

  NewsArticleModel({
    this.category,
    this.title,
    this.subtitle,
    this.author,
    this.location,
    this.publishedDate,
    this.publishedTime,
    this.readersCount,
    this.imageUrl,
    this.content,
  });

  factory NewsArticleModel.fromJson(Map<String, dynamic> json) {
    return NewsArticleModel(
      category: json['category'] as String?,
      title: json['title'] as String?,
      subtitle: json['subtitle'] as String?,
      author: json['author'] as String?,
      location: json['location'] as String?,
      publishedDate: json['publishedDate'] != null
          ? DateTime.tryParse(json['publishedDate'])
          : null,
      publishedTime: json['publishedTime'] as String?,
      readersCount: json['readersCount'] as int?,
      imageUrl: json['imageUrl'] as String?,
      content: json['content'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'title': title,
      'subtitle': subtitle,
      'author': author,
      'location': location,
      'publishedDate': publishedDate?.toIso8601String(),
      'publishedTime': publishedTime,
      'readersCount': readersCount,
      'imageUrl': imageUrl,
      'content': content,
    };
  }
}
