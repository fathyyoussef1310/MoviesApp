import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:moviesapproute/providers/movie_List_providers.dart';
import 'dart:ui';
import '../../../core/image_manager/imagesManager.dart';
import '../widgets/movie_card.dart';

class FeaturedMoviesSection extends StatefulWidget {
  const FeaturedMoviesSection({super.key});

  @override
  State<FeaturedMoviesSection> createState() => _FeaturedMoviesSectionState();
}

class _FeaturedMoviesSectionState extends State<FeaturedMoviesSection> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<MoviesListProvider>(
      builder: (context, moviesProvider, child) {
        if (moviesProvider.isLoading) {
          return SafeArea(
            child: const Center(child: CircularProgressIndicator()),
          );
        }

        if (moviesProvider.errorMessage != null) {
          return Center(child: Text(moviesProvider.errorMessage!));
        }

        if (moviesProvider.movies.isEmpty) {
          return const Center(child: Text("No movies found"));
        }

        final validMovies = moviesProvider.movies
            .where((movie) => movie.mediumCoverImage != null && movie.mediumCoverImage!.isNotEmpty)
            .toList();

        if (validMovies.isEmpty) {
          return const Center(child: Text("No valid movies with images"));
        }

        final currentMovie = validMovies[currentIndex];

        return Stack(
          children: [
            Positioned.fill(
              child: currentMovie.mediumCoverImage != null
                  ? Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    currentMovie.mediumCoverImage!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.black,
                        child: Center(
                          child: Icon(Icons.broken_image, size: 50, color: Colors.white),
                        ),
                      );
                    },
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color.fromRGBO(0, 0, 0, 0.5),
                          Color.fromRGBO(0, 0, 0, 0.8),
                        ],
                      ),
                    ),
                  ),
                ],
              )
                  : Container(color: Colors.black),
            ),
            Column(
              children: [
                SafeArea(
                  child: Center(child: Image.asset(ImagesManager.avilableNow)),
                ),
                CarouselSlider.builder(
                  itemCount:5, //validMovies.length,
                  itemBuilder: (context, index, realIndex) {
                    final movie = validMovies[index];
                    return MovieCard(
                      movie: movie,
                      width: 200,
                      height: 300,
                    );
                  },
                  options: CarouselOptions(
                    height: 351.h,
                    viewportFraction: 0.6,
                    enlargeCenterPage: true,
                    autoPlay: false,
                    enableInfiniteScroll: true,
                    onPageChanged: (index, reason) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                  ),
                ),
                SizedBox(height: 21.h),
                Center(child: Image.asset(ImagesManager.watchNow)),
              ],
            ),
          ],
        );
      },
    );
  }
}
