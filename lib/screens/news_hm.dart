import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ss_news/provider/news_pvd.dart';
import 'package:ss_news/screens/news_navbar.dart';

class NewsHomePage extends StatefulWidget {
  const NewsHomePage({super.key});

  @override
  State<NewsHomePage> createState() => _NewsHomePageState();
}

class _NewsHomePageState extends State<NewsHomePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<NewsPvd>(
      builder: (context, pvd, child) {
        return Scaffold(
          body: Column(
            children: [NavBar(), Expanded(child: Text("data"))],
          ),
        );
      },
    );
  }
}
