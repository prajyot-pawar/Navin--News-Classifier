import 'package:flutter/material.dart';
import 'package:news_app/models/news.dart';
import 'package:news_app/widgets/news_card_widget.dart';
import 'package:news_app/db/news_database.dart';
import 'package:news_app/models/news.dart';
import 'package:news_app/widgets/news_form_widget.dart';

class AddEditNewsPage extends StatefulWidget {
  final News? news;

  const AddEditNewsPage({
    Key? key,
    this.news,
  }) : super(key: key);
  @override
  _AddEditNewsPageState createState() => _AddEditNewsPageState();
}

class _AddEditNewsPageState extends State<AddEditNewsPage> {
  final _formKey = GlobalKey<FormState>();
  late bool isImportant;
  late int number;
  late String title;
  late String description;

  @override
  void initState() {
    super.initState();

    isImportant = widget.news?.isImportant ?? false;
    number = widget.news?.number ?? 0;
    title = widget.news?.title ?? '';
    description = widget.news?.description ?? '';
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      actions: [buildButton()],
    ),
    body: Form(
      key: _formKey,
      child: NewsFormWidget(
        isImportant: isImportant,
        number: number,
        title: title,
        description: description,
        onChangedImportant: (isImportant) =>
            setState(() => this.isImportant = isImportant),
        onChangedNumber: (number) => setState(() => this.number = number),
        onChangedTitle: (title) => setState(() => this.title = title),
        onChangedDescription: (description) =>
            setState(() => this.description = description),
      ),
    ),
  );

  Widget buildButton() {
    final isFormValid = title.isNotEmpty && description.isNotEmpty;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.white,
          primary: isFormValid ? null : Colors.grey.shade700,
        ),
        onPressed: addOrUpdateNews,
        child: Text('Save'),
      ),
    );
  }

  void addOrUpdateNews() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.news != null;

      if (isUpdating) {
        await updateNews();
      } else {
        await addNews();
      }

      Navigator.of(context).pop();
    }
  }

  Future updateNews() async {
    final news = widget.news!.copy(
      isImportant: isImportant,
      number: number,
      title: title,
      description: description,
    );

    await Newsdatabase.instance.update(news);
  }

  Future addNews() async {
    final news = News(
      title: title,
      isImportant: true,
      number: number,
      description: description,
      createdTime: DateTime.now(),
    );

    await Newsdatabase.instance.create(news);
  }
}
