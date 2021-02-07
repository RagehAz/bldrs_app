import 'package:bldrs/view_brains/drafters/text_directionz.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';

class SectionLabel extends StatelessWidget {
  final bool sectionsListIsOpen;
  final String label;
  final Function tappingSection;
  final String labelDescription;

  SectionLabel({
    @required this.label,
    @required this.sectionsListIsOpen,
    @required this.tappingSection,
    @required this.labelDescription,
  });

  @override
  Widget build(BuildContext context) {
    String _sectionPickerDropDownIcon =
    sectionsListIsOpen == false ? Iconz.ArrowDown
        :
    sectionsListIsOpen == true && appIsLeftToRight(context) ? Iconz.ArrowRight
        :
    sectionsListIsOpen == true && !appIsLeftToRight(context) ? Iconz.ArrowLeft
        : Iconz.ArrowDown;

    int _verseSize = sectionsListIsOpen == true ? 4 : 3;

    return GestureDetector(
      onTap: tappingSection,
      child: Column(
        children: <Widget>[

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

              WebsafeSvg.asset(_sectionPickerDropDownIcon, width: 10),

              SuperVerse(
                verse: label,
                size: _verseSize,
                weight: VerseWeight.bold,
                color: Colorz.White,
                italic: true,
                labelColor: Colorz.WhiteAir,
                shadow: true,
              ),
            ],
          ),
          sectionsListIsOpen == false ? Container()
              :
          SuperVerse(
            verse: labelDescription,
            size: 1,
            color: Colorz.WhiteLingerie,
            weight: VerseWeight.thin,
            italic: true,
            maxLines: 4,
          ),
        ],
      ),
    );
  }
}
