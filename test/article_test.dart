// Unit tests for the Model classes 
import 'package:flutter_test/flutter_test.dart';
import 'package:cs442_mp6/models/article.dart';

void main() {
  group('Article Model Tests', () {
    test('fromJson creates an Article object from valid JSON', () {
      final Map<String, dynamic> json = {
        'title': 'Test Title',
        'description': 'Test Description',
        'url': 'http://testurl.com',
        'urlToImage': 'http://testurl.com/image.png',
        'author': 'Test Author',
        'source': {'name': 'Test Source'},
        'publishedAt': '2023-01-01T12:00:00Z',
      };

      final article = Article.fromJson(json);

      expect(article.title, 'Test Title');
      expect(article.description, 'Test Description');
      expect(article.url, 'http://testurl.com');
      expect(article.urlToImage, 'http://testurl.com/image.png');
      expect(article.author, 'Test Author');
      expect(article.source, 'Test Source');
      expect(article.publishedAt, DateTime.parse('2023-01-01T12:00:00Z'));
    });

    test('toJson creates a valid JSON map from an Article object', () {
      final article = Article(
        title: 'Test Title',
        description: 'Test Description',
        url: 'http://testurl.com',
        urlToImage: 'http://testurl.com/image.png',
        author: 'Test Author',
        source: 'Test Source',
        publishedAt: DateTime.parse('2023-01-01T12:00:00Z'),
      );

      final json = article.toJson();

      expect(json['title'], 'Test Title');
      expect(json['description'], 'Test Description');
      expect(json['url'], 'http://testurl.com');
      expect(json['urlToImage'], 'http://testurl.com/image.png');
      expect(json['author'], 'Test Author');
      expect(json['source']['name'], 'Test Source');
      expect(json['publishedAt'], '2023-01-01T12:00:00Z');
    });

    test('Handles null values in JSON gracefully', () {
      final Map<String, dynamic> json = {
        'title': null,
        'description': null,
        'url': null,
        'urlToImage': null,
        'author': null,
        'source': {'name': null},
        'publishedAt': null,
      };

      final article = Article.fromJson(json);

      expect(article.title, 'No title available');
      expect(article.description, 'No description available');
      expect(article.url, '');
      expect(article.urlToImage, '');
      expect(article.author, 'Unknown author');
      expect(article.source, 'Unknown source');
      expect(article.publishedAt, isNotNull);
    });

    test('Handles empty JSON gracefully', () {
      final Map<String, dynamic> json = {};

      final article = Article.fromJson(json);

      expect(article.title, 'No title available');
      expect(article.description, 'No description available');
      expect(article.url, '');
      expect(article.urlToImage, '');
      expect(article.author, 'Unknown author');
      expect(article.source, 'Unknown source');
      expect(article.publishedAt, isNotNull);
    });

    test('Equality and hashCode are based on URL', () {
      final article1 = Article(
        title: 'Test Title',
        description: 'Test Description',
        url: 'http://testurl.com',
        urlToImage: 'http://testurl.com/image.png',
        author: 'Test Author',
        source: 'Test Source',
        publishedAt: DateTime.parse('2023-01-01T12:00:00Z'),
      );

      final article2 = Article(
        title: 'Different Title',
        description: 'Different Description',
        url: 'http://testurl.com',
        urlToImage: 'http://differenturl.com/image.png',
        author: 'Different Author',
        source: 'Different Source',
        publishedAt: DateTime.parse('2023-02-01T12:00:00Z'),
      );

      expect(article1 == article2, isTrue);
      expect(article1.hashCode, article2.hashCode);
    });
  });
}
