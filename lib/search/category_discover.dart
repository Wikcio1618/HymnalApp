import 'package:flutter/material.dart';
import 'package:hymnal_app/model/hymn.dart';
import 'package:hymnal_app/services/tile_builder.dart';

class DiscoverCategoryPage extends StatelessWidget {
  DiscoverCategoryPage(this.option, {super.key});

  final int option;
  late final List<Hymn> hymnsOfCategory = Hymn.getHymnsOfCategory(option);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: hymnsOfCategory.length,
        itemBuilder: tileBuilder);
  }

  Widget tileBuilder(BuildContext context, int index) =>
      TileBuilder.customHymnTile(hymnsOfCategory[index]);
}
