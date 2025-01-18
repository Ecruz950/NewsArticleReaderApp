// Model for a news article
class Article {
  final String title; // Title of the article
  final String description; // Description of the article
  final String url; // URL of the full article
  final String urlToImage; // URL of the article image
  final String author; // Author of the article
  final String source; // Source of the article
  final DateTime publishedAt; // Date and time of publication

  Article({
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.author,
    required this.source,
    required this.publishedAt,
  });

  // Factory method to create an Article object from JSON data
  factory Article.fromJson(Map<String, dynamic> json) {
    // Safely parse the source as a Map to extract 'name' field
    final sourceInfo = json['source'];
    final sourceName = sourceInfo is Map<String, dynamic>
        ? sourceInfo['name']
        : 'Unknown source';

    return Article(
      title: json['title'] ?? 'No title available',
      description: json['description'] ?? 'No description available',
      url: json['url'] ?? '',
      urlToImage: json['urlToImage'] ?? '',
      author: json['author'] ?? 'Unknown author',
      source: sourceName ?? 'Unknown source',
      publishedAt:
          DateTime.tryParse(json['publishedAt'] ?? '') ?? DateTime.now(),
    );
  }

  // Method to convert an Article object to JSON data
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'author': author,
      'source': {'name': source}, // Ensure source is serialized properly
      'publishedAt': '${publishedAt.toIso8601String().split('.').first}Z',
    };
  }

  // Override the equality operator to compare Article objects by URL
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Article && other.url == url;
  }
  // Override the hashCode property to match the overridden equality operator
  @override
  int get hashCode => url.hashCode;
}
