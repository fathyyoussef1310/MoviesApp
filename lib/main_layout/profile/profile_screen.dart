// profile_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:moviesapproute/controllers/UpdateProfileController.dart';
import 'package:moviesapproute/core/colors_manager/colorsManager.dart';
import 'package:moviesapproute/core/image_manager/imagesManager.dart';
import 'package:moviesapproute/core/routes_manager/routesManager.dart';
import 'package:provider/provider.dart';
import 'package:moviesapproute/providers/favorites_provider.dart';
import 'package:moviesapproute/data/model/movie_list/Movies.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});
  final UpdateProfileController updateProfileController =
  Get.put(UpdateProfileController());

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  Widget buildMovieGrid(List<Movies> movies) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.6,
      ),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];
        return Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  movie.mediumCoverImage ?? "",
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.broken_image,
                      size: 40, color: ColorsManager.ofwhite),
                ),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              movie.title ?? "No Title",
              style: const TextStyle(color: ColorsManager.white, fontSize: 12),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.darkBlack,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            Obx(
                  () => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 55,
                        backgroundImage: AssetImage(
                          widget.updateProfileController.selectedAvatarId.value == 1
                              ? ImagesManager.User1
                              : widget.updateProfileController.selectedAvatarId.value == 2
                              ? ImagesManager.User2
                              : ImagesManager.User3,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.updateProfileController.nameController.text,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: ColorsManager.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(width: 80),
                  Consumer<FavoritesProvider>(
                    builder: (context, favProvider, _) {
                      return Column(
                        children: [
                          Text(
                            favProvider.favorites.length.toString(),
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: ColorsManager.white,
                            ),
                          ),
                          const Text(
                            "Wish List",
                            style: TextStyle(
                              color: ColorsManager.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(width: 20),
                  Consumer<FavoritesProvider>(
                    builder: (context, favProvider, _) {
                      return Column(
                        children: [
                          Text(
                            favProvider.history.length.toString(),
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: ColorsManager.white,
                            ),
                          ),
                          const Text(
                            "History",
                            style: TextStyle(
                              color: ColorsManager.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(width: 16),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Get.offAllNamed(RoutesManager.updateProfileUi);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorsManager.yellow,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Edit Profile",
                        style: TextStyle(
                          color: ColorsManager.darkBlack,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      label: const Text(
                        "Exit",
                        style: TextStyle(
                          color: ColorsManager.white,
                          fontSize: 20,
                        ),
                      ),
                      icon: const Icon(
                        LucideIcons.logOut,
                        color: ColorsManager.white,
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorsManager.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            TabBar(
              controller: _tabController,
              indicatorColor: ColorsManager.yellow,
              labelColor: ColorsManager.yellow,
              unselectedLabelColor: ColorsManager.white,
              tabs: const [
                Tab(icon: Icon(Icons.list), text: "Watch List"),
                Tab(icon: Icon(Icons.folder), text: "History"),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  Consumer<FavoritesProvider>(
                    builder: (context, favProvider, _) {
                      return favProvider.favorites.isEmpty
                          ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Image(
                              image: AssetImage(ImagesManager.popcorn),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "No movies yet",
                              style: TextStyle(color: ColorsManager.ofwhite),
                            ),
                          ],
                        ),
                      )
                          : Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: buildMovieGrid(favProvider.favorites.cast<Movies>()),
                      );
                    },
                  ),
                  Consumer<FavoritesProvider>(
                    builder: (context, favProvider, _) {
                      return favProvider.history.isEmpty
                          ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.history,
                                size: 80, color: ColorsManager.yellow),
                            SizedBox(height: 10),
                            Text(
                              "No history yet",
                              style: TextStyle(color: ColorsManager.ofwhite),
                            ),
                          ],
                        ),
                      )
                          : Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: buildMovieGrid(favProvider.history.cast<Movies>()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
