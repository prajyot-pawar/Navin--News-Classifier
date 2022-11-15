import 'package:flutter/material.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:news_app/db/news_database.dart';
import 'package:news_app/widgets/news_card_widget.dart';
import 'package:news_app/models/news.dart';

// import 'package:news_app/db/news_database.dart';
import 'package:news_app/screens/news_detail_page.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  _FeedPageState createState() => _FeedPageState();
}

  class _FeedPageState extends State<FeedPage>{
    late List<News> newss;
  bool isLoading = false;
  @override
  void initState() {
  super.initState();

  refreshNews();
  }
  @override
  void dispose() {
  Newsdatabase.instance.close();

  super.dispose();
  }

  Future refreshNews() async {
  setState(() => isLoading = true);

  newss = await Newsdatabase.instance.readAllNews();

  setState(() => isLoading = false);
  }

  Widget _buildTab(IconData iconData, String title) {
  return Tab(icon: Icon(iconData), text: title);
  }

  @override
  Widget build(BuildContext context) {
  return DefaultTabController(
  length: 4,
  child: Scaffold(
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
  ),


  body:SingleChildScrollView(
  child: Column(
  children: [
  Container(
  child: ListView.builder(
  physics: NeverScrollableScrollPhysics(),
  shrinkWrap: true,
  itemCount: newss.length,
  itemBuilder: (context,index){
  final news = newss[index];

  return GestureDetector(
  onTap: () async {
  await Navigator.of(context).push(MaterialPageRoute(
  builder: (context) => NewsDetailPage(newsId: news.id!),
  ));

  refreshNews();
  },
  child: NewsCardWidget(news: news, index: index),
  );
  }

  ),

  )
  ],
  ),
  ),
  ),
  );

  }
  }

// ADD IF YOU HAVE NO NEWS
  // body: Center(
  // child: isLoading
  // ? CircularProgressIndicator()
  //     : news.isEmpty
  // ? Text(
  // 'No News',
  // style: TextStyle(color: Colors.white, fontSize: 24),
  // )
  //     : buildNewss(),
  // ),