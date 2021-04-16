import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/streamerz.dart';
import 'package:bldrs/controllers/drafters/text_generators.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/tiny_models/tiny_bz.dart';
import 'package:bldrs/models/user_model.dart';
import 'package:bldrs/views/screens/s40_bz_editor_screen.dart';
import 'package:bldrs/views/screens/s42_bz_flyer_screen.drt.dart';
import 'package:bldrs/views/widgets/bubbles/bubbles_separator.dart';
import 'package:bldrs/views/widgets/bubbles/in_pyramids_bubble.dart';
import 'package:bldrs/views/widgets/bubbles/paragraph_bubble.dart';
import 'package:bldrs/views/widgets/bubbles/tile_bubble.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/flyer/parts/header_parts/max_header_parts/gallery.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:flutter/material.dart';

class MyBzScreen extends StatefulWidget {
  final TinyBz tinyBz;
  final UserModel userModel;

  MyBzScreen({
    @required this.tinyBz,
    @required this.userModel,
});

  @override
  _MyBzScreenState createState() => _MyBzScreenState();
}

class _MyBzScreenState extends State<MyBzScreen> {

// ---------------------------------------------------------------------------
  /// --- LOADING BLOCK
  bool _loading = false;
  // void _triggerLoading(){
  //   setState(() {_loading = !_loading;});
  //   _loading == true?
  //   print('LOADING--------------------------------------') : print('LOADING COMPLETE--------------------------------------');
  // }
// ---------------------------------------------------------------------------
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
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


  @override
  Widget build(BuildContext context) {

    double _bubbleWidth = superScreenWidth(context) - (2 * Ratioz.ddAppBarMargin);

    return bzModelStreamBuilder(
        context: context,
        bzID: widget.tinyBz.bzID,

        builder: (ctx, bzModel){

          return

            MainLayout(
                pyramids: Iconz.DvBlankSVG,
                sky: Sky.Black,
                appBarBackButton: true,
                appBarType: AppBarType.Basic,
                loading: _loading,
                appBarRowWidgets: <Widget>[

                  DreamBox(
                    height: 40,
                    icon: widget.tinyBz.bzLogo,
                    verse: widget.tinyBz.bzName,
                    bubble: false,
                    verseScaleFactor: 0.6,
                    secondLine: TextGenerator.bzTypeSingleStringer(context, widget.tinyBz.bzType),
                  ),

                  Expanded(child: Container()),

                  // -- edit bz button
                  DreamBox(
                    height: 35,
                    width: 35,
                    icon: Iconz.Gears,
                    iconSizeFactor: 0.6,
                    boxMargins: EdgeInsets.symmetric(horizontal: Ratioz.ddAppBarMargin),
                    bubble: false,
                    boxFunction: () => _goToEditBzProfile(bzModel),
                  ),

                ],

                layoutWidget: ListView(
                  children: <Widget>[

                    Stratosphere(),

                    // --- GALLERY
                    InPyramidsBubble(
                      title: 'Published Flyers',
                      centered: false,
                      columnChildren: <Widget>[

                        Gallery(
                          flyerZoneWidth: superBubbleClearWidth(context),
                          showFlyers: true,
                          bz: bzModel,
                          flyerOnTap: (tinyFlyer){
                            Nav.goToNewScreen(context,
                              BzFlyerScreen(
                                tinyFlyer : tinyFlyer,
                                bzModel: bzModel,
                              ),
                            );
                          },
                        ),

                      ],
                    ),

                    BubblesSeparator(),

                    // --- SCOPE
                    ParagraphBubble(
                      title: 'Scope of services',
                      paragraph: bzModel.bzScope,
                      maxLines: 5,
                    ),

                    // --- ABOUT
                    ParagraphBubble(
                      title: 'About ${bzModel.bzName}',
                      paragraph: bzModel.bzAbout,
                      maxLines: 5,
                      centered: false,
                    ),

                    BubblesSeparator(),

                    // --- TOTAL FOLLOWERS
                    TileBubble(
                      verse: '${bzModel.bzTotalFollowers} ${Wordz.followers(context)}',
                      icon: Iconz.Follow,
                      iconSizeFactor: 0.6,
                      iconIsBubble: false,
                    ),

                    // --- TOTAL CALLS
                    TileBubble(
                      verse: '${bzModel.bzTotalCalls} ${Wordz.callsReceived(context)}',
                      icon: Iconz.ComPhone,
                      iconSizeFactor: 0.6,
                      iconIsBubble: false,
                    ),

                    BubblesSeparator(),

                    // --- TOTAL SLIDES
                    TileBubble(
                      verse: '${bzModel.bzTotalSlides} ${Wordz.slidesPublished(context)}',
                      icon: Iconz.Gallery,
                      iconSizeFactor: 0.6,
                      iconIsBubble: false,
                    ),

                    // --- TOTAL FLYERS
                    TileBubble(
                      verse: '${bzModel.bzFlyers.length} ${Wordz.flyers(context)}',
                      icon: Iconz.Flyer,
                      iconSizeFactor: 0.6,
                      iconIsBubble: false,
                    ),

                    BubblesSeparator(),

                    // --- TOTAL SAVES
                    TileBubble(
                      verse: '${bzModel.bzTotalSaves} ${Wordz.totalSaves(context)}',
                      icon: Iconz.SaveOn,
                      iconSizeFactor: 0.6,
                      iconIsBubble: false,
                    ),

                    // --- TOTAL VIEWS
                    TileBubble(
                      verse: '${bzModel.bzTotalViews} ${Wordz.totalViews(context)}',
                      icon: Iconz.Views,
                      iconSizeFactor: 0.6,
                      iconIsBubble: false,
                    ),

                    // --- TOTAL SHARES
                    TileBubble(
                      verse: '${bzModel.bzTotalShares} ${Wordz.totalShares(context)}',
                      icon: Iconz.Share,
                      iconSizeFactor: 0.6,
                      iconIsBubble: false,
                    ),

                    BubblesSeparator(),

                    // --- BIRTH DATE
                    TileBubble(
                      verse: TextGenerator.monthYearStringer(context,bzModel.bldrBirth),
                      icon: Iconz.Calendar,
                      iconSizeFactor: 0.6,
                      iconIsBubble: false,
                    ),

                    PyramidsHorizon(heightFactor: 3,),

                  ],
                ),

            );

          }
      );
  }
}
