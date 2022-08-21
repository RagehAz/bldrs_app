import 'package:bldrs/a_models/flyer/sub/flyer_typer.dart';
import 'package:bldrs/b_views/x_screens/j_chains/controllers/a_chains_screen_controllers.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/c_protocols/phrase_protocols/a_phrase_protocols_old.dart';
import 'package:bldrs/d_providers/chains_provider.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
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
  static String getTitle({
    @required BuildContext context,
    @required String currentKeywordID,
    @required FlyerType currentSection,
}){
    String _title;

    if (currentKeywordID == null){
      _title = xPhrase(context, 'phid_section');
    }

    else {
      final String _sectionName = FlyerTyper.translateFlyerType(
        context: context,
        flyerType: currentSection,
      );
      _title = _sectionName;
    }

    return _title;
  }
// -----------------------------------------------------------------------------
  static String getBody({
    @required BuildContext context,
    @required String currentKeywordID,
    @required FlyerType currentSection,
}){
    String _body;

    if (currentKeywordID != null){
      _body = xPhrase(context, currentKeywordID);
    }
    else {
      final String _sectionName = FlyerTyper.translateFlyerType(
        context: context,
        flyerType: currentSection,
      );

      _body = _sectionName;
    }

    return _body;
}
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Builder(
      builder: (BuildContext context) => GestureDetector(
        onTap: onTap ?? () => onSectionButtonTap(context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[

            IntrinsicWidth(
              child: Container(
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(Ratioz.boxCorner12),
                ),
                child: Consumer<ChainsProvider>(
                  builder: (_, ChainsProvider chainsPro, Widget child){

                    final String _titleVerse = getTitle(
                        context: context,
                        currentKeywordID: chainsPro.wallPhid,
                        currentSection: chainsPro.wallFlyerType,
                    );

                    final String _sectionVerse = getBody(
                        context: context,
                        currentKeywordID: chainsPro.wallPhid,
                        currentSection: chainsPro.wallFlyerType
                    );

                    final String _icon = chainsPro.getPhidIcon(
                      context: context,
                      son: chainsPro.wallPhid,
                    );

                    return Row(
                      children: <Widget>[

                        DreamBox(
                          height: 40,
                          width: 40,
                          icon: _icon ?? Iconz.stop,
                          bubble: false,
                        ),

                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[

                            /// 'Section' TITLE
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: SuperVerse(
                                verse: _titleVerse,
                                size: 1,
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
                                    scaleFactor: 1.26,
                                  ),

                                ],
                              ),
                            ),

                          ],
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
