import 'package:bldrs/b_views/j_flyer/z_components/a_structure/x_flyer_dim.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/images/super_image.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class SlidesShelf extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SlidesShelf({
    @required this.title,
    @required this.pics,
    @required this.onImageTap,
    @required this.onAddButtonOnTap,
    @required this.shelfHeight,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final String title;
  final List<dynamic> pics;
  final Function onImageTap;
  final Function onAddButtonOnTap;
  final double shelfHeight;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    const double _stackTitleHeight = 85;
    const double _flyerNumberTagZoneHeight = 15;
    // --------------------
    final double _stackZoneHeight = shelfHeight - _stackTitleHeight;
    final double _flyerZoneHeight = _stackZoneHeight -
        _flyerNumberTagZoneHeight -
        (Ratioz.appBarPadding * 5);
    // --------------------
    final double _flyerSizeFactor = FlyerDim.flyerFactorByFlyerHeight(context, _flyerZoneHeight);
    final double _flyerZoneWidth = FlyerDim.flyerWidthByFactor(context, _flyerSizeFactor);
    final BorderRadius _flyerBorderRadius = FlyerDim.flyerCorners(context, _flyerZoneWidth);
    final BoxDecoration _flyerDecoration = BoxDecoration(
      borderRadius: _flyerBorderRadius,
      color: Colorz.white10,
    );
    final double _titleZoneHeight = _flyerZoneWidth * 0.5;
    final double _screenWidth = Scale.superScreenWidth(context);
    // --------------------
    return SizedBox(
      width: _screenWidth,
      height: _stackZoneHeight + _titleZoneHeight,
      // color: Colorz.BloodTest,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              width: _screenWidth,
              height: _titleZoneHeight,
              alignment: Aligners.superCenterAlignment(context),
              padding: const EdgeInsets.symmetric(horizontal: Ratioz.appBarPadding),
              child: SuperVerse(
                verse: Verse(
                  text: title,
                  translate: false,
                  casing: Casing.upperCase,
                ),
                size: 4,
                scaleFactor: _flyerSizeFactor * 4,
                weight: VerseWeight.black,
                italic: true,
                shadow: true,
              )),
          Container(
            height: _stackZoneHeight,
            alignment: Aligners.superCenterAlignment(context),
            child: ListView.builder(
              itemCount: pics.length,
              scrollDirection: Axis.horizontal,
              itemExtent: _flyerZoneWidth + Ratioz.appBarPadding * 1.5,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: Ratioz.appBarPadding),
              itemBuilder: (BuildContext ctx, int index) {
                final dynamic _pic = pics[index];

                return Container(
                  margin: const EdgeInsets.only(
                      left: Ratioz.appBarPadding,
                      right: Ratioz.appBarPadding,
                      bottom: Ratioz.appBarPadding),
                  alignment: Alignment.center,
                  child: Column(
                    children: <Widget>[
                      /// PIC NUMBER
                      Container(
                        width: _flyerZoneWidth,
                        height: _flyerNumberTagZoneHeight,
                        // padding: EdgeInsets.symmetric(horizontal: Ratioz.appBarPadding),
                        decoration: BoxDecoration(
                          borderRadius: Borderers.superBorderAll(
                              context, Ratioz.appBarButtonCorner * 0.5),
                          // color: Colorz.WhiteAir,
                        ),
                        alignment: Aligners.superCenterAlignment(context),
                        child: index < pics.length
                            ? SuperVerse(
                          verse: Verse(
                            text: '${index + 1}',
                            translate: false,
                          ),
                          size: 1,
                          color: Colorz.white200,
                          labelColor: Colorz.white10,
                        )
                            : Container(),
                      ),

                      /// SPACER
                      const SizedBox(
                        height: Ratioz.appBarPadding,
                      ),

                      /// IMAGE
                      SizedBox(
                          width: _flyerZoneWidth,
                          height: _flyerZoneHeight,
                          // decoration: _flyerDecoration,
                          child: index < pics.length
                              ?

                          /// IMAGE
                          GestureDetector(
                            onTap: () => onImageTap(index),
                            child: SizedBox(
                              width: _flyerZoneWidth,
                              height: _flyerZoneHeight,
                              child: ClipRRect(
                                borderRadius: _flyerBorderRadius,
                                child: SuperImage(
                                    pic: _pic,
                                    width: _flyerZoneWidth,
                                    height: _flyerZoneHeight),
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
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: <Widget>[
                                  /// PLUS ICON
                                  DreamBox(
                                    height: _flyerZoneWidth * 0.5,
                                    width: _flyerZoneWidth * 0.5,
                                    icon: Iconz.plus,

                                    iconColor: Colorz.white20,
                                    bubble:
                                    false, //() => _getMultiGalleryImages(flyerZoneWidth: _flyerZoneWidth),
                                  ),

                                  SizedBox(
                                    height: _flyerZoneWidth * 0.05,
                                  ),

                                  SizedBox(
                                    width: _flyerZoneWidth * 0.95,
                                    child: const SuperVerse(
                                      verse: Verse(
                                        text: 'phid_add_photos',
                                        translate: true,
                                        casing: Casing.capitalizeFirstChar,
                                      ),
                                      color: Colorz.white20,
                                      maxLines: 2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
    // --------------------
  }
/// --------------------------------------------------------------------------
}
