import 'package:bldrs/b_views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/texting/unfinished_super_verse.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class DreamList extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const DreamList({
    @required this.itemCount,
    @required this.itemBuilder,
    this.itemHeight = 50,
    this.itemZoneHeight = 60,
    Key key,
  }) : super(key: key);

  /// --------------------------------------------------------------------------
  final int itemCount;
  final Function itemBuilder;
  final double itemHeight;
  final double itemZoneHeight;

  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: Ratioz.stratosphere),
      itemCount: itemCount,
      itemBuilder: itemBuilder,
    );
  }
}

Widget dreamListBuilder(
  BuildContext c,
  int x,
  String info,
  String icon,
  String verse,
  String secondLine,
) {
  final Widget dreamListItems = Container(
    width: Scale.superScreenWidth(c),
    alignment: Alignment.center,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SuperVerse(
          verse: '${x + 1} : $info}',
          size: 1,
          color: Colorz.grey255,
          weight: VerseWeight.thin,
          centered: false,
          margin: 5,
        ),
        DreamBox(
          height: 70,
          width: Scale.superScreenWidth(c) * 0.95,
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
  /// --------------------------------------------------------------------------
  const DreamTile({
    this.index,
    this.info,
    this.icon,
    this.verse,
    this.secondLine,
    Key key,
  }) : super(key: key);

  /// --------------------------------------------------------------------------
  final int index;
  final String info;
  final String icon;
  final String verse;
  final String secondLine;

  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Scale.superScreenWidth(context),
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SuperVerse(
            verse: '${index + 1} : $info',
            size: 1,
            color: Colorz.grey255,
            weight: VerseWeight.thin,
            centered: false,
            margin: 5,
          ),
          DreamBox(
            height: 70,
            width: Scale.superScreenWidth(context) * 0.95,
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
