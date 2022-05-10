import 'package:bldrs/a_models/chain/spec_models/spec_picker_model.dart';
import 'package:bldrs/a_models/chain/spec_models/spec_model.dart';
import 'package:bldrs/b_views/z_components/app_bar/bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/d_providers/chains_provider.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart' as Borderers;
import 'package:bldrs/f_helpers/drafters/iconizers.dart' as Iconizer;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class SpecPickerTile extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SpecPickerTile({
    @required this.onTap,
    @required this.specPicker,
    @required this.selectedSpecs,
    @required this.onDeleteSpec,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Function onTap;
  final SpecPicker specPicker;
  final List<SpecModel> selectedSpecs;
  final Function onDeleteSpec;
  /// --------------------------------------------------------------------------
  static double height() {
    return 70;
  }
// -----------------------------------------------------------------------------
  static double width(BuildContext context) {
    final double _specTileWidth = BldrsAppBar.width(context);
    return _specTileWidth;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
// -----------------------------------------------------------------------------
//     final double _screenWidth = Scale.superScreenWidth(context);
//     final double _screenHeight = Scale.superScreenHeight(context);
// -----------------------------------------------------------------------------
    final double _specTileHeight = height();
    final double _specTileWidth = width(context);
    final BorderRadius _tileBorders =
        Borderers.superBorderAll(context, Ratioz.appBarCorner);
    final double _specNameBoxWidth = _specTileWidth - (2 * _specTileHeight);
// -----------------------------------------------------------------------------

    return GestureDetector(
      key: const ValueKey<String>('SpecPickerTile'),
      onTap: onTap,
      child: Center(
        child: Container(
          width: _specTileWidth,
          // height: _specTileHeight,
          margin: const EdgeInsets.only(bottom: Ratioz.appBarPadding),
          decoration: BoxDecoration(
            color: Colorz.white10,
            borderRadius: _tileBorders,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              /// SPECS LIST ROW
              SizedBox(
                width: _specTileWidth,
                child: Row(
                  children: <Widget>[

                    /// - ICON
                    DreamBox(
                      width: _specTileHeight,
                      height: _specTileHeight,
                      color: Colorz.white10,
                      corners: _tileBorders,
                      bubble: false,
                      icon: superIcon(context, specPicker.chainID),
                      iconSizeFactor: 0.6,
                    ),

                    /// - LIST NAME
                    Expanded(
                      child: SizedBox(
                        height: _specTileHeight,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              width: _specNameBoxWidth,
                              child: SuperVerse(
                                verse: superPhrase(context, specPicker.chainID),
                                centered: false,
                                margin: 10,
                                maxLines: 2,
                                redDot: specPicker.isRequired,
                              ),
                            ),

                            // SuperVerse(
                            //   verse: Name.getNameByCurrentLingoFromNames(context, _chain.names),
                            //   centered: false,
                            // ),

                          ],
                        ),
                      ),
                    ),

                    /// - ARROW
                    DreamBox(
                      width: _specTileHeight,
                      height: _specTileHeight,
                      corners: _tileBorders,
                      icon: Iconizer.superArrowENRight(context),
                      iconSizeFactor: 0.15,
                      bubble: false,
                    ),

                  ],
                ),
              ),

              /// SELECTED SPECS ROW
              if (selectedSpecs.isNotEmpty)
                SizedBox(
                  width: _specTileWidth,
                  child: Row(
                    children: <Widget>[

                      /// FAKE SPACE UNDER ICON
                      SizedBox(
                        width: _specTileHeight,
                        height: 10,
                      ),

                      /// SELECTED SPECS BOX
                      Container(
                        width: _specTileWidth - _specTileHeight,
                        padding: const EdgeInsets.all(Ratioz.appBarMargin),
                        child: Wrap(
                          spacing: Ratioz.appBarPadding,
                          children: <Widget>[

                            ...List<Widget>.generate(selectedSpecs.length,
                                (int index) {

                              final SpecModel _spec = selectedSpecs[index];

                              final String _specName = SpecModel.translateSpec(
                                context: context,
                                spec: _spec,
                              );

                              return DreamBox(
                                height: 30,
                                icon: Iconz.xLarge,
                                margins: const EdgeInsets.symmetric(vertical: 2.5),
                                verse: _specName,
                                verseWeight: VerseWeight.thin,
                                verseItalic: true,
                                verseScaleFactor: 1.5,
                                verseShadow: false,
                                iconSizeFactor: 0.4,
                                color: Colorz.black255,
                                bubble: false,
                                onTap: () => onDeleteSpec(_spec),
                              );
                            }),

                          ],
                        ),
                      ),

                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
