import 'package:flutter/material.dart';
import 'package:hymnal_app/root_home.dart';
import 'package:hymnal_app/root_library.dart';
import 'package:hymnal_app/root_search.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int currPage = 0;
  List<Widget> pagesWidgets = const [Home(), Search(), Library()];
  List<String> pagesTitles = const ['Początek', 'Wyszukaj', 'Biblioteka'];
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 151, 98, 79),
      appBar: AppBar(
        title: Text(pagesTitles[currPage]),
        centerTitle: true,
      ),
      body: pagesWidgets[currPage],
      drawer: Drawer(
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
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: const Icon(Icons.home), label: pagesTitles[0]),
          BottomNavigationBarItem(
              icon: const Icon(Icons.search), label: pagesTitles[1]),
          BottomNavigationBarItem(
              icon:
                  const Icon(Icons.book /* ballot amp_stories apps article */),
              label: pagesTitles[2])
        ],
        currentIndex: currPage,
        onTap: (int index) {
          setState(() {
            currPage = index;
          });
        },
        backgroundColor: const Color.fromARGB(255, 194, 155, 141),
      ),
    );
  }
}
