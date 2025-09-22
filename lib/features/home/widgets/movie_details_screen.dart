import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviesapproute/core/colors_manager/colorsManager.dart';
import 'package:moviesapproute/core/widgets/custom_container.dart';
import 'package:moviesapproute/core/widgets/custom_elevated_button.dart';
import 'package:moviesapproute/data/model/HomepageApi/Movies.dart';
import 'package:moviesapproute/data/model/MovieDetailsApi/Movie.dart';
import 'package:provider/provider.dart';
import '../../../data/api_service/api_service.dart';
import '../../../data/model/movie_list/Movies.dart' hide Movies;
import '../../../providers/favorites_provider.dart';
import '../../../providers/movie_details_providers.dart';
import '../../../providers/movie_suggestion_provider.dart';
import '../../../repositiory/movie_repository.dart';
import '../../../features/home/widgets/movie_card.dart';

// Converter function from Movie (API) to Movies (provider)
Movies convertMovieToMovies(dynamic movie) {
  return Movies(
    id: movie.id,
    title: movie.title ?? movie.titleLong ?? "No Title",
    mediumCoverImage: movie.mediumCoverImage ?? "",
    largeCoverImage: movie.largeCoverImage ?? "",
    rating: movie.rating ?? 0.0,
    likeCount: movie.likeCount ?? 0,
  );
}

class MovieDetailsScreen extends StatelessWidget {
  final int movieId;

