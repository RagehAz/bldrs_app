import 'package:bldrs/main.dart';
import 'package:bldrs/view_brains/drafters/file_formatters.dart';
import 'package:bldrs/view_brains/localization/localization_constants.dart';
import 'package:bldrs/views/widgets/appbar/buttons/bt_search.dart';
import 'package:bldrs/views/widgets/buttons/bt_rageh.dart';
import 'package:bldrs/views/widgets/flyer/old_flyer_data.dart';
import 'package:bldrs/views/widgets/pyramids/pyramids.dart';
import 'package:bldrs/views/widgets/space/skies/night_sky.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:bldrs/view_brains/drafters/shadowers.dart';
import 'package:websafe_svg/websafe_svg.dart';

final List<FlyerDataz> loadedFlyers = [
  FlyerDataz(
    f01flyerID: 'f_10',
    f02Index: 0,
    f03bzLogo: Iconz.DumBusinessLogo,
    f04bzName: 'Business 04',
    f05bzCity: 'City 04',
    f06bzCountry: 'Country 04',
    f07aPic: Iconz.DumAuthorPic,
    f08aName: 'Author Name 04',
    f09aTitle: 'Author Title 04',
    f10followers: 4000,
    f11followIsOn: false,
    f12galleryCount: 400,
    f13bzFields: ['Bldrs', 'Kick', 'Ass'],
    f17headlines: [' 1', '2', '3', '4', '5', '6', '7', '8', '9', '10'],
    f18pictures: [
      Iconz.DumUniverse,
      Iconz.DumSlide2,
      Iconz.DumUniverse,
      Iconz.DumSlide4,
      Iconz.DumUniverse,
      Iconz.DumSlide2,
      Iconz.DumUniverse,
      Iconz.DumSlide4,
      Iconz.DumUniverse,
      Iconz.DumSlide2
    ],
    f20shares: [9000, 9100, 9200, 9300, 9400, 9500, 9600, 9700, 9800, 555],
    f21views: [9000, 9100, 9200, 9300, 9400, 9500, 9600, 9700, 9800, 555],
    f22saves: [9000, 9100, 9200, 9300, 9400, 9500, 9600, 9700, 9800, 555],
    f23ankhsOn: [
      false,
      false,
      true,
      true,
      true,
      true,
      false,
      false,
      false,
      true
    ],
    phoneNumber: '01554555107',
  ),
];

class HeroTestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    double flyerZoneWidth = screenWidth;
    double flyerTopCorners = screenHeight * Ratioz.rrFlyerTopCorners;
    double flyerBottomCorners = screenHeight * Ratioz.rrFlyerBottomCorners;

    // int flyerIndex = 0;
