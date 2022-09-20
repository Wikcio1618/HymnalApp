import 'package:flutter/material.dart';
import 'package:hymnal_app/model/enums.dart';
import 'package:hymnal_app/model/hymn.dart';
import 'package:hymnal_app/search_tile_builder.dart';

class DiscoverSongbookPage extends StatelessWidget {
  DiscoverSongbookPage(this.option, {super.key});

  final int option;
  late final List<Hymn> hymnsOfSongbook =
      Hymn.getHymnsOfSongbook(Songbooks.values[option], option);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(Songbooks.values[option].name)),
      body: ListView.builder(
          itemCount: hymnsOfSongbook.length, itemBuilder: tileBuilder),
    );
  }

  Widget tileBuilder(BuildContext context, int index) =>
      TileBuilder.customLibraryTile(hymnsOfSongbook[index]);
}
