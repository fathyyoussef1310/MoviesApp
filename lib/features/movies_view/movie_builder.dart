import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:moviesapproute/providers/movie_providers.dart';
import '../../data/api_service/api_service.dart';

class MoviesBuilder extends StatelessWidget {
  const MoviesBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: apiService.getMovies(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Center(child: Text("Error loading movies"));
        }

        final movies = snapshot.data ?? [];

        if (movies.isEmpty) {
          return const Center(child: Text("No movies found"));
        }

        return
          CarouselSlider(
          options: CarouselOptions(
            height: 300.0,
            viewportFraction: .5,
            enlargeCenterPage: true,
            autoPlay: true,
            enableInfiniteScroll: true,
          ),
          items: movies.map((movie) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: NetworkImage(movie.backgroundImage ?? ""),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            );
          }).toList(),
        );
      },
    );
  }
}
