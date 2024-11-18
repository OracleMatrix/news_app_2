import 'package:dio/dio.dart';
import 'package:news_app_2/Constants/constants.dart';
import 'package:news_app_2/Models/all_news_model.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<AllNewsModel?> getAllNews({String? query, int page = 1}) async {
    final String everythingUrl =
        "https://newsapi.org/v2/everything?q=$query&sortBy=publishedAt&language=en&page=$page&pageSize=20&apiKey=$api";

    try {
      final response = await _dio.get(everythingUrl);

      if (response.statusCode == 200) {
        return AllNewsModel.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      throw Exception("Error to getAllNews : $e");
    }
  }
}
