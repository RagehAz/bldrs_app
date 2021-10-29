import 'dart:ui';
import 'package:bldrs/controllers/drafters/shadowers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/widgets/general/artworks/blur_layer.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'enum_lister_tile.dart';

class EnumLister extends StatelessWidget {
  final String listTitle;
  final List<String> stringsList;
  final Function triggerTile;
  final List<bool> triggersList;
  final Function closeEnumLister;

  const EnumLister({
    @required this.listTitle,
    @required this.stringsList,
    @required this.triggerTile,
    @required this.triggersList,
    @required this.closeEnumLister,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double listHeight = screenHeight - Ratioz.appBarSmallHeight * 3;
    final double listWidth = screenWidth - Ratioz.appBarSmallHeight * 1;

    return Stack(
      children: <Widget>[

        /// --- BLACK BACKGROUND LAYER
        Container(
          width: screenWidth,
          height: screenHeight,
          color: Colorz.black80,
        ),

        /// --- THE LIST PAGE
        Positioned(
          bottom: 0,
          left: 0,
          child: Container(
            height: listHeight,
            width: listWidth,
            margin: const EdgeInsets.only(left: Ratioz.appBarMargin * 2),
            decoration: const BoxDecoration(
                // color: Colorz.BlackSmoke,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(Ratioz.appBarButtonCorner),
                  topRight: Radius.circular(Ratioz.appBarButtonCorner),
                ),
                boxShadow: <BoxShadow>[
                  const CustomBoxShadow(
                      color: Colorz.black230,
                      offset: const Offset(0, 0),
                      blurRadius: 30,
                      blurStyle: BlurStyle.outer),
                  const CustomBoxShadow(
                      color: Colorz.black230,
                      offset: const Offset(0, 0),
                      blurRadius: 30,
                      blurStyle: BlurStyle.outer),
                ]),
            child: Stack(
              children: <Widget>[

                /// --- BLUR LAYER
                BlurLayer(
                  width: listWidth,
                  height: listHeight,
                  borders: const BorderRadius.only(
                    topLeft: const Radius.circular(Ratioz.appBarButtonCorner),
                    topRight: const Radius.circular(Ratioz.appBarButtonCorner),
                  ),
                  blur: 10,
                ),

                /// --- LIST CONTENTS
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[

                      /// --- LIST TITLE
                      Container(
                        // padding: EdgeInsets.all(Ratioz.ddAppBarMargin * 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[

                            /// LIST TITLE
                            SuperVerse(
                              verse: listTitle,
                              size: 3,
                              shadow: true,
                              italic: true,
                              margin: Ratioz.appBarMargin * 2,
                            ),

                            /// EXIT X ICON
                            DreamBox(
                              height: 50,
                              width: 60,
                              corners: 10,
                              icon: Iconz.XLarge,
                              onTap: closeEnumLister,
                              // boxMargins: EdgeInsets.symmetric(horizontal: Ratioz.ddAppBarMargin),
                              iconSizeFactor: 0.4,
                              bubble: false,
                            ),
                          ],
                        ),
                      ),

                      /// DIVIDING LINE
                      Container(
                        width: listWidth - Ratioz.appBarMargin,
                        height: 0.5,
                        color: Colorz.yellow255,
                        margin: const EdgeInsets.symmetric(horizontal: Ratioz.appBarMargin * 2),

                      ),

                      /// LIST ITEMS
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: Ratioz.appBarMargin * 2),
                          decoration: const BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: <Color>[Colorz.black200, Colorz.black0],
                              stops: <double>[0, 0.25]
                            )
                          ),
                          child: ListView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: stringsList.length,
                            padding: const EdgeInsets.only(bottom: Ratioz.pyramidsHeight, top: Ratioz.appBarMargin ),
                            itemBuilder: (_, index) =>

                                 EnumListerTile(
                                  verse: stringsList[index],
                                  onTap: () => triggerTile(index),
                                  tileIsOn: triggersList[index],
                                )

                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}


// ...List<Widget>.generate(12, (int index) {
//   return EnumListerTile(
//     verse: stringsList[index],
//     onTap: () => triggerTile(index),
//     tileIsOn: triggersList[index],
//   );
// })
