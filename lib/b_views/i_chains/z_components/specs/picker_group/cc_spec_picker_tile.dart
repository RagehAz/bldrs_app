import 'package:bldrs/a_models/c_chain/c_picker_model.dart';
import 'package:bldrs/a_models/c_chain/d_spec_model.dart';
import 'package:bldrs/b_views/i_chains/z_components/specs/specs_wrapper.dart';
import 'package:bldrs/b_views/z_components/app_bar/a_bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/c_protocols/phrase_protocols/provider/phrase_provider.dart';
import 'package:bldrs/f_helpers/drafters/iconizers.dart';
import 'package:bldrscolors/bldrscolors.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class PickerTile extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const PickerTile({
    @required this.picker,
    @required this.pickerSelectedSpecs,
    @required this.onDeleteSpec,
    @required this.onSpecTap,
    @required this.onTap,
    this.searchText,
    this.width,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final PickerModel picker;
  final List<SpecModel> pickerSelectedSpecs;
  final Function onTap;
  final Function({@required SpecModel value, @required SpecModel unit}) onSpecTap;
  final Function({@required SpecModel value, @required SpecModel unit}) onDeleteSpec;
  final ValueNotifier<String> searchText;
  final double width;
/// --------------------------------------------------------------------------
  static double height() {
    return 70;
  }
  // --------------------
  static double getDefaultWidth(BuildContext context) {
    final double _specTileWidth = BldrsAppBar.width(context);
    return _specTileWidth;
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _specTileHeight = height();
    final double _specTileWidth = width ?? getDefaultWidth(context);
    const BorderRadius _tileBorders = BldrsAppBar.corners;
    final double _specNameBoxWidth = _specTileWidth - (2 * _specTileHeight);
    // --------------------
    return GestureDetector(
      key: const ValueKey<String>('PickerTile'),
      onTap: onTap,
      child: Center(
        child: Container(
          width: _specTileWidth,
          // height: _specTileHeight,
          margin: const EdgeInsets.only(bottom: Ratioz.appBarPadding),
          decoration: const BoxDecoration(
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
                      icon: phidIcon(context, picker?.chainID),
                      iconSizeFactor: 0.6,
                    ),

                    /// - PICKER NAME
                    SizedBox(
                      width: _specNameBoxWidth,
                      height: _specTileHeight,
                      child: SuperVerse(
                        verse: Verse(
                          text: picker?.chainID,
                          translate: true,
                        ),
                        centered: false,
                        margin: 10,
                        maxLines: 2,
                        redDot: picker?.isRequired,
                        highlight: searchText,
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
              if (pickerSelectedSpecs.isNotEmpty)
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
                        specs: pickerSelectedSpecs,
                        picker: picker,
                        onSpecTap: onSpecTap,
                        onDeleteSpec: onDeleteSpec,
                        xIsOn: true,
                        searchText: searchText,

                      ),

                    ],
                  ),
                ),

            ],
          ),
        ),
      ),
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}
