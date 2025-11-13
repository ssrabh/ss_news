import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ss_news/data/data_model.dart';

class NewsDetailPage extends StatelessWidget {
  final NewsArticleModel article;

  const NewsDetailPage({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(article.category ?? "समाचार"),
        backgroundColor: Colors.redAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🏷️ Title and Subtitle
            Text(
              article.title ?? '',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              article.subtitle ?? '',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 14),

            // Author Info
            Row(
              children: [
                const Icon(Icons.person_outline, color: Colors.grey, size: 18),
                const SizedBox(width: 4),
                Text(article.author ?? ''),
                const SizedBox(width: 16),
                const Icon(Icons.location_on_outlined,
                    color: Colors.grey, size: 18),
                const SizedBox(width: 4),
                Text(article.location ?? ''),
                const SizedBox(width: 16),
                const Icon(Icons.calendar_today_outlined,
                    color: Colors.grey, size: 18),
                const SizedBox(width: 4),
                Text(DateFormat('dd MMM yyyy, hh:mm a')
                    .format(article.publishedDate ?? DateTime.now())),
              ],
            ),
            const SizedBox(height: 16),

            // 🖼️ Image
            if (article.imageUrl != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(article.imageUrl!),
              ),
            const SizedBox(height: 20),

            // 📰 Content
            Text(
              article.content ?? '',
              style: const TextStyle(fontSize: 16, height: 1.6),
            ),
          ],
        ),
      ),
    );
  }
}
