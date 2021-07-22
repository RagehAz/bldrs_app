import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/streamerz.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/tiny_models/tiny_bz.dart';
import 'package:bldrs/models/tiny_models/tiny_user.dart';
import 'package:bldrs/models/user_model.dart';
import 'package:bldrs/views/screens/fx_bz_editor_screen.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/flyer/parts/flyer_zone.dart';
import 'package:bldrs/views/widgets/flyer/parts/header.dart';
import 'package:bldrs/views/widgets/flyer/parts/header_parts/gallery.dart';
import 'package:bldrs/views/widgets/flyer/parts/slides_parts/single_slide.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart' show MainLayout, Stratosphere;

class OldMyBzScreen extends StatefulWidget {
  final UserModel userModel;
  final Function switchPage;
  final String bzID;

  OldMyBzScreen({
    @required this.userModel,
    this.switchPage,
    @required this.bzID,
  });

  @override
  _OldMyBzScreenState createState() => _OldMyBzScreenState();
}

class _OldMyBzScreenState extends State<OldMyBzScreen> {
  bool _bzPageIsOn = false;
// ---------------------------------------------------------------------------
  Future <void> _goToEditBzProfile(BzModel bzModel) async {
    var _result = await Navigator.push(context, new MaterialPageRoute(
        // maintainState: ,
        // settings: ,
        fullscreenDialog: true,
        builder: (BuildContext context){
          return new BzEditorScreen(
            firstTimer: false,
            userModel: widget.userModel,
            bzModel: bzModel,
          );
        }
    ));

    print(_result);
  }
// ---------------------------------------------------------------------------
  void _triggerMaxHeader(){
    setState(() {
      _bzPageIsOn = !_bzPageIsOn;
    });
  }
  // ----------------------------------------------------------------------
  // Future<void> _deleteBzProfile(BuildContext context, FlyersProvider pro, UserModel userModel) async {
  //   _triggerLoading();
  //   try { await pro.deleteBz(_bzID, userModel); }
  //   catch(error) {
  //     await showDialog(
  //       context: context,
  //       builder: (ctx)=>
  //           AlertDialog(
  //             title: SuperVerse(verse: 'error man', color: Colorz.BlackBlack,),
  //             content: SuperVerse(verse: 'error is : ${error.toString()}', color: Colorz.BlackBlack, maxLines: 10,),
  //             backgroundColor: Colorz.Grey,
  //             elevation: 10,
  //             shape: RoundedRectangleBorder(borderRadius: superBorderAll(context, 20)),
  //             contentPadding: EdgeInsets.all(10),
  //             actionsOverflowButtonSpacing: 10,
  //             actionsPadding: EdgeInsets.all(5),
  //             insetPadding: EdgeInsets.symmetric(vertical: (superScreenHeight(context)*0.32), horizontal: 35),
  //             buttonPadding:  EdgeInsets.all(5),
  //             titlePadding:  EdgeInsets.all(20),
  //             actions: <Widget>[BldrsBackButton(onTap: ()=> goBack(ctx)),],
  //
  //           ),
  //     );
  //   }
  //   finally {
  //     _triggerLoading();
  //     goToNewScreen(context, UserProfileScreen());
  //   }
  //
  // }
  // ----------------------------------------------------------------------
  // void _tapAchievements(){
  //   print('_tapAchievements');
  // }
// ---------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    double _flyerSizeFactor = 0.8;
    double _flyerZoneWidth = Scale.superFlyerZoneWidth(context, _flyerSizeFactor);
    double _achievementsIconWidth = 60;

    double _spacing = _flyerZoneWidth * 0.05;
    double _bWidth = _flyerZoneWidth * 0.9;

