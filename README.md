# NewsArticleReaderApp

## Overview

**NewsArticleReaderApp** is a Flutter application that allows users to search for and read news articles in real time. Users can:
- Search for articles based on custom queries
- View detailed article information
- Bookmark favorite articles
- Track previously read articles
- Sort results by relevance, popularity, or latest publications
- Filter by language (e.g., English, Spanish, French)
- Swipe right to dismiss bookmarked/read articles
- Visit original sources via URL links

The app saves all searches, bookmarks, and read history locally, ensuring a seamless experience across sessions.

---

## Features

- Real-time search with sorting and language filters  
- Bookmark and read tracking  
- Persistent local storage using `shared_preferences`  
- Launch full articles in the browser  
- Swipe-to-dismiss for bookmarked and read articles   
- Optimized for iOS simulator use

![DemoApp](Assets/Videos/DemoApp.gif)

---

## Data Source

This application uses [**NewsAPI**](https://newsapi.org/) — a RESTful API that aggregates news from various sources and publishers worldwide. It supports queries, filters, and sorting to fetch up-to-date, relevant news articles.

---

## Dependencies

The following third-party packages were integrated:

- [`url_launcher`](https://pub.dev/packages/url_launcher): To open article URLs in a web browser.
- [`intl`](https://pub.dev/packages/intl): To format and present article publication dates clearly.
- [`shared_preferences`](https://pub.dev/packages/shared_preferences): For saving search history, bookmarks, and read articles persistently across sessions.
- [`provider`](https://pub.dev/packages/provider): For effective state management throughout the app.

---

## Local Data Persistence

The app uses `shared_preferences` to store:
- User search queries
- List of bookmarked articles
- List of read articles

This enables consistent user experience, even after closing or restarting the app.

---

## Usage Instructions

1. Clone or download the repository.
2. Run `flutter pub get` to fetch all dependencies.
3. Obtain an API key from [https://newsapi.org](https://newsapi.org) and configure it within the `news_api_service.dart` file located within the news_reader_app/lib/services folder.
4. Run the app using an **iOS simulator** 
5. Start searching and bookmarking your favorite articles!

---
## Developer Notes

This project was a valuable hands-on experience in real-world app design, data handling, state management, and testing. I enjoyed connecting real-time APIs with a well-designed UI, and learned a lot about debugging, persistence, and improving UX based on edge cases (e.g., missing data). Future improvements could include fixing test ambiguity, expanding platform compatibility, and enhancing UI accessibility.

---

## License

This project is for educational purposes and does not carry a specific license. Please ensure compliance with [NewsAPI's usage policy](https://newsapi.org/pricing).
