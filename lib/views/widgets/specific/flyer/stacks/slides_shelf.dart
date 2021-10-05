
import 'package:bldrs/controllers/drafters/aligners.dart';
import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/imagers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:bldrs/views/widgets/specific/flyer/parts/flyer_zone_box.dart';
import 'package:flutter/material.dart';

class SlidesShelf extends StatelessWidget {
  final String title;
  final List<dynamic> pics;
  final Function onImageTap;
  final Function onAddButtonOnTap;
  final double shelfHeight;

  const SlidesShelf({
    @required this.title,
    @required this.pics,
    @required this.onImageTap,
    @required this.onAddButtonOnTap,
    @required this.shelfHeight,
});

  @override
  Widget build(BuildContext context) {

    const double _stackTitleHeight = 85;
    const double _flyerNumberTagZoneHeight = 15;

    final double _stackZoneHeight = shelfHeight - _stackTitleHeight;
    final double _flyerZoneHeight = _stackZoneHeight - _flyerNumberTagZoneHeight - (Ratioz.appBarPadding * 5);

    final double _flyerSizeFactor = FlyerBox.sizeFactorByHeight(context, _flyerZoneHeight);
    final double _flyerZoneWidth = FlyerBox.width(context, _flyerSizeFactor);
    final BorderRadius _flyerBorderRadius = Borderers.superFlyerCorners(context, _flyerZoneWidth);
    final BoxDecoration _flyerDecoration = BoxDecoration(
      borderRadius: _flyerBorderRadius,
      color: Colorz.White10,
    );


    return
      Container(
        width: Scale.superScreenWidth(context),
        height: _stackZoneHeight,
        // color: Colorz.BloodTest,
        alignment: Aligners.superCenterAlignment(context),
        child: ListView.builder(
          itemCount: pics.length,
          scrollDirection: Axis.horizontal,
          itemExtent: _flyerZoneWidth + Ratioz.appBarPadding* 1.5,
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: Ratioz.appBarPadding),
          addAutomaticKeepAlives: true,
          itemBuilder: (ctx, index){

            final dynamic _pic = pics[index];

            return
              Container(
                margin: EdgeInsets.only(left: Ratioz.appBarPadding, right: Ratioz.appBarPadding, bottom: Ratioz.appBarPadding),
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[

                    /// PIC NUMBER
                    Container(
                      width: _flyerZoneWidth,
                      height: _flyerNumberTagZoneHeight,
                      // padding: EdgeInsets.symmetric(horizontal: Ratioz.appBarPadding),
                      decoration: BoxDecoration(
                        borderRadius: Borderers.superBorderAll(context, Ratioz.appBarButtonCorner * 0.5),
                        // color: Colorz.WhiteAir,
                      ),
                      alignment: Aligners.superCenterAlignment(context),
                      child:
                      index < pics.length ?
                      SuperVerse(
                        verse: '${index + 1}',
                        size: 1,
                        color: Colorz.White200,
                        labelColor: Colorz.White10,
                      ) : Container(),
                    ),

                    /// SPACER
                    SizedBox(
                      height: Ratioz.appBarPadding,
                    ),

                    /// IMAGE
                    Container(
                        width: _flyerZoneWidth,
                        height: _flyerZoneHeight,
                        // decoration: _flyerDecoration,
                        child:
                        index < pics.length ?

                        /// IMAGE
                        GestureDetector(
                          onTap: () => onImageTap(index),
                          child: Container(
                            width: _flyerZoneWidth,
                            height: _flyerZoneHeight,
                            child: ClipRRect(
                              borderRadius: _flyerBorderRadius,
                              child:
                              Imagers.superImageWidget(_pic, width: _flyerZoneWidth, height: _flyerZoneHeight),
                            ),
                          ),
                        )

                            :

                        /// ADD IMAGE BUTTON
                        GestureDetector(
                          onTap: () => onAddButtonOnTap(_pic),
                          child: Container(
                            width: _flyerZoneWidth,
                            height: _flyerZoneHeight,
                            decoration: _flyerDecoration,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[

                                /// PLUS ICON
                                DreamBox(
                                  height: _flyerZoneWidth * 0.5,
                                  width: _flyerZoneWidth * 0.5,
                                  icon: Iconz.Plus,

                                  iconColor: Colorz.White20,
                                  bubble: false,
                                  onTap: null,//() => _getMultiGalleryImages(flyerZoneWidth: _flyerZoneWidth),
                                ),

                                SizedBox(
                                  height: _flyerZoneWidth * 0.05,
                                ),

                                Container(
                                  width: _flyerZoneWidth * 0.95,
                                  child: SuperVerse(
                                    verse: 'Add Photos',
                                    size: 2,
                                    color: Colorz.White20,
                                    maxLines: 2,
                                  ),
                                ),

                              ],
                            ),
                          ),
                        )

                    ),

                  ],
                ),
              );



          },
        ),
      );

  }
}
