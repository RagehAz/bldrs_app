import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/b_views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/widgets/general/layouts/navigation/scroller.dart';
import 'package:bldrs/b_views/widgets/general/textings/super_verse.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/final_flyer.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/flyer_zone_box.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/stacks/gallery_grid.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/stacks/sliver_flyers_grid.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart' as Aligners;
import 'package:bldrs/f_helpers/drafters/borderers.dart' as Borderers;
import 'package:bldrs/f_helpers/drafters/sliders.dart' as Sliders;
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
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final List<FlyerModel> flyers;
  final List<FlyerModel> selectedFlyers;
  final bool selectionMode;
  final Function onSelectFlyer;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final int _numberOfColumns = GalleryGrid.gridColumnCount(flyers.length);
    const double _spacing = SliverFlyersGrid.spacing;

    final double _flyerBoxWidth = SliverFlyersGrid.calculateFlyerBoxWidth(
      flyersLength: flyers.length,
      context: context,
    );

    return flyers.isEmpty ?
    Container()
        :
    Scroller(
      child: GridView.builder(
        itemCount: flyers.length,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(right: _spacing, left: _spacing, top: _spacing, bottom: Ratioz.horizon),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: _numberOfColumns,
          mainAxisSpacing: _spacing,
          crossAxisSpacing: _spacing,
          childAspectRatio: 1 / Ratioz.xxflyerZoneHeight,
        ),
        itemBuilder: (BuildContext ctx, int index) {

          final bool _isSelected = FlyerModel.flyersContainThisID(
            flyers: selectedFlyers,
            flyerID: flyers[index].id,
          );

          /// SELECTION MODE FLYER
          return selectionMode == true ?
          GestureDetector(
            onTap: () => onSelectFlyer(flyers[index]),
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[

                /// THE FLYER
                AbsorbPointer(
                  child: FinalFlyer(
                    flyerBoxWidth: _flyerBoxWidth,
                    flyerModel: flyers[index],
                    onSwipeFlyer:
                        (Sliders.SwipeDirection direction) {
                      // print('Direction is ${direction}');
                        },
                  ),
                ),

                /// BLACK COLOR OVERRIDE
                if (_isSelected == true)
                  DreamBox(
                    width: _flyerBoxWidth,
                    height: OldFlyerBox.height(context, _flyerBoxWidth),
                    color: Colorz.black50,
                    corners: Borderers.superFlyerCorners(context, _flyerBoxWidth),
                  ),

                /// SELECTED TEXT
                if (_isSelected == true)
                  Container(
                    width: _flyerBoxWidth,
                    height:
                    OldFlyerBox.height(context, _flyerBoxWidth),
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
                    height: OldFlyerBox.height(context, _flyerBoxWidth),
                    alignment: Aligners.superInverseBottomAlignment(context),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colorz.white20,),
                      borderRadius: Borderers.superFlyerCorners(context, _flyerBoxWidth),
                    ),
                    child: DreamBox(
                      height: OldFlyerBox.bottomCornerValue(_flyerBoxWidth) * 2,
                      width: OldFlyerBox.bottomCornerValue(_flyerBoxWidth) * 2,
                      corners: OldFlyerBox.bottomCornerValue(_flyerBoxWidth),
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
          FinalFlyer(
            flyerBoxWidth: _flyerBoxWidth,
            flyerModel: flyers[index],
            onSwipeFlyer: (Sliders.SwipeDirection direction) {
              // print('Direction is ${direction}');
            },
          );
          },
      ),
    );
  }
}
