import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moviesapproute/features/home/widgets/FeaturedMoviesSection.dart';
import 'package:moviesapproute/features/home/widgets/MoviesCategorySection.dart';
import 'package:provider/provider.dart';
import 'package:moviesapproute/core/colors_manager/colorsManager.dart';
import 'package:moviesapproute/providers/movie_providers.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late MoviesProvider moviesProvider;
  Set<String> allCategories = {};

  @override
  void initState() {
    super.initState();
    moviesProvider = MoviesProvider();
    moviesProvider.getMovies().then((_) {
      _extractAllCategories();
    });
  }

  void _extractAllCategories() {
    final categories = <String>{};
    for (var movie in moviesProvider.movies) {
      if (movie.genres != null) {
        categories.addAll(movie.genres!);
      }
    }
    setState(() {
      allCategories = categories;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: moviesProvider),
      ],
      child: Scaffold(
        backgroundColor: ColorsManager.scaffoldBackgroundColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              FeaturedMoviesSection(),
              SizedBox(height: 10.h),
              ...allCategories.map((category) => Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: MoviesCategorySection(
                  header: category[0].toUpperCase() + category.substring(1),
                  categoryName: category,
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
