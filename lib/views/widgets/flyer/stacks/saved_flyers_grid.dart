import 'package:bldrs/controllers/drafters/aligners.dart';
import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/scrollers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/flyer/tiny_flyer.dart';
import 'package:bldrs/views/widgets/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/flyer/final_flyer.dart';
import 'package:bldrs/views/widgets/flyer/parts/flyer_zone_box.dart';
import 'package:bldrs/views/widgets/flyer/stacks/gallery_grid.dart';
import 'package:bldrs/views/widgets/flyer/stacks/sliver_flyers_grid.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

class SavedFlyersGrid extends StatelessWidget {
  final List<TinyFlyer> tinyFlyers;
  final List<TinyFlyer> selectedTinyFlyers;
  final bool selectionMode;
  final Function onSelectFlyer;

  const SavedFlyersGrid({
    @required this.tinyFlyers,
    @required this.selectedTinyFlyers,
    @required this.selectionMode,
    @required this.onSelectFlyer,
  });

  @override
  Widget build(BuildContext context) {

    int _numberOfColumns = GalleryGrid.gridColumnCount(tinyFlyers.length);
    double _spacing = SliverFlyersGrid.spacing;

    double _flyerBoxWidth = SliverFlyersGrid.calculateFlyerBoxWidth(
      flyersLength: tinyFlyers.length,
      context: context,
    );


    return
      tinyFlyers.length == 0 ? Container() :
      Scroller(
        child: GridView.builder(
          itemCount: tinyFlyers.length,
          physics: const BouncingScrollPhysics(),
          shrinkWrap: false,
          padding: EdgeInsets.all(_spacing),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: _numberOfColumns,
            mainAxisSpacing: _spacing,
            crossAxisSpacing: _spacing,
            childAspectRatio: 1  / Ratioz.xxflyerZoneHeight,
          ),
          itemBuilder: (ctx, index){

            bool _isSelected = TinyFlyer.tinyFlyersContainThisID(
              tinyFlyers: selectedTinyFlyers,
              flyerID: tinyFlyers[index].flyerID,
            );


            return

              selectionMode == true ?
              GestureDetector(
                onTap: () => onSelectFlyer(tinyFlyers[index]),
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[

                    AbsorbPointer(
                      absorbing:  true,
                      child: FinalFlyer(
                        flyerBoxWidth: _flyerBoxWidth,
                        tinyFlyer: tinyFlyers[index],
                        inEditor: false,
                        goesToEditor: false,
                        initialSlideIndex: tinyFlyers[index].slideIndex,
                      ),
                    ),

                    if(_isSelected == true)
                      DreamBox(
                        width: _flyerBoxWidth,
                        height: FlyerBox.height(context, _flyerBoxWidth),
                        color: Colorz.Black50,
                        corners: Borderers.superFlyerCorners(context, _flyerBoxWidth),
                        bubble: true,
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
                          color: Colorz.White255,
                          size: 2,
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
                          border: Border.all(width: 1, color: Colorz.White20,),
                          borderRadius: Borderers.superFlyerCorners(context, _flyerBoxWidth),
                        ),
                        child: DreamBox(
                          height: FlyerBox.bottomCornerValue(_flyerBoxWidth) * 2,
                          width: FlyerBox.bottomCornerValue(_flyerBoxWidth) * 2,
                          corners: FlyerBox.bottomCornerValue(_flyerBoxWidth),
                          color: Colorz.Green255,
                          icon: Iconz.Check,
                          iconSizeFactor: 0.4,
                          iconColor: Colorz.White255,
                        ),
                      ),


                  ],
                ),
              )

                  :

              FinalFlyer(
                flyerBoxWidth: _flyerBoxWidth,
                tinyFlyer: tinyFlyers[index],
                inEditor: false,
                goesToEditor: false,
                initialSlideIndex: tinyFlyers[index].slideIndex,
              );

          },
        ),
      );

  }
}