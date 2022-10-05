import 'package:flutter/material.dart';

class Collections extends StatefulWidget {
  const Collections({super.key});

  @override
  State<Collections> createState() => _CollectionsState();
}

class _CollectionsState extends State<Collections> {
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Center(child: Text('dummy'));

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
