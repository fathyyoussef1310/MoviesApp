import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moviesapproute/data/model/movie_list/Movies.dart';
import 'package:moviesapproute/repositiory/movie_repository.dart';
class BrowseController extends GetxController {
  final BrowseRepository browseRepository;
  BrowseController(this.browseRepository);
  var isLoading = false.obs;
  var movies = <Movies>[].obs;
  var genres = <String>{}.obs;
  var page = 1.obs;
  var hasMore = true.obs;
  var selectedCategory = "All".obs;
  late ScrollController scrollController;
  @override
  void onInit()
  {
    super.onInit();
    scrollController = ScrollController()..addListener(_onScroll);
    fetchMovies();
  }
  void _onScroll()
  {
    if (!scrollController.hasClients) return;
    ////hasClients ==More Postion
    final pos = scrollController.position;
    if (pos.pixels >= pos.maxScrollExtent) ////Iterate لغايه اخر الصفحه يعني
    {
      if (hasMore.value && !isLoading.value) ////true and true
      {
        fetchMovies(loadMore: true);
      }
    }
  }
  Future<void> fetchMovies({bool loadMore = false}) async {
    if (isLoading.value) return;
    if (!hasMore.value && loadMore) return;
    try
    {
      isLoading.value = true;
      final result = await browseRepository.fetchMovies(
        page: page.value,
        limit: 20,
      );
      if (result != null && result.isNotEmpty) {
        if (loadMore)
        {
          movies.addAll(result);
        } else
        {
          movies.assignAll(result);
        }
        for (var movie in result) {
          if (movie.genres != null)
          {
            genres.addAll(movie.genres!);
          }
        }
        page.value++;
      }
      else
      {
        hasMore.value = false;
      }
    } catch (e) {
      print("❌ Error fetching movies: $e");
    } finally {
      isLoading.value = false;
    }
  }
  void changeCategory(String category) {
    selectedCategory.value = category;
  }
  List<Movies> filterByGenre(String genre) {
    return movies.where((movie) => movie.genres?.contains(genre) ?? false).toList();
  }
  @override
  void onClose()
  {
    try
    {
      scrollController.removeListener(_onScroll);
      scrollController.dispose();
    } catch (_) {}
    super.onClose();
  }
}
