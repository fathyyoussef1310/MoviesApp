import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviesapproute/core/colors_manager/colorsManager.dart';
import 'package:provider/provider.dart';
import 'package:moviesapproute/providers/movie_providers.dart';
import 'dart:ui';

import '../../../core/image_manager/imagesManager.dart';
import '../../../main_layout/MoviesDetailsScreen.dart';

class FeaturedMoviesSection extends StatefulWidget {
  const FeaturedMoviesSection({super.key});

  @override
  State<FeaturedMoviesSection> createState() => _FeaturedMoviesSectionState();
}

class _FeaturedMoviesSectionState extends State<FeaturedMoviesSection> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<MoviesProvider>(
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

        final currentMovie = moviesProvider.movies[currentIndex];

        return Stack(
          children: [
            // الخلفية
            Positioned.fill(
              child: currentMovie.mediumCoverImage != null
                  ? Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    currentMovie.mediumCoverImage!,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    decoration: const BoxDecoration(
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

            // المحتوى
            Column(
              children: [
                SafeArea(
                  child: Center(child: Image.asset(ImagesManager.avilableNow)),
                ),
                CarouselSlider.builder(
                  itemCount: moviesProvider.movies.length,
                  itemBuilder: (context, index, realIndex) {
                    final movie = moviesProvider.movies[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MovieDetailsScreen(
                              movieId: movie.id ?? 0,
                            ),
                          ),
                        );
                      },
                      child: Stack(
                        children: [
                          Container(
                            margin:
                            const EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              image: DecorationImage(
                                image: NetworkImage(
                                    movie.mediumCoverImage ?? ""),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 15,
                            left: 15,
                            child: Container(
                              padding: const EdgeInsets.all(7),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: ColorsManager.grayish,
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    movie.rating?.toString() ?? "0.0",
                                    style: GoogleFonts.inter(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                      color: ColorsManager.white,
                                    ),
                                  ),
                                  SizedBox(width: 5.w),
                                  Icon(
                                    Icons.star,
                                    color: ColorsManager.yellow,
                                    size: 18.sp,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
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
