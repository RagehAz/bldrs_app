import 'dart:ui';
import 'package:bldrs/controllers/drafters/shadowers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'enum_lister_items/enum_lister_tile.dart';

class EnumLister extends StatelessWidget {
  final String listTitle;
  final List<String> stringsList;
  final Function triggerTile;
  final List<bool> triggersList;
  final Function closeEnumLister;

  EnumLister({
    @required this.listTitle,
    @required this.stringsList,
    @required this.triggerTile,
    @required this.triggersList,
    @required this.closeEnumLister,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    // double safeAreaHeight = MediaQuery.of(context).padding.top;

    double listHeight = screenHeight - Ratioz.appBarSmallHeight * 3;
    double listWidth = screenWidth - Ratioz.appBarSmallHeight * 1;

    return Stack(
      children: <Widget>[
        // --- BLACK BACKGROUND LAYER
        Container(
          width: screenWidth,
          height: screenHeight,
          color: Colorz.BlackSmoke,
        ),

        // --- THE LIST PAGE
        Positioned(
          bottom: 0,
          left: 0,
          child: Container(
            height: listHeight,
            width: listWidth,
            margin: EdgeInsets.only(left: Ratioz.appBarMargin * 2),
            decoration: BoxDecoration(
                // color: Colorz.BlackSmoke,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Ratioz.appBarButtonCorner),
                  topRight: Radius.circular(Ratioz.appBarButtonCorner),
                ),
                boxShadow: <BoxShadow>[
                  CustomBoxShadow(
                      color: Colorz.BlackBlack,
                      offset: const Offset(0, 0),
                      blurRadius: 30,
                      blurStyle: BlurStyle.outer),
                  CustomBoxShadow(
                      color: Colorz.BlackBlack,
                      offset: const Offset(0, 0),
                      blurRadius: 30,
                      blurStyle: BlurStyle.outer),
                ]),
            child: Stack(
              children: <Widget>[

                // --- BLUR LAYER
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Ratioz.appBarButtonCorner),
                    topRight: Radius.circular(Ratioz.appBarButtonCorner),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                    child: Container(
                      height: listHeight,
                      width: listWidth,
                      color: Colorz.WhiteGlass,
                    ),
                  ),
                ),

                // --- LIST CONTENTS
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[

                      // --- LIST TITLE
                      Container(
                        // padding: EdgeInsets.all(Ratioz.ddAppBarMargin * 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[

                            // --- LIST TITLE
                            SuperVerse(
                              verse: listTitle,
                              size: 3,
                              shadow: true,
                              italic: true,
                              margin: Ratioz.appBarMargin * 2,
                            ),

                            // --- EXIT X ICON
                            DreamBox(
                              height: 50,
                              width: 60,
                              corners: 10,
                              icon: Iconz.XLarge,
                              boxFunction: closeEnumLister,
                              // boxMargins: EdgeInsets.symmetric(horizontal: Ratioz.ddAppBarMargin),
                              iconSizeFactor: 0.4,
                              bubble: false,
                            ),
                          ],
                        ),
                      ),

                      // --- DIVIDING LINE
                      Container(
                        width: listWidth - Ratioz.appBarMargin,
                        height: 0.5,
                        color: Colorz.Yellow,
                        margin: EdgeInsets.symmetric(horizontal: Ratioz.appBarMargin * 2),

                      ),

                      // --- LIST ITEMS
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: Ratioz.appBarMargin * 2),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [Colorz.BlackLingerie, Colorz.BlackNothing],
                              stops: [0, 0.25]
                            )
                          ),
                          child: ListView.builder(
                            physics: AlwaysScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: stringsList.length,
                            padding: EdgeInsets.only(bottom: Ratioz.pyramidsHeight, top: Ratioz.appBarMargin ),
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
