import 'package:bldrs/controllers/drafters/aligners.dart' as Aligners;
import 'package:bldrs/controllers/drafters/borderers.dart' as Borderers;
import 'package:bldrs/controllers/drafters/sliders.dart' as Sliders;
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart' as Iconz;
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/flyer/flyer_model.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/layouts/navigation/scroller.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:bldrs/views/widgets/specific/flyer/final_flyer.dart';
import 'package:bldrs/views/widgets/specific/flyer/parts/flyer_zone_box.dart';
import 'package:bldrs/views/widgets/specific/flyer/stacks/gallery_grid.dart';
import 'package:bldrs/views/widgets/specific/flyer/stacks/sliver_flyers_grid.dart';
import 'package:flutter/material.dart';

class SavedFlyersGrid extends StatelessWidget {
  final List<FlyerModel> flyers;
  final List<FlyerModel> selectedFlyers;
  final bool selectionMode;
  final Function onSelectFlyer;

  const SavedFlyersGrid({
    @required this.flyers,
    @required this.selectedFlyers,
    @required this.selectionMode,
    @required this.onSelectFlyer,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final int _numberOfColumns = GalleryGrid.gridColumnCount(flyers.length);
    const double _spacing = SliverFlyersGrid.spacing;

    final double _flyerBoxWidth = SliverFlyersGrid.calculateFlyerBoxWidth(
      flyersLength: flyers.length,
      context: context,
    );

    return
      flyers.length == 0 ? Container() :
      Scroller(
        child: GridView.builder(
          itemCount: flyers.length,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(_spacing),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: _numberOfColumns,
            mainAxisSpacing: _spacing,
            crossAxisSpacing: _spacing,
            childAspectRatio: 1  / Ratioz.xxflyerZoneHeight,
          ),
          itemBuilder: (BuildContext ctx, int index){

            final bool _isSelected = FlyerModel.flyersContainThisID(
              flyers: selectedFlyers,
              flyerID: flyers[index].id,
            );


            return

              selectionMode == true ?
              GestureDetector(
                onTap: () => onSelectFlyer(flyers[index]),
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[

                    AbsorbPointer(
                      child: FinalFlyer(
                        flyerBoxWidth: _flyerBoxWidth,
                        flyerModel: flyers[index],
                        onSwipeFlyer: (Sliders.SwipeDirection direction){
                          // print('Direction is ${direction}');
                        },
                      ),
                    ),

                    if(_isSelected == true)
                      DreamBox(
                        width: _flyerBoxWidth,
                        height: FlyerBox.height(context, _flyerBoxWidth),
                        color: Colorz.black50,
                        corners: Borderers.superFlyerCorners(context, _flyerBoxWidth),
                      ),

                    if(_isSelected == true)
                      Container(
                        width: _flyerBoxWidth,
                        height: FlyerBox.height(context, _flyerBoxWidth),
                        alignment: Alignment.center,
                        child: SuperVerse(
                          verse: 'SELECTED',
                          weight: VerseWeight.black,
                          italic: true,
                          scaleFactor: _flyerBoxWidth/100,
                          shadow: true,
                        ),
                      ),

                    if(_isSelected == true)
                      Container(
                        width: _flyerBoxWidth,
                        height: FlyerBox.height(context, _flyerBoxWidth),
                        alignment: Aligners.superInverseBottomAlignment(context),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colorz.white20,),
                          borderRadius: Borderers.superFlyerCorners(context, _flyerBoxWidth),
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

              FinalFlyer(
                flyerBoxWidth: _flyerBoxWidth,
                flyerModel: flyers[index],
                onSwipeFlyer: (Sliders.SwipeDirection direction){
                  // print('Direction is ${direction}');
                },
              );

          },
        ),
      );

  }
}