// -------------------------------------------------------------------------
//     final List<FlyerData> loadedFlyers = [
//     FlyerData(
//       f01flyerID: 'f_10',
//       f02Index: 1,
//       f03bzLogo: Iconz.DumBusinessLogo,
//       f04bzName: 'Business 04',
//       f05bzCity: 'City 04',
//       f06bzCountry: 'Country 04',
//       f07aPic: Iconz.DumAuthorPic,
//       f08aName: 'Author Name 04',
//       f09aTitle: 'Author Title 04',
//       f10followers: 4000,
//       f11followIsOn: false,
//       f12galleryCount: 400,
//       f13bzFields: ['Bldrs', 'Kick', 'Ass'],
//       f17headlines: [' 1', '2', '3', '4', '5', '6', '7', '8', '9', '10'],
//       f18pictures: [Iconz.DumUniverse, Iconz.DumSlide2,Iconz.DumUniverse, Iconz.DumSlide4,Iconz.DumUniverse, Iconz.DumSlide2,Iconz.DumUniverse, Iconz.DumSlide4, Iconz.DumUniverse, Iconz.DumSlide2],
//       f20shares: [9000, 9100, 9200, 9300, 9400, 9500, 9600, 9700, 9800, 555],
//       f21views: [9000, 9100, 9200, 9300, 9400, 9500, 9600, 9700, 9800, 555],
//       f22saves: [9000, 9100, 9200, 9300, 9400, 9500, 9600, 9700, 9800, 555],
//       f23ankhsOn: [false, false, true, true, true, true, false, false, false, true],
//     ),
//     ];

    return SafeArea(
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: [
            NightSky(),
            ListView(

              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[

                  // --- HERO TEST
                  // Center(
                  //   child: Hero(
                  //     tag: 'flyerzzz',
                  //     child: GestureDetector(
                  //       onTap: () {
                  //         Navigator.push(
                  //             context,
                  //             PageRouteBuilder(
                  //                 transitionDuration: Duration(milliseconds: 800),
                  //                 pageBuilder: (_, __, ___) =>
                  //                     _getExpandedFlyer(context)));
                  //       },
                  //       child: DreamBox(
                  //         color: Colorz.White,
                  //         corners: 10,
                  //         width: 100,
                  //         height: 100,
                  //       ),
                  //     ),
                  //
                  //     // Flyer(
                  //     //   flyerSizeFactor: 0.25,
                  //     //   id: loadedFlyers[0].f01flyerID,
                  //     //   bLogo: loadedFlyers[0].f03bzLogo,
                  //     //   bName: loadedFlyers[0].f04bzName,
                  //     //   bCity: loadedFlyers[0].f05bzCity,
                  //     //   bCountry: loadedFlyers[0].f06bzCountry,
                  //     //   aPic: loadedFlyers[0].f07aPic,
                  //     //   aName: loadedFlyers[0].f08aName,
                  //     //   aTitle: loadedFlyers[0].f09aTitle,
                  //     //   followers: loadedFlyers[0].f10followers,
                  //     //   followingOn: loadedFlyers[0].f11followIsOn,
                  //     //   galleryCount: loadedFlyers[0].f12galleryCount,
                  //     //   headlines: loadedFlyers[0].f17headlines,
                  //     //   pictures: loadedFlyers[0].f18pictures,
                  //     //   shares: loadedFlyers[0].f20shares,
                  //     //   views: loadedFlyers[0].f21views,
                  //     //   saves: loadedFlyers[0].f22saves,
                  //     //   ankhsOn: loadedFlyers[0].f23ankhsOn,
                  //     //   slidingIsOn: false,
                  //     //   tappingMiniFlyer: (){
                  //     //     Navigator.push(context, PageRouteBuilder(
                  //     //       pageBuilder: (_,__,___) => _getExpandedFlyer(context)
                  //     //     ));
                  //     //   },
                  //     // ),
                  //   ),
                  // ),

                  SizedBox(
                    width: 100,
                    height: 100,
                  ),

                  // // --- THE NEW DREAMBOX
                  // NewDreamBox(
                  //   verse: 'I will finish this app in October 7alawa ya 7alawaazz, jdjdj',
                  //   color: Colorz.YellowSmoke,
                  //   icon: Iconz.DumAuthorPic,
                  // ),

                  SizedBox(
                    width: 100,
                    height: 100,
                  ),

                  NewDreamBox(
                    // width: 380,
                    height: 40,
                    verse: 'Open Business account ya man',
                    verseColor: Colorz.White,
                    // corners: 10,
                    color: Colorz.BlackPlastic,
                    icon: Iconz.Bz,
                    iconSizeFactor: 0.7,
                    blackAndWhite: false,

                  ),

                  SizedBox(
                    width: 10,
                    height: 10,
                  ),

                  NewDreamBox(
                    // width: 230,
                    height: 40,
                    icon: Iconz.DumAuthorPic,
                    verse: 'Rageh El Azzazy',
                    iconSizeFactor: 1,
                    bubble: true,
                    color: Colorz.WhiteAir,
                    blackAndWhite: true,
                  ),

                  SizedBox(
                    width: 10,
                    height: 10,
                  ),

                  NewDreamBox(
                    height: 50,
                    // width: 300,
                    verse: 'Thing of the things',
                    iconSizeFactor: 0.9,
                    // icon: Iconz.DvGouran,
                    color: Colorz.BabyBlue,
                    blackAndWhite: true,
                    bubble: true,
                  ),

                  NewDreamBox(
                    width: 100,
                    height: 100,
                    icon: Iconz.DumUniverse,
                  ),

                  Center(child: BtSearch(

                  )),

                  NewDreamBox(
                    width: 150,
                    height: 35,
                    // corners: 0,
                    verse: 'Open A Bldr account ya man ya brengyyyyyy ',
                    verseColor: Colorz.White,
                    boxMargins: EdgeInsets.all(10),
                    color: Colorz.BabyBlueSmoke,
                    icon: Iconz.Bz,
                    iconSizeFactor: 0.6,
                    boxFunction: (){},
                    // image: Iconz.DumAuthorPic,
                  ),



                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      // verticalDirection: ver,
                      children: [
                    IntrinsicWidth(
                      child: Container(
                        // width: 100,
                        color: Colorz.BlackSmoke,
                        padding: EdgeInsets.all(10),
                        child: Stack(
                          children: [

                            Container(
                              // width: double.minPositive,
                              height: 20,
                              color: Colorz.Yellow,
                            ),

                            Container(
                              width: 150,
                              child: SuperVerse(
                                verse: 'testing testing testing testing ',
                                maxLines: 1,
                                designMode: true,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                      ],
                    ),

                ],
              )
              ],
            ),
            Pyramids(
              whichPyramid: Iconz.PyramidzYellow,
            ),
            Rageh(
              tappingRageh:
                  getTranslated(context, 'Active_Language') == 'Arabic'
                      ? () async {
                          Locale temp = await setLocale('en');
                          BldrsApp.setLocale(context, temp);
                        }
                      : () async {
                          Locale temp = await setLocale('ar');
                          BldrsApp.setLocale(context, temp);
                        },
              doubleTappingRageh: () {
                print(flyerZoneWidth);
                print(flyerTopCorners);
                print(flyerBottomCorners);
                print(screenHeight);
                print(flyerBottomCorners);
                print(Ratioz.rrFlyerTopCorners);
                print(0);
                print(((Ratioz.rrFlyerTopCorners) * screenHeight) /
                    flyerZoneWidth);
                print(((Ratioz.rrFlyerBottomCorners) * screenHeight) /
                    flyerZoneWidth);
              },
            ),
          ],
        ),
      ),
    );
  }
}

