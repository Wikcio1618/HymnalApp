import 'package:flutter/material.dart';
import 'package:hymnal_app/model/enums.dart';
import 'package:hymnal_app/search/songbook_discover.dart';
import 'package:google_fonts/google_fonts.dart';

import '../model/hymn.dart';

class SongbookMenu extends StatefulWidget {
  const SongbookMenu({super.key});

  @override
  State<SongbookMenu> createState() => _SongbookMenuState();
}

class _SongbookMenuState extends State<SongbookMenu> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: 5,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
            ),
            itemCount: Songbooks.values.length,
            itemBuilder: buttonBuilder),
      ),
    );
  }

  Widget buttonBuilder(BuildContext context, int index) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.8),
            blurRadius: 8,
            offset: const Offset(5, -5),
            spreadRadius: 5,
          )
        ],
      ),
      child: OutlinedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
                Theme.of(context).colorScheme.secondary),
            foregroundColor: MaterialStateProperty.all(
                Theme.of(context).colorScheme.onSecondary),
            // side: MaterialStateProperty.all(
            //     const BorderSide(color: Colors.grey, width: 2)),
            shadowColor: MaterialStateProperty.all(Colors.black),
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
            style: GoogleFonts.kalam(textStyle: const TextStyle(fontSize: 36)),
            Hymn.getSongbooksSortedAlphabetically()[index].name),
      ),
    );
  }
}
