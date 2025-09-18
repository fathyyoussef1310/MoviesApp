import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moviesapproute/core/colors_manager/colorsManager.dart';
import 'package:provider/provider.dart';
import '../../providers/movie_details_provider.dart';
class MovieDetailsScreen extends StatelessWidget {
  final int movieId;
  const MovieDetailsScreen({super.key, required this.movieId});
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) { ///////from Chat Gpt to get Movies Detaisls form provider <<Repository<<Model<<Api
      context.read<MovieDetailsProvider>().loadMovieDetails(movieId);
    });
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorsManager.yellow),
        centerTitle: true,
        title: Text("Movie Details",style: TextStyle(color: ColorsManager.yellow),),
        backgroundColor: ColorsManager.darkBlack,
      ),
      backgroundColor: ColorsManager.darkBlack,
      body: Consumer<MovieDetailsProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return  Center(child: CircularProgressIndicator(color:ColorsManager.yellow));
          }
          if (provider.errorMessage != null) {
            return Center(
              child: Text(provider.errorMessage!,
                style: TextStyle(color: Colors.red),
              ),
            );
          }
          final movie = provider.movieDetails?.data?.movie;
          if (movie == null) {
            return Center(child: Text("No details available"));
          }
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  movie.largeCoverImage ?? "",
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.cover,
                ),
                 SizedBox(height: 16.h),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    "${movie.title} (${movie.year})",
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                      color: ColorsManager.yellow,
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                Padding(
                  padding:const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      const Icon(Icons.star, color: ColorsManager.yellow),
                      const SizedBox(width: 4),
                      Text(
                        "${movie.rating}/10",
                        style:  TextStyle(fontSize: 16.sp,color: ColorsManager.yellow),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                if (movie.genres != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Wrap( /////ABDO khalil and AboAli
                      spacing: 8.sp,
                      children: movie.genres!
                          .map((genre) => Chip(label: Text(genre)))
                          .toList(),
                    ),
                  ),
                 SizedBox(height: 16),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    movie.title ?? "No description",
                    style:  TextStyle(fontSize: 16, height: 1.5,color: ColorsManager.yellow),
                  ),
                ),

                 SizedBox(height: 24.h),
              ],
            ),
          );
        },
      ),
    );
  }
}
