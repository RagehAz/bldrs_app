import 'package:basics/helpers/classes/maps/lister.dart';
import 'package:flutter/material.dart';

class PyramidsPanel extends StatelessWidget {
  // ---------------------------------------------------------------------------
  const PyramidsPanel({
    this.pyramidButtons,
    super.key
  });
  // --------------------
  final List<Widget>? pyramidButtons;
  // --------------------
  static const double bottomMargin = 50;
  // ---------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

      return Material(
        child: Padding(
          padding: const EdgeInsets.only(right: 10, bottom: bottomMargin),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[

              /// EXTRA BUTTONS
              if (Lister.checkCanLoopList(pyramidButtons) == true)
                ...List.generate(pyramidButtons!.length, (index){

                  return pyramidButtons![index];

                }),


            ],
          ),
        ),
      );

  }
// ---------------------------------------------------------------------------
}
