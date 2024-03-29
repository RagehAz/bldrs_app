import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/components/super_box/src/f_super_box_tap_layer/x_tap_layer.dart';
import 'package:bldrs/a_models/f_flyer/sub/flyer_typer.dart';
import 'package:bldrs/c_protocols/main_providers/home_provider.dart';
import 'package:bldrs/e_back_end/g_storage/storage_path.dart';
import 'package:bldrs/h_navigation/mirage/mirage.dart';
import 'package:bldrs/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/z_components/layouts/main_layout/app_bar/bldrs_app_bar.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SectionsButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SectionsButton({
    this.onTap,
    this.color = Colorz.white10,
    this.textColor = Colorz.white255,
    this.titleColor = Colorz.grey255,
    this.borderColor,
    this.height,
    super.key
  });
  /// --------------------------------------------------------------------------
  final Function? onTap;
  final Color color;
  final Color textColor;
  final Color titleColor;
  final Color? borderColor;
  final double? height;
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
      _body = currentKeywordID;
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

    final HomeProvider _chainsProvider = Provider.of<HomeProvider>(context);
    const bool _loadingChains = false; //_chainsProvider.loadingChains;

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

    final String? _icon = StoragePath.phids_phid(wallPhid);
    // _chainsProvider.getPhidIcon(son: wallPhid);

    final double _maxBoxWidth = BldrsAppBar.width() - 20 - Ratioz.appBarButtonSize;
    final double _maxTextWidth = _maxBoxWidth - 20 - Ratioz.appBarButtonSize;

    final double _borderFix = borderColor == null ? 0 : 1;
    final double _height = height ?? 40;

    return Material(
      child: InkWell(
        onTap: () => onTap?.call(),
        splashColor: Colorz.yellow125,
        borderRadius: MirageButton.getCorners,
        child: AnimatedContainer(
          height: _height - _borderFix,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: color,
              borderRadius: MirageButton.getCorners,
              border: TapLayer.getBorder(
                color: borderColor,
              )
          ),
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          child: Row(
            children: <Widget>[

              /// PIC
              BldrsBox(
                height: _height,
                width: _height,
                icon: _icon ?? Iconz.keywords,
                bubble: false,
                corners: MirageButton.getCorners,
                // loading: _loadingChains,
              ),

              /// TEXTS
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  /// 'Section' TITLE
                  BldrsText(
                    verse: _loadingChains == true ? _loadingVerse : _titleVerse,
                    size: 1,
                    italic: true,
                    color: titleColor,
                    weight: VerseWeight.thin,
                    centered: false,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    maxWidth: _maxTextWidth,
                  ),

                  /// CURRENT SECTION NAME
                  BldrsText(
                    verse: _sectionVerse,
                    size: 1,
                    centered: false,
                    scaleFactor: 1.26,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    maxWidth: _maxTextWidth,
                    color: textColor,
                  ),

                ],
              ),

            ],
          ),
        ),
      ),
    );


  }
  // -----------------------------------------------------------------------------
}
