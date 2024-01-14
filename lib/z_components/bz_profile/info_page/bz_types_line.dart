import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/b_bz/sub/bz_typer.dart';
import 'package:bldrs/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/z_components/texting/customs/zone_line.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

class BzTypesLine extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BzTypesLine({
    required this.bzModel,
    required this.width,
    this.centered = true,
    this.oneLine = false,
    this.showIcon = false,
    super.key
  });
  /// --------------------------------------------------------------------------
  final BzModel? bzModel;
  final double width;
  final bool centered;
  final bool oneLine;
  final bool showIcon;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    if (Lister.checkCanLoop(bzModel?.bzTypes) == false){
      return const SizedBox();
    }
    else {

      final String _bzTypesString = BzTyper.translateBzTypesIntoString(
        context: context,
        bzTypes: bzModel?.bzTypes,
        bzForm: bzModel?.bzForm,
        oneLine: oneLine,
      );

      if (showIcon == true){

        const double _iconSize = ZoneLine.flagSize;
        final int _typesLength = bzModel!.bzTypes!.length;
        final double _textWidth = width - (_iconSize * _typesLength);

       return  SizedBox(
         width: width,
         child: Row(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: <Widget>[

             ...List.generate(bzModel!.bzTypes!.length, (index){

               final BzType _bzType = bzModel!.bzTypes![index];

               return BldrsBox(
                 height: _iconSize,
                 width: _iconSize,
                 icon: BzTyper.getBzTypeIcon(_bzType),
               );

             }),

             BldrsText(
               width: _textWidth,
               verse: Verse(
                 id: _bzTypesString,
                 translate: false,
               ),
               maxLines: 4,
               weight: VerseWeight.thin,
               italic: true,
               color: Colorz.grey255,
               centered: centered,
             ),

           ],
         ),
       );
      }

      else {
        return SizedBox(
          width: width,
          child: BldrsText(
            verse: Verse(
              id: _bzTypesString,
              translate: false,
            ),
            maxLines: 4,
            weight: VerseWeight.thin,
            italic: true,
            color: Colorz.grey255,
            centered: centered,
          ),
        );
      }

    }


  }
  /// --------------------------------------------------------------------------
}
