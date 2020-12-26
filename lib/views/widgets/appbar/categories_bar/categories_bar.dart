import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

class TagBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      sliver: SliverAppBar(
        automaticallyImplyLeading: false,
        pinned: true,
        floating: true,
        expandedHeight: 40,
        backgroundColor: Colorz.WhiteAir,
        elevation: 1,
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.all(Radius.circular(Ratioz.ddAppBarCorner))),
        titleSpacing: 5,
        toolbarHeight: 40,
        title: Row(
          children: <Widget>[

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: DreamBox(
              width: 30,
              height: 30,
              color: Colorz.Nothing,
              icon: Iconz.Filter,
              iconSizeFactor: 0.7,
              corners: Ratioz.ddAppBarButtonCorner-5,
              boxMargins: EdgeInsets.symmetric(horizontal: 0),
            ),
          ),

            SuperVerse(
              verse: 'Stairs',
              weight: VerseWeight.thin,
              shadow: false,
              italic: true,
              labelColor: Colorz.WhiteGlass,
              size: 2,
              color: Colorz.White,

            ),
            SuperVerse(
              verse: 'Appliances',
              weight: VerseWeight.thin,
              shadow: false,
              italic: true,
              labelColor: Colorz.WhiteGlass,
              size: 2,
              color: Colorz.White,

            ),

            SuperVerse(
              verse: 'Kitchens',
              weight: VerseWeight.thin,
              shadow: false,
              italic: true,
              labelColor: Colorz.WhiteGlass,
              size: 2,
              color: Colorz.White,

            ),


          ],
        ),
      ),
    );
  }
}
