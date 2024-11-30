import 'package:flutter/material.dart';
import 'package:news_app_2/Models/all_news_model.dart';
import 'package:news_app_2/Pages/news_detail_page_desktop_tablet.dart';
import 'package:news_app_2/Providers/get_all_news_api_provider.dart';
import 'package:news_app_2/Widgets/HomePageWidgets/DesktopAndTablet/post_card_tablet.dart';
import 'package:news_app_2/Widgets/HomePageWidgets/Mobile/app_bar.dart';
import 'package:news_app_2/Widgets/HomePageWidgets/Mobile/data_available.dart';
import 'package:news_app_2/Widgets/HomePageWidgets/Mobile/diff_cats.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

SmartRefresher buildTabletUI(RefreshController refreshController,
    GetAllNewsApiProvider provider, ScrollController scrollController) {
  return SmartRefresher(
    controller: refreshController,
    onRefresh: () async {
      await provider.refresh();
      refreshController.refreshCompleted();
    },
    child: CustomScrollView(
      controller: scrollController,
      slivers: [
        const MySliverAppBar(),
        const SliverToBoxAdapter(
          child: ShowDifferentCategories(),
        ),
        SliverToBoxAdapter(
          child: Selector<GetAllNewsApiProvider, String?>(
            builder: (context, total, child) => Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12),
              child: Text("Total Results: $total"),
            ),
            selector: (_, provider) => provider.model!.totalResults.toString(),
          ),
        ),
        Consumer<GetAllNewsApiProvider>(
          builder: (context, api, child) {
            if (api.isLoading && api.articles.isEmpty) {
              return const SliverToBoxAdapter(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 150.0),
                    child: CircularProgressIndicator(),
                  ),
                ),
              );
            }
            if (api.model?.articles == null ||
                api.articles.isEmpty ||
                api.model!.totalResults == 0 ||
                api.onError) {
              return const SliverToBoxAdapter(
                child: NoDataAvailableWidget(),
              );
            }

            return SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: api.articles.length,
                (context, index) {
                  if (index == api.articles.length) {
                    if (api.isFetchingMore) {
                      return const SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(child: CircularProgressIndicator()),
                        ),
                      );
                    }

                    if (api.hasMorePages) {
                      return const SizedBox.shrink();
                    }

                    return const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            "No more articles",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    );
                  }

                  if (api.articles[index].title!.toLowerCase() == '[removed]') {
                    return const SizedBox.shrink();
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            final Article data = api.articles[index];
                            return NewsDetailPageDesktopAndTablet(
                              author: data.author.toString(),
                              title: data.title.toString(),
                              description: data.description.toString(),
                              imageUrl: data.urlToImage.toString(),
                              url: data.url.toString(),
                              dateTime: data.publishedAt!,
                              source: data.source!.name.toString(),
                            );
                          },
                        ));
                      },
                      child: PostCardWidgetTablet(index: index, api: api),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ],
    ),
  );
}
