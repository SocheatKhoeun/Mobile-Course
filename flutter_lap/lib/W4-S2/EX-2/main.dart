import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProductCardsScreen(),
    );
  }
}

class ProductCardsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
        backgroundColor: Colors.grey,
      ),
      backgroundColor: Colors.blue, // Set blue background here
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: ListView(
          children: [
            const SizedBox(height: 7),
            ProductCard(product: Product.dart),
            const SizedBox(height: 15),
            ProductCard(product: Product.flutter),
            const SizedBox(height: 15),
            ProductCard(product: Product.firebase),
          ],
        ),
      ),
    );
  }
}

enum Product {
  dart('Dart', 'The best object-oriented language.', 'assets/images/dart.png'),
  flutter('Flutter', 'The best mobile widget library.', 'assets/images/flutter.png'),
  firebase('Firebase', 'The best cloud database.', 'assets/images/firebase.png');

  final String title;
  final String description;
  final String imagePath;

  const Product(this.title, this.description, this.imagePath);
}

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            product.imagePath,
            height: 100,
            width: 100,
            fit: BoxFit.contain,
          ),
          SizedBox(height: 8),
          Text(
            product.title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          SizedBox(height: 4),
          Text(
            product.description,
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
