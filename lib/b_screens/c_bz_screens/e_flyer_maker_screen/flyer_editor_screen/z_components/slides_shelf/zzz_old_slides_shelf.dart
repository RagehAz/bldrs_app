import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/helpers/space/borderers.dart';
import 'package:bldrs/flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/z_components/images/bldrs_image.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/f_helpers/drafters/bldrs_aligners.dart';
import 'package:flutter/material.dart';
import 'package:basics/helpers/space/scale.dart';

class OldSlidesShelf extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const OldSlidesShelf({
    required this.title,
    required this.pics,
    required this.onImageTap,
    required this.onAddButtonOnTap,
    required this.shelfHeight,
    super.key
  });
  /// --------------------------------------------------------------------------
  final String title;
  final List<dynamic> pics;
  final Function onImageTap;
  final Function onAddButtonOnTap;
  final double shelfHeight;
  /// --------------------------------------------------------------------------
  static const double _stackTitleHeight = 85;
  static const double _flyerNumberTagZoneHeight = 15;
  // --------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _screenWidth = Scale.screenWidth(context);
    // --------------------
    final double _stackZoneHeight = shelfHeight - _stackTitleHeight;
    // --------------------
    final double _flyerZoneHeight = _stackZoneHeight -
        _flyerNumberTagZoneHeight -
        (Ratioz.appBarPadding * 5);
    // --------------------
    final double _flyerSizeFactor = FlyerDim.flyerFactorByFlyerHeight(
      flyerBoxHeight: _flyerZoneHeight,
      gridWidth: _screenWidth,
    );
    final double _flyerZoneWidth = FlyerDim.flyerWidthByFactor(
      flyerSizeFactor: _flyerSizeFactor,
      gridWidth: _screenWidth,
    );
    final BorderRadius _flyerBorderRadius = FlyerDim.flyerCorners(_flyerZoneWidth);
    final double _titleZoneHeight = _flyerZoneWidth * 0.5;
    // --------------------
    return SizedBox(
      width: _screenWidth,
      height: _stackZoneHeight + _titleZoneHeight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          /// SHELF TITLE
          Container(
              width: _screenWidth,
              height: _titleZoneHeight,
              alignment: BldrsAligners.superCenterAlignment(context),
              padding: const EdgeInsets.symmetric(horizontal: Ratioz.appBarPadding),
              child: BldrsText(
                verse: Verse(
                  id: title,
                  translate: false,
                  casing: Casing.upperCase,
                ),
                size: 4,
                scaleFactor: _flyerSizeFactor * 4,
                weight: VerseWeight.black,
                italic: true,
                shadow: true,
              )),

          /// SHELF SLIDES
          Container(
            height: _stackZoneHeight,
            alignment: BldrsAligners.superCenterAlignment(context),
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
                      bottom: Ratioz.appBarPadding,
                  ),
                  alignment: Alignment.center,
                  child: Column(
                    children: <Widget>[

                      /// PIC NUMBER
                      Container(
                        width: _flyerZoneWidth,
                        height: _flyerNumberTagZoneHeight,
                        // padding: EdgeInsets.symmetric(horizontal: Ratioz.appBarPadding),
                        decoration: BoxDecoration(
                          borderRadius: Borderers.cornerAll(Ratioz.appBarButtonCorner * 0.5),
                          // color: Colorz.WhiteAir,
                        ),
                        alignment: BldrsAligners.superCenterAlignment(context),
                        child: index < pics.length
                            ? BldrsText(
                          verse: Verse(
                            id: '${index + 1}',
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
                          child: index < pics.length ?

                          /// IMAGE
                          GestureDetector(
                            onTap: () => onImageTap(index),
                            child: SizedBox(
                              width: _flyerZoneWidth,
                              height: _flyerZoneHeight,
                              child: ClipRRect(
                                borderRadius: _flyerBorderRadius,
                                child: BldrsImage(
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
                              decoration: BoxDecoration(
                                borderRadius: _flyerBorderRadius,
                                color: Colorz.white10,
                              ),
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: <Widget>[
                                  /// PLUS ICON
                                  BldrsBox(
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
                                    child: const BldrsText(
                                      verse: Verse(
                                        id: 'phid_add_photos',
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
                          )

                      ),

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
