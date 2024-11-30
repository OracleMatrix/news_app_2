import 'package:flutter/material.dart';
import 'package:news_app_2/Providers/get_all_news_api_provider.dart';
import 'package:news_app_2/Widgets/HomePageWidgets/Mobile/diff_cats.dart';
import 'package:provider/provider.dart';

class NoDataAvailableWidget extends StatelessWidget {
  const NoDataAvailableWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 110,
        title: const Text("N E W S"),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Consumer<GetAllNewsApiProvider>(
                  builder: (context, provider, child) => SearchBar(
                    hintText: "search...",
                    controller: provider.controller,
                    onTap: () => provider.controller.clear(),
                    onSubmitted: (value) async {
                      provider.reset();
                      if (provider.controller.text.isEmpty) {
                        await provider.fetchAllNews(query: 'global');
                      } else {
                        await provider.fetchAllNews(
                          query: provider.controller.text,
                        );
                      }
                    },
                  ),
                ),
              ),
              const ShowDifferentCategories(),
            ],
          ),
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error,
              size: 80,
              color: Colors.red,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Consumer<GetAllNewsApiProvider>(
                builder: (context, value, child) => Text(
                  "No Data Available\n${value.error?.message ?? "An unexpected error occurred.\nPlease try again later."}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
