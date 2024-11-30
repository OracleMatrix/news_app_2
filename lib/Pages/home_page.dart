import 'package:flutter/material.dart';
import 'package:news_app_2/Providers/get_all_news_api_provider.dart';
import 'package:news_app_2/Providers/internet_status_provider.dart';
import 'package:news_app_2/Responsive/DesktopAndTablet/desktop_ui.dart';
import 'package:news_app_2/Responsive/DesktopAndTablet/tablet_ui.dart';
import 'package:news_app_2/Responsive/Mobile/mobile_ui.dart';
import 'package:news_app_2/Widgets/HomePageWidgets/Mobile/data_available.dart';
import 'package:news_app_2/Widgets/HomePageWidgets/Mobile/no_result.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:responsive_builder/responsive_builder.dart';

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

          return ResponsiveBuilder(
            builder: (context, sizingInformation) {
              if (sizingInformation.deviceScreenType ==
                  DeviceScreenType.mobile) {
                return Consumer<GetAllNewsApiProvider>(
                  builder: (context, provider, child) => buildMobileUI(
                      refreshController, provider, scrollController),
                );
              } else if (sizingInformation.deviceScreenType ==
                  DeviceScreenType.desktop) {
                return Consumer<GetAllNewsApiProvider>(
                  builder: (context, provider, child) =>
                      buildDesktopUI(scrollController),
                );
              } else if (sizingInformation.deviceScreenType ==
                  DeviceScreenType.tablet) {
                return Consumer<GetAllNewsApiProvider>(
                  builder: (context, provider, child) => buildTabletUI(
                      refreshController, provider, scrollController),
                );
              }
              return const Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error, size: 100, color: Colors.yellowAccent),
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                          'Sorry we cannot support this screen size :(\nTry mobile or web ;)'),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
