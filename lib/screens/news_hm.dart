import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ss_news/provider/news_pvd.dart';
import 'package:ss_news/provider/navbar_provider.dart';
import 'package:ss_news/screens/news_navbar.dart';

class NewsHomePage extends StatefulWidget {
  const NewsHomePage({super.key});

  @override
  State<NewsHomePage> createState() => _NewsHomePageState();
}

class _NewsHomePageState extends State<NewsHomePage> {
  @override
  void initState() {
    super.initState();
    // Trigger initial data load when provider is ready
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // context.read<NewsPvd>().fetchAllCategoryNews();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<NewsPvd, NavbarProvider>(
      builder: (context, newsPvd, navPvd, child) {
        return Scaffold(
          backgroundColor: Colors.grey.shade100,
          appBar: const PreferredSize(
            preferredSize: Size.fromHeight(130),
            child: ResponsiveNavbar(), // renamed to match your file
          ),
          endDrawer: Drawer(
            backgroundColor: Colors.white,
            child: ListView(
              children: [
                const DrawerHeader(
                  decoration: BoxDecoration(color: Colors.redAccent),
                  child: Text(
                    "समाचार",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ...newsPvd.categories.map((category) {
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
                      navPvd.setCategory(category);
                      Navigator.pop(context);
                    },
                  );
                }),
              ],
            ),
          ),
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
      itemBuilder: (context, index) {
        final article = articles[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          elevation: 3,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            leading: article.imageUrl != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      article.imageUrl!,
                      width: 70,
                      height: 70,
                      fit: BoxFit.cover,
                    ),
                  )
                : const Icon(Icons.article, color: Colors.grey),
            title: Text(article.title ?? ""),
            subtitle: Text(article.subtitle ?? ""),
            trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
            onTap: () {
              // You can later navigate to detailed news page
            },
          ),
        );
      },
    );
  }
}
