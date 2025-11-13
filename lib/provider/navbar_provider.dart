import 'package:flutter/material.dart';
import 'package:ss_news/data/mock_data.dart';

class NavbarProvider extends ChangeNotifier {
  String _selectedCategory = MockData.newsCategories.first;

  String get selectedCategory => _selectedCategory;

  void setCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }
}
