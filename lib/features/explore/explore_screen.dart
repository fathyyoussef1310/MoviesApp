import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:moviesapproute/core/colors_manager/colorsManager.dart';
import 'package:moviesapproute/data/api_service/api_service.dart';
import 'package:moviesapproute/repositiory/movie_repository.dart';
import 'package:moviesapproute/controllers/BrowseControllers.dart';
import 'package:moviesapproute/data/model/movie_list/Movies.dart';
import '../home/widgets/movie_card.dart';
import '../home/widgets/movie_details_screen.dart';

class ExploreScreen extends StatelessWidget {
  ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final BrowseController controller =
    Get.put(BrowseController(BrowseRepository(ApiService())));
    final baseCategories = ["All"];
    return Scaffold(
      backgroundColor: ColorsManager.darkBlack,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() {
                final categories = [...baseCategories, ...controller.genres.toList()];
                return SizedBox(
                  height: 50.h,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    separatorBuilder: (context, index) => SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      final isSelected = category == controller.selectedCategory.value;
                      return GestureDetector(
                        onTap: () {
                          controller.changeCategory(category);
                        },
                        child: Container(
                          padding:
                          EdgeInsets.symmetric(horizontal: 20.sp, vertical: 10.sp),
                          decoration: BoxDecoration(
                            color: isSelected ? ColorsManager.yellow : ColorsManager.darkBlack,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: ColorsManager.yellow,
                              width: 2,
                            ),
                          ),
                          child: Text(category, style: TextStyle(color: isSelected ? ColorsManager.darkBlack : ColorsManager.yellow, fontWeight: FontWeight.bold, fontSize: 18.sp,),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }),
              SizedBox(height: 20.h),
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value && controller.movies.isEmpty) {
                    return Center(
                      child: CircularProgressIndicator(color: ColorsManager.yellow),
                    );
                  }
                  List<Movies> displayedMovies =
                  controller.selectedCategory.value == "All" ? controller.movies : controller.filterByGenre(controller.selectedCategory.value);
                  if (displayedMovies.isEmpty) {
                    return Center(child: Text("No movies found", style: TextStyle(color: ColorsManager.red)),);
                  }
                  return GridView.builder(
                    controller: controller.scrollController,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16.sp,
                      crossAxisSpacing: 16.sp,
                      childAspectRatio: 0.6,
                    ),
                    itemCount: displayedMovies.length,
                    itemBuilder: (context, index) {
                      final movie = displayedMovies[index];

                      return GestureDetector(
                        onTap: () {
                          Get.to(()=> MovieDetailsScreen(movieId: movie.id!,));
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  movie.mediumCoverImage ?? "https://via.placeholder.com/150", ///Chat
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(height: 5),
                          ],
                        ),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
