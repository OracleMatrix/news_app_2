import 'package:flutter/material.dart';
import 'package:news_app_2/API/api_service.dart';
import 'package:news_app_2/Models/all_news_model.dart';
import 'package:news_app_2/Models/on_error_model.dart';

class GetAllNewsApiProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  AllNewsModel? model;
  ErrorResponse? error;
  bool isLoading = false;
  bool isFetchingMore = false;
  bool onError = false;
  bool hasMorePages = true;
  int currentPage = 1;
  List<Article> articles = [];
  Set<String> uniqueArticleTitles = {};
  final TextEditingController controller = TextEditingController();

  Future<void> fetchAllNews({String? query = 'global'}) async {
    isLoading = true;
    hasMorePages = true;

    try {
      model = await _apiService.getAllNews(query: query, page: currentPage);

      if (model?.articles != null) {
        onError = false;
        articles.addAll(model!.articles!);
        if (articles.length >= (model!.totalArticles ?? 0)) {
          hasMorePages = false;
        }
      }
    } catch (e) {
      debugPrint(e.toString());
      onError = true;
      error = ErrorResponse.fromJson({
        "errors": [e.toString()]
      });
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchMoreNews({String? query = 'economy'}) async {
    if (isFetchingMore || !hasMorePages) return;

    isFetchingMore = true;
    currentPage += 1;

    final newModel =
        await _apiService.getAllNews(query: query, page: currentPage);

    if (newModel?.articles != null) {
      articles.addAll(newModel!.articles!);
      if (articles.length >= (newModel.totalArticles ?? 0)) {
        hasMorePages = false;
      }
    }

    isFetchingMore = false;
    notifyListeners();
  }

  void reset() {
    articles.clear();
    currentPage = 1;
    hasMorePages = true;
    notifyListeners();
  }

  bool isRTL(String? text) {
    if (text == null || text.isEmpty) {
      return false;
    }
    return RegExp(r'[\u0600-\u06FF]').hasMatch(text);
  }

  Future<void> refresh() async {
    try {
      isLoading = true;

      reset();

      await fetchAllNews(
        query: controller.text.isEmpty ? 'economy' : controller.text,
      );

      isLoading = false;
      notifyListeners();
    } catch (error) {
      isLoading = false;
      notifyListeners();
      throw Exception("Error during refresh: $error");
    }
  }
}
