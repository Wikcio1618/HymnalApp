import 'package:flutter/material.dart';
import 'package:hymnal_app/model/enums.dart';
import 'package:hymnal_app/services/navigation_song_notifier.dart';
import 'package:provider/provider.dart';
import 'category_discover.dart';
import '../model/hymn.dart';

class CategoryMenu extends StatefulWidget {
  const CategoryMenu({super.key});

  @override
  State<CategoryMenu> createState() => _CategoryMenuState();
}

class _CategoryMenuState extends State<CategoryMenu> {
  @override
  Widget build(BuildContext context) {
    return Consumer<StateAndSongNotifier>(
      builder: (context, state, child) => Container(
        padding: const EdgeInsets.all(20.0),
        child: state.categoryState == null
            ? GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3.5,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemCount: Categories.values.length,
                itemBuilder: buttonBuilder)
            : DiscoverCategoryPage(state.categoryState!),
      ),
    );
  }

  Widget buttonBuilder(BuildContext context, int index) {
    return OutlinedButton(
      style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all(Categories.values[index].color),
          foregroundColor:
              MaterialStateProperty.all(const Color.fromARGB(255, 111, 86, 55)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              side: const BorderSide(width: 2, color: Colors.black),
              borderRadius: BorderRadius.circular(15),
            ),
          )),
      onPressed: () {
        Provider.of<StateAndSongNotifier>(context, listen: false)
            .changeCategoryState(index);
        Provider.of<StateAndSongNotifier>(context, listen: false)
            .changeSearchBarVisibility(false);
      },
      child: Text(
          style: const TextStyle(fontSize: 26),
          Hymn.getCategoriesSortedAlphabetically()[index].name),
    );
  }
}
