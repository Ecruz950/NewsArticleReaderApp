import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'article.dart';
import 'dart:convert';

// Model class for managing news data
class NewsModel with ChangeNotifier {
  final List<Article> _articles = [];
  List<Article> _bookmarkedArticles = [];
  List<Article> _readArticles = [];
  List<String> _previousSearches = [];

  List<Article> get articles => _articles;  // Getter for articles
  List<Article> get bookmarkedArticles => _bookmarkedArticles;  // Getter for bookmarked articles
  List<Article> get readArticles => _readArticles;  // Getter for read articles
  List<String> get previousSearches => _previousSearches; // Getter for previous searches

  // Method for adding an article to the list
  void addArticle(Article article) {
    _articles.add(article);
    notifyListeners();
  }

  // Method for clearing the list of articles
  void clearArticles() {
    _articles.clear();
    notifyListeners();
  }

  // Method for adding a bookmarked article
  void addBookmark(Article article) {
    if (!_bookmarkedArticles.contains(article)) {
      _bookmarkedArticles.add(article);
      persistData();
      notifyListeners();
    }
  }

  // Method for removing a bookmarked article
  void removeBookmark(Article article) {
    _bookmarkedArticles.remove(article);
    persistData();
    notifyListeners();
  }

  // Method for marking an article as read
  void markAsRead(Article article) {
    if (!_readArticles.contains(article)) {
      _readArticles.add(article);
      persistData();
      notifyListeners();
    }
  }

  // Method for removing a read article
  void removeReadArticle(Article article) {
    _readArticles.remove(article);
    persistData();
    notifyListeners();
  }

  // Method for adding a search query to the list
  void addSearch(String search) {
    if (!_previousSearches.contains(search)) {
      _previousSearches.add(search);
      persistData();
      notifyListeners();
    }
  }

  // Method for removing a search query from the list
  Future<void> loadPersistedData() async {
    final prefs = await SharedPreferences.getInstance();
    final bookmarkedJson = prefs.getStringList('bookmarked') ?? [];
    final readJson = prefs.getStringList('read') ?? [];
    final searches = prefs.getStringList('searches') ?? [];

    _bookmarkedArticles =
        bookmarkedJson.map((s) => Article.fromJson(json.decode(s))).toList();
    _readArticles =
        readJson.map((s) => Article.fromJson(json.decode(s))).toList();
    _previousSearches = searches;

    notifyListeners();
  }

  // Method for persisting data to shared preferences
  Future<void> persistData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('bookmarked',
        _bookmarkedArticles.map((a) => json.encode(a.toJson())).toList());
    await prefs.setStringList(
        'read', _readArticles.map((a) => json.encode(a.toJson())).toList());
    await prefs.setStringList('searches', _previousSearches);
  }
}
