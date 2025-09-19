import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:moviesapproute/controllers/UpdateProfileController.dart';
import 'package:moviesapproute/core/colors_manager/colorsManager.dart';
import 'package:moviesapproute/core/image_manager/imagesManager.dart';
import 'package:moviesapproute/core/routes_manager/routesManager.dart';
import 'package:moviesapproute/features/Screens/update_profile.dart';

class Movie {
  final String title;
  final String image;

  Movie({required this.title, required this.image});
}

// test watch list
List<Movie> watchListMovies = [
  // Movie(title: "Movie 1", image: "assets/Images/movie1.png"),
  // Movie(title: "Movie 2", image: "assets/Images/movie2.png"),
  // Movie(title: "Movie 3", image: "assets/Images/movie3.png"),
  // Movie(title: "Movie 4", image: "assets/Images/movie4.png"),
  // Movie(title: "Movie 5", image: "assets/Images/movie5.png"),
  // Movie(title: "Movie 6", image: "assets/Images/movie6.png"),
];

// test history list
List<Movie> historyMovies = [
  // Movie(title: "Movie 1", image: "assets/Images/movie1.png"),
  // Movie(title: "Movie 2", image: "assets/Images/movie2.png"),
  // Movie(title: "Movie 3", image: "assets/Images/movie3.png"),
  // Movie(title: "Movie 4", image: "assets/Images/movie4.png"),
  // Movie(title: "Movie 5", image: "assets/Images/movie5.png"),
  // Movie(title: "Movie 6", image: "assets/Images/movie6.png"),
  // Movie(title: "Movie 1", image: "assets/Images/movie1.png"),
  // Movie(title: "Movie 2", image: "assets/Images/movie2.png"),
  // Movie(title: "Movie 3", image: "assets/Images/movie3.png"),
  // Movie(title: "Movie 4", image: "assets/Images/movie4.png"),
  // Movie(title: "Movie 5", image: "assets/Images/movie5.png"),
  // Movie(title: "Movie 6", image: "assets/Images/movie6.png"),
];

class ProfileScreen extends StatefulWidget {
   ProfileScreen({super.key});
  final UpdateProfileController updateProfileController= Get.put(UpdateProfileController());

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
  Widget buildMovieGrid(List<Movie> movies) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                child: Image.asset(
                  movie.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              movie.title,
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
            Obx(()=>Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 55,
                        backgroundImage: AssetImage( widget.updateProfileController.selectedAvatarId.value == 1 ? ImagesManager.User1 : widget.updateProfileController.selectedAvatarId.value == 2 ? ImagesManager.User2 : ImagesManager.User3,),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.updateProfileController.nameController.text, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: ColorsManager.white)),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(width: 80),
                  Column(
                    children: const [
                      Text("12",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: ColorsManager.white)),
                      Text("Wish List",
                          style: TextStyle(
                              color: ColorsManager.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(width: 20),
                  Column(
                    children: const [
                      Text("10",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: ColorsManager.white)),
                      Text("History",
                          style: TextStyle(
                              color: ColorsManager.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                    ],
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
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text("Edit Profile",
                          style: TextStyle(
                              color: ColorsManager.darkBlack, fontSize: 20)),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      label: const Text("Exit",
                          style: TextStyle(
                              color: ColorsManager.white, fontSize: 20)),
                      icon: const Icon(LucideIcons.logOut,
                          color: ColorsManager.white),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorsManager.red,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
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
                  watchListMovies.isEmpty
                      ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Image(image: AssetImage(ImagesManager.popcorn)),
                        SizedBox(height: 10),
                        Text("No movies yet",
                            style: TextStyle(color: ColorsManager.ofwhite)),
                      ],
                    ),
                  )
                      : Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: buildMovieGrid(watchListMovies),
                  ),
                  historyMovies.isEmpty
                      ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.history,
                            size: 80, color: ColorsManager.yellow),
                        SizedBox(height: 10),
                        Text("No history yet",
                            style: TextStyle(color:  ColorsManager.ofwhite)),
                      ],
                    ),
                  )
                      : Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: buildMovieGrid(historyMovies),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
