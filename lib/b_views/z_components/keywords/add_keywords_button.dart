import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class AddKeywordsButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const AddKeywordsButton({
    @required this.onTap,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Function onTap;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    const double _corners = Ratioz.boxCorner12;

    return GestureDetector(
      onTap: onTap,
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                        /// 'Group' TITLE
                        // if (title != null)
                        SuperVerse(
                          verse: xPhrase(context, '##Add ...'),
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
                            SuperVerse(
                              verse: xPhrase(context, '##Keywords'),
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
}
