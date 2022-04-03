import 'package:bldrs/a_models/flyer/sub/flyer_type_class.dart';
import 'package:bldrs/b_views/z_components/texting/unfinished_super_verse.dart';
import 'package:bldrs/d_providers/chains_provider.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SectionsButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SectionsButton({
    this.onTap,
    this.color = Colorz.white10,
    Key key,
  }) : super(key: key);

  /// --------------------------------------------------------------------------
  final Function onTap;
  final Color color;

  /// --------------------------------------------------------------------------
  void _changeSection(BuildContext context) {
    // final double _dialogHeight = Scale.superScreenHeight(context) * 0.95;

    Scaffold.of(context).openDrawer();
    // await SectionDialog.slideDialog(
    //   context: context,
    //   dialogHeight: _dialogHeight,
    // );
  }

// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    // double _btThirdsOfScreenWidth = (_screenWidth - (6*_abPadding))/3;
    // double _buttonWidth = _sectionsAreExpanded == true ? _btThirdsOfScreenWidth : null;

    return Builder(
      builder: (BuildContext context) => GestureDetector(
        onTap: onTap ?? () => _changeSection(context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[

            IntrinsicWidth(
              child: Container(
                height: 40,
                // width: buttonWidth,
                // margin: const EdgeInsets.symmetric(horizontal: Ratioz.ddAppBarMargin*0.5),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(Ratioz.boxCorner12),
                ),
                child: Consumer<ChainsProvider>(
                  builder: (_, ChainsProvider keywordsProvider, Widget child){

                    final FlyerType _currentSection = keywordsProvider.currentSection;
                    final String _currentKeywordID = keywordsProvider.currentKeywordID;
                    final String _keywordPhrase = superPhrase(context, _currentKeywordID);

                    final String _sectionName = translateFlyerType(
                      context: context,
                      flyerType: _currentSection,
                    );

                    final String _titleVerse = _currentKeywordID == null ?
                    _keywordPhrase
                        :
                    _sectionName;

                    final String _sectionVerse = _currentKeywordID == null ?
                    translateFlyerType(
                      context: context,
                      flyerType: _currentSection,
                    )
                        :
                    _keywordPhrase;

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                        /// 'Section' TITLE
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: SuperVerse(
                            verse: _titleVerse,
                            size: 0,
                            italic: true,
                            color: Colorz.grey255,
                            weight: VerseWeight.thin,
                            centered: false,
                          ),
                        ),

                        /// CURRENT SECTION NAME
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[

                              SuperVerse(
                                verse: _sectionVerse,
                                size: 1,
                                centered: false,
                              ),

                            ],
                          ),
                        ),

                      ],
                    );

                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
