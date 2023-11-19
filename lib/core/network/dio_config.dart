import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@injectable
class NetworkConfig {
  static const baseImageUrl = 'https://image.tmdb.org/t/p/original';
  static const baseUrl = 'https://api.themoviedb.org/3/';
  static const token =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI0YTZiNTdjNDczZWMwODIxN2U4NTU2ZGZhOWQwNWY5NCIsInN1YiI6IjY1MWJiYTIwMjIzYThiMDBhYjNkMWEwNSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.KzwyO2BmjIGyeHJCOu5XOAld_LiRAS92VTGTRQVCrA8';

  static final _baseOptions = BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );

  static Dio getDio() {
    final dio = Dio(_baseOptions);
    dio.interceptors.add(
      LogInterceptor(
        request: true,
        responseBody: true,
        requestBody: true,
        requestHeader: true,
        responseHeader: true,
      ),
    );
    return dio;
  }
}
