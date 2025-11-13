import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ss_news/data/mock_data.dart';
import 'package:ss_news/provider/navbar_provider.dart';

class ResponsiveNavbar extends StatelessWidget implements PreferredSizeWidget {
  const ResponsiveNavbar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(130);

  @override
  Widget build(BuildContext context) {
    final navbarProvider = Provider.of<NavbarProvider>(context);
    final isMobile = MediaQuery.of(context).size.width < 700;

    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: Colors.white,
      flexibleSpace: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _topBar(),
          const Divider(height: 1),
          if (!isMobile)
            _desktopCategoryBar(context, navbarProvider)
          else
            _mobileAppBar(context),
          _breakingNewsBar(),
        ],
      ),
    );
  }

  // 📅 Top Red Bar (Date, E-Paper, Contact)
  Widget _topBar() {
    return Container(
      color: const Color(0xFFE53935),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Row(
            children: [
              Icon(Icons.calendar_today, size: 16, color: Colors.white),
              SizedBox(width: 6),
              Text(
                "गुरुवार, 13 नवंबर 2025",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          Row(
            children: [
              Text("ई-पेपर  •  संपर्क करें",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w500)),
            ],
          ),
        ],
      ),
    );
  }

  // 💻 Desktop Navbar (with categories)
  Widget _desktopCategoryBar(BuildContext context, NavbarProvider provider) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          // Logo & Brand
          Row(
            children: const [
              Icon(Icons.article_rounded, color: Colors.redAccent, size: 36),
              SizedBox(width: 8),
              Text(
                "दैनिक समाचार",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              SizedBox(width: 6),
              Text(
                "सत्य की आवाज़",
                style: TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ],
          ),
          const Spacer(),
          // Search
          SizedBox(
            width: 250,
            child: TextField(
              decoration: InputDecoration(
                hintText: 'समाचार खोजें...',
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                suffixIcon: const Icon(Icons.search, color: Colors.redAccent),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                fillColor: Colors.white,
                filled: true,
              ),
            ),
          ),
          const SizedBox(width: 20),
        ],
      ),
    );
  }

  // 📱 Mobile Navbar (with menu icon)
  Widget _mobileAppBar(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          const Icon(Icons.article_rounded, color: Colors.redAccent, size: 30),
          const SizedBox(width: 8),
          const Text(
            "दैनिक समाचार",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () => Scaffold.of(context).openEndDrawer(),
          ),
        ],
      ),
    );
  }

  // 📰 Breaking News Bar
  Widget _breakingNewsBar() {
    return Container(
      color: Colors.redAccent,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Text(
              "ब्रेकिंग न्यूज़",
              style: TextStyle(
                  color: Colors.redAccent, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: MockData.breakingNews
                    .map((news) => Padding(
                          padding: const EdgeInsets.only(right: 24),
                          child: Text(
                            "• $news",
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 14),
                          ),
                        ))
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
