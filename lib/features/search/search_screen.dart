import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moviesapproute/core/colors_manager/colorsManager.dart';
import 'package:moviesapproute/core/image_manager/imagesManager.dart';
import '../../core/widgets/custom_text_form_fied.dart';
import '../../data/api_service/api_service.dart';
import '../../data/model/movie_list/Movies.dart';
import '../home/widgets/movie_card.dart';

class SearchMovies extends StatefulWidget {
  const SearchMovies({super.key});

  @override
  State<SearchMovies> createState() => _SearchMoviesState();
}

class _SearchMoviesState extends State<SearchMovies> {
  final TextEditingController _controller = TextEditingController();
  Timer? _debounce;

  List<Movies> _results = [];
  bool _isLoading = false;
  String? _error;

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      if (query.isEmpty) {
        setState(() {
          _results = [];
        });
        return;
      }

      setState(() {
        _isLoading = true;
        _error = null;
      });

      try {
        final movies = await ApiService.searchMovies(query);
        setState(() {
          _results = movies ?? [];
          _isLoading = false;
        });
      } catch (e) {
        setState(() {
          _error = e.toString();
          _isLoading = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.darkBlack,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CustomTextFormField(
                hint: 'Search',
                prefixIcon: Icons.search_outlined,
                controller: _controller,
                onChanged: _onSearchChanged,
              ),
              SizedBox(height: 20.h),
              Expanded(
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : _error != null
                    ? Center(
                  child: Text(
                    "Error: $_error",
                    style: const TextStyle(color: Colors.white),
                  ),
                )
                    : _results.isEmpty
                    ? Center(
                  child: Image.asset(
                    ImagesManager.popcorn,
                    fit: BoxFit.contain,
                  ),
                )
                    : GridView.builder(
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: _results.length,
                  itemBuilder: (context, index) {
                    final movie = _results[index];
                    return MovieCard(
                      movie: movie,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
