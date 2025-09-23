import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:moviesapproute/controllers/UpdateProfileController.dart';
import 'package:moviesapproute/core/colors_manager/colorsManager.dart';
import 'package:moviesapproute/core/image_manager/imagesManager.dart';
import 'package:moviesapproute/core/routes_manager/routesManager.dart';
import 'package:moviesapproute/data/api_service/favorite_service.dart';
import 'package:moviesapproute/data/api_service/history_service.dart';
import 'package:moviesapproute/data/model/favorite/favorite_model.dart';
import 'package:moviesapproute/data/model/history/history_model.dart';
import 'package:moviesapproute/features/home/widgets/movie_details_screen.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});
  final UpdateProfileController updateProfileController = Get.put(UpdateProfileController());

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<FavoriteModel> _watchlist = [];
  List<HistoryModel> _history = [];
  bool _isLoading = true;
  bool _isHistoryLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadWatchlist();
    _loadHistory();
  }

  _loadWatchlist() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final watchlist = await FavoriteService.getFavorites();
      setState(() {
        _watchlist = watchlist;
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      _showErrorSnackbar('Failed to load watchlist');
    }
  }

  _loadHistory() async {
    setState(() {
      _isHistoryLoading = true;
    });

    try {
      final history = await HistoryService.getHistory();
      setState(() {
        _history = history;
        _isHistoryLoading = false;
      });
    } catch (error) {
      setState(() {
        _isHistoryLoading = false;
      });
      _showErrorSnackbar('Failed to load history');
    }
  }

  _removeFromWatchlist(int movieId, String movieTitle) async {
    final confirmed = await _showDeleteConfirmation(movieTitle, isHistory: false);
    if (!confirmed) return;

    try {
      await FavoriteService.removeFromFavorites(movieId);
      setState(() {
        _watchlist.removeWhere((fav) => fav.movieId == movieId);
      });

      Get.snackbar(
        'Success',
        'Removed from watchlist',
        backgroundColor: ColorsManager.red,
        colorText: ColorsManager.white,
        duration: Duration(seconds: 2),
      );
    } catch (error) {
      _showErrorSnackbar('Failed to remove from watchlist');
    }
  }

  _removeFromHistory(int movieId, String movieTitle) async {
    final confirmed = await _showDeleteConfirmation(movieTitle, isHistory: true);
    if (!confirmed) return;

    try {
      await HistoryService.removeFromHistory(movieId);
      setState(() {
        _history.removeWhere((item) => item.movieId == movieId);
      });

      Get.snackbar(
        'Success',
        'Removed from history',
        backgroundColor: ColorsManager.red,
        colorText: ColorsManager.white,
        duration: Duration(seconds: 2),
      );
    } catch (error) {
      _showErrorSnackbar('Failed to remove from history');
    }
  }

  Future<bool> _showDeleteConfirmation(String movieTitle, {bool isHistory = false}) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: ColorsManager.darkBlack,
        title: Text(
          isHistory ? 'Remove from History' : 'Remove from Watchlist',
          style: TextStyle(color: ColorsManager.white),
        ),
        content: Text(
          'Are you sure you want to remove "$movieTitle"?',
          style: TextStyle(color: ColorsManager.ofwhite),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('Cancel', style: TextStyle(color: ColorsManager.grayish)),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Remove', style: TextStyle(color: ColorsManager.red)),
          ),
        ],
      ),
    ) ?? false;
  }

  void _showErrorSnackbar(String message) {
    Get.snackbar(
      'Error',
      message,
      backgroundColor: Colors.red,
      colorText: ColorsManager.white,
      duration: Duration(seconds: 3),
    );
  }

  // دالة منفصلة للـ Watchlist
  Widget _buildWatchlistGrid(List<FavoriteModel> movies) {
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

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MovieDetailsScreen(movieId: movie.movieId),
              ),
            ).then((_) => _loadWatchlist());
          },
          onLongPress: () => _removeFromWatchlist(movie.movieId, movie.title),
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        movie.posterPath.isNotEmpty
                            ? movie.posterPath
                            : 'https://via.placeholder.com/200x300/333/fff?text=No+Image',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: ColorsManager.gray,
                            child: Icon(
                              Icons.movie,
                              color: ColorsManager.white,
                              size: 40,
                            ),
                          );
                        },
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            color: ColorsManager.gray,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: ColorsManager.yellow,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Positioned(
                      top: 5,
                      right: 5,
                      child: Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: ColorsManager.darkBlack.withOpacity(0.7),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.bookmark,
                          color: ColorsManager.yellow,
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              Text(
                movie.title,
                style: const TextStyle(
                  color: ColorsManager.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.star, color: Colors.amber, size: 12),
                  const SizedBox(width: 2),
                  Text(
                    movie.voteAverage.toStringAsFixed(1),
                    style: TextStyle(
                      color: ColorsManager.ofwhite,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  // دالة منفصلة للـ History
  Widget _buildHistoryGrid(List<HistoryModel> movies) {
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

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MovieDetailsScreen(movieId: movie.movieId),
              ),
            ).then((_) => _loadHistory());
          },
          onLongPress: () => _removeFromHistory(movie.movieId, movie.title),
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        movie.posterPath.isNotEmpty
                            ? movie.posterPath
                            : 'https://via.placeholder.com/200x300/333/fff?text=No+Image',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: ColorsManager.gray,
                            child: Icon(
                              Icons.movie,
                              color: ColorsManager.white,
                              size: 40,
                            ),
                          );
                        },
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            color: ColorsManager.gray,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: ColorsManager.yellow,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Positioned(
                      top: 5,
                      right: 5,
                      child: Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: ColorsManager.darkBlack.withOpacity(0.7),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.history,
                          color: ColorsManager.green,
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              Text(
                movie.title,
                style: const TextStyle(
                  color: ColorsManager.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.star, color: Colors.amber, size: 12),
                  const SizedBox(width: 2),
                  Text(
                    movie.voteAverage.toStringAsFixed(1),
                    style: TextStyle(
                      color: ColorsManager.ofwhite,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
              Text(
                'Watched: ${_formatDate(movie.watchedAt)}',
                style: TextStyle(
                  color: ColorsManager.grayish,
                  fontSize: 8,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  Widget _buildEmptyState(bool isWatchlist) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isWatchlist
              ? Image(image: AssetImage(ImagesManager.popcorn))
              : Icon(Icons.history, size: 80, color: ColorsManager.yellow),
          const SizedBox(height: 16),
          Text(
            isWatchlist ? "No movies in watchlist" : "No history yet",
            style: TextStyle(
              color: ColorsManager.ofwhite,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            isWatchlist
                ? "Add movies to your watchlist to see them here"
                : "Your watched movies will appear here",
            style: TextStyle(
              color: ColorsManager.grayish,
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: ColorsManager.yellow),
          const SizedBox(height: 16),
          Text(
            "Loading...",
            style: TextStyle(
              color: ColorsManager.white,
              fontSize: 14,
            ),
          ),
        ],
      ),
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
            Obx(() => Row(
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
                    const SizedBox(height: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.updateProfileController.nameController.text.isEmpty
                              ? "User Name"
                              : widget.updateProfileController.nameController.text,
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: ColorsManager.white
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(width: 40),
                Column(
                  children: [
                    Text(
                      _watchlist.length.toString(),
                      style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: ColorsManager.white
                      ),
                    ),
                    Text(
                      "Watch List",
                      style: const TextStyle(
                          color: ColorsManager.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 20),
                Column(
                  children: [
                    Text(
                      _history.length.toString(),
                      style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: ColorsManager.white
                      ),
                    ),
                    Text(
                      "History",
                      style: const TextStyle(
                          color: ColorsManager.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 16),
              ],
            )),
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
                            borderRadius: BorderRadius.circular(12)
                        ),
                      ),
                      child: const Text(
                        "Edit Profile",
                        style: TextStyle(
                            color: ColorsManager.darkBlack,
                            fontSize: 20
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // دالة الخروج من التطبيق
                      },
                      label: const Text(
                        "Exit",
                        style: TextStyle(
                            color: ColorsManager.white,
                            fontSize: 20
                        ),
                      ),
                      icon: const Icon(
                        LucideIcons.logOut,
                        color: ColorsManager.white,
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorsManager.red,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)
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
                Tab(icon: Icon(Icons.bookmark), text: "Watch List"),
                Tab(icon: Icon(Icons.history), text: "History"),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // Tab 1: Watch List
                  _isLoading
                      ? _buildLoadingState()
                      : _watchlist.isEmpty
                      ? _buildEmptyState(true)
                      : Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: _buildWatchlistGrid(_watchlist),
                  ),

                  // Tab 2: History
                  _isHistoryLoading
                      ? _buildLoadingState()
                      : _history.isEmpty
                      ? _buildEmptyState(false)
                      : Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: _buildHistoryGrid(_history),
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