import 'package:flutter/material.dart';

// Search bar widget for entering search queries
class Searchbar extends StatelessWidget {
  final TextEditingController controller; // Controller for the search input field
  final Function() onSearch;  // Callback function for performing the search

  const Searchbar({super.key, required this.controller, required this.onSearch});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller, // Assign the provided controller to the text field
              decoration: const InputDecoration(
                hintText: 'Search for articles...', // Placeholder text for the text field
                border: OutlineInputBorder(), // Border style for the text field
              ),
            ),
          ),
          IconButton( // Button to trigger the search operation
            icon: const Icon(Icons.search),
            onPressed: onSearch,
          ),
        ],
      ),
    );
  }
}
