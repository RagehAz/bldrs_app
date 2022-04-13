import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/a_flyer_starter.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/e_flyer_box.dart';
import 'package:bldrs/b_views/z_components/flyer/c_flyer_groups/flyers_grid.dart';
import 'package:bldrs/b_views/z_components/texting/unfinished_super_verse.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart' as Aligners;
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class SavedFlyersGrid extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SavedFlyersGrid({
    @required this.flyers,
    @required this.selectedFlyers,
    @required this.selectionMode,
    @required this.onSelectFlyer,
    @required this.flyersGridScrollController,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final List<FlyerModel> flyers;
  final List<FlyerModel> selectedFlyers;
  final bool selectionMode;
  final Function onSelectFlyer;
  final ScrollController flyersGridScrollController;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final int _numberOfColumns = FlyersGrid.gridColumnCount(flyers.length);
    const double _spacing = Ratioz.appBarMargin;
    final double _flyerBoxWidth = FlyersGrid.calculateFlyerBoxWidth(
      flyersLength: flyers.length,
      context: context,
    );

    return
      flyers.isEmpty ?
    const SizedBox()
        :
    GridView.builder(
      key: const ValueKey<String>('Saved_Flyers_Grid'),
      itemCount: flyers.length,
      // controller: flyersGridScrollController,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(right: _spacing, left: _spacing, top: _spacing, bottom: Ratioz.horizon),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: _numberOfColumns,
        mainAxisSpacing: _spacing,
        crossAxisSpacing: _spacing,
        childAspectRatio: 1 / Ratioz.xxflyerZoneHeight,
      ),
      itemBuilder: (BuildContext ctx, int index) {

        final FlyerModel _flyer = flyers[index];

        final bool _isSelected = FlyerModel.flyersContainThisID(
          flyers: selectedFlyers,
          flyerID: _flyer.id,
        );

        /// SELECTION MODE FLYER
        return selectionMode == true ?
        GestureDetector(
          key: const ValueKey<String>('saved_flyers_gesture_detector'),
          onTap: () => onSelectFlyer(_flyer),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[

              /// THE FLYER
              AbsorbPointer(
                child: FlyerStarter(
                  key: PageStorageKey<String>('saved_flyer_${_flyer.id}'),
                  heroTag: 'saved_flyer_${_flyer.id}',
                  flyerModel: _flyer,
                  minWidthFactor: FlyersGrid.getFlyerMinWidthFactor(
                      gridFlyerWidth: _flyerBoxWidth,
                      gridZoneWidth: superScreenWidth(context)
                  ),
                )
              ),

              /// BLACK COLOR OVERRIDE
              if (_isSelected == true)
                DreamBox(
                  width: _flyerBoxWidth,
                  height: FlyerBox.height(context, _flyerBoxWidth),
                  color: Colorz.black50,
                  corners: FlyerBox.corners(context, _flyerBoxWidth),
                ),

              /// SELECTED TEXT
              if (_isSelected == true)
                Container(
                  width: _flyerBoxWidth,
                  height: FlyerBox.height(context, _flyerBoxWidth),
                  alignment: Alignment.center,
                  child: SuperVerse(
                    verse: 'SELECTED',
                    weight: VerseWeight.black,
                    italic: true,
                    scaleFactor: _flyerBoxWidth / 100,
                    shadow: true,
                  ),
                ),

              /// CHECK ICON
              if (_isSelected == true)
                Container(
                  width: _flyerBoxWidth,
                  height: FlyerBox.height(context, _flyerBoxWidth),
                  alignment: Aligners.superInverseBottomAlignment(context),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colorz.white20,),
                    borderRadius: FlyerBox.corners(context, _flyerBoxWidth),
                  ),
                  child: DreamBox(
                    height: FlyerBox.bottomCornerValue(_flyerBoxWidth) * 2,
                    width: FlyerBox.bottomCornerValue(_flyerBoxWidth) * 2,
                    corners: FlyerBox.bottomCornerValue(_flyerBoxWidth),
                    color: Colorz.green255,
                    icon: Iconz.check,
                    iconSizeFactor: 0.4,
                    iconColor: Colorz.white255,
                  ),
                ),

            ],
          ),
        )
            :
        /// NORMAL FLYER
        FlyerStarter(
          flyerModel: flyers[index],
          minWidthFactor: FlyersGrid.getFlyerMinWidthFactor(
              gridFlyerWidth: _flyerBoxWidth,
              gridZoneWidth: superScreenWidth(context)
          ),
        );
        },
    );
  }
}
