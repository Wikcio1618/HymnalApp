import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hymnal_app/services/tile_builder.dart';

import 'main.dart';
import 'model/collection.dart';

class InspectCollection extends StatefulWidget {
  const InspectCollection({super.key, required this.nameKey});
  final String nameKey;

  @override
  State<InspectCollection> createState() => _InspectCollectionState();
}

class _InspectCollectionState extends State<InspectCollection> {
  late Box<Collection> box;

  @override
  void initState() {
    super.initState();
    box = Hive.box<Collection>(collectionsBox);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverAppBar(
          title: Text(box.get(widget.nameKey)!.name),
        ),
        SliverList(
            delegate: SliverChildListDelegate([
          SizedBox(
            width: double.infinity,
            child: Column(
              children: _buildHymnsColumn()!,
            ),
          )
        ]))
      ]),
    );
  }

  List<Widget>? _buildHymnsColumn() {
    final hymns = box.get(widget.nameKey)?.hymns;

    return hymns?.map((hymn) => TileBuilder.customLibraryTile(hymn)).toList();
  }
}
