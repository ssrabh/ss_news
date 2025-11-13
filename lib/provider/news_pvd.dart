import 'package:flutter/material.dart';
import 'package:ss_news/data/data_model.dart';
import 'package:ss_news/data/mock_data.dart';

class NewsPvd extends ChangeNotifier {
  bool isLoading = false;
  String cErr = "";

  List<NewsArticleModel> businessContent = [];
  List<NewsArticleModel> entertainmentContent = [];
  List<NewsArticleModel> sportContent = [];
  List<NewsArticleModel> technologyContent = [];

  /// Constructor – fetch all mock data on initialization
  NewsPvd() {
    fetchAllNews();
  }

  /// Fetch all news categories (simulating network delay)
  Future<void> fetchAllNews() async {
    try {
      _setLoading(true);
      cErr = "";

      // Simulated API delay
      await Future.delayed(const Duration(milliseconds: 800));

      // Assign mock data (replace with API calls later)
      businessContent = MockData.businessMockData;
      entertainmentContent =
          MockData.entertainmentMockData; // example placeholder
      sportContent = MockData.sportsMockData;
      technologyContent = MockData.technologyMockData;

      _setLoading(false);
    } catch (e) {
      _setError("Failed to load news: $e");
    }
  }

  /// Fetch specific category (if needed individually)
  Future<void> fetchBusinessNews() async {
    try {
      _setLoading(true);
      cErr = "";
      await Future.delayed(const Duration(milliseconds: 600));
      businessContent = MockData.businessMockData;
      _setLoading(false);
    } catch (e) {
      _setError("Failed to load business news: $e");
    }
  }

  /// Private helper: Set loading state
  void _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  /// Private helper: Handle errors
  void _setError(String error) {
    cErr = error;
    isLoading = false;
    notifyListeners();
  }

  /// Refresh all news manually
  Future<void> refreshNews() async {
    businessContent.clear();
    entertainmentContent.clear();
    sportContent.clear();
    technologyContent.clear();
    await fetchAllNews();
  }
}
