import 'package:moviesapproute/data/model/movie_list/Movies.dart' as movie_list;
import 'package:moviesapproute/data/model/HomepageApi/Movies.dart' as homepage_api;

homepage_api.Movies convertToHomepageApiMovie(movie_list.Movies movie) {
  return homepage_api.Movies(
    id: movie.id,
    title: movie.title,
    mediumCoverImage: movie.mediumCoverImage,
    rating: movie.rating, likeCount: null,
  );
}
