import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_chord/flutter_chord.dart';
import 'package:hymnal_app/services/navigation_song_notifier.dart';
import 'package:provider/provider.dart';
import 'package:mdi/mdi.dart';

double fontSizeVariable = 16;
var iconChords = Icons.circle_outlined;
bool showChordVariable = false;

class SongPage extends StatefulWidget {
  const SongPage({super.key, required this.multiple, this.hiveKey});
  final bool multiple;
  final Hymn? hymn;
  final String? hiveKey;

  @override
  State<SongPage> createState() => _SongPageState();
}

class _SongPageState extends State<SongPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pieśń"),
        leading: Positioned(
          left: 30,
          top: 30,
          child: IconButton(
            icon: const Icon(Icons.arrow_downward),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
      bottomNavigationBar: widget.multiple? _buildNavigationBar2():_buildNavigationNavig
      body: Consumer<StateAndSongNotifier>(
        builder: (context, state, child) => Column(children: [
          Container(),
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(30),
                child: LyricsRenderer( 
                    showChord: showChordVariable,
                    lyrics:
                        state.currSong != null ? state.currSong!.text : 'no',
                    textStyle: TextStyle(
                        color: Colors.black, fontSize: fontSizeVariable),
                    chordStyle: TextStyle(
                        color: Colors.black, fontSize: fontSizeVariable),
                    onTapChord: (String chord) {}),
              ),
            ],
          ),
        ]),
      ),
    );
  }

  _buildNavigationBar2 ()=>BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color.fromARGB(255, 241, 248, 244),
        selectedItemColor: Colors.green[800],
        items: [
          BottomNavigationBarItem(
              icon: IconButton(
                  onPressed: () => {
                        fontSizeVariable += 1,
                        setState(() {
                          () => _SongPageState();
                        })
                      },
                  iconSize: 17,
                  color: Colors.green[800],
                  icon: const Icon(Mdi.formatFontSizeIncrease)),
              label: ''),
          BottomNavigationBarItem(
              icon: IconButton(
                  onPressed: () => {
                        fontSizeVariable -= 1,
                        setState(() {
                          () => _SongPageState();
                        })
                      },
                  iconSize: 17,
                  color: Colors.green[800],
                  icon: const Icon(Mdi.formatFontSizeDecrease)),
              label: ''),
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
          BottomNavigationBarItem(
              icon: IconButton(
                icon: Icon(iconChords),
                color: Colors.green[800],
                onPressed: () => {
                  if (iconChords == Icons.circle_outlined)
                    [iconChords = Icons.circle_sharp, showChordVariable = true]
                  else
                    [
                      iconChords = Icons.circle_outlined,
                      showChordVariable = false
                    ],
                  setState(() {
                    () => _SongPageState();
                  })
                },
                iconSize: 17,
              ),
              label: ''),
        ],
      );
 
  _buildNavigationBar1() => BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color.fromARGB(255, 241, 248, 244),
        selectedItemColor: Colors.green[800],
        items: [
          BottomNavigationBarItem(
              icon: IconButton(
                  onPressed: () => {
                        fontSizeVariable += 1,
                        setState(() {
                          () => _SongPageState();
                        })
                      },
                  iconSize: 17,
                  color: Colors.green[800],
                  icon: const Icon(Mdi.formatFontSizeIncrease)),
              label: ''),
          BottomNavigationBarItem(
              icon: IconButton(
                  onPressed: () => {
                        fontSizeVariable -= 1,
                        setState(() {
                          () => _SongPageState();
                        })
                      },
                  iconSize: 17,
                  color: Colors.green[800],
                  icon: const Icon(Mdi.formatFontSizeDecrease)),
              label: ''),
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
          BottomNavigationBarItem(
              icon: IconButton(
                icon: Icon(iconChords),
                color: Colors.green[800],
                onPressed: () => {
                  if (iconChords == Icons.circle_outlined)
                    [iconChords = Icons.circle_sharp, showChordVariable = true]
                  else
                    [
                      iconChords = Icons.circle_outlined,
                      showChordVariable = false
                    ],
                  setState(() {
                    () => _SongPageState();
                  })
                },
                iconSize: 17,
              ),
              label: ''),
        ],
      );
}
