import 'package:flutter/material.dart';
import 'package:moviesapproute/core/colors_manager/colorsManager.dart';
import 'package:moviesapproute/main_layout/explore/explore_screen.dart';
import 'package:moviesapproute/main_layout/home/home_screen.dart';
import 'package:moviesapproute/main_layout/profile/profile_screen.dart';
import 'package:moviesapproute/main_layout/search/search_screen.dart';
import 'package:moviesapproute/movies_screen/moviehomepage.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  final List<Widget> _tabs = [
   HomeScreen(),
    SearchScreen(),
    ExploreScreen(),
    ProfileScreen(),
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _tabs[_selectedIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: ColorsManager.grayish,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildIcon(Icons.home_filled, 0),
              _buildIcon(Icons.search_sharp, 1),
              _buildIcon(Icons.explore, 2),
              _buildIcon(Icons.person_pin, 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(IconData icon, int index) {
    final isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        // decoration: BoxDecoration(
        //   color: isSelected ? ColorsManager.yellow : Colors.transparent,
        //   shape: BoxShape.circle,
        // ),
        child: Icon(
          icon,
          color: isSelected ? ColorsManager.yellow: ColorsManager.white,
          size: 38,
        ),
      ),
    );
  }
}
