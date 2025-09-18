class ApiEndpoints {
  static const String baseUrl = "https://route-movie-apis.vercel.app/";
  static _Auth auth = _Auth();
}
class _Auth {
  final String login = "auth/login";
  final String register = "auth/register";
  final String UpdateProfile = "profile";
}
