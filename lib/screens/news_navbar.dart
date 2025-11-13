import 'package:flutter/material.dart';

/// Responsive top navigation bar with an end-drawer for small screens.
/// - On large screens: shows logo + date, search field, horizontal menu and a
///   red breaking-news strip below the app bar.
/// - On small screens: shows logo + date, a compact search icon, and an
///   end-drawer (right side) that holds menu items and other actions.
///
/// Usage:
/// Scaffold(
///   endDrawer: NavBar.endDrawer(context), // optional - widget also provides it
///   appBar: NavBar(),                      // use directly as PreferredSizeWidget
///   body: ...,
/// );
class NavBar extends StatelessWidget implements PreferredSizeWidget {
  NavBar({Key? key}) : super(key: key);

  // Basic menu items - customize as needed.
  final List<String> _menu = const [
    'मुख्य पृष्ठ',
    'राजनीति',
    'खेल',
    'व्यापार',
    'मनोरंजन',
    'स्थानीय',
    'विश्व',
    'तकनीक',
  ];

  // Breaking news items
  final List<String> _breaking = const [
    'ब्रेकिंग न्यूज़: नई नीति का ऐलान - जानिए क्या बदला',
    'बैंकिन्ग शेयरों में उछाल, सेंसेक्स उच्च',
    'स्थानीय मौसम अपडेट: हल्की बारिश की संभावना',
  ];

  static Widget endDrawer(BuildContext context) {
    // same menu used inside drawer
    final List<String> menu = const [
      'मुख्य पृष्ठ',
      'राजनीति',
      'खेल',
      'व्यापार',
      'मनोरंजन',
      'स्थानीय',
      'विश्व',
      'तकनीक',
      'ई-पेपर',
      'संपर्क करें',
    ];

    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.red.shade700, Colors.deepOrange.shade400],
                ),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.newspaper, color: Colors.red.shade700),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'दैनिक समाचार',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Menu list
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: menu.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, i) {
                  return ListTile(
                    title: Text(menu[i]),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      Navigator.of(context).pop(); // close drawer
                      // Add navigation logic here
                    },
                  );
                },
              ),
            ),

            // Social / bottom actions
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.mail_outline),
                      label: const Text('ई-पेपर'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.contact_page_outlined),
                      label: const Text('संपर्क करें'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final bool isSmall = width < 800; // breakpoint - tweak as needed

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Top row with date / logo / search / actions
        Container(
          color: Colors.white,
          padding:
              EdgeInsets.symmetric(horizontal: isSmall ? 12 : 24, vertical: 8),
          child: SafeArea(
            bottom: false,
            child: Row(
              children: [
                // Date (left)
                Row(
                  children: [
                    const Icon(Icons.calendar_today_outlined,
                        size: 16, color: Colors.red),
                    const SizedBox(width: 8),
                    Text(
                      _formattedDate(),
                      style: TextStyle(
                          color: Colors.grey.shade800,
                          fontSize: isSmall ? 12 : 14),
                    ),
                  ],
                ),

                const SizedBox(width: 16),

                // Logo
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.red.shade700,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.newspaper, color: Colors.white),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'दैनिक समाचार',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent),
                    ),
                  ],
                ),

                const Spacer(),

                // Search field or icon
                if (!isSmall)
                  SizedBox(
                    width: width * 0.25,
                    child: _SearchField(),
                  )
                else
                  IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      // For small screens use a search dialog or navigate to search page
                      showSearch(
                          context: context, delegate: _SimpleSearchDelegate());
                    },
                  ),

                const SizedBox(width: 12),

                // Show menu items on larger screens; else show end drawer icon
                if (!isSmall)
                  Row(
                    children: _menu
                        .map((text) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: TextButton(
                                onPressed: () {},
                                child: Text(
                                  text,
                                  style: const TextStyle(color: Colors.black87),
                                ),
                              ),
                            ))
                        .toList(),
                  )
                else
                  IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () {
                      // open end drawer
                      Scaffold.of(context).openEndDrawer();
                    },
                  ),
              ],
            ),
          ),
        ),

        // Dark nav strip
        Container(
          color: Colors.black87,
          padding:
              EdgeInsets.symmetric(horizontal: isSmall ? 12 : 24, vertical: 12),
          child: Row(
            children: [
              // categories condensed on small screens
              if (!isSmall)
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: _menu
                        .map((m) => GestureDetector(
                              onTap: () {},
                              child: Text(
                                m,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                            ))
                        .toList(),
                  ),
                )
              else
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: _menu
                          .map((m) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: Text(m,
                                    style:
                                        const TextStyle(color: Colors.white)),
                              ))
                          .toList(),
                    ),
                  ),
                ),

              // right side small labels - could be user actions
              Row(
                children: [
                  TextButton(
                    onPressed: () {},
                    child: const Text('ई-पेपर',
                        style: TextStyle(color: Colors.white)),
                  ),
                  const SizedBox(width: 8),
                  TextButton(
                    onPressed: () {},
                    child: const Text('संपर्क करें',
                        style: TextStyle(color: Colors.white)),
                  ),
                ],
              )
            ],
          ),
        ),

        // Breaking news ticker
        _BreakingNewsTicker(breakingItems: _breaking),
      ],
    );
  }

  /// Simple date text in Hindi format (example)
  static String _formattedDate() {
    final now = DateTime.now();
    // Customize your formatting as required.
    // This is a simple english->hindi mapping for day names (example).
    final days = [
      'रविवार',
      'सोमवार',
      'मंगलवार',
      'बुधवार',
      'गुरुवार',
      'शुक्रवार',
      'शनिवार'
    ];
    final months = [
      'जनवरी',
      'फरवरी',
      'मार्च',
      'अप्रैल',
      'मई',
      'जून',
      'जुलाई',
      'अगस्त',
      'सितंबर',
      'अक्टूबर',
      'नवंबर',
      'दिसंबर'
    ];

    final day = days[now.weekday % 7];
    final month = months[now.month - 1];
    return '$day, ${now.day} $month ${now.year}';
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(140); // adjust height as required
}

