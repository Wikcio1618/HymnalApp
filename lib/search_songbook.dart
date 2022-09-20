import 'package:flutter/material.dart';
import 'package:hymnal_app/model/enums.dart';
import 'package:hymnal_app/songbook_discover.dart';

class SongbookListView extends StatefulWidget {
  const SongbookListView({super.key});

  @override
  State<SongbookListView> createState() => _SongbookListViewState();
}

class _SongbookListViewState extends State<SongbookListView> {
  int? currSongbook;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30.0),
      child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1,
            mainAxisSpacing: 15,
            crossAxisSpacing: 15,
          ),
          itemCount: Songbooks.values.length,
          itemBuilder: buttonBuilder),
    );
  }

  Widget buttonBuilder(BuildContext context, int index) {
    return OutlinedButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.grey[200]),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              side: const BorderSide(width: 2, color: Colors.black),
              borderRadius: BorderRadius.circular(15),
            ),
          )),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return DiscoverSongbookPage(index);
            },
          ),
        );
      },
      child: Text(
          style: const TextStyle(fontSize: 26), Songbooks.values[index].name),
    );
  }
}
