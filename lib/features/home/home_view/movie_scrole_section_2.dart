import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../core/colors_manager/colorsManager.dart';
import '../../../providers/movie_List_providers.dart';
import '../widgets/movie_card.dart';

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
    return Consumer<MoviesListProvider>(
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
                    onPressed: () {},
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
                        Icon(Icons.arrow_forward,color: ColorsManager.yellow,size: 14,)
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15.h),
              SizedBox(
                height: 300.h,
                child:
                ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(width: 15.w),
                  scrollDirection: Axis.horizontal,
                  itemCount: categoryMovies.length,
                  itemBuilder: (context, index) {
                    final movie = categoryMovies[index];
                    return MovieCard(
                      movie: movie,
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
