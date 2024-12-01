import 'package:flutter/material.dart';
import 'package:news_app_2/Providers/get_all_news_api_provider.dart';
import 'package:provider/provider.dart';

class MySliverAppBar extends StatelessWidget {
  const MySliverAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      snap: false,
      flexibleSpace: AppBar(
        title: const Text("N E W S"),
        centerTitle: true,
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Padding(
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
      ),
    );
  }
}
