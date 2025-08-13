import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../main.dart';
import '../widgets/product_card.dart';
import '../widgets/offer_item.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home';
  const HomeScreen({super.key});

  List<Map<String, String>> get featured => const [
    {"img": "images/feature1.jpg"},
    {"img": "images/feature2.jpg"},
    {"img": "images/feature3.jpg"},
  ];

  List<Map<String, String>> get products => const [
    {"title": "Shoes", "img": "images/shoes.jpg"},
    {"title": "Bag", "img": "images/bag.jpg"},
    {"title": "Watch", "img": "images/Watch.jpg"},
    {"title": "Jacket", "img": "images/Jacket.jpg"},
    {"title": "Glasses", "img": "images/Glasses.jpg"},
    {"title": "Headphones", "img": "images/Headphones.jpg"}
  ];

  List<Map<String, String>> get offers => const [
    {
      "img": "images/feature3.jpg",
      "desc": "Offer 1: save more with bundle"
    },
    {
      "img": "images/Glasses.jpg",
      "desc": "Offer 2: weekend discount"
    },
    {
      "img": "images/shoes.jpg",
      "desc": "Offer 3: limited time"
    },
    {
      "img": "images/Headphones.jpg",
      "desc": "Offer 4: buy 1 get 1"
    },
    {
      "img": "images/bag.jpg",
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
                  child: Image.asset(
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
