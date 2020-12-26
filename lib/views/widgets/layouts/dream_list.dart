import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
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
      padding: EdgeInsets.symmetric(vertical: Ratioz.stratosphere),
      itemCount: itemCount,
      itemBuilder: itemBuilder,
    );
  }
}


dreamListBuilder  (BuildContext c, int x, String info,String icon ,String verse, String secondLine,) {
     Widget dreamListItems =  Container(
        width: superScreenWidth(c),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SuperVerse(
              verse: '${x+1} : $info}',
              size: 1,
              color: Colorz.Grey,
              weight: VerseWeight.thin,
              centered: false,
              margin: 5,
            ),
            DreamBox(
              height: 70,
              width: superScreenWidth(c)*0.95,
              boxMargins: EdgeInsets.only(bottom: 10),
              verse: verse,
              verseScaleFactor: 0.6,
              icon: icon,
              secondLine: secondLine,
              verseMaxLines: 3,

            )
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
      width: superScreenWidth(context),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SuperVerse(
            verse: '${index+1} : $info',
            size: 1,
            color: Colorz.Grey,
            weight: VerseWeight.thin,
            centered: false,
            margin: 5,
          ),
          DreamBox(
            height: 70,
            width: superScreenWidth(context)*0.95,
            boxMargins: EdgeInsets.only(bottom: 10),
            verse: verse,
            verseScaleFactor: 0.6,
            icon: icon,
            secondLine: secondLine,
            verseMaxLines: 3,

          )
        ],
      ),
    );
  }
}

