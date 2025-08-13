import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../main.dart';
import '../widgets/product_card.dart';
import '../widgets/offer_item.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home';
  const HomeScreen({super.key});

  List<Map<String, String>> get featured => const [
    {"img": "https://picsum.photos/800/300?1"},
    {"img": "https://picsum.photos/800/300?2"},
    {"img": "https://picsum.photos/800/300?3"},
  ];

  List<Map<String, String>> get products => const [
    {"title": "Shoes", "img": "https://picsum.photos/300/240?10"},
    {"title": "Bag", "img": "https://picsum.photos/300/240?11"},
    {"title": "Watch", "img": "https://picsum.photos/300/240?12"},
    {"title": "Jacket", "img": "https://picsum.photos/300/240?13"},
    {"title": "Glasses", "img": "https://picsum.photos/300/240?14"},
    {"title": "Headphones", "img": "https://picsum.photos/300/240?15"}
  ];

  List<Map<String, String>> get offers => const [
    {
      "img": "https://picsum.photos/200/120?21",
      "desc": "Offer 1: save more with bundle"
    },
    {
      "img": "https://picsum.photos/200/120?22",
      "desc": "Offer 2: weekend discount"
    },
    {
      "img": "https://picsum.photos/200/120?23",
      "desc": "Offer 3: limited time"
    },
    {
      "img": "https://picsum.photos/200/120?24",
      "desc": "Offer 4: buy 1 get 1"
    },
    {
      "img": "https://picsum.photos/200/120?25",
      "desc": "Offer 5: clearance sale"
    }
  ];

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(t.ourProducts),
        actions: [
          IconButton(
            tooltip: 'Language',
            onPressed: () => LocaleController.instance.toggle(),
            icon: const Icon(Icons.language),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          // Featured section
          SizedBox(
            height: 180,
            child: PageView.builder(
              controller: PageController(viewportFraction: 0.92),
              itemCount: featured.length,
              itemBuilder: (_, i) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    featured[i]["img"]!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Products section
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: .72,
            ),
            itemBuilder: (ctx, i) {
              final p = products[i];
              return ProductCard(
                title: p['title']!,
                imageUrl: p['img']!,
                onAdd: () {
                  ScaffoldMessenger.of(ctx).showSnackBar(
                    SnackBar(content: Text(t.addedToCart(p['title']!))),
                  );
                },
              );
            },
          ),
          const SizedBox(height: 16),

          // Hot offers section
          Text(
            t.hotOffers,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: offers.length,
            itemBuilder: (_, i) => OfferItem(
              imageUrl: offers[i]['img']!,
              description: offers[i]['desc']!,
            ),
          ),
        ],
      ),
    );
  }
}
