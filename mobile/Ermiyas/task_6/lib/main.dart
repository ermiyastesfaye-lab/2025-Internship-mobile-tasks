import 'package:flutter/material.dart';
import 'package:task_6/pages/add_product.dart';
import 'package:task_6/pages/home.dart';
import 'package:task_6/pages/product_detail.dart';
import 'package:task_6/pages/search_product.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => const Home(),
      '/productdetail': (context) => const ProductDetail(),
      '/searchproduct': (context) => const SearchProduct(),
      '/addproduct': (context) => const AddProduct(),
    },
    debugShowCheckedModeBanner: false,
  ));
}
