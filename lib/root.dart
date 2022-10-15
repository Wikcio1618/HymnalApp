import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hymnal_app/root_home.dart';
import 'package:hymnal_app/root_collections.dart';
import 'package:hymnal_app/root_search.dart';

import 'model/hymn.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int currPage = 0;
  List<Widget> pagesWidgets = const [Home(), Search(), Collections()];
  List<String> pagesTitles = const ['Początek', 'Szukaj', 'Moje śpiewniki'];
  bool isSwitched = false;

  @override
  void initState() {
    super.initState();
    fetchHymns();
  }

  void fetchHymns() async {
    await Firebase.initializeApp();
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
    return Scaffold(
      appBar: AppBar(
        title: Text(pagesTitles[currPage]),
        centerTitle: true,
      ),
      body: pagesWidgets[currPage],
      drawer: _buildCustomDrawer(),
      bottomNavigationBar: _buildCustomNavigationBar(),
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

  _buildCustomNavigationBar() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
            icon: const Icon(Icons.home_outlined), label: pagesTitles[0]),
        BottomNavigationBarItem(
            icon: const Icon(Icons.search), label: pagesTitles[1]),
        BottomNavigationBarItem(
            icon: const Icon(Icons.ballot_outlined /* ballot apps */),
            label: pagesTitles[2])
      ],
      currentIndex: currPage,
      onTap: (int index) {
        setState(() {
          currPage = index;
        });
      },
    );
  }
}
