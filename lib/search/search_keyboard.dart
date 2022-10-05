import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../model/hymn.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  static List<Hymn> hymns = Hymn.hymns;

// TODO - make it a widget not route

  @override
  Widget build(BuildContext context) {
    timeDilation = 1.5;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 40, right: 25),
        child: Row(
          children: [
            TextButton(
              child: const Icon(Icons.arrow_back_ios_new_rounded),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            Expanded(
                child: Hero(
                    tag: 'searchBar',
                    child: Card(
                      shape: const RoundedRectangleBorder(
                          side: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: ListTile(
                        tileColor: const Color.fromARGB(255, 231, 230, 230),
                        shape: const RoundedRectangleBorder(
                            side: BorderSide(color: Colors.grey),
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        leading: const Icon(
                          Icons.search,
                          color: Color.fromARGB(255, 190, 136, 86),
                        ),
                        title: TextField(
                          autocorrect: false,
                          autofocus: true,
                          onTap: () {},
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Wyszukaj po tytule lub tekście...',
                              hintStyle:
                                  TextStyle(fontStyle: FontStyle.italic)),
                        ),
                      ),
                    )))
          ],
        ),
      ),
    );
  }
}
