import 'package:bldrs/a_models/c_chain/aaa_phider.dart';
import 'package:bldrs/a_models/f_flyer/sub/flyer_typer.dart';
import 'package:bldrs/b_views/a_starters/b_home_screen/x_home_screen_controllers.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/chain_protocols/provider/chains_provider.dart';



import 'package:bldrs_theme/bldrs_theme.dart';
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
  static Verse getTitle({
    @required BuildContext context,
    @required String currentKeywordID,
    @required FlyerType currentSection,
  }){
    String _title;

    if (currentKeywordID == null){
      _title = 'phid_section';
    }

    else {
      final String _flyerTypePhid = FlyerTyper.getFlyerTypePhid(
        flyerType: currentSection,
      );
      _title = _flyerTypePhid;
    }

    return Verse(
      id: _title,
      translate: true,
    );
  }
// -----------------------------------------------------------------------------
  static Verse getBody({
    @required BuildContext context,
    @required String currentKeywordID,
    @required FlyerType currentSection,
  }){
    String _body;

    if (currentKeywordID != null){
      _body = Phider.removeIndexFromPhid(phid: currentKeywordID);
    }
    else {
      final String _flyerTypePhid = FlyerTyper.getFlyerTypePhid(
        flyerType: currentSection,
      );

      _body = _flyerTypePhid;
    }

    return Verse(
      id: _body,
      translate: true,
    );
  }
  // --------------------
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

                    final Verse _titleVerse = getTitle(
                      context: context,
                      currentKeywordID: chainsPro.wallPhid,
                      currentSection: chainsPro.wallFlyerType,
                    );

                    final Verse _sectionVerse = getBody(
                        context: context,
                        currentKeywordID: chainsPro.wallPhid,
                        currentSection: chainsPro.wallFlyerType
                    );

                    final String _icon = chainsPro.getPhidIcon(
                      son: chainsPro.wallPhid,
                    );

                    return Row(
                      children: <Widget>[

                        BldrsBox(
                          height: 40,
                          width: 40,
                          icon: _icon ?? Iconz.keywords,
                          bubble: false,
                        ),

                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[

                            /// 'Section' TITLE
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: BldrsText(
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

                                  BldrsText(
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
  // -----------------------------------------------------------------------------
}
