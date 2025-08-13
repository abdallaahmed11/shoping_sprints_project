import 'package:flutter/material.dart';

class OfferItem extends StatelessWidget {
  final String imageUrl;
  final String description;

  const OfferItem({
    super.key,
    required this.imageUrl,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.network(imageUrl, width: 60, fit: BoxFit.cover),
        title: Text(description),
      ),
    );
  }
}
