import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/screens/feed_page.dart';
import 'package:news_app/screens/AddEditNewsPage.dart';
import 'package:news_app/db/news_database.dart';
import 'package:news_app/models/news.dart';

// import 'package:sqflite_database_example/db/newss_database.dart';
// import 'package:sqflite_database_example/model/news.dart';
// import 'package:sqflite_database_example/page/edit_news_page.dart';

class NewsDetailPage extends StatefulWidget {
  final int newsId;

  const NewsDetailPage({
    Key? key,
    required this.newsId,
  }) : super(key: key);

  @override
  _NewsDetailPageState createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  late News news;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshNews();
  }

  Future refreshNews() async {
    setState(() => isLoading = true);

    news = await Newsdatabase.instance.readNews(widget.newsId);

    setState(() => isLoading = false);
  }

  Widget _buildTab(IconData iconData, String title) {
    return Tab(icon: Icon(iconData), text: title);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      flexibleSpace: Container(
        color: Colors.white,
        child: SafeArea(
          child: TabBar(
            tabs: <Widget>[
              _buildTab(Icons.video_collection, 'Shorts'),
              _buildTab(Icons.fiber_new, 'Latest'),
              _buildTab(Icons.trending_up, 'Trending'),
              _buildTab(Icons.live_tv, 'LiveTv'),
            ],
          ),
        ),
      ),
      // actions: [editButton(), deleteButton()],
    ),
    body: isLoading
        ? Center(child: CircularProgressIndicator())
        : Padding(
      padding: EdgeInsets.all(12),
      child: ListView(
        padding: EdgeInsets.symmetric(vertical: 8),
        children: [
          Text(
            news.title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            DateFormat.yMMMd().format(news.createdTime),
            style: TextStyle(color: Colors.white38),
          ),
          SizedBox(height: 8),
          Text(
            news.description,
            style: TextStyle(color: Colors.white70, fontSize: 18),
          )
        ],
      ),
    ),
  );

  Widget editButton() => IconButton(
      icon: Icon(Icons.edit_outlined),
      onPressed: () async {
        if (isLoading) return;

        await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AddEditNewsPage(news: news),
        ));

        refreshNews();
      });
  //
  // Widget deleteButton() => IconButton(
  //   icon: Icon(Icons.delete),
  //   onPressed: () async {
  //     await Newsdatabase.instance.delete(widget.newsId);
  //
  //     Navigator.of(context).pop();
  //   },
  // );
}
