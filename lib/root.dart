import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hymnal_app/root_song.dart';
import 'package:hymnal_app/root_collections.dart';
import 'package:hymnal_app/root_search.dart';
import 'package:hymnal_app/services/navigation_song_notifier.dart';
import 'package:provider/provider.dart';

import 'model/hymn.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage>
    with SingleTickerProviderStateMixin {
  List<Widget> pagesWidgets = const [Song(), Search(), Collections()];

  List<String> pagesTitles = const ['Pieśń', 'Szukaj', 'Moje śpiewniki'];
  bool isSwitched = false;

  late AnimationController controller;
  late Animation<Offset> animation;

  @override
  void initState() {
    super.initState();
    fetchHymns();
    controller = AnimationController(
      duration: const Duration(milliseconds: 170),
      vsync: this,
    );
    animation =
        Tween<Offset>(begin: Offset.zero, end: Offset.zero).animate(controller);
  }

  void animatePage(int destPage, StateAndSongNotifier state) {
    controller.reset();
    double startPos = destPage.compareTo(state.currPage).toDouble();

    animation = Tween<Offset>(begin: Offset(startPos, 0), end: Offset.zero)
        .animate(controller);
    controller.forward();
  }

  void fetchHymns() async {
    final ref = FirebaseFirestore.instance.collection("hymns").withConverter(
        fromFirestore: Hymn.fromFirestore,
        toFirestore: (Hymn hymn, _) => hymn.toFirestore());

    await ref.get().then((snapshots) {
      for (var hymn in snapshots.docs) {
        Hymn.hymns.add(hymn.data());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<StateAndSongNotifier>(builder: (context, state, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text(pagesTitles[state.currPage]),
          centerTitle: true,
        ),
        body: _buildScreens(state),
        drawer: _buildCustomDrawer(),
        bottomNavigationBar: _buildCustomNavigationBar(state),
      );
    });
  }

  Stack _buildScreens(StateAndSongNotifier state) {
    List<Widget> children = [];
    pagesWidgets.asMap().forEach((index, value) {
      children.add(
        Offstage(
          offstage: state.currPage != index,
          child: TickerMode(
            enabled: state.currPage == index,
            child: SlideTransition(
              position: animation,
              child: value,
            ),
          ),
        ),
      );
    });

    return Stack(children: children);
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
      currentIndex: state.currPage,
      onTap: (int destPage) {
        animatePage(destPage, state);
        state.changeState(destPage);
      },
    );
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
}
