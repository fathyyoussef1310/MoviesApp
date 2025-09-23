import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviesapproute/core/colors_manager/colorsManager.dart';
import 'package:moviesapproute/core/widgets/custom_container.dart';
import 'package:moviesapproute/core/widgets/custom_elevated_button.dart';
import 'package:moviesapproute/data/api_service/favorite_service.dart';
import 'package:moviesapproute/data/api_service/history_service.dart';
import 'package:moviesapproute/data/model/favorite/favorite_model.dart';
import 'package:moviesapproute/data/model/history/history_model.dart';
import 'package:moviesapproute/providers/favorites_provider.dart';
import 'package:provider/provider.dart';
import '../../../data/api_service/api_service.dart';
import '../../../providers/movie_details_providers.dart';
import '../../../providers/movie_suggestion_provider.dart';
import '../../../repositiory/movie_repository.dart';
import '../../../features/home/widgets/movie_card.dart';

class MovieDetailsScreen extends StatefulWidget {
  final int movieId;

  const MovieDetailsScreen({super.key, required this.movieId});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FavoritesProvider(),
      child: _buildMovieDetailsContent(),
    );
  }

  Widget _buildMovieDetailsContent() {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) {
            final provider = MovieDetailsProvider(
              MovieRepository(ApiService()),
            );
            provider.loadMovieDetails(widget.movieId);
            return provider;
          },
        ),
        ChangeNotifierProvider(
          create: (_) {
            final provider = MovieSuggestionsProvider(
              MovieSuggestionsRepository(ApiService()),
            );
            provider.loadSuggestions(widget.movieId);
            return provider;
          },
        ),
      ],
      child: Consumer3<MovieDetailsProvider, MovieSuggestionsProvider, FavoritesProvider>(
        builder: (context, detailsProvider, suggestionsProvider, favoritesProvider, _) {
          return _buildScaffold(detailsProvider, suggestionsProvider, favoritesProvider, context);
        },
      ),
    );
  }

  Widget _buildScaffold(MovieDetailsProvider detailsProvider, MovieSuggestionsProvider suggestionsProvider, FavoritesProvider favoritesProvider, BuildContext context) {
    final isFavorite = favoritesProvider.isFavorite(widget.movieId);

    if (detailsProvider.isLoading) {
      return Scaffold(
        backgroundColor: ColorsManager.scaffoldBackgroundColor,
        body: Center(
          child: CircularProgressIndicator(color: ColorsManager.red),
        ),
      );
    }

    if (detailsProvider.movieDetails == null) {
      return Scaffold(
        backgroundColor: ColorsManager.scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: ColorsManager.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Center(
          child: Text(
            "Failed to load movie details",
            style: GoogleFonts.inter(color: ColorsManager.white),
          ),
        ),
      );
    }

    final movie = detailsProvider.movieDetails!.data?.movie;

    if (movie == null) {
      return Scaffold(
        backgroundColor: ColorsManager.scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: ColorsManager.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Center(
          child: Text(
            "No movie data available",
            style: GoogleFonts.inter(color: ColorsManager.white),
          ),
        ),
      );
    }

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
              color: ColorsManager.yellow,
            ),
            onPressed: () => _toggleFavorite(context, favoritesProvider, detailsProvider),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 2 / 3,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  movie.largeCoverImage != null
                      ? Image.network(
                    movie.largeCoverImage!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(color: ColorsManager.gray);
                    },
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          color: ColorsManager.red,
                        ),
                      );
                    },
                  )
                      : Container(color: ColorsManager.darkBlack),
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
                            child: Icon(
                              Icons.play_arrow_outlined,
                              size: 60,
                              color: ColorsManager.white,
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              movie.titleLong ?? "Unknown Name",
                              style: GoogleFonts.inter(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
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
                        SizedBox(height: 20.h),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomElevatedButton(
                    onPressed: () => _addToHistory(context, detailsProvider),
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
                        Title: "${movie.runtime ?? 90} min",
                        icon: Icons.watch_later,
                      ),
                      CustomContainer(
                        Title: "${movie.rating ?? 0.0}",
                        icon: Icons.star,
                      ),
                    ],
                  ),
                  SizedBox(height: 15.h),

                  Text(
                    "Screen Shots",
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: ColorsManager.white,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  _buildScreenshots(movie),
                  SizedBox(height: 15.h),

                  _buildSimilarMovies(suggestionsProvider),
                  SizedBox(height: 15.h),

                  _buildSummary(movie),
                  SizedBox(height: 15.h),

                  _buildGenres(movie),
                  SizedBox(height: 16.h),

                  if (movie.cast != null && movie.cast!.isNotEmpty)
                    _buildCast(movie),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _addToHistory(BuildContext context, MovieDetailsProvider detailsProvider) async {
    final movie = detailsProvider.movieDetails?.data?.movie;

    if (movie != null) {
      final historyMovie = HistoryModel(
        movieId: movie.id,
        title: movie.title ?? 'Unknown Title',
        posterPath: movie.largeCoverImage ?? movie.mediumCoverImage ?? movie.smallCoverImage ?? '',
        voteAverage: movie.rating ?? 0.0,
        releaseDate: movie.year?.toString() ?? '',
        watchedAt: DateTime.now(),
      );

      await HistoryService.addToHistory(historyMovie);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Added to history',
            style: GoogleFonts.inter(),
          ),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  _toggleFavorite(BuildContext context, FavoritesProvider favoritesProvider, MovieDetailsProvider detailsProvider) async {
    final movie = detailsProvider.movieDetails?.data?.movie;

    if (movie != null) {
      final favoriteMovie = FavoriteModel(
        movieId: movie.id,
        title: movie.title,
        posterPath: movie.smallCoverImage ?? movie.mediumCoverImage ?? '',
        voteAverage: movie.movieRating,
        releaseDate: movie.year?.toString() ?? '',
      );

      await favoritesProvider.toggleFavorite(favoriteMovie);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            favoritesProvider.isFavorite(movie.id)
                ? 'Added to watchlist'
                : 'Removed from watchlist',
            style: GoogleFonts.inter(),
          ),
          backgroundColor: favoritesProvider.isFavorite(movie.id)
              ? Colors.green
              : ColorsManager.red,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Widget _buildScreenshots(movie) {
    try {
      List<String> screenshots = [];

      if (movie.backgroundImage != null && movie.backgroundImage.toString().isNotEmpty) {
        screenshots.add(movie.backgroundImage.toString());
      }
      if (movie.backgroundImageOriginal != null && movie.backgroundImageOriginal.toString().isNotEmpty) {
        screenshots.add(movie.backgroundImageOriginal.toString());
      }
      if (movie.largeCoverImage != null && movie.largeCoverImage.toString().isNotEmpty) {
        screenshots.add(movie.largeCoverImage.toString());
      }

      if (screenshots.isEmpty) {
        return _buildEmptyScreenshot();
      }

      return Column(
        children: screenshots.map((imageUrl) => _buildScreenshotItem(imageUrl)).toList(),
      );
    } catch (e) {
      return _buildEmptyScreenshot();
    }
  }

  Widget _buildEmptyScreenshot() {
    return Container(
      height: 150,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: ColorsManager.gray,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        Icons.photo,
        size: 50,
        color: ColorsManager.grayish,
      ),
    );
  }

  Widget _buildScreenshotItem(String imageUrl) {
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
  }

  Widget _buildSimilarMovies(MovieSuggestionsProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 80.0),
          child: Divider(color: ColorsManager.grayish, thickness: 1.h),
        ),
        Text(
          "Similar Movies",
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: ColorsManager.white,
          ),
        ),
        SizedBox(height: 15.h),

        if (provider.isLoading)
          Center(child: CircularProgressIndicator(color: ColorsManager.red)),

        if (provider.errorMessage != null)
          Center(
            child: Text(
              provider.errorMessage!,
              style: GoogleFonts.inter(color: ColorsManager.white),
            ),
          ),

        if (provider.suggestions == null || provider.suggestions!.isEmpty)
          Center(
            child: Text(
              "No suggestions available",
              style: GoogleFonts.inter(
                fontWeight: FontWeight.bold,
                color: ColorsManager.white,
                fontSize: 16,
              ),
            ),
          ),

        if (provider.suggestions != null && provider.suggestions!.isNotEmpty)
          Column(
            children: List.generate(
              (provider.suggestions!.length / 2).ceil(),
                  (index) {
                int first = index * 2;
                int second = first + 1;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: MovieCard(
                          movie: provider.suggestions![first],
                          height: 270,
                        ),
                      ),
                      SizedBox(width: 16.w),
                      if (second < provider.suggestions!.length)
                        Expanded(
                          child: MovieCard(
                            movie: provider.suggestions![second],
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
          ),
      ],
    );
  }

  Widget _buildSummary(movie) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 80.0),
          child: Divider(color: ColorsManager.grayish, thickness: 1.h),
        ),
        Text(
          "Summary",
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: ColorsManager.white,
          ),
        ),
        SizedBox(height: 10.h),
        Text(
          movie.descriptionFull ?? "No description available",
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: ColorsManager.ofwhite,
          ),
        ),
      ],
    );
  }

  Widget _buildGenres(movie) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 80.0),
          child: Divider(color: ColorsManager.grayish, thickness: 1.h),
        ),
        Text(
          "Genres",
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: ColorsManager.white,
          ),
        ),
        SizedBox(height: 10.h),
        if (movie.genres != null && movie.genres!.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Wrap(
              spacing: 8.sp,
              children: movie.genres!
                  .map<Widget>((genre) {
                final genreString = genre.toString();
                return Chip(
                  label: Text(
                    genreString,
                    style: GoogleFonts.inter(color: Colors.white),
                  ),
                  backgroundColor: ColorsManager.gray,
                );
              })
                  .toList(),
            ),
          )
        else
          Text(
            "No genres available",
            style: GoogleFonts.inter(color: ColorsManager.grayish),
          ),
      ],
    );
  }

  Widget _buildCast(movie) {
    final hasCast = movie.cast != null &&
        movie.cast is List &&
        movie.cast!.isNotEmpty;

    if (!hasCast) {
      return SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
              final actorName = actor.name?.toString() ?? "Unknown";
              final actorImage = actor.imageUrl?.toString();

              return Container(
                width: 100,
                margin: EdgeInsets.only(right: 12.w),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: actorImage != null && actorImage.isNotEmpty
                          ? Image.network(
                        actorImage,
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return _buildActorPlaceholder();
                        },
                      )
                          : _buildActorPlaceholder(),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      actorName,
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
    );
  }

  Widget _buildActorPlaceholder() {
    return Container(
      height: 100,
      width: 100,
      color: ColorsManager.gray,
      child: Icon(Icons.person, color: ColorsManager.white),
    );
  }
}