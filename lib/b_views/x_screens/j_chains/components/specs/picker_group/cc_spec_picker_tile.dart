import 'package:bldrs/a_models/chain/spec_models/spec_model.dart';
import 'package:bldrs/a_models/chain/spec_models/picker_model.dart';
import 'package:bldrs/b_views/x_screens/j_chains/components/specs/specs_wrapper.dart';
import 'package:bldrs/b_views/z_components/app_bar/a_bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart';
import 'package:bldrs/f_helpers/drafters/iconizers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
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
  final PickerModel specPicker;
  final List<SpecModel> selectedSpecs;
  final ValueChanged<List<SpecModel>> onDeleteSpec;
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
    final double _specTileHeight = height();
    final double _specTileWidth = width(context);
    final BorderRadius _tileBorders = Borderers.superBorderAll(context, Ratioz.appBarCorner);
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
                      icon: phidIcon(context, specPicker.chainID),
                      iconSizeFactor: 0.6,
                    ),

                    /// - PICKER NAME
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
                                verse: xPhrase(context, specPicker.chainID),
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
                      SpecsWrapper(
                        boxWidth: _specTileWidth - _specTileHeight,
                        specs: selectedSpecs,
                        picker: specPicker,
                        onSpecTap: (List<SpecModel> specs) => onDeleteSpec(specs),
                        xIsOn: true,
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
