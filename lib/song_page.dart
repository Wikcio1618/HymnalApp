import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_chord/flutter_chord.dart';
import 'package:hymnal_app/services/navigation_song_notifier.dart';
import 'package:provider/provider.dart';
import 'package:mdi/mdi.dart';
import '/model/hymn.dart';

double fontSizeVariable = 16;
var iconChords = Icons.circle_outlined;
bool showChordVariable = false;

class SongPage extends StatefulWidget {
  const SongPage({super.key, required this.multiple, this.hiveKey, this.hymn});
  final bool multiple;
  final Hymn? hymn;
  final String? hiveKey;
  @override
  State<SongPage> createState() => _SongPageState();
}

class _SongPageState extends State<SongPage> {
  IconButton makeFontBiggerButton() {
    return IconButton(
        onPressed: () => {
              fontSizeVariable += 1,
              setState(() {
                () => _SongPageState();
              })
            },
        iconSize: 17,
        color: Colors.green[800],
        icon: const Icon(Mdi.formatFontSizeIncrease));
  }

  IconButton makeFontSmallerButton() {
    return IconButton(
        onPressed: () => {
              fontSizeVariable -= 1,
              setState(() {
                () => _SongPageState();
              })
            },
        iconSize: 17,
        color: Colors.green[800],
        icon: const Icon(Mdi.formatFontSizeDecrease));
  }

  IconButton chordsVisibilityButton() {
    return IconButton(
      icon: Icon(iconChords),
      color: Colors.green[800],
      onPressed: () => {
        if (iconChords == Icons.circle_outlined)
          [iconChords = Icons.circle_sharp, showChordVariable = true]
        else
          [iconChords = Icons.circle_outlined, showChordVariable = false],
        setState(() {
          () => _SongPageState();
        })
      },
      iconSize: 17,
    );
  }

  BottomNavigationBar whichBottomNavigationBar() {
    if (widget.multiple == true) {
      return bottomNavigationBarCollections();
    } else {
      return bottomNavigationBarSingleSong();
    }
  }

  BottomNavigationBar bottomNavigationBarCollections() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: const Color.fromARGB(255, 241, 248, 244),
      selectedItemColor: Colors.green[800],
      items: [
        BottomNavigationBarItem(icon: makeFontSmallerButton(), label: ''),
        BottomNavigationBarItem(icon: makeFontBiggerButton(), label: ''),
        BottomNavigationBarItem(
            icon: IconButton(
              icon: const Icon(Icons.arrow_left),
              onPressed: () {},
              color: Colors.green[800],
              iconSize: 17,
            ),
            label: ''),
        BottomNavigationBarItem(
            icon: IconButton(
              icon: const Icon(Icons.arrow_right),
              onPressed: () {},
              color: Colors.green[800],
              iconSize: 17,
            ),
            label: ''),
        BottomNavigationBarItem(icon: chordsVisibilityButton(), label: '')
      ],
    );
  }

  BottomNavigationBar bottomNavigationBarSingleSong() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: const Color.fromARGB(255, 241, 248, 244),
      selectedItemColor: Colors.green[800],
      items: [
        BottomNavigationBarItem(icon: makeFontSmallerButton(), label: ''),
        BottomNavigationBarItem(icon: makeFontBiggerButton(), label: ''),
        BottomNavigationBarItem(icon: chordsVisibilityButton(), label: '')
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: whichBottomNavigationBar(),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(30),
            child: LyricsRenderer(
                leadingWidget: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_downward),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      Text(widget.hymn != null ? widget.hymn!.title : 'no'),
                      IconButton(
                        icon: const Icon(Icons.more_vert),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ]),
                showChord: showChordVariable,
                lyrics: widget.hymn != null ? widget.hymn!.text : 'no',
                textStyle:
                    TextStyle(color: Colors.black, fontSize: fontSizeVariable),
                chordStyle:
                    TextStyle(color: Colors.black, fontSize: fontSizeVariable),
                onTapChord: (String chord) {}),
          ),
        ],
      ),
    );
  }
}