// _getExpandedFlyer(context) {
//   return SafeArea(
//     child: Scaffold(
//       body: Stack(
//         alignment: Alignment.center,
//         children: [
//           NightSky(),
//           Center(
//             child: Hero(
//               tag: 'flyerzzz',
//               child: GestureDetector(
//                 onTap: () {
//                   Navigator.pop(context);
//                 },
//                 child: DreamBox(
//                   color: Colorz.White,
//                   corners: 10,
//                   width: 200,
//                   height: 200,
//                 ),
//               ),
//
//               // Flyer(
//               //   flyerSizeFactor: 0.8,
//               //   id: loadedFlyers[0].f01flyerID,
//               //   bLogo: loadedFlyers[0].f03bzLogo,
//               //   bName: loadedFlyers[0].f04bzName,
//               //   bCity: loadedFlyers[0].f05bzCity,
//               //   bCountry: loadedFlyers[0].f06bzCountry,
//               //   aPic: loadedFlyers[0].f07aPic,
//               //   aName: loadedFlyers[0].f08aName,
//               //   aTitle: loadedFlyers[0].f09aTitle,
//               //   followers: loadedFlyers[0].f10followers,
//               //   followingOn: loadedFlyers[0].f11followIsOn,
//               //   galleryCount: loadedFlyers[0].f12galleryCount,
//               //   headlines: loadedFlyers[0].f17headlines,
//               //   pictures: loadedFlyers[0].f18pictures,
//               //   shares: loadedFlyers[0].f20shares,
//               //   views: loadedFlyers[0].f21views,
//               //   saves: loadedFlyers[0].f22saves,
//               //   ankhsOn: loadedFlyers[0].f23ankhsOn,
//               //   slidingIsOn: false,
//               //   tappingMiniFlyer: () {
//               //     Navigator.pop(context);
//               //     print('ana kbeer');
//               //   },
//               // ),
//             ),
//           ),
//           Pyramids(
//             whichPyramid: Iconz.PyramidzYellow,
//           ),
//           Rageh(
//             tappingRageh: getTranslated(context, 'Active_Language') == 'Arabic'
//                 ? () async {
//                     Locale temp = await setLocale('en');
//                     BldrsApp.setLocale(context, temp);
//                   }
//                 : () async {
//                     Locale temp = await setLocale('ar');
//                     BldrsApp.setLocale(context, temp);
//                   },
//             doubleTappingRageh: () {},
//           ),
//         ],
//       ),
//     ),
//   );
// }

