import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app_2/Pages/home_page.dart';
import 'package:news_app_2/Providers/get_all_news_api_provider.dart';
import 'package:news_app_2/Providers/internet_status_provider.dart';
import 'package:news_app_2/Providers/open_file_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => GetAllNewsApiProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => OpenFileProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => InternetStatusProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      initial: AdaptiveThemeMode.system,
      light: ThemeData(
        fontFamily: GoogleFonts.poppins().fontFamily,
        brightness: Brightness.light,
        useMaterial3: true,
      ),
      dark: ThemeData(
        fontFamily: GoogleFonts.poppins().fontFamily,
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      builder: (light, dark) {
        return MaterialApp(
          darkTheme: dark,
          theme: light,
          title: 'NEWS',
          debugShowCheckedModeBanner: false,
          home: const HomePage(),
        );
      },
    );
  }
}
