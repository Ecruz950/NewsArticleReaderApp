// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:flutter/material.dart';
import '../models/article.dart';
import 'package:intl/intl.dart'; // For formatting date and time
import 'package:url_launcher/url_launcher.dart'; // For launching URLs

// Screen for displaying the details of an article
class ArticleDetailScreen extends StatelessWidget {
  final Article article;

  const ArticleDetailScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    final formattedDate =
        DateFormat('yyyy-MM-dd').format(article.publishedAt); // Format the date

    // Return a Scaffold widget with the article details
    return Scaffold(
      appBar: AppBar(
        title: Text(article.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Conditionally display the article image or a placeholder icon
            article.urlToImage.isNotEmpty
                ? Image.network(article.urlToImage)
                : Container(
                    height: 200,
                    color: Colors.grey[300],
                    child: const Center(child: Icon(Icons.image_not_supported)),
                  ),
            const SizedBox(height: 16),
            Text(
              article.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(article.description.isEmpty
                ? 'No description available'
                : article.description),
            const SizedBox(height: 16),
            Text('Author: ${article.author}'),
            Text('Source: ${article.source}'),
            Text('Published: $formattedDate'),
            const SizedBox(height: 16),
            // Button to open the full article in a web browser
            ElevatedButton(
              onPressed: () async {
                if (await canLaunch(article.url)) {
                  await launch(article.url);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Could not launch article URL')),
                  );
                }
              },
              child: const Center(
                child: Text('Read Full Article'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
