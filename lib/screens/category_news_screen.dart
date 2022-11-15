import 'package:flutter/material.dart';
import 'package:news_app/data.dart';

class NewsScreen extends StatelessWidget {
  static const routeName = '/news-screen';

  @override
  Widget build(BuildContext context) {
    final newsId = ModalRoute.of(context)?.settings.arguments as String;
    final selectedCategory = CATEGORIES.firstWhere((item) => item.id == newsId);



    return Scaffold(
      appBar: AppBar(
        title: Text(selectedCategory.title),
        centerTitle: true,
      ),
    );
  }
}
