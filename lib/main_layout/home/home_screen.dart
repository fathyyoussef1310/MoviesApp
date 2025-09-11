import 'package:flutter/material.dart';

class Movie {
  final String title;
  final String image;
  final String category;
  Movie({required this.title, required this.image, required this.category});
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {





  @override
  Widget build(BuildContext context) {


return Scaffold(
  backgroundColor: Colors.pink,
);
  }}