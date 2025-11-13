import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For DateFormat
import 'package:timeago/timeago.dart' as timeago; // For relative time
import 'package:share_plus/share_plus.dart'; // For sharing

class Utils {
  // --- UI NOTIFICATIONS ---
  // These methods need a BuildContext to find the Scaffold

  /// Shows a simple snackbar
  static void showAppSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  /// Shows a standard confirmation dialog (Alert)
  static void showAppDialog(BuildContext context,
      {required String title, required String content}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // --- DATE & TIME FORMATION ---

  /// Formats time relatively (e.g., "5 मिनट पहले")
  /// This requires the 'timeago' package
  static String formatRelativeTime(DateTime dateTime) {
    // We add the Hindi messages to the timeago library
    // You only need to do this *once* in your app's initialization
    // A good place might be in main.dart or a startup service.
    // For this example, I'll set it here.
    timeago.setLocaleMessages('hi', timeago.HiMessages());

    return timeago.format(dateTime, locale: 'hi');
  }

  /// Formats a full date and time in Hindi (e.g., "१३ नवंबर २०२५, शाम ७:३० बजे")
  /// This requires the 'intl' package and initialization in main.dart
  static String formatFullDateTime(DateTime dateTime) {
    // 'yMMMd' = 13 Nov 2025
    // 'jj' = 7 PM (locale-aware)
    // 'ss' = 30 seconds
    final format = DateFormat('yMMMMd(\'hi_IN\')', 'hi_IN').add_jm();
    return format.format(dateTime);
  }

  /// Formats just the date in Hindi (e.g., "१३ नवंबर २०२५")
  static String formatSimpleDate(DateTime dateTime) {
    final format = DateFormat.yMMMMd('hi_IN');
    return format.format(dateTime);
  }

  // --- TEXT & CONTENT ---

  /// Truncates a string to a max length and adds "..."
  static String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    }
    return '${text.substring(0, maxLength)}...';
  }

  /// Calculates estimated reading time in Hindi
  static String getReadingTime(String text) {
    if (text.isEmpty) {
      return "० मिनट पढ़ें";
    }

    // Average reading speed for Hindi is ~180-200 WPM
    const int wordsPerMinute = 190;

    // Count words by splitting by whitespace
    final int wordCount = text.split(RegExp(r'\s+')).length;

    // Calculate reading time
    final double minutes = wordCount / wordsPerMinute;

    // Round up to the nearest minute
    final int readingTime = minutes.ceil();

    // Handle the case for very short articles
    if (readingTime == 0) {
      return "१ मिनट पढ़ें";
    }

    return "$readingTime मिनट पढ़ें";
  }

  // --- INTERACTIONS & SHARING ---

  /// Opens the native platform share sheet
  /// This requires the 'share_plus' package
  static void shareArticle(String title, String url) {
    // The subject is optional and mostly used for email
    Share.share(
      '$title\n\n$url',
      subject: title,
    );
  }
}
