import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:flutter/material.dart';

class DreamList extends StatelessWidget {
  final int itemCount;
  final Function itemBuilder;
  final double itemHeight;
  final double itemZoneHeight;

  DreamList({
    @required this.itemCount,
    @required this.itemBuilder,
    this.itemHeight = 50,
    this.itemZoneHeight = 60,

});


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      reverse: false,
      padding: const EdgeInsets.symmetric(vertical: Ratioz.stratosphere),
      itemCount: itemCount,
      itemBuilder: itemBuilder,
    );
  }
}


Widget dreamListBuilder  (BuildContext c, int x, String info,String icon ,String verse, String secondLine,) {

     Widget dreamListItems =  Container(
        width: Scale.superScreenWidth(c),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            SuperVerse(
              verse: '${x+1} : $info}',
              size: 1,
              color: Colorz.Grey225,
              weight: VerseWeight.thin,
              centered: false,
              margin: 5,
            ),

            DreamBox(
              height: 70,
              width: Scale.superScreenWidth(c)*0.95,
              margins: const EdgeInsets.only(bottom: 10),
              verse: verse,
              verseScaleFactor: 0.6,
              icon: icon,
              secondLine: secondLine,
              verseMaxLines: 3,
            ),

          ],
        ),
      );
     return dreamListItems;
}

class DreamTile extends StatelessWidget {
  final int index;
  final String info;
  final String icon;
  final String verse;
  final String secondLine;

  DreamTile({
    this.index,
    this.info,
    this.icon,
    this.verse,
    this.secondLine,
});
  @override
  Widget build(BuildContext context) {

    return Container(
      width: Scale.superScreenWidth(context),
      alignment: Alignment.center,

      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          SuperVerse(
            verse: '${index+1} : $info',
            size: 1,
            color: Colorz.Grey225,
            weight: VerseWeight.thin,
            centered: false,
            margin: 5,
          ),

          DreamBox(
            height: 70,
            width: Scale.superScreenWidth(context)*0.95,
            margins: const EdgeInsets.only(bottom: 10),
            verse: verse,
            verseScaleFactor: 0.6,
            icon: icon,
            secondLine: secondLine,
            verseMaxLines: 3,
          ),

        ],
      ),
    );
  }
}

