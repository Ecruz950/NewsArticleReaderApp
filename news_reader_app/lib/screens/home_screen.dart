import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/news_model.dart';
import '../widgets/article_list.dart';
import '../widgets/search_bar.dart';
import '../services/news_api_service.dart';

// Home screen for displaying the news articles
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedSort = 'relevancy'; // Default sort option
  String _selectedLanguage = 'en'; // Default language
  final TextEditingController _searchController =
      TextEditingController(); // Controller for search query

  // Method to handle search
  void _searchArticles() async {
    final query = _searchController.text; // Get the search query from the text field
    if (query.isNotEmpty) {
      final newsModel = Provider.of<NewsModel>(context, listen: false);
      newsModel.clearArticles(); // Clear previous articles
      try {
        // Fetch articles based on the search query, sort option, and language
        final articles = await NewsApiService()
            .fetchArticles(query, _selectedSort, _selectedLanguage);
        articles.forEach(newsModel.addArticle); // Add fetched articles to the model
        newsModel.addSearch(query); // Add the search query to the search history
      } catch (e) { // Show error message if fetching articles fails
        if (!mounted) return; // Prevent calling setState if the widget is not mounted
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error fetching articles: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News Reader'),
        actions: [
          IconButton( // Button to navigate to the bookmarks screen
            icon: const Icon(Icons.bookmark),
            onPressed: () {
              Navigator.pushNamed(context, '/bookmarks');
            },
          ),
          IconButton( // Button to navigate to the read articles screen
            icon: const Icon(Icons.history),
            onPressed: () {
              Navigator.pushNamed(context, '/read_articles');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Searchbar(  // Search bar for entering search queries
            controller: _searchController,
            onSearch: _searchArticles,
          ),
          // Dropdown menu for selecting sort option
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Sort by: '),
              DropdownButton<String>(
                value: _selectedSort,
                onChanged: (String? newValue) {
                  if (newValue != null && newValue != _selectedSort) {
                    setState(() {
                      _selectedSort = newValue;
                    });
                    _searchArticles(); // Re-search with the current query and new sort option
                  }
                },
                items: <String>['relevancy', 'popularity', 'publishedAt']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value[0].toUpperCase() + value.substring(1),  // Capitalize the first letter
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
          // Dropdown menu for selecting language
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Language: '),
              DropdownButton<String>(
                value: _selectedLanguage,
                onChanged: (String? newValue) {
                  if (newValue != null && newValue != _selectedLanguage) {
                    setState(() {
                      _selectedLanguage = newValue;
                    });
                    _searchArticles(); // Re-search with the current query and new language
                  }
                },
                items: <String>[
                  'all',
                  'ar',
                  'de',
                  'en',
                  'es',
                  'fr',
                  'he',
                  'it',
                  'nl',
                  'no',
                  'pt',
                  'ru',
                  'sv',
                  'ud',
                  'zh'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value == 'all' ? 'All' : value.toUpperCase(), // Show "All" for the 'all' option
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
          Expanded(
            child: Consumer<NewsModel>(
              builder: (context, newsModel, child) {
                return ArticleList(
                  articles: newsModel.articles,
                  isDismissible: false, // Articles are not dismissible in the home screen
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
