import 'package:flutter/material.dart';
import 'package:news_app/screens/feed_page.dart';
import 'package:news_app/screens/feed_screen.dart';
import 'package:news_app/screens/search_screen.dart';
import 'package:news_app/widgets/main_drawer.dart';

import '../screens/categories_screen.dart';
// import '../screens/feed_screen.dart';
// import 'package:news_app/screens/feed_page.dart';
import './favorites_screen.dart';
import './account_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Map<String, Object>> _pages;
  late PageController pageController;
  int _page = 0;

  @override
  void initState() {
    _pages = [
      {
        'page': FeedPage(),
        'title': 'News Feed',
      },
      {
        'page': CategoriesScreen(),
        'title': 'Categories',
      },
      {
        'page': FavoritesScreen(),
        'title': 'Your Favorites',
      },
      {
        'page': AccountScreen(),
        'title': 'Settings',
      },
    ];
    super.initState();
    pageController = PageController();
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  BottomNavigationBarItem _builtNavigationItem(
      IconData iconData, String title, int index) {
    return BottomNavigationBarItem(
        icon: Icon(
          iconData,
          color: (_page == index) ? Theme.of(context).colorScheme.secondary : Colors.grey,
        ),
        label: title,
        backgroundColor: Colors.black);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _pages[_page]['title'].toString(),
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black54,
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(
                SearchScreen.routeName,
              );
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: PageView(
        children: <Widget>[
          FeedScreen(),
          CategoriesScreen(),
          FavoritesScreen(),
          AccountScreen(),
        ],
        controller: pageController,
        onPageChanged: onPageChanged,
      ),
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              _builtNavigationItem(Icons.newspaper, 'Feed', 0),
              _builtNavigationItem(Icons.category, 'Section', 1),
              _builtNavigationItem(Icons.bookmark, 'Bookmark', 2),
              _builtNavigationItem(Icons.account_circle, 'Account', 3),
            ],
            selectedItemColor: Theme.of(context).colorScheme.secondary,
            unselectedItemColor: Colors.grey,
            onTap: navigationTapped,
            currentIndex: _page,
            type: BottomNavigationBarType.shifting,
          ),
        ),
      ),
    );
  }
}
