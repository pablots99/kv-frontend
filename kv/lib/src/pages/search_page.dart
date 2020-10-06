import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  SearchBar searchBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Search'),
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(35),
          child: AppBar(title: Text('Search'))),
    );
  }
}
