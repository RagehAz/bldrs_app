import 'package:flutter/material.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:basics/helpers/classes/space/scale.dart';

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

      return Container(
        width: Scale.screenWidth(context),
        height: Scale.screenHeight(context),
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: const EdgeInsets.only(right: 10, bottom: bottomMargin),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[

              /// EXTRA BUTTONS
              if (Mapper.checkCanLoopList(pyramidButtons) == true)
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
