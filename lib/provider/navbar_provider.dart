import 'package:flutter/material.dart';
import 'package:ss_news/data/mock_data.dart';

class NavbarProvider extends ChangeNotifier {
  // Categories (from mock data or hardcoded)
  final List<String> _categories = [
    "मुख्य समाचार",
    "व्यापार",
    "राजनीति",
    "खेल",
    "मनोरंजन",
    "टेक्नोलॉजी",
    "स्वास्थ्य",
  ];

  List<String> get categories => _categories;

  // Breaking news list
  List<String> breakingNews = MockData.breakingNews;

  // Selected category
  String _selectedCategory = "मुख्य समाचार";
  String get selectedCategory => _selectedCategory;

  // For managing auto-scrolling ticker
  final ScrollController breakingScrollController = ScrollController();

  // Search field text
  String _searchQuery = "";
  String get searchQuery => _searchQuery;

  // Methods
  void selectCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void updateSearch(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  // Optionally you can simulate ticker scroll
  void autoScrollTicker() {
    if (breakingScrollController.hasClients) {
      breakingScrollController.animateTo(
        breakingScrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 15),
        curve: Curves.linear,
      );
    }
  }
}
