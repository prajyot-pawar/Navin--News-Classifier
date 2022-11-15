import 'package:flutter/material.dart';
import './screens/home_screen.dart';
import './screens/category_news_screen.dart';
import './screens/search_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News Application',
      theme: ThemeData(
        backgroundColor: Colors.black,
        fontFamily: 'Lato', colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey).copyWith(secondary: Colors.amber[700]),
      ),
      // home: const HomeScreen(),
      routes: {
        '/': (ctx) => const HomeScreen(),
        NewsScreen.routeName: (ctx) => NewsScreen(),
        SearchScreen.routeName: (ctx) => SearchScreen()
      },
    );
  }

}
