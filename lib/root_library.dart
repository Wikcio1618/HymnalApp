import 'package:flutter/material.dart';
import 'package:hymnal_app/model/hymn.dart';

class Library extends StatefulWidget {
  const Library({super.key});

  @override
  State<Library> createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  List<Hymn> hymns = const [
    Hymn(title: 'Cudowna boża łaska', text: 'twa, zbawiła z grzechów mnie..'),
    Hymn(title: 'Gdy na ten świat', text: 'spoglądam wielki Boże'),
    Hymn(title: 'Błogo mi', text: 'W Panu wieczny mam dział')
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(children: _libraryListTiles(hymns));
  }

  List<Widget> _libraryListTiles(List<Hymn> hymns) {
    List<Widget> viewTiles = [];
    for (var hymn in hymns) {
      viewTiles.add(ListTile(
        title: Text(hymn.title),
        subtitle: Text(hymn.text),
      ));
    }
    return viewTiles;
  }
}
