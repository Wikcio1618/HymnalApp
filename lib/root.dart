import 'package:flutter/material.dart';
import 'package:hymnal_app/root_song.dart';
import 'package:hymnal_app/root_collections.dart';
import 'package:hymnal_app/root_search.dart';
import 'package:hymnal_app/services/state_song_notifier.dart';
import 'package:provider/provider.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  List<Widget> pagesWidgets = const [Song(), Search(), Collections()];
  List<String> pagesTitles = const ['Pieśń', 'Szukaj', 'Moje śpiewniki'];
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<StateAndSongNotifier>(builder: (context, state, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text(pagesTitles[state.currState]),
          centerTitle: true,
        ),
        body: pagesWidgets[state.currState],
        drawer: _buildCustomDrawer(),
        bottomNavigationBar: _buildCustomNavigationBar(state),
      );
    });
  }

  _buildCustomDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          ListTile(
            title: const Text('Historia wyszukiwania'),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Tryb ciemny'),
            trailing: Switch(
              value: isSwitched,
              onChanged: (bool value) {
                setState(() {
                  isSwitched = value;
                });
              },
            ),
            onTap: () {
              setState(() {
                isSwitched = !isSwitched;
              });
            },
          ),
          ListTile(
            title: const Text('Zgłoś pieśń'),
            onTap: () {},
          ),
          const ListTile(
              title: null, subtitle: Text('Autor aplikacji:\nWiktor Ciołek')),
        ],
      ),
    );
  }

  _buildCustomNavigationBar(StateAndSongNotifier state) {
    return BottomNavigationBar(
      enableFeedback: true,
      items: [
        BottomNavigationBarItem(
            icon: const Icon(Icons.menu_book_rounded), label: pagesTitles[0]),
        BottomNavigationBarItem(
            icon: const Icon(Icons.search), label: pagesTitles[1]),
        BottomNavigationBarItem(
            icon: const Icon(Icons.ballot_outlined /* ballot apps */),
            label: pagesTitles[2])
      ],
      currentIndex: state.currState,
      onTap: (int index) {
        state.changeState(index);
      },
    );
  }
}
