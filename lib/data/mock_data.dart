import 'package:ss_news/data/data_model.dart';

class MockData {
  static List<String> newsCategories = [
    'मुख्य पृष्ठ',
    'राजनीति',
    'खेल',
    'व्यापार',
    'मनोरंजन',
    'स्थानीय',
    'विश्व',
    'तकनीक',
  ];

  static List<String> breakingNews = const [
    'नई नीति का ऐलान - जानिए क्या बदला',
    'बैंकिन्ग शेयरों में उछाल, सेंसेक्स उच्च',
    'स्थानीय मौसम अपडेट: हल्की बारिश की संभावना',
  ];

  static List<NewsArticleModel> businessMockData = [
    NewsArticleModel(
      category: 'व्यापार',
      title: 'शेयर बाजार में तेजी, सेंसेक्स 500 अंक चढ़ा',
      subtitle: 'निवेशकों में सकारात्मक माहौल, विदेशी निवेश में बढ़ोतरी',
      author: 'अमित मेहता',
      location: 'मुंबई',
      publishedDate: DateTime(2025, 1, 13),
      publishedTime: '09:30 PM',
      readersCount: 891,
      imageUrl: 'https://example.com/images/market_up.jpg',
      content:
          'बीएसई सेंसेक्स 523 अंक बढ़कर 72,450 पर बंद हुआ, जबकि निफ्टी 158 अंक चढ़कर 21,890 पर रहा। विदेशी निवेश और बैंकिंग सेक्टर में खरीदारी से बाजार को मजबूती मिली।',
    ),
    NewsArticleModel(
      category: 'व्यापार',
      title: 'रुपया डॉलर के मुकाबले मजबूत, विदेशी निवेशकों की वापसी',
      subtitle: 'आईटी और बैंकिंग शेयरों में बढ़त से निवेशकों में उत्साह',
      author: 'नेहा शर्मा',
      location: 'नई दिल्ली',
      publishedDate: DateTime(2025, 1, 10),
      publishedTime: '10:15 AM',
      readersCount: 654,
      imageUrl: 'https://example.com/images/rupee_dollar.jpg',
      content:
          'भारतीय रुपया 12 पैसे मजबूत होकर 82.95 पर बंद हुआ। विदेशी निवेशकों की वापसी और तेल कीमतों में गिरावट से रुपये को सपोर्ट मिला।',
    ),
    NewsArticleModel(
      category: 'व्यापार',
      title: 'सोने की कीमतों में बढ़ोतरी, निवेशकों की दिलचस्पी बढ़ी',
      subtitle: 'अंतरराष्ट्रीय बाजार में सोना 0.8% महंगा हुआ',
      author: 'राहुल वर्मा',
      location: 'जयपुर',
      publishedDate: DateTime(2025, 1, 8),
      publishedTime: '05:00 PM',
      readersCount: 472,
      imageUrl: 'https://example.com/images/gold_prices.jpg',
      content:
          'वैश्विक आर्थिक अनिश्चितता के कारण निवेशक सुरक्षित निवेश की ओर झुक रहे हैं। सोने की कीमतें 0.8% बढ़कर 63,200 रुपये प्रति 10 ग्राम पर पहुंचीं।',
    ),
  ];

  static List<NewsArticleModel> sportsMockData = [
    NewsArticleModel(
      category: 'खेल',
      title: 'भारत ने ऑस्ट्रेलिया को हराया, सीरीज़ में 2-1 की बढ़त',
      subtitle: 'विराट कोहली ने जड़ा शानदार शतक',
      author: 'प्रिया सिंह',
      location: 'कोलकाता',
      publishedDate: DateTime(2025, 1, 12),
      publishedTime: '08:45 PM',
      readersCount: 1203,
      imageUrl: 'https://example.com/images/india_vs_aus.jpg',
      content:
          'भारत ने ऑस्ट्रेलिया को तीसरे वनडे में 7 विकेट से हराकर सीरीज़ में 2-1 की बढ़त बना ली। विराट कोहली ने 112 रनों की शानदार पारी खेली।',
    ),
  ];

  static List<NewsArticleModel> technologyMockData = [
    NewsArticleModel(
      category: 'टेक्नोलॉजी',
      title: 'नई 5G स्मार्टवॉच लॉन्च, 7 दिन की बैटरी लाइफ के साथ',
      subtitle: 'भारतीय बाजार में ₹12,999 की कीमत पर उपलब्ध',
      author: 'संदीप कुमार',
      location: 'बेंगलुरु',
      publishedDate: DateTime(2025, 1, 9),
      publishedTime: '02:30 PM',
      readersCount: 834,
      imageUrl: 'https://example.com/images/smartwatch_5g.jpg',
      content:
          'नई स्मार्टवॉच में हेल्थ ट्रैकिंग, ब्लूटूथ कॉलिंग और 5G कनेक्टिविटी फीचर शामिल हैं। कंपनी का दावा है कि यह 7 दिन तक की बैटरी लाइफ देती है।',
    ),
  ];

  static List<NewsArticleModel> entertainmentMockData = [
    NewsArticleModel(
      category: 'मनोरंजन',
      title: 'नया बॉलीवुड ट्रेलर रिलीज, सोशल मीडिया पर छाया',
      subtitle: 'फैंस ने कहा – साल की सबसे बड़ी फिल्म!',
      author: 'राधा अग्रवाल',
      location: 'मुंबई',
      publishedDate: DateTime(2025, 1, 11),
      publishedTime: '07:00 PM',
      readersCount: 1576,
      imageUrl: 'https://example.com/images/bollywood_trailer.jpg',
      content:
          'फिल्म का ट्रेलर रिलीज होते ही सोशल मीडिया पर वायरल हो गया। दो घंटे में 10 मिलियन से ज्यादा व्यूज़ मिल चुके हैं।',
    ),
  ];
}