  const MovieDetailsScreen({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) {
            final provider = MovieDetailsProvider(MovieRepository(ApiService()));
            provider.loadMovieDetails(movieId);
            return provider;
          },
        ),
        ChangeNotifierProvider(
          create: (_) {
            final provider =
            MovieSuggestionsProvider(MovieSuggestionsRepository(ApiService()));
            provider.loadSuggestions(movieId);
            return provider;
          },
        ),
      ],
      child: Consumer2<MovieDetailsProvider, MovieSuggestionsProvider>(
        builder: (context, detailsProvider, suggestionsProvider, _) {
          if (detailsProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (detailsProvider.movieDetails == null) {
            return const Center(child: Text("Failed to load movie details"));
          }

          final movie = detailsProvider.movieDetails!.data?.movie;

          if (movie == null) {
            return const Center(child: Text("No movie data available"));
          }

          final favProvider = Provider.of<FavoritesProvider>(context);

          final isFavorite = favProvider.favorites.any((m) => m.id == movie.id);

          return Scaffold(
            backgroundColor: ColorsManager.scaffoldBackgroundColor,
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new, color: ColorsManager.white),
                onPressed: () => Navigator.pop(context),
              ),
              actions: [
                IconButton(
                  icon: Icon(
                    isFavorite ? Icons.bookmark : Icons.bookmark_border,
                    size: 30,
                    color: ColorsManager.white,
                  ),
                  onPressed: () {
                    favProvider.toggleFavorite(convertMovieToMovies(movie) as Movies);
                  },
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Poster Section
                  AspectRatio(
                    aspectRatio: 2 / 3,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        movie.largeCoverImage != null
                            ? Image.network(movie.largeCoverImage!, fit: BoxFit.cover)
                            : Container(color: Colors.black),
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
                        Padding(
                          padding: const EdgeInsets.all(0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Center(
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white.withOpacity(0.5),
                                  ),
                                  child: Icon(Icons.play_arrow_outlined,
                                      size: 60, color: ColorsManager.white),
                                ),
                              ),
                              SizedBox(height: 20.h),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text(
                                    movie.titleLong ?? movie.title ?? "Unknown Name",
                                    style: GoogleFonts.inter(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.h),
                              Center(
                                child: Text(
                                  "${movie.year ?? 0}",
                                  style: GoogleFonts.inter(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: ColorsManager.grayish,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Watch Button + Stats
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CustomElevatedButton(
                          onPressed: () {
                            favProvider.addToHistory(convertMovieToMovies(movie) as Movies);
                          },
                          title: "Watch",
                          backgroundColor: ColorsManager.red,
                          foregroundColor: ColorsManager.white,
                        ),
                        SizedBox(height: 15.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomContainer(
                              Title: "${movie.likeCount ?? 0}",
                              icon: Icons.favorite,
                            ),
                            CustomContainer(
                              Title: "90",
                              icon: Icons.watch_later,
                            ),
                            CustomContainer(
                              Title: "${movie.rating ?? 0.0}",
                              icon: Icons.star,
                            ),
                          ],
                        ),
                        SizedBox(height: 15.h),
                        // Screenshots
                        Text(
                          "Screen Shots",
                          style: GoogleFonts.inter(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: ColorsManager.white,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Consumer<MovieDetailsProvider>(
                          builder: (context, detailsProvider, _) {
                            final movie = detailsProvider.movieDetails!.data?.movie;
                            final List<String> screenshots = [
                              movie?.backgroundImage ?? "",
                              movie?.backgroundImageOriginal ?? "",
                              movie?.backgroundImageOriginal ?? "",
                            ];
                            return Column(
                              children: screenshots.map((imageUrl) {
                                if (imageUrl.isEmpty) {
                                  return Container(
                                    height: 150,
                                    width: double.infinity,
                                    margin: const EdgeInsets.symmetric(vertical: 8),
                                    color: Colors.grey,
                                  );
                                }
                                return Container(
                                  height: 150,
                                  width: double.infinity,
                                  margin: const EdgeInsets.symmetric(vertical: 8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    image: DecorationImage(
                                      image: NetworkImage(imageUrl),
                                      fit: BoxFit.cover,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: ColorsManager.grayish.withOpacity(0.4),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: const Offset(0, 1),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            );
                          },
                        ),
                        SizedBox(height: 15.h),
                        // Similar Movies
                        Text(
                          "Similar",
                          style: GoogleFonts.inter(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: ColorsManager.white),
                        ),
                        SizedBox(height: 15.h),
                        Consumer<MovieSuggestionsProvider>(
                          builder: (context, provider, _) {
                            if (provider.isLoading) {
                              return const Center(child: CircularProgressIndicator());
                            }
                            if (provider.errorMessage != null) {
                              return Center(child: Text(provider.errorMessage!));
                            }
                            if (provider.suggestions == null || provider.suggestions!.isEmpty) {
                              return Center(
                                child: Text(
                                  "No suggestions available",
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.bold,
                                    color: ColorsManager.white,
                                    fontSize: 16,
                                  ),
                                ),
                              );
                            }

                            final suggestions = provider.suggestions ?? [];

                            return Column(
                              children: List.generate(
                                (suggestions.length / 2).ceil(),
                                    (index) {
                                  int first = index * 2;
                                  int second = first + 1;

                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 16),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: MovieCard(
                                            movie: suggestions[first],
                                            height: 270,
                                          ),
                                        ),
                                        SizedBox(width: 16.w),
                                        if (second < suggestions.length)
                                          Expanded(
                                            child: MovieCard(
                                              movie: suggestions[second],
                                              height: 270,
                                            ),
                                          )
                                        else
                                          Expanded(child: Container()),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 10.h),
                        // Summary
                        Text(
                          "Summary",
                          style: GoogleFonts.inter(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: ColorsManager.white),
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          movie.descriptionFull ?? "No description",
                          style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: ColorsManager.ofwhite),
                        ),
                        SizedBox(height: 15.h),
                        Divider(color: ColorsManager.grayish, thickness: 1.h),
                        // Genres
                        Text(
                          "Genres",
                          style: GoogleFonts.inter(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: ColorsManager.white),
                        ),
                        SizedBox(height: 10.h),
                        if (movie.genres != null)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Wrap(
                              spacing: 8.sp,
                              children: movie.genres!
                                  .map(
                                    (genre) => Chip(
                                  label: Text(
                                    genre,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  backgroundColor: ColorsManager.gray,
                                ),
                              )
                                  .toList(),
                            ),
                          ),
                        SizedBox(height: 16),
                        // Cast
                        if (movie.cast != null && movie.cast!.isNotEmpty) ...[
                          SizedBox(height: 20.h),
                          Text(
                            "Cast",
                            style: GoogleFonts.inter(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: ColorsManager.white,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          SizedBox(
                            height: 150,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: movie.cast!.length,
                              itemBuilder: (context, index) {
                                final actor = movie.cast![index];
                                return Container(
                                  width: 100,
                                  margin: EdgeInsets.only(right: 12.w),
                                  child: Column(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: actor.imageUrl != null
                                            ? Image.network(
                                          actor.imageUrl!,
                                          height: 100,
                                          width: 100,
                                          fit: BoxFit.cover,
                                        )
                                            : Container(
                                          height: 100,
                                          width: 100,
                                          color: Colors.grey,
                                          child: Icon(Icons.person, color: Colors.white),
                                        ),
                                      ),
                                      SizedBox(height: 5.h),
                                      Text(
                                        actor.name ?? "Unknown",
                                        style: GoogleFonts.inter(
                                          fontSize: 12,
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