/// Simple search field used in the app bar for larger screens
class _SearchField extends StatelessWidget {
  const _SearchField({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextField(
      onSubmitted: (q) {},
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        filled: true,
        fillColor: Colors.grey.shade100,
        hintText: 'समाचार खोजें...',
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none),
      ),
    );
  }
}

/// Very small search delegate (for mobile when user taps search icon)
class _SimpleSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget>? buildActions(BuildContext context) =>
      [IconButton(icon: const Icon(Icons.clear), onPressed: () => query = '')];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
      icon: const Icon(Icons.arrow_back), onPressed: () => close(context, ''));

  @override
  Widget buildResults(BuildContext context) {
    return Center(child: Text('Search results for "$query"'));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView(
      children: [
        ListTile(title: Text('Suggestion 1 for "$query"')),
        ListTile(title: Text('Suggestion 2 for "$query"')),
      ],
    );
  }
}

/// Breaking news ticker widget
class _BreakingNewsTicker extends StatefulWidget {
  final List<String> breakingItems;
  const _BreakingNewsTicker({Key? key, required this.breakingItems})
      : super(key: key);

  @override
  State<_BreakingNewsTicker> createState() => _BreakingNewsTickerState();
}

class _BreakingNewsTickerState extends State<_BreakingNewsTicker>
    with SingleTickerProviderStateMixin {
  late final ScrollController _scrollCtrl;
  late final double _singleRoundDurationSeconds;
  late final AnimationController _animController;

  @override
  void initState() {
    super.initState();
    _scrollCtrl = ScrollController();
    // Determine a duration so the ticker slowly scrolls
    _singleRoundDurationSeconds = 12.0;
    _animController = AnimationController(
        vsync: this,
        duration: Duration(seconds: _singleRoundDurationSeconds.toInt()))
      ..addListener(_tick)
      ..repeat();
  }

  void _tick() {
    // If no scrolling possible or disposed, do nothing
    if (!mounted || !_scrollCtrl.hasClients) return;

    final maxScroll = _scrollCtrl.position.maxScrollExtent;
    final v = _animController.value;
    // ping-pong effect
    final offset = v <= 0.5 ? (v * 2) * maxScroll : ((1 - v) * 2) * maxScroll;
    _scrollCtrl.jumpTo(offset);
  }

  @override
  void dispose() {
    _animController.dispose();
    _scrollCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Build a long single-line horizontally scrollable row that repeats items
    final items = widget.breakingItems;
    final repeated = List<String>.from(items)..addAll(items);

    return Container(
      color: Colors.red.shade700,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(6)),
            child: Row(
              children: const [
                Icon(Icons.notification_important, color: Colors.red, size: 18),
                SizedBox(width: 6),
                Text('ब्रेकिंग न्यूज़',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: SizedBox(
              height: 24,
              child: ListView.separated(
                controller: _scrollCtrl,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final text = repeated[index % repeated.length];
                  return Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      text,
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  );
                },
                separatorBuilder: (_, __) => const SizedBox(width: 40),
                itemCount: repeated.length,
                physics: const NeverScrollableScrollPhysics(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
