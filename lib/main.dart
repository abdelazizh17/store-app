import 'package:flutter/material.dart';
import 'package:store/pages/home_page.dart';
import 'package:store/pages/update_product.dart';

void main() {
  runApp(const StoreApp());
}

class StoreApp extends StatelessWidget {
  const StoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        HomePage.id: (context) => HomePage(),
        UpdateProduct.id : (context) => UpdateProduct(),
      },
      initialRoute: HomePage.id,
    );
  }
}
