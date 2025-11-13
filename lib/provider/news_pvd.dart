import 'package:flutter/material.dart';
import 'package:ss_news/data/data_model.dart';
import 'package:ss_news/data/mock_data.dart';

class NewsPvd extends ChangeNotifier {
  bool isLoading = false;
  String cErr = "";

  // 📰 Category-specific lists
  List<NewsArticleModel> businessContent = [];
  List<NewsArticleModel> entertainmentContent = [];
  List<NewsArticleModel> sportContent = [];
  List<NewsArticleModel> technologyContent = [];
  List<NewsArticleModel> politicsContent = [];
  List<NewsArticleModel> generalContent = [];

  /// ✅ Expose all available categories
  List<String> get categories => MockData.newsCategories;

  /// 🧭 Constructor — loads all mock data on startup
  NewsPvd() {
    fetchAllNews();
  }

  /// 🔄 Fetch all category mock data
  Future<void> fetchAllNews() async {
    try {
      _setLoading(true);
      cErr = "";

      await Future.delayed(const Duration(milliseconds: 800));

      businessContent = MockData.businessMockData;
      entertainmentContent = MockData.entertainmentMockData;
      sportContent = MockData.sportsMockData;
      technologyContent = MockData.technologyMockData;

      // If you have these in MockData later, uncomment:
      // politicsContent = MockData.politicsMockData;
      // generalContent = MockData.generalMockData;

      _setLoading(false);
    } catch (e) {
      _setError("Failed to load news: $e");
    }
  }

  /// 🎯 Fetch single categories individually (if you ever want to refresh one)
  Future<void> fetchBusinessNews() async {
    await Future.delayed(const Duration(milliseconds: 500));
    businessContent = MockData.businessMockData;
    notifyListeners();
  }

  Future<void> fetchEntertainmentNews() async {
    await Future.delayed(const Duration(milliseconds: 500));
    entertainmentContent = MockData.entertainmentMockData;
    notifyListeners();
  }

  Future<void> fetchSportsNews() async {
    await Future.delayed(const Duration(milliseconds: 500));
    sportContent = MockData.sportsMockData;
    notifyListeners();
  }

  Future<void> fetchTechnologyNews() async {
    await Future.delayed(const Duration(milliseconds: 500));
    technologyContent = MockData.technologyMockData;
    notifyListeners();
  }

  /// ✅ Helper: return category-specific list
  List<NewsArticleModel> getNewsByCategory(String category) {
    switch (category) {
      case 'व्यापार':
        return businessContent;
      case 'मनोरंजन':
        return entertainmentContent;
      case 'खेल':
        return sportContent;
      case 'तकनीक':
        return technologyContent;
      case 'राजनीति':
        return politicsContent;
      default:
        return generalContent;
    }
  }

  // Private helpers
  void _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void _setError(String error) {
    cErr = error;
    isLoading = false;
    notifyListeners();
  }
}
