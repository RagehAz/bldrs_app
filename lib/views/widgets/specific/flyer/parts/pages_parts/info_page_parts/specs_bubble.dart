import 'package:bldrs/controllers/drafters/mappers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/kw/specs/spec_model.dart';
import 'package:bldrs/views/widgets/general/bubbles/bubble.dart';
import 'package:bldrs/views/widgets/general/textings/data_strip.dart';
import 'package:flutter/material.dart';

class SpecsBubble extends StatelessWidget {
  final String title;
  final List<Spec> specs;
  final int verseSize;
  final Function onTap;
  final Color bubbleColor;
  final List<dynamic> selectedWords;
  final double bubbleWidth;
  final dynamic margins;
  final dynamic corners;
  final bool passKeywordOnTap;
  final bool addButtonIsOn;

  const SpecsBubble({
    @required this.title,
    @required this.specs,
    @required this.selectedWords,
    @required this.addButtonIsOn,
    this.verseSize = 2,
    this.onTap,
    this.bubbleColor = Colorz.white20,
    this.bubbleWidth,
    this.margins,
    this.corners,
    this.passKeywordOnTap = false,
    Key key,
  }) : super(key: key);
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    /// the keyword bottom bubble corner when set in flyer info page
    final double _bottomPadding = ((bubbleWidth) * Ratioz.xxflyerBottomCorners) - Ratioz.appBarPadding - Ratioz.appBarMargin;

    return Bubble(
      key: key,
      centered: false,
      bubbleColor: bubbleColor,
      margins: margins,
      corners: corners,
      actionBtIcon: Iconz.Gears,
      title: title,
      width: bubbleWidth,
      bubbleOnTap: passKeywordOnTap == true ? null : onTap,
      columnChildren: <Widget>[

        /// STRINGS
        if(Mapper.canLoopList(specs))
          ...List<Widget>.generate(
              specs?.length,
                  (index){

                final Spec _spec = specs[index];

                return
                  DataStrip(dataKey: _spec.specsListID, dataValue: _spec.value);
              }
          ),

        // if(Mapper.canLoopList(specs) && addButtonIsOn == true)
        //   AddKeywordsButton(
        //     onTap: passKeywordOnTap == true ? null : onTap,
        //   ),

        Container(
          height: _bottomPadding,
        ),

      ],
    );
  }
}
