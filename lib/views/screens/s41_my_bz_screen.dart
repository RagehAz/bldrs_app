import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/streamerz.dart';
import 'package:bldrs/controllers/drafters/text_generators.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:bldrs/firestore/bz_ops.dart';
import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/tiny_models/tiny_bz.dart';
import 'package:bldrs/models/user_model.dart';
import 'package:bldrs/providers/flyers_provider.dart';
import 'package:bldrs/views/screens/s40_bz_editor_screen.dart';
import 'package:bldrs/views/screens/s42_bz_flyer_screen.drt.dart';
import 'package:bldrs/views/screens/s43_deactivated_flyers_screen.dart';
import 'package:bldrs/views/widgets/bubbles/bubbles_separator.dart';
import 'package:bldrs/views/widgets/bubbles/in_pyramids_bubble.dart';
import 'package:bldrs/views/widgets/bubbles/paragraph_bubble.dart';
import 'package:bldrs/views/widgets/bubbles/tile_bubble.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/dialogs/alert_dialog.dart';
import 'package:bldrs/views/widgets/dialogs/bottom_sheet.dart';
import 'package:bldrs/views/widgets/flyer/parts/header_parts/max_header_parts/gallery.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  bool _showOldFlyers;
// -----------------------------------------------------------------------------
  /// --- LOADING BLOCK
  bool _loading = false;
  void _triggerLoading(){
    setState(() {_loading = !_loading;});
    _loading == true?
    print('LOADING--------------------------------------') : print('LOADING COMPLETE--------------------------------------');
  }
// -----------------------------------------------------------------------------
  @override
  void initState() {
    _showOldFlyers = false;
    // TODO: implement initState
    super.initState();
  }
// -----------------------------------------------------------------------------
  Future<void> _deleteBzOnTap(BzModel bzModel) async {


    Nav.goBack(context);

    bool _dialogResult = await superDialog(
      context: context,
      title: '',
      body: 'Are you sure you want to Delete ${bzModel.bzName} Business account ?',
      boolDialog: true,
    );

    print(_dialogResult);

    /// if user chooses to stop ops
    if (_dialogResult == false){
      print('user cancelled ops');
    }

    /// if user chose to continue ops
    else {

      _triggerLoading();

      /// start delete bz ops
      await BzOps().superDeleteBzOps(
        context: context,
        bzModel: bzModel,
      );

      // /// remove tinyBz from Local list
      FlyersProvider _prof = Provider.of<FlyersProvider>(context, listen: false);
      // _prof.removeTinyBzFromLocalList(bzModel.bzID);

      /// remove tinyBz from local userTinyBzz
      _prof.removeTinyBzFromLocalUserTinyBzz(bzModel.bzID);

      _triggerLoading();

      /// re-route back
      Nav.goBack(context, argument: true);

    }
}
// -----------------------------------------------------------------------------
  Future<void> _deactivateBzOnTap(BzModel bzModel) async {

      /// close bottom sheet
      Nav.goBack(context);

      bool _dialogResult = await superDialog(
        context: context,
        title: '',
        body: 'Are you sure you want to Deactivate ${bzModel.bzName} Business account ?',
        boolDialog: true,
      );

      print(_dialogResult);

      /// if user chooses to cancel ops
      if (_dialogResult == false) {
        print('user cancelled ops');
      }

      /// if user chooses to continue ops
      else {

        _triggerLoading();

        /// start deactivate bz ops
        await BzOps().deactivateBzOps(
          context: context,
          bzModel: bzModel,
        );

        /// remove tinyBz from Local list
        FlyersProvider _prof = Provider.of<FlyersProvider>(context, listen: false);
        _prof.removeTinyBzFromLocalList(bzModel.bzID);

        /// remove tinyBz from local userTinyBzz
        _prof.removeTinyBzFromLocalUserTinyBzz(bzModel.bzID);

        _triggerLoading();

        /// re-route back
        Nav.goBack(context, argument: true);

    }

  }
