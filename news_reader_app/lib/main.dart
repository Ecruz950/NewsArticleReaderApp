import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/news_model.dart';
import 'screens/home_screen.dart';
import 'screens/bookmarks_screen.dart';
import 'screens/read_articles_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NewsModel()..loadPersistedData(),
      child: MaterialApp(
        title: 'News Reader',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(),
        routes: {
          '/bookmarks': (context) => const BookmarksScreen(),
          '/read_articles': (context) => const ReadArticlesScreen(),
        },
      ),
    );
  }
}
