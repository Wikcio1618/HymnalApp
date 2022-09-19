import 'package:flutter/material.dart';

class NoSearchYet extends StatelessWidget {
  const NoSearchYet({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Icon(
        Icons.manage_search_rounded,
        size: 80,
        color: Color.fromARGB(255, 231, 224, 224),
      ),
    );
  }
}
