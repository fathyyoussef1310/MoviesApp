import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../core/colors_manager/colorsManager.dart';
import '../../../main_layout/MoviesDetailsScreen.dart';
import '../../../providers/movie_providers.dart';
class MoviesCategorySection extends StatelessWidget {
  const MoviesCategorySection({
    super.key,
    required this.header,
    required this.categoryName,
  });

  final String header;
  final String categoryName;

  @override
  Widget build(BuildContext context) {
    return Consumer<MoviesProvider>(
      builder: (context, moviesProvider, child) {
        if (moviesProvider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (moviesProvider.errorMessage != null) {
          return Center(child: Text(moviesProvider.errorMessage!));
        }
        if (moviesProvider.movies.isEmpty) {
          return const Center(child: Text("No movies found"));
        }

        final categoryMovies = moviesProvider.movies
            .where(
              (movie) =>
          movie.genres
              ?.map((g) => g.toLowerCase())
              .contains(categoryName.toLowerCase()) ??
              false,
        )
            .take(15)
            .toList();

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    header,
                    style: GoogleFonts.inter(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: ColorsManager.white,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // TODO: See More navigation
                    },
                    child: Row(
                      children: [
                        Text(
                          "See More ",
                          style: GoogleFonts.inter(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                            color: ColorsManager.yellow,
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward,
                          color: ColorsManager.yellow,
                          size: 14,
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15.h),

              // Movies horizontal list
              SizedBox(
                height: 300.h,
                child: ListView.builder(
                  itemCount: categoryMovies.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final movie = categoryMovies[index];
                    return GestureDetector(
                      onTap: () {
                        // Navigate to MovieDetailsScreen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => MovieDetailsScreen(
                              movieId: movie.id!,
                            ),
                          ),
                        );
                      },
                      child: Stack(
                        children: [
                          // Poster
                          Container(
                            width: 180.w,
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              image: DecorationImage(
                                image: NetworkImage(
                                  movie.mediumCoverImage ??
                                      "https://via.placeholder.com/180x270",
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          // Rating badge
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
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
