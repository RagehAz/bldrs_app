import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/texting/unfinished_super_verse.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class BubbleNotes extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BubbleNotes({
    @required this.notes,
    this.bubbleWidth,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final List<String> notes;
  final double bubbleWidth;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    if (Mapper.canLoopList(notes) == false){
      return const SizedBox();
    }
    else {

      final double _bubbleWidth = bubbleWidth ?? Bubble.clearWidth(context);

      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[

          ...List.generate(notes.length, (index){

            return SizedBox(
              width: _bubbleWidth,
              child: SuperVerse(
                verse: notes[index],
                margin: 5,
                // size: 2,
                maxLines: 10,
                centered: false,
                color: Colorz.blue255,
                italic: true,
                weight: VerseWeight.thin,
                leadingDot: true,
              ),
            );

          }),

          Container(
            width: _bubbleWidth - (Ratioz.appBarMargin * 2),
            height: 0.5,
            color: Colorz.blue125,
            margin: const EdgeInsets.symmetric(vertical: 10),
          ),
          
        ],
      );
    }

  }
}
