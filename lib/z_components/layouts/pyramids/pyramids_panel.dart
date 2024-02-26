import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:bldrs/c_protocols/main_providers/home_provider.dart';
import 'package:bldrs/z_components/layouts/pyramids/pyramid_floating_button.dart';
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

      return Align(
        alignment: Alignment.centerRight,
        child: Container(
          color: Colorz.nothing,
          width: 55,
          child: Material(
            child: Stack(
              children: <Widget>[

                /// EXTRA BUTTONS
                if (Lister.checkCanLoop(pyramidButtons) == true)
                  ...List.generate(pyramidButtons!.length, (index){

                    final double _bottomOffset = bottomMargin + (PyramidFloatingButton.size * index);

                    return ValueListenableBuilder(
                        valueListenable: HomeProvider.proGetPyramidIsOn(
                          context: context,
                          listen: true,
                        ),
                        builder: (_, bool pyramidIsOpen, Widget? child) {

                          return AnimatedPositioned(
                            duration: Duration(milliseconds: 500 + (50 * index)),
                            bottom: pyramidIsOpen == true ? _bottomOffset : _bottomOffset - 400,
                            right: 10,
                            curve: Curves.easeInOutBack,
                            child: pyramidButtons!.reversed.toList()[index],
                          );

                        }
                    );

                  }),

              ],
            ),
          ),
        ),
      );

  }
// ---------------------------------------------------------------------------
}