    return
        MainLayout(
          sky: Sky.Black,
          appBarType: AppBarType.Basic,
          // appBarBackButton: true,
          pyramids: Iconz.DvBlankSVG,
          layoutWidget: bzModelStreamBuilder(
            bzID: widget.bzID,
            context: context,
            builder: (ctx, _bzModel){
              return
                Column(
                  children: <Widget>[

                    Stratosphere(),

                    // --- BZ CARD REVIEW
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[

                          FlyerZone(
                            flyerSizeFactor: _flyerSizeFactor,
                            tappingFlyerZone: (){print('bzID is : (${_bzModel.bzID})');},
                            stackWidgets: <Widget>[

                              SingleSlide(
                                flyerID: '',
                                flyerZoneWidth: _flyerZoneWidth,
                                slideColor: Colorz.White80,
                                onTap: (){
                                  print('tapping slide in old my bz screen');
                                },
                              ),

                              // --- BZ BUTTONS
                              ListView(
                                children: <Widget>[

                                  // --- HEADER FOOTPRINT
                                  SizedBox(
                                    height: Scale.superHeaderHeight(false, _flyerZoneWidth),
                                  ),

                                  // // --- ACHIEVEMENTS
                                  // GestureDetector(
                                  //   onTap: _tapAchievements,
                                  //   child: Container(
                                  //     width: _bWidth,
                                  //     padding: superInsets(context, enRight: _spacing, enTop: _spacing, enBottom: _spacing),
                                  //     margin: EdgeInsets.symmetric(vertical: _spacing),
                                  //     decoration: BoxDecoration(
                                  //       color: Colorz.WhiteGlass,
                                  //       borderRadius: superBorderAll(context, _flyerZoneWidth * 0.05),
                                  //     ),
                                  //     child: Row(
                                  //       mainAxisAlignment: MainAxisAlignment.start,
                                  //       crossAxisAlignment: CrossAxisAlignment.start,
                                  //       children: <Widget>[
                                  //
                                  //         DreamBox(
                                  //           height: _achievementsIconWidth,
                                  //           width: _achievementsIconWidth,
                                  //           bubble: false,
                                  //           icon: Iconz.Achievement,
                                  //         ),
                                  //
                                  //         Container(
                                  //           width: _bWidth - _achievementsIconWidth - _spacing,
                                  //           child: Column(
                                  //             mainAxisAlignment: MainAxisAlignment.start,
                                  //             crossAxisAlignment: CrossAxisAlignment.start,
                                  //             children: <Widget>[
                                  //
                                  //               SuperVerse(
                                  //                 verse: 'Achievements',
                                  //                 color: Colorz.Yellow,
                                  //                 size: 3,
                                  //                 maxLines: 2,
                                  //               ),
                                  //
                                  //               SuperVerse(
                                  //                 verse:
                                  //                 // 'Market your Brand,\n'
                                  //                     'Advertise your Flyers,\n'
                                  //                     'Grow your Bldrs network\n'
                                  //                     'Reach your customers & help them reach you.',
                                  //                 color: Colorz.Grey,
                                  //                 size: 2,
                                  //                 italic: true,
                                  //                 weight: VerseWeight.thin,
                                  //                 maxLines: 5,
                                  //                 centered: false,
                                  //               ),
                                  //
                                  //             ],
                                  //           ),
                                  //         ),
                                  //
                                  //       ],
                                  //     ),
                                  //   ),
                                  // ),

                                  // --- ADD FLYER
                                  // DreamBox(
                                  //   width: _flyerZoneWidth * 0.9,
                                  //   height: _flyerZoneWidth * 0.3,
                                  //   color: Colorz.WhiteGlass,
                                  //   corners: _flyerZoneWidth * 0.05,
                                  //   icon: Iconz.AddFlyer,
                                  //   iconSizeFactor: 0.5,
                                  //   verse: 'Add New Flyer',
                                  //   verseScaleFactor: 1.6,
                                  //   bubble: false,
                                  //   boxFunction: () => goToNewScreen(context,
                                  //       FlyerEditorScreen(
                                  //         bzModel: _bzModel,
                                  //         firstTimer: true,
                                  //       )
                                  //   ),
                                  // ),

                                  /// --- EDIT BZ
                                  DreamBox(
                                    width: _bWidth,
                                    height: _flyerZoneWidth * 0.2,
                                    margins: EdgeInsets.symmetric(vertical: _spacing),
                                    color: Colorz.White20,
                                    corners: _flyerZoneWidth * 0.05,
                                    icon: Iconz.Gears,
                                    iconSizeFactor: 0.5,
                                    verse: 'Edit Business details',
                                    verseScaleFactor: 1.6,
                                    bubble: false,
                                    onTap: () => _goToEditBzProfile(_bzModel),
                                  ),

                                  /// flyersGrid
                                  // --- BZ GALLERY
                                  Gallery(
                                    flyerZoneWidth: _flyerZoneWidth,
                                    showFlyers: true,
                                    bz: _bzModel,
                                    flyerOnTap: (){},
                                  ),


                                  // () =>_deleteBzProfile(context, _prof, widget.userModel)

                                ],
                              ),

                              Header(
                                tinyBz: TinyBz.getTinyBzFromBzModel(_bzModel),
                                tinyAuthor: TinyUser.getTinyAuthorFromAuthorModel(_bzModel.bzAuthors[0] ?? null),
                                flyerShowsAuthor: false,
                                followIsOn: false,
                                flyerZoneWidth: _flyerZoneWidth,
                                bzPageIsOn: _bzPageIsOn,
                                tappingHeader: _triggerMaxHeader,
                                onFollowTap: (){},
                                onCallTap: (){},
                                stripBlurIsOn: true,
                              ),

                            ],
                          ),

                        ],
                      ),
                    ),

                  ],
                );
            }
          ),
        );

  }
}

