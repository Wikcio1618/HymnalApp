import 'package:flutter/material.dart';
import 'package:hymnal_app/main.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hymnal_app/services/tile_builder.dart';
import 'model/collection.dart';

class Collections extends StatefulWidget {
  const Collections({super.key});

  @override
  State<Collections> createState() => _CollectionsState();
}

class _CollectionsState extends State<Collections> {
  late Box<Collection> box;
  TextEditingController textController = TextEditingController();
  var increment = 0;

  @override
  void initState() {
    super.initState();
    box = Hive.box<Collection>(collectionsBox);
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: box.listenable(),
      builder: (context, box, child) => ListView.builder(
        itemCount: box.keys.length + 1, // +1 because addtile has to be included
        itemBuilder: (context, index) {
          if (index == 0) {
            return ListTile(
              title: IconButton(
                  onPressed: () => _buildCollectionNameDialog(box),
                  icon: const Icon(Icons.add_circle_outline_outlined)),
            );
          }
          return TileBuilder.collectionTile(box.getAt(index - 1)!);
        },
      ),
    );
  }

  _buildCollectionNameDialog(Box<Collection> box) => showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: const Text('Nazwa twojego śpiewnika'),
          content: TextField(
            autocorrect: false,
            enableSuggestions: false,
            autofocus: true,
            controller: textController,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
              border: OutlineInputBorder(borderSide: BorderSide()),
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  textController.clear();
                },
                child: const Text('Anuluj')),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  // box.deleteAt(0);
                  box.put(
                    textController.text, // KEY of hive elemnts is their name
                    // TODO - add same-name notification (nothing is added then by framework)
                    Collection(name: textController.text),
                  );
                  textController.clear();
                },
                child: const Text('Dodaj'))
          ],
        ),
      );
}