class NewDreamBox extends StatelessWidget {
  final String icon;
  /// works as a verseSizeFactor as well
  final double iconSizeFactor;
  final Color color;
  final double width;
  final double height;
  final double corners;
  final Color iconColor;
  final String verse;
  final Color verseColor;
  final Function boxFunction;
  final EdgeInsets boxMargins;
  final bool blackAndWhite;
  final bool iconRounded;
  final bool bubble;

  NewDreamBox({
    @required this.height,
    this.width,
    this.icon,
    this.iconSizeFactor = 1,
    this.color = Colorz.Nothing,
    this.corners = Ratioz.ddBoxCorner *1.5,
    this.iconColor,
    this.verse,
    this.verseColor = Colorz.White,
    this.boxFunction,
    this.boxMargins,
    this.blackAndWhite = false,
    this.iconRounded = true,
    this.bubble = true,
  });

  @override
  Widget build(BuildContext context) {

    double sizeFactor = iconSizeFactor;

    // double boxWidth = width ;
    double boxHeight = height ;

    Color imageSaturationColor =
    blackAndWhite == true ? Colorz.Grey : Colorz.Nothing;


    double verseIconSpacing = verse != null ? height * 0.3 : 0;

    double svgGraphicWidth = height * sizeFactor;
    double jpgGraphicWidth = height * sizeFactor;
    double graphicWidth = icon == null ? 0 :
    fileExtensionOf(icon) == 'svg' ? svgGraphicWidth :
    fileExtensionOf(icon) == 'jpg' ||
        fileExtensionOf(icon) == 'jpeg' ||
        fileExtensionOf(icon) == 'png' ? jpgGraphicWidth : height;

    double iconMargin = verse == null ? 0 : (height - graphicWidth)/2;

    double verseWidth = width != null ? width - (iconMargin * 2) - graphicWidth - (verseIconSpacing * 2) : width;

    int verseSize =  iconSizeFactor == 1 ? 4 : 4;

    double iconCorners = iconRounded == true ? (corners-iconMargin) : 0;

    Color boxColor =
    (blackAndWhite == true && color != Colorz.Nothing) ?
    Colorz.GreySmoke :
    (color == Colorz.Nothing && blackAndWhite == true) ?
    Colorz.Nothing :
    color;

    Color _iconColor = blackAndWhite == true ? Colorz.WhiteSmoke : iconColor;

    return GestureDetector(
      onTap: boxFunction,

      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[

          IntrinsicWidth(
            child: Container(
              width: width,
              height: boxHeight,
              alignment: Alignment.center,
              margin: boxMargins,
              decoration: BoxDecoration(
                  color: boxColor,
                  borderRadius: BorderRadius.circular(corners),
                  boxShadow: [
                    CustomBoxShadow(
                        color: bubble == true ? Colorz.BlackLingerie : Colorz.Nothing,
                        offset: new Offset(0, height * -0.019 * 0 ),
                        blurRadius: height * 0.15,
                        blurStyle: BlurStyle.outer),
                  ]),

              child: ClipRRect(
                borderRadius: BorderRadius.circular(corners),

                child: Stack(
                  alignment: Alignment.center,
                  children: [

                    Row(
                      mainAxisAlignment: verse != null ? MainAxisAlignment.start : MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[

                        // --- ICON
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            icon == null || icon == '' ?
                            Container()
                                :
                            fileExtensionOf(icon) == 'svg' ?
                            Padding(
                              padding: EdgeInsets.all(iconMargin),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.all(Radius.circular(iconCorners)),
                                  child: WebsafeSvg.asset(icon, color: _iconColor, height: svgGraphicWidth, fit: BoxFit.cover)),
                            )
                                :
                            fileExtensionOf(icon) == 'jpg' || fileExtensionOf(icon) == 'jpeg' || fileExtensionOf(icon) == 'png' ?
                            Container(
                              width: jpgGraphicWidth,
                              height: jpgGraphicWidth,
                              margin: EdgeInsets.all(iconMargin),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(iconCorners)),
                                  boxShadow: [
                                    CustomBoxShadow(
                                        color: bubble == true ? Colorz.BlackLingerie : Colorz.Nothing,
                                        offset: new Offset(0, jpgGraphicWidth * -0.019 ),
                                        blurRadius: jpgGraphicWidth * 0.2,
                                        blurStyle: BlurStyle.outer),
                                  ]
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(iconCorners)),
                                child: ColorFiltered(
                                  colorFilter: ColorFilter.mode(
                                      imageSaturationColor,
                                      BlendMode.saturation),
                                  child: Container(
                                    width: jpgGraphicWidth,
                                    height: jpgGraphicWidth,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(image: AssetImage(icon), fit: BoxFit.cover),
                                    ),
                                  ),
                                ),),
                            ) : Container(),

                            // --- BUTTON BLACK LAYER IF GREYED OUT
                            blackAndWhite == true && icon != null && fileExtensionOf(icon) != 'svg'?
                            Container(
                              height: jpgGraphicWidth,
                              width: jpgGraphicWidth,
                              decoration: BoxDecoration(
                                // color: Colorz.Yellow,
                                borderRadius: BorderRadius.circular(iconCorners),
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [Colorz.BlackSmoke, Colorz.BlackPlastic],
                                    stops: [0.5, 1]),
                              ),
                            ) : Container(),

                          ],
                        ),

                        // --- SPACING
                        SizedBox(
                          width: iconSizeFactor != 1 && icon != null ? verseIconSpacing * 0.25 : verseIconSpacing,
                          height: height,
                        ),

                        // --- VERSE
                        verse == null ? Container() :
                        Container(
                          height: height,
                          width: verseWidth,

                          child: SuperVerse(
                            verse: verse,
                            size: verseSize,
                            weight: VerseWeight.bold,
                            color: blackAndWhite == true ? Colorz.WhiteSmoke : verseColor,
                            shadow: blackAndWhite == true ? false : true,
                            maxLines: 1,
                            designMode: false,
                            centered: icon == null ? true : false,
                            scaleFactor: iconSizeFactor,
                          ),
                        ),

                        // --- SPACING
                        SizedBox(
                          width: verseIconSpacing,
                          height: height,
                        ),
                      ],
                    ),

                    // --- BOX HIGHLIGHT
                    bubble == false ? Container() :
                    Container(
                      width: width,
                      height: height * 0.27,
                      decoration: BoxDecoration(
                        // color: Colorz.White,
                          borderRadius: BorderRadius.circular(
                              corners - (height * 0.8) ),
                          boxShadow: [
                            CustomBoxShadow(
                                color: Colorz.WhiteZircon,
                                offset: new Offset(0, height * -0.33),
                                blurRadius: height * 0.2,
                                blurStyle: BlurStyle.normal),
                          ]),
                    ),

                    // --- BOX GRADIENT
                    bubble == false ? Container() :
                    Container(
                      height: height,
                      width: width,
                      decoration: BoxDecoration(
                        // color: Colorz.Grey,
                        borderRadius: BorderRadius.circular(corners),
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colorz.BlackNothing, Colorz.BlackPlastic],
                            stops: [0.5, 0.95]),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}

