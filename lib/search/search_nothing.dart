import 'package:flutter/material.dart';
import 'package:inner_shadow_widget/inner_shadow_widget.dart';

class NoSearchYet extends StatelessWidget {
  const NoSearchYet({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InnerShadow(
        color: Colors.black12,
        offset: const Offset(3, 1),
        blur: 4,
        child: Icon(
          Icons.manage_search_rounded,
          size: 200,
          color: Theme.of(context).colorScheme.onBackground,
          /*  shadows: [
            Shadow(
              color: Colors.grey[400]!,
              offset: Offset(-3, 2),
              blur: 3,
              child: null,
            )
          ], */
        ),
      ),
    );
  }
}
