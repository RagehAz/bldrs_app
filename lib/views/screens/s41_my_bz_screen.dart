import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/user_model.dart';
import 'package:bldrs/view_brains/controllers/streamerz.dart';
import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/views/screens/s40_bz_editor_screen.dart';
import 'package:bldrs/views/widgets/bubbles/in_pyramids_bubble.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/flyer/parts/flyer_zone.dart';
import 'package:bldrs/views/widgets/flyer/parts/header.dart';
import 'package:bldrs/views/widgets/flyer/parts/slides_parts/single_slide.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart' show MainLayout, PyramidsHorizon, Stratosphere;

class MyBzScreen extends StatefulWidget {
  final UserModel userModel;
  final Function switchPage;

  MyBzScreen({
    @required this.userModel,
    this.switchPage,
  });

  @override
  _MyBzScreenState createState() => _MyBzScreenState();
}

class _MyBzScreenState extends State<MyBzScreen> {
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
  void _tapAchievements(){
    print('_tapAchievements');
  }
// ---------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    double _flyerSizeFactor = 0.8;
    double _flyerZoneWidth = superFlyerZoneWidth(context, _flyerSizeFactor);
    double _achievementsIconWidth = 60;

    return
        MainLayout(
          sky: Sky.Black,
          appBarType: AppBarType.Basic,
          appBarBackButton: true,
          layoutWidget: bzModelStreamBuilder(
            bzID: widget.userModel.followedBzzIDs[0],
            context: context,
            builder: (ctx, _bzModel){
              return
                ListView(
                  children: <Widget>[

                    Stratosphere(),

                    // --- ACHIEVEMENTS
                    InPyramidsBubble(
                      bubbleColor: Colorz.WhiteGlass,
                      centered: true,
                      columnChildren: <Widget>[

                        GestureDetector(
                          onTap: _tapAchievements,
                          child: Container(
                            width: superBubbleClearWidth(context),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[

                                DreamBox(
                                  height: _achievementsIconWidth,
                                  width: _achievementsIconWidth,
                                  bubble: false,
                                  icon: Iconz.Achievement,
                                ),

                                Container(
                                  width: superBubbleClearWidth(context) - _achievementsIconWidth,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[

                                      SuperVerse(
                                        verse: 'Achievements',
                                        color: Colorz.Yellow,
                                        size: 3,
                                        maxLines: 2,
                                      ),

                                      SuperVerse(
                                        verse: 'Perform specific tasks, '
                                            'market your flyers, '
                                            'grow your Bldrs network and reach your targeted customers.',
                                        color: Colorz.Grey,
                                        size: 2,
                                        italic: true,
                                        weight: VerseWeight.thin,
                                        maxLines: 5,
                                        centered: false,
                                      ),

                                    ],
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),

                      ],
                    ),

                    // --- BZ CARD REVIEW
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[

                          // --- EDIT BUTTON
                          Container(
                            width: _flyerZoneWidth,
                            height: _flyerZoneWidth * 0.14,
                            // color: Colorz.Facebook,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[

                                // --- EDIT BZ BUTTON
                                DreamBox(
                                  // width: 30,
                                  height: _flyerZoneWidth * 0.1,
                                  icon: Iconz.Gears,
                                  color: Colorz.WhiteGlass,
                                  bubble: false,
                                  iconSizeFactor: 0.6,
                                  verse: 'Edit Your Business details',
                                  verseItalic: true,
                                  verseWeight: VerseWeight.thin,
                                  boxMargins: EdgeInsets.symmetric(vertical : _flyerZoneWidth * 0.02),
                                  boxFunction: () => _goToEditBzProfile(_bzModel),
                                ),

                                // DreamBox(
                                //   width: _flyerZoneWidth * 0.1,
                                //   height: _flyerZoneWidth * 0.1,
                                //   icon: Iconz.XLarge,
                                //   iconColor: Colorz.BloodRed,
                                //   color: Colorz.WhiteGlass,
                                //   bubble: false,
                                //   iconSizeFactor: 0.6,
                                //   // verse: 'Delete Account',
                                //   verseItalic: true,
                                //   verseWeight: VerseWeight.thin,
                                //   boxMargins: EdgeInsets.symmetric(vertical : _flyerZoneWidth * 0.02),
                                //   boxFunction: () =>_deleteBzProfile(context, _prof, widget.userModel),
                                // ),

                              ],
                            ),
                          ),

                          FlyerZone(
                            flyerSizeFactor: _flyerSizeFactor,
                            tappingFlyerZone: (){print('bzID is : (${_bzModel.bzID})');},
                            stackWidgets: <Widget>[

                              SingleSlide(
                                flyerZoneWidth: _flyerZoneWidth,
                                slideColor: Colorz.WhiteSmoke,
                              ),

                              Header(
                                bz: _bzModel,
                                author: _bzModel.bzAuthors[0] ?? null,
                                flyerShowsAuthor: true,
                                followIsOn: false,
                                flyerZoneWidth: _flyerZoneWidth,
                                bzPageIsOn: _bzPageIsOn,
                                tappingHeader: _triggerMaxHeader,
                                tappingFollow: (){},
                                tappingUnfollow: (){},
                              ),

                            ],
                          ),

                        ],
                      ),
                    ),

                    PyramidsHorizon(heightFactor: 5,),



                  ],
                );
            }
          ),
        );

  }
}

