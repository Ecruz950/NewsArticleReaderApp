// Widget tests for Custom Widgets
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:cs442_mp6/models/article.dart';
import 'package:cs442_mp6/models/news_model.dart';
import 'package:cs442_mp6/widgets/article_tile.dart';

void main() {
  group('ArticleTile Widget Tests', () {
    final article = Article(
      title: 'Test Article',
      description: 'This is a test description.',
      url: 'http://testurl.com',
      urlToImage: '', // Use empty URL to test the placeholder
      author: 'Test Author',
      source: 'Test Source',
      publishedAt: DateTime.parse('2023-01-01T12:00:00Z'),
    );

    testWidgets('Displays article information', (WidgetTester tester) async {
      final article = Article(
        title: 'Test Article',
        description: 'This is a test description.',
        url: 'http://testurl.com',
        urlToImage: '',
        author: 'Test Author',
        source: 'Test Source',
        publishedAt: DateTime.parse('2023-01-01T12:00:00Z'),
      );

      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (_) => NewsModel(),
          child: MaterialApp(
            home: Scaffold(
              body: ArticleTile(article: article),
            ),
          ),
        ),
      );

      expect(find.text('Test Article'), findsOneWidget);
      expect(find.text('This is a test description.'), findsOneWidget);
      expect(find.text('Author: Test Author'),
          findsOneWidget); // Ensure "Author: Test Author"
      expect(find.text('Source: Test Source'),
          findsOneWidget); // Ensure "Source: Test Source"
      // Specify the exact IconButton or icon to find
      expect(
          find.descendant(
              of: find.byType(ListTile), matching: find.byIcon(Icons.bookmark)),
          findsOneWidget);
    });



    testWidgets('Bookmarks an article when bookmark button is pressed',
        (WidgetTester tester) async {
      final newsModel = NewsModel();

      await tester.pumpWidget(
        ChangeNotifierProvider.value(
          value: newsModel,
          child: MaterialApp(
            home: Scaffold(
              body: ArticleTile(article: article),
            ),
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.bookmark));
      await tester.pump();

      expect(newsModel.bookmarkedArticles.contains(article), isTrue);
      expect(find.byIcon(Icons.bookmark), findsOneWidget);
    });

    testWidgets('Marks an article as read when tapped',
        (WidgetTester tester) async {
      final newsModel = NewsModel();

      await tester.pumpWidget(
        ChangeNotifierProvider.value(
          value: newsModel,
          child: MaterialApp(
            home: Scaffold(
              body: ArticleTile(article: article),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Test Article'));
      await tester.pumpAndSettle();

      expect(newsModel.readArticles.contains(article), isTrue);
    });

    testWidgets('Displays placeholder when image fails to load',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (_) => NewsModel(),
          child: MaterialApp(
            home: Scaffold(
              body: ArticleTile(
                article: Article(
                  title: 'Test Article',
                  description: 'This is a test description.',
                  url: 'http://testurl.com',
                  urlToImage:
                      'http://invalidurl.com/image.png', // Invalid image URL
                  author: 'Test Author',
                  source: 'Test Source',
                  publishedAt: DateTime.parse('2023-01-01T12:00:00Z'),
                ),
              ),
            ),
          ),
        ),
      );

      await tester.pump();

      expect(find.byIcon(Icons.image_not_supported), findsOneWidget);
    });

    testWidgets('Handles articles with missing image gracefully',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (_) => NewsModel(),
          child: MaterialApp(
            home: Scaffold(
              body: ArticleTile(
                article: Article(
                  title: 'Test Article',
                  description: 'This is a test description.',
                  url: 'http://testurl.com',
                  urlToImage: '', // No image URL
                  author: 'Test Author',
                  source: 'Test Source',
                  publishedAt: DateTime.parse('2023-01-01T12:00:00Z'),
                ),
              ),
            ),
          ),
        ),
      );

      await tester.pump();

      expect(find.byIcon(Icons.image_not_supported), findsOneWidget);
    });
  });
}