// -----------------------------------------------------------------------------
  Future<void> _editBzOnTap(BzModel bzModel) async {
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

    if (_result == true){
      setState(() {});
    }

    print(_result);
  }
// -----------------------------------------------------------------------------
  void _slideBzOptions(BuildContext context, BzModel bzModel){

    double _buttonHeight = 50;

    BottomSlider.slideButtonsBottomSheet(
      context: context,
      draggable: true,
      buttonHeight: _buttonHeight,
      buttons: <Widget>[

          // --- DELETE BZ
          DreamBox(
            height: _buttonHeight,
            width: BottomSlider.bottomSheetClearWidth(context),
            icon: Iconz.XSmall,
            iconSizeFactor: 0.5,
            iconColor: Colorz.Black225,
            verse: 'delete Business Account',
            verseScaleFactor: 1.2,
            verseWeight: VerseWeight.black,
            verseColor: Colorz.Black225,
            // verseWeight: VerseWeight.thin,
            onTap: () => _deleteBzOnTap(bzModel),

          ),

          // --- DEACTIVATE BZ
          DreamBox(
            height: _buttonHeight,
            width: BottomSlider.bottomSheetClearWidth(context),
            icon: Iconz.XSmall,
            iconSizeFactor: 0.5,
            iconColor: Colorz.Red225,
            verse: 'Deactivate Business Account',
            verseScaleFactor: 1.2,
            verseColor: Colorz.Red225,
            // verseWeight: VerseWeight.thin,
            onTap: () => _deactivateBzOnTap(bzModel)

          ),

          // --- EDIT BZ
          DreamBox(
            height: _buttonHeight,
            width: BottomSlider.bottomSheetClearWidth(context),
            icon: Iconz.Gears,
            iconSizeFactor: 0.5,
            verse: 'Edit Business Account info',
            verseScaleFactor: 1.2,
            verseColor: Colorz.White225,
            onTap: () => _editBzOnTap(bzModel),
          ),

        ],

    );

  }
// -----------------------------------------------------------------------------
  void _showOldFlyersOnTap(BzModel bzModel){

    Nav.goToNewScreen(context, DeactivatedFlyerScreen(bz: bzModel));

  }
