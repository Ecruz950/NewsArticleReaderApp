import 'package:flutter/material.dart';
import '../models/article.dart';
import 'article_tile.dart';

// Widget for displaying a list of articles
class ArticleList extends StatelessWidget {
  final List<Article> articles; // List of articles to display
  final Function(Article)? onDismissed; // Nullable function for dismiss action
  final bool isDismissible; // Flag to determine if articles are dismissible

  const ArticleList(
      {super.key, required this.articles, this.onDismissed, this.isDismissible = false});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (context, index) {
        final article = articles[index];
        // Conditionally wrap the ArticleTile in a Dismissible widget
        if (isDismissible && onDismissed != null) {
          return Dismissible(
            key: Key(article.url),
            background: Container(color: Colors.red),
            onDismissed: (direction) {
              onDismissed!(article);  // Call the onDismissed callback
            },
            child: ArticleTile(article: article),
          );
        } else {
          return ArticleTile(article: article);
        }
      },
    );
  }
}
