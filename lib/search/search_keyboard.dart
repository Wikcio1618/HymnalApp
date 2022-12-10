import 'package:algolia_helper_flutter/algolia_helper_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../model/hymn.dart';
import '../model/search_metadata.dart';
import '../services/tile_builder.dart';

class KeyboardSearch extends StatefulWidget {
  const KeyboardSearch({super.key});

  @override
  State<KeyboardSearch> createState() => _KeyboardSearchState();
}

class _KeyboardSearchState extends State<KeyboardSearch> {
  final _productsSearcher = HitsSearcher(
      applicationID: 'Y8A7EXYNL3',
      apiKey: '03209caa73a08969b5d553197f540681',
      indexName: 'hymns');

  Stream<SearchMetadata> get _searchMetadata =>
      _productsSearcher.responses.map(SearchMetadata.fromResponse);
  final PagingController<int, Hymn> _pagingController =
      PagingController(firstPageKey: 0);

  TextEditingController textController = TextEditingController();
  List<Hymn> queryHymns = [];

  @override
  void initState() {
    super.initState();
    textController
        .addListener(() => _productsSearcher.query(textController.text));

    // textController.addListener(_getFirebaseQuery);
  }

  @override
  void dispose() {
    textController.dispose();
    _productsSearcher.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 1.5;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 40, right: 25),
        child: Column(
          children: [_buildSearchBarRow(context), _buildSearchResults()],
        ),
      ),
    );
  }

  Widget _buildSearchBarRow(BuildContext context) => Row(children: [
        TextButton(
          child: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        Expanded(
          child: Hero(
            tag: 'searchBar',
            // It has to be card for splash animation when hero animation
            child: Card(
              shape: const RoundedRectangleBorder(
                  side: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              child: ListTile(
                tileColor: const Color.fromARGB(255, 231, 230, 230),
                shape: const RoundedRectangleBorder(
                    side: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                leading: const Icon(
                  Icons.search,
                  color: Color.fromARGB(255, 190, 136, 86),
                ),
                title: TextField(
                  autocorrect: false,
                  autofocus: true,
                  controller: textController,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Wyszukaj po tytule lub tekście...',
                      hintStyle: TextStyle(fontStyle: FontStyle.italic)),
                ),
              ),
            ),
          ),
        )
      ]);

  Widget _buildSearchResults() {
    List<Widget> column = [];
    for (Hymn hymn in queryHymns) {
      column.add(TileBuilder.customLibraryTile(hymn));
    }
    return SingleChildScrollView(
      child: StreamBuilder(
          stream: _searchMetadata,
          builder: (context, snapshot) {
            if (snapshot.hasData) return Text('${snapshot.data!.nbHits}');
            return const Text('No search results');
          }),
    );
  }

  void _getFirebaseQuery() async {
    final ref = FirebaseFirestore.instance
        .collection("hymns")
        .withConverter(
            fromFirestore: Hymn.fromFirestore,
            toFirestore: (Hymn hymn, _) => hymn.toFirestore())
        .where('title', arrayContains: textController.text);

    await ref.get().then((snapshots) {
      List<Hymn> queried = [];
      for (var hymn in snapshots.docs) {
        queried.add(hymn.data());
      }

      setState(() {
        queryHymns = queried;
      });
    });
  }
}
