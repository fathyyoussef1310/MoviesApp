import 'package:flutter/material.dart';
import 'package:moviesapproute/core/colors_manager/colorsManager.dart';
import 'package:moviesapproute/core/image_manager/imagesManager.dart';
import '../../core/widgets/custom_text_form_fied.dart';

class Movie {
  final String title;
  final String image;
  Movie({required this.title, required this.image});
}

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}


class _SearchScreenState extends State<SearchScreen> {
  String searchQuery = "";
  List<Movie> allMovies = [
    Movie(title: 'Movie 1', image: 'assets/Images/movie1.png'),
    Movie(title: 'Movie 2', image: 'assets/Images/movie2.png'),
    Movie(title: 'Movie 3', image: 'assets/Images/movie3.png'),
    Movie(title: 'Movie 4', image: 'assets/Images/movie4.png'),
  ];
  List<Movie> filteredMovies = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorsManager.darkBlack,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CustomTextFormField(
                hint: 'Search',
                prefixIcon: Icons.search_outlined,
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                    filteredMovies = allMovies
                        .where((movie) =>
                        movie.title.toLowerCase().contains(searchQuery.toLowerCase()))
                        .toList();
                  });
                },
              ),
              const SizedBox(height: 20),
              Expanded(
                child: filteredMovies.isEmpty
                    ? Center(
                  child: searchQuery.isEmpty
                      ? Image.asset(
                    ImagesManager.popcorn,
                    fit: BoxFit.contain,
                  )
                      : Text(
                    "Not Found",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
                    : GridView.builder(
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
              )

            ],
          ),
        ),
      ),
    );
  }
}

