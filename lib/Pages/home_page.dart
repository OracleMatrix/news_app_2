import 'package:flutter/material.dart';
import 'package:news_app_2/Models/all_news_model.dart';
import 'package:news_app_2/Pages/news_detail_page.dart';
import 'package:news_app_2/Providers/get_all_news_api_provider.dart';
import 'package:news_app_2/Providers/internet_status_provider.dart';
import 'package:news_app_2/Widgets/HomePageWidgets/app_bar.dart';
import 'package:news_app_2/Widgets/HomePageWidgets/data_available.dart';
import 'package:news_app_2/Widgets/HomePageWidgets/diff_cats.dart';
import 'package:news_app_2/Widgets/HomePageWidgets/no_result.dart';
import 'package:news_app_2/Widgets/HomePageWidgets/post_card.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final refreshController = RefreshController();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        Provider.of<GetAllNewsApiProvider>(context, listen: false)
            .fetchAllNews();
      },
    );

    final scrollController = ScrollController();

    scrollController.addListener(() {
      final apiProvider =
          Provider.of<GetAllNewsApiProvider>(context, listen: false);
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          apiProvider.hasMorePages) {
        apiProvider.fetchMoreNews(
          query: apiProvider.controller.text.isEmpty
              ? 'global'
              : apiProvider.controller.text,
        );
      }
    });

    return Scaffold(
      body: Consumer<GetAllNewsApiProvider>(
        builder: (context, provider, child) {
          if (provider.onError) {
            return const NoDataAvailableWidget();
          }
          if (provider.articles.isEmpty && provider.controller.text.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (provider.model!.totalResults == 0) {
            return const NoResultScreenWithAppBar();
          } else if (!Provider.of<InternetStatusProvider>(context)
              .isConnected) {
            return const Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.network_wifi_1_bar_rounded,
                      size: 90,
                      color: Colors.orange,
                    ),
                  ),
                  Text('No internet connection...!'),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(),
                  ),
                ],
              ),
            );
          }

          return Consumer<GetAllNewsApiProvider>(
            builder: (context, provider, child) => SmartRefresher(
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
                        padding: const EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 12),
                        child: Text("Total Results: $total"),
                      ),
                      selector: (_, provider) =>
                          provider.model!.totalResults.toString(),
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
                                  child: Center(
                                      child: CircularProgressIndicator()),
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
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            );
                          }

                          if (api.articles[index].title!.toLowerCase() ==
                              '[removed]') {
                            return const SizedBox.shrink();
                          }
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(12),
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    final Article data = api.articles[index];
                                    return NewsDetailPage(
                                      title: data.title.toString(),
                                      content: data.content.toString(),
                                      imageUrl: data.urlToImage.toString(),
                                      url: data.url.toString(),
                                      dateTime: data.publishedAt!,
                                      source: data.source!.name.toString(),
                                    );
                                  },
                                ));
                              },
                              child: PostCardWidget(index: index, api: api),
                            ),
                          );
                        },
                      ));
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
