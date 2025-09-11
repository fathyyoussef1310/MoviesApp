import 'package:flutter/material.dart';
import 'package:moviesapproute/core/colors_manager/colorsManager.dart';

class Movie {
  final String title;
  final String image;
  final String category;
  Movie({required this.title, required this.image, required this.category});
}

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  String selectedCategory = "All";

  List<String> categories = [
    "All",
    "Action",
    "Comedy",
    "Drama",
    "Horror",
    "Romance",
  ];

  List<Movie> allMovies = [
    Movie(title: 'Movie 1', image: 'assets/Images/movie1.png', category: "Action"),
    Movie(title: 'Movie 2', image: 'assets/Images/movie2.png', category: "Comedy"),
    Movie(title: 'Movie 3', image: 'assets/Images/movie3.png', category: "Drama"),
    Movie(title: 'Movie 4', image: 'assets/Images/movie5.png', category: "Horror"),
    Movie(title: 'Movie 5', image: 'assets/Images/movie4.png', category: "Romance"),
    Movie(title: 'Movie 6', image: 'assets/Images/movie6.png', category: "Action"),
  ];

  @override
  Widget build(BuildContext context) {

    List<Movie> filteredMovies = selectedCategory == "All"
        ? allMovies
        : allMovies.where((m) => m.category == selectedCategory).toList();

    return Scaffold(
      backgroundColor: ColorsManager.darkBlack,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Categories Bar
              SizedBox(
                height: 50,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  separatorBuilder: (context, index) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    final isSelected = category == selectedCategory;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCategory = category;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.yellow : ColorsManager.darkBlack,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: ColorsManager.yellow,
                            width: 2,
                          ),
                        ),
                        child: Text(
                          category,
                          style: TextStyle(
                            color: isSelected ? ColorsManager.darkBlack: ColorsManager.yellow,
                            fontWeight: FontWeight.bold,fontSize: 20
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            
            
              const SizedBox(height: 20),
            
              // Movies Grid
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: filteredMovies.length,
                  itemBuilder: (context, index) {
                    final movie = filteredMovies[index];
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        movie.image,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
