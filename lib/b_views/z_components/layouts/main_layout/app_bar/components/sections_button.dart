import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:bldrs/a_models/c_chain/aaa_phider.dart';
import 'package:bldrs/a_models/f_flyer/sub/flyer_typer.dart';
import 'package:bldrs/b_views/a_starters/b_home_screen/x_home_screen_controllers.dart';
import 'package:bldrs/b_views/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/chain_protocols/provider/chains_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SectionsButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SectionsButton({
    this.onTap,
    this.color = Colorz.white10,
    super.key
  });
  /// --------------------------------------------------------------------------
  final Function? onTap;
  final Color color;
  /// --------------------------------------------------------------------------
  static Verse getTitle({
    required BuildContext context,
    required String? currentKeywordID,
    required FlyerType? currentSection,
  }){
    String? _title;

    if (currentKeywordID == null){
      _title = 'phid_section';
    }

    else {
      final String? _flyerTypePhid = FlyerTyper.getFlyerTypePhid(
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
  static Verse? getBody({
    required BuildContext context,
    required String? currentKeywordID,
    required FlyerType? currentSection,
  }){
    String? _body;

    if (currentKeywordID != null){
      _body = Phider.removeIndexFromPhid(phid: currentKeywordID);
    }
    else {
      final String? _flyerTypePhid = FlyerTyper.getFlyerTypePhid(
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

    final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(context);
    final bool _zoneHasChains = Mapper.checkCanLoopList(_chainsProvider.zoneChains);
    final bool _loadingChains = _chainsProvider.loadingChains;

    if (_loadingChains == false && _zoneHasChains == false){
      return const SizedBox();
    }

    else {

      final String? wallPhid = _chainsProvider.wallPhid;
      final FlyerType? _wallFlyerType = _chainsProvider.wallFlyerType;

      final Verse _titleVerse = getTitle(
        context: context,
        currentKeywordID: wallPhid,
        currentSection: _wallFlyerType,
      );

      const Verse _loadingVerse = Verse(
        id: 'phid_loading',
        translate: true,
      );

      final Verse? _sectionVerse = getBody(
          context: context,
          currentKeywordID: wallPhid,
          currentSection: _wallFlyerType
      );

      final String? _icon = _chainsProvider.getPhidIcon(
        son: wallPhid,
      );

      return Builder(
        builder: (BuildContext context) => GestureDetector(
          onTap: onTap == null ? () => onSectionButtonTap() : () => onTap!(),
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
                  child: Row(
                    children: <Widget>[

                      BldrsBox(
                        height: 40,
                        width: 40,
                        icon: _icon ?? Iconz.keywords,
                        bubble: false,
                        loading: _loadingChains,
                      ),

                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[

                          /// 'Section' TITLE
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: BldrsText(
                              verse: _loadingChains == true ? _loadingVerse : _titleVerse,
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
                  ),
                ),
              ),

            ],
          ),
        ),
      );

    }


  }
  // -----------------------------------------------------------------------------
}
