import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ss_news/provider/news_pvd.dart';
import 'package:ss_news/provider/navbar_provider.dart';
import 'package:ss_news/screens/news_navbar.dart';
import 'package:ss_news/widgets/news_card.dart';

class NewsHomePage extends StatefulWidget {
  const NewsHomePage({super.key});

  @override
  State<NewsHomePage> createState() => _NewsHomePageState();
}

class _NewsHomePageState extends State<NewsHomePage> {
  @override
  void initState() {
    super.initState();

    // 📰 Load business/general news once at startup
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final newsPvd = Provider.of<NewsPvd>(context, listen: false);
      newsPvd.fetchBusinessNews();
      // newsPvd.fetchPoliticsNews();
      newsPvd.fetchSportsNews();
      // newsPvd.fetchGeneralNews();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<NewsPvd, NavbarProvider>(
      builder: (context, newsPvd, navPvd, child) {
        return Scaffold(
          backgroundColor: Colors.grey.shade100,
          appBar: const PreferredSize(
            preferredSize: Size.fromHeight(165), // match ResponsiveNavbar
            child: ResponsiveNavbar(),
          ),

          // 📱 Drawer for small screens
          endDrawer: Drawer(
            backgroundColor: Colors.white,
            child: ListView(
              children: [
                const DrawerHeader(
                  decoration: BoxDecoration(color: Colors.redAccent),
                  child: Text(
                    "समाचार श्रेणियाँ",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                ...navPvd.categories.map((category) {
                  final isSelected = navPvd.selectedCategory == category;
                  return ListTile(
                    title: Text(
                      category,
                      style: TextStyle(
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                        color: isSelected ? Colors.redAccent : Colors.black,
                      ),
                    ),
                    selected: isSelected,
                    onTap: () {
                      navPvd.selectCategory(category);
                      Navigator.pop(context);
                    },
                  );
                }),
              ],
            ),
          ),

          // 📰 Main body area
          body: SafeArea(
            child: newsPvd.isLoading
                ? const Center(child: CircularProgressIndicator())
                : newsPvd.cErr.isNotEmpty
                    ? Center(
                        child: Text(
                          newsPvd.cErr,
                          style: const TextStyle(color: Colors.redAccent),
                        ),
                      )
                    : _buildCategoryContent(context, newsPvd, navPvd),
          ),
        );
      },
    );
  }

  // Builds the news feed list based on selected category
  Widget _buildCategoryContent(
      BuildContext context, NewsPvd newsPvd, NavbarProvider navPvd) {
    final category = navPvd.selectedCategory;
    final articles = newsPvd.getNewsByCategory(category);

    if (articles.isEmpty) {
      return const Center(
        child: Text(
          "कोई समाचार उपलब्ध नहीं है।",
          style: TextStyle(fontSize: 16, color: Colors.black54),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: articles.length,
      itemBuilder: (context, index) =>
          NewsCard(article: articles[index]), // ✅ use NewsCard widget
    );
  }
}
