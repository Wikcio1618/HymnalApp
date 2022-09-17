import 'package:flutter/material.dart';

class Library extends StatefulWidget {
  const Library({super.key});



  @override
  State<Library> createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_literals_to_create_immutables
    return ListView.builder(itemBuilder: (context, item){
      if (item.isOdd) return const Divider();

      return const ListTile(
        title: Text('q')
      );
    });
  }
}
