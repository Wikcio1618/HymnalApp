import 'package:flutter/material.dart';
import 'package:hymnal_app/main.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'model/collection.dart';

class Collections extends StatefulWidget {
  const Collections({super.key});

  @override
  State<Collections> createState() => _CollectionsState();
}

class _CollectionsState extends State<Collections> {
  late Box<Collection> box;
  var increment = 0;

  @override
  void initState() {
    super.initState();
    box = Hive.box<Collection>(collectionsBox);
  }

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Column(children: [
      FloatingActionButton(onPressed: (() {
        box.put('key$increment', Collection(name: 'name$increment'));
        increment++;
      })),
      ValueListenableBuilder(
        valueListenable: box.listenable(),
        builder: (context, box, child) => Flexible(
          child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: box.toMap().keys.length,
              itemBuilder: ((context, index) => Text(box.getAt(index)!.name))),
        ),
      ),
      FloatingActionButton(onPressed: () {
        box.deleteAt(0);
      })
    ]);

    /* TweenAnimationBuilder(
      tween: Tween<Offset>(begin: Offset(startPos, 0), end: Offset(endPos, 0)),
      duration: Duration(seconds: 1),
      builder: (context, offset, child) {
        return FractionalTranslation(
          translation: offset,
          child: Container(
            width: double.infinity,
            child: Center(
              child: child,
            ),
          ),
        );
      },
      child: Text(
        'animated text',
        textScaleFactor: 3.0,
      ),
      onEnd: () {
        print('onEnd');
        Future.delayed(
          Duration(milliseconds: 500),
          () {
            if (startPos == -1) {
              setState(() {
                startPos = 0.0;
                endPos = 1.0;
              });
            }
          },
        );
      },
    ); */
  }
}
