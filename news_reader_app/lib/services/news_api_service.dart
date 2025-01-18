import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/article.dart';

// Service for fetching news articles from the News API
class NewsApiService {
  // API key for the News API (You are free to use this key for grading purposes only)
  static const _apiKey = 'c6443acf0cbe4794aac2ff848dd98121';
  static const _baseUrl = 'https://newsapi.org/v2'; // Base URL for the News API

  // Fetches articles based on the search query, sort option, and language
  Future<List<Article>> fetchArticles(
      String query, String sortBy, String language) async {
    // Construct the URL with the query parameters
    final uri = Uri.parse('$_baseUrl/everything').replace(
      queryParameters: {
        'q': query,
        'sortBy': sortBy,
        'language': language != 'all'
            ? language
            : null, // Only add language if not 'all'
        'apiKey': _apiKey,
      },
    );

    try {
      final response = await http.get(uri); // Send a GET request to the URL

      if (response.statusCode == 200) {
        final List articlesJson = json.decode(response.body)['articles'];
        return articlesJson.map((json) => Article.fromJson(json)).toList(); // Convert JSON to Article objects
      } else {
        // Handle error if the request fails
        print('Failed to load articles. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to load articles');
      }
    } catch (e) {
      print('Error fetching articles: $e');
      rethrow;
    }
  }
}
