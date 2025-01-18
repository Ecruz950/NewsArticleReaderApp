import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/news_model.dart';
import '../widgets/article_list.dart';

// Screen for displaying the read articles
class ReadArticlesScreen extends StatelessWidget {
  const ReadArticlesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Read Articles'),
      ),
      body: Consumer<NewsModel>(
        builder: (context, newsModel, child) {
          return ArticleList(
            articles: newsModel.readArticles,
            onDismissed: (article) {
              newsModel.removeReadArticle(article);
            },
            isDismissible: true, // Dismissible in the read articles screen
          );
        },
      ),
    );
  }
}
