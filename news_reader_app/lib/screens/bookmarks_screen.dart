import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/news_model.dart';
import '../widgets/article_list.dart';

// Screen for displaying the bookmarked articles
class BookmarksScreen extends StatelessWidget {
  const BookmarksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmarked Articles'),
      ),
      body: Consumer<NewsModel>(
        builder: (context, newsModel, child) {
          return ArticleList(
            articles: newsModel.bookmarkedArticles,
            onDismissed: (article) {
              newsModel.removeBookmark(article);
            },
            isDismissible: true, // Dismissible in the bookmarks screen
          );
        },
      ),
    );
  }
}

