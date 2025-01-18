import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/article.dart';
import '../models/news_model.dart';
import '../screens/article_detail_screen.dart';
import 'package:intl/intl.dart'; // For formatting date and time

// Widget for displaying a single article tile
class ArticleTile extends StatelessWidget {
  final Article article;

  const ArticleTile({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    final newsModel = Provider.of<NewsModel>(context);
    final isBookmarked = newsModel.bookmarkedArticles.contains(article);  // Check if the article is bookmarked
    final formattedDate =
        DateFormat('yyyy-MM-dd').format(article.publishedAt); // Format the date

    // Return a ListTile widget with the article details
    return ListTile(
      title: Text(article.title),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            article.description.isEmpty
                ? 'No description available'
                : article.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          if (article.author.isNotEmpty) Text('Author: ${article.author}'), // Display author if available
          //Text('Source: ${article.source}'),
          if (article.source.isNotEmpty) Text('Source: ${article.source}'), // Display source name if available
          Text('Published: $formattedDate'),
        ],
      ),
      // Conditionally display the article image or a placeholder icon
      leading: article.urlToImage.isNotEmpty
          ? Image.network(
              article.urlToImage,
              width: 100,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 100,
                  height: 100,
                  color: Colors.grey[300],
                  child: const Icon(Icons.image_not_supported),
                );
              },
            )
          : Container(
              width: 100,
              height: 100,
              color: Colors.grey[300],
              child: const Icon(Icons.image_not_supported),
            ),
      trailing: IconButton(
        icon: const Icon(Icons.bookmark),
        color: isBookmarked ? Colors.yellow : null, // Highlight if bookmarked
        onPressed: () {
          if (isBookmarked) { // Remove the article from bookmarks if already bookmarked
            newsModel.removeBookmark(article);
          } else {  // Add the article to bookmarks if not bookmarked
            newsModel.addBookmark(article);
          }
        },
      ),
      onTap: () {
        newsModel.markAsRead(article); // Mark the article as read
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ArticleDetailScreen(article: article),  // Navigate to the article detail screen
          ),
        );
      },
    );
  }
}
