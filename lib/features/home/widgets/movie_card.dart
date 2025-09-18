import 'package:flutter/material.dart';
import 'package:moviesapproute/features/home/widgets/movie_details_screen.dart';

import '../../../data/model/movie_list/Movies.dart';

class MovieCard extends StatelessWidget {
  final Movies movie;
  final double width;
  final double height;

  const MovieCard({
    super.key,
    required this.movie,
    this.width = 180,
    this.height = 270,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => MovieDetailsScreen(movieId: movie.id!), // هنا بعتنا movieId بس
          ),
        );
      },
      child: Stack(
        children: [
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              image: DecorationImage(
                image: NetworkImage(movie.mediumCoverImage ?? ""),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 10,
            left: 15,
            child: Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.black54,
              ),
              child: Row(
                children: [
                  Text(
                    (movie.rating ?? 0).toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 5),
                  const Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: 16,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

