import 'package:flutter/material.dart';
import 'package:news_app_2/Providers/get_all_news_api_provider.dart';
import 'package:provider/provider.dart';

class NoResultScreenWithAppBar extends StatelessWidget {
  const NoResultScreenWithAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 140,
        title: Column(
          children: [
            const Text("N E W S"),
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
                      await provider.fetchAllNews(query: 'economy');
                    } else {
                      await provider.fetchAllNews(
                        query: provider.controller.text,
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      body: const Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error,
              size: 80,
              color: Colors.red,
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "No Data Available!",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