// -----------------------------------------------------------------------------
  Widget _statsButton({@required String verse, @required String icon}){
    return
    DreamBox(
      height: 30,
      icon: icon,
      verse: verse,
      verseWeight: VerseWeight.thin,
      verseItalic: true,
      iconSizeFactor: 0.6,
      bubble: false,
    );
}
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    // double _bubbleWidth = superScreenWidth(context) - (2 * Ratioz.ddAppBarMargin);

    double _appBarBzButtonWidth = Scale.superScreenWidth(context) - (Ratioz.appBarMargin * 2) -
        (Ratioz.appBarButtonSize * 2) - (Ratioz.appBarPadding * 4);

    String _spaces = '   ';

    return bzModelStreamBuilder(
        context: context,
        bzID: widget.tinyBz.bzID,
        builder: (ctx, bzModel){

          String _zoneString = TextGenerator.cityCountryStringer(context: context, zone: bzModel.bzZone);

          print('bzZone is ${bzModel.bzZone.countryID} : ${bzModel.bzZone.provinceID} : ${bzModel.bzZone.districtID}');

          print ('_zoneString is : $_zoneString');

          return

            MainLayout(
                pyramids: Iconz.PyramidzYellow,
                sky: Sky.Black,
                // appBarBackButton: true,
                appBarType: AppBarType.Basic,
                loading: _loading,
                appBarRowWidgets: <Widget>[

                  /// --- BZ LOGO
                  DreamBox(
                    height: Ratioz.appBarButtonSize,
                    width: _appBarBzButtonWidth,
                    icon: bzModel.bzLogo,
                    verse: '${bzModel.bzName}',
                    bubble: false,
                    verseScaleFactor: 0.8,
                    color: Colorz.White10,
                    secondLine: '${TextGenerator.bzTypeSingleStringer(context, bzModel.bzType)} $_zoneString',
                    secondLineColor: Colorz.White200,
                    secondLineScaleFactor: 0.9,
                  ),

                  /// -- SLIDE BZ ACCOUNT OPTIONS
                  DreamBox(
                    height: Ratioz.appBarButtonSize,
                    width: Ratioz.appBarButtonSize,
                    icon: Iconz.More,
                    iconSizeFactor: 0.6,
                    margins: const EdgeInsets.symmetric(horizontal: Ratioz.appBarPadding),
                    bubble: false,
                    onTap:  () => _slideBzOptions(context, bzModel),
                  ),

                ],

                layoutWidget: ListView(
                  children: <Widget>[

                    Stratosphere(),

                    /// --- SCOPE
                    ParagraphBubble(
                      title: 'Scope of services',
                      paragraph: bzModel.bzScope,
                      maxLines: 5,
                    ),

                    /// --- ABOUT
                    ParagraphBubble(
                      title: 'About ${bzModel.bzName}',
                      paragraph: bzModel.bzAbout,
                      maxLines: 5,
                      centered: false,
                    ),

                    BubblesSeparator(),

                    /// --- STATS
                    InPyramidsBubble(
                        title: 'Stats',
                        centered: false,
                        columnChildren: <Widget>[

                          /// FOLLOWERS
                          _statsButton(
                            verse: '$_spaces${bzModel.bzTotalFollowers} ${Wordz.followers(context)}',
                            icon: Iconz.Follow,
                          ),

                          /// CALLS
                          _statsButton(
                            verse: '$_spaces${bzModel.bzTotalCalls} ${Wordz.callsReceived(context)}',
                            icon: Iconz.ComPhone,
                          ),

                          /// SLIDES & FLYERS
                          _statsButton(
                            verse: '$_spaces${bzModel.bzTotalSlides} ${Wordz.slidesPublished(context)} ${Wordz.inn(context)} ${bzModel.nanoFlyers.length} ${Wordz.flyers(context)}',
                            icon: Iconz.Gallery,
                          ),

                          /// SAVES
                          _statsButton(
                            verse: '$_spaces${bzModel.bzTotalSaves} ${Wordz.totalSaves(context)}',
                            icon: Iconz.SaveOn,
                          ),

                          /// VIEWS
                          _statsButton(
                            verse: '$_spaces${bzModel.bzTotalViews} ${Wordz.totalViews(context)}',
                            icon: Iconz.Views,
                          ),

                          /// SHARES
                          _statsButton(
                            verse: '$_spaces${bzModel.bzTotalShares} ${Wordz.totalShares(context)}',
                            icon: Iconz.Share,
                          ),

                          /// BIRTH
                          _statsButton(
                            verse: '$_spaces${TextGenerator.monthYearStringer(context,bzModel.bldrBirth)}',
                            icon: Iconz.Calendar,
                          ),

                        ]
                    ),

                    BubblesSeparator(),

                    /// --- GALLERY
                    InPyramidsBubble(
                      title: 'Published Flyers',
                      centered: false,
                      actionBtIcon: Iconz.Clock,
                      actionBtFunction: () => _showOldFlyersOnTap(bzModel),
                      columnChildren: <Widget>[

                        Gallery(
                          flyerZoneWidth: Scale.superBubbleClearWidth(context),
                          showFlyers: true,
                          bz: bzModel,
                          // showOldFlyers: _showOldFlyers,
                          flyerOnTap: (tinyFlyer) async {

                            dynamic _rebuild = await Navigator.push(context,
                            new MaterialPageRoute(
                                builder: (context) => new BzFlyerScreen(
                                    tinyFlyer: tinyFlyer,
                                    bzModel: bzModel,
                                )
                            ));

                            if (_rebuild == true){
                              print('we should rebuild');
                              setState(() { });
                            } else if (_rebuild == false){
                              print('do not rebuild');
                            } else {
                              print ('rebuild is null');
                            }

                          },
                        ),

                      ],
                    ),


                    PyramidsHorizon(heightFactor: 3,),

                  ],
                ),

            );

          }
      );
  }
}
