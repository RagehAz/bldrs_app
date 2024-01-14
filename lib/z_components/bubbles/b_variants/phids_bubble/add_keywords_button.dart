import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

class AddKeywordsButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const AddKeywordsButton({
    required this.onTap,
    super.key
  });
  /// --------------------------------------------------------------------------
  final Function? onTap;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    const double _corners = Ratioz.boxCorner12;

    return GestureDetector(
      onTap: () => onTap?.call(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[

          IntrinsicWidth(
            child: Container(
              height: 40,
              // width: buttonWidth,
              margin: const EdgeInsets.symmetric(horizontal: 2.5),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colorz.blue20,
                borderRadius: BorderRadius.circular(_corners),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                        /// 'Group' TITLE
                        // if (title != null)
                        BldrsText(
                          verse: Verse(
                            id: 'phid_add',
                            translate: true,
                          ),
                          size: 1,
                          italic: true,
                          color: Colorz.white125,
                          weight: VerseWeight.thin,
                          centered: false,
                        ),

                        /// CURRENT SECTION NAME
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            BldrsText(
                              verse: Verse(
                                id: 'phid_keywords',
                                translate: true,
                              ),
                              size: 1,
                              color: Colorz.white125,
                              centered: false,
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

  }
/// --------------------------------------------------------------------------
}
