import 'package:dio/dio.dart';
import 'package:news_app_2/Constants/constants.dart';
import 'package:news_app_2/Models/all_news_model.dart';
import 'package:news_app_2/Models/on_error_model.dart';

class ApiService {
  final Dio _dio = Dio(
    BaseOptions(
      validateStatus: (status) {
        return status != null && status < 500;
      },
    ),
  );

  Future<AllNewsModel?> getAllNews({String? query, int page = 1}) async {
    final String everythingUrl =
        "https://gnews.io/api/v4/search?q=$query&sortBy=publishedAt&page=$page&apikey=$api";

    try {
      final response = await _dio.get(everythingUrl);

      if (response.statusCode == 200) {
        return AllNewsModel.fromJson(response.data);
      } else if (response.statusCode == 403) {
        final errorResponse = ErrorResponse.fromJson(response.data);
        throw errorResponse.errors.join("\n").split('here: https://gnews.io/#pricing').first;
      } else {
        throw Exception("Unexpected error occurred");
      }
    } catch (e) {
      rethrow;
    }
  }
}
