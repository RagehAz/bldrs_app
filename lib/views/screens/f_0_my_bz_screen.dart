import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/scrollers.dart';
import 'package:bldrs/controllers/drafters/text_generators.dart';
import 'package:bldrs/controllers/drafters/timerz.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:bldrs/firestore/bz_ops.dart';
import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/models/flyer/mutables/super_flyer.dart';
import 'package:bldrs/models/bz/tiny_bz.dart';
import 'package:bldrs/models/user/user_model.dart';
import 'package:bldrs/providers/flyers_and_bzz/flyers_provider.dart';
import 'package:bldrs/views/screens/f_x_bz_editor_screen.dart';
import 'package:bldrs/views/screens/f_2_deactivated_flyers_screen.dart';
import 'package:bldrs/views/widgets/bubbles/bubbles_separator.dart';
import 'package:bldrs/views/widgets/bubbles/in_pyramids_bubble.dart';
import 'package:bldrs/views/widgets/bubbles/paragraph_bubble.dart';
import 'package:bldrs/views/widgets/bubbles/stats_line.dart';
import 'package:bldrs/views/widgets/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/dialogs/alert_dialog.dart';
import 'package:bldrs/views/widgets/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/views/widgets/flyer/parts/header_parts/gallery.dart';
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
  // bool _showOldFlyers;
  BzModel _bzModel;
  double _bubblesOpacity = 0;
// -----------------------------------------------------------------------------
  /// --- FUTURE LOADING BLOCK
  bool _loading = false;
  Future <void> _triggerLoading({Function function}) async {

    if (function == null){
    setState(() {
      _loading = !_loading;
    });
    }

    else {
      setState(() {
        _loading = !_loading;
        function();
      });
    }

    _loading == true?
    print('LOADING--------------------------------------') : print('LOADING COMPLETE--------------------------------------');
  }
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    print('1 - we got temp bzModel');

    _bzModel = BzModel.getTempBzModelFromTinyBz(widget.tinyBz);
    // _showOldFlyers = false;

    // TODO: implement initState
  }
// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      _triggerLoading().then((_) async {

        print('2 - retrieving bzModel from firebase');
        BzModel _bzFromDB = await BzOps.readBzOps(context: context, bzID: widget.tinyBz.bzID);
        print('3 - got the bzModel');
        // setState(() {
          // _bzModel = _bzFromDB;
          // _bubblesOpacity = 1;
        // });
        print('4 - rebuilt tree with the retrieved bzModel');

        FlyersProvider _prof = Provider.of<FlyersProvider>(context, listen: false);
        _prof.setCurrentBzModel(_bzFromDB);

        /// X - REBUILD : TASK : check previous set states malhomsh lazma keda ba2a
        _triggerLoading(
          function: (){
            _bzModel = _bzFromDB;
            _bubblesOpacity = 1;
          }
        );

      });

    }
    _isInit = false;
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------
  Future<void> _deleteBzOnTap(BzModel bzModel) async {


    Nav.goBack(context);

    bool _dialogResult = await superDialog(
      context: context,
      title: '',
      body: 'Are you sure you want to Delete ${_bzModel.bzName} Business account ?',
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
      // _prof.removeTinyBzFromLocalList(_bzModel.bzID);

      /// remove tinyBz from local userTinyBzz
      _prof.removeTinyBzFromLocalUserTinyBzz(_bzModel.bzID);

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
        body: 'Are you sure you want to Deactivate ${_bzModel.bzName} Business account ?',
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
        _prof.removeTinyBzFromLocalList(_bzModel.bzID);

        /// remove tinyBz from local userTinyBzz
        _prof.removeTinyBzFromLocalUserTinyBzz(_bzModel.bzID);

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

    BottomDialog.slideButtonsBottomDialog(
      context: context,
      draggable: true,
      buttonHeight: _buttonHeight,
      buttons: <Widget>[

        // --- DELETE BZ
        DreamBox(
          height: _buttonHeight,
          width: BottomDialog.dialogClearWidth(context),
          icon: Iconz.XSmall,
          iconSizeFactor: 0.5,
          iconColor: Colorz.Red255,
          verse: 'Delete Business Account',
          verseScaleFactor: 1.2,
          verseWeight: VerseWeight.black,
          verseColor: Colorz.Red255,
          // verseWeight: VerseWeight.thin,
          onTap: () => _deleteBzOnTap(bzModel),
        ),

        // --- DEACTIVATE BZ
        DreamBox(
              height: _buttonHeight,
              width: BottomDialog.dialogClearWidth(context),
              icon: Iconz.XSmall,
              iconSizeFactor: 0.5,
              iconColor: Colorz.Red255,
              verse: 'Deactivate Business Account',
              verseScaleFactor: 1.2,
              verseWeight: VerseWeight.black,
              verseColor: Colorz.Red255,
              // verseWeight: VerseWeight.thin,
              onTap: () => _deactivateBzOnTap(bzModel)

          ),

          // --- EDIT BZ
          DreamBox(
            height: _buttonHeight,
            width: BottomDialog.dialogClearWidth(context),
            icon: Iconz.Gears,
            iconSizeFactor: 0.5,
            verse: 'Edit Business Account info',
            verseScaleFactor: 1.2,
            verseColor: Colorz.White255,
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
//   Widget _statsButton({@required String verse, @required String icon}){
//     return
//     DreamBox(
//       height: 30,
//       icon: icon,
//       verse: verse,
//       verseWeight: VerseWeight.thin,
//       verseItalic: true,
//       iconSizeFactor: 0.6,
//       bubble: false,
//     );
// }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    // double _bubbleWidth = superScreenWidth(context) - (2 * Ratioz.ddAppBarMargin);

    double _appBarBzButtonWidth = Scale.superScreenWidth(context) - (Ratioz.appBarMargin * 2) -
        (Ratioz.appBarButtonSize * 2) - (Ratioz.appBarPadding * 4);

    String _zoneString = TextGenerator.cityCountryStringer(context: context, zone: _bzModel.bzZone);


    return MainLayout(
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
          icon: _bzModel.bzLogo,
          verse: '${_bzModel.bzName}',
          bubble: false,
          verseScaleFactor: 0.7,
          color: Colorz.White10,
          secondLine: '${TextGenerator.bzTypeSingleStringer(context, _bzModel.bzType)} $_zoneString',
          secondLineColor: Colorz.White200,
          secondLineScaleFactor: 0.8,
        ),

        /// -- SLIDE BZ ACCOUNT OPTIONS
        DreamBox(
          height: Ratioz.appBarButtonSize,
          width: Ratioz.appBarButtonSize,
          icon: Iconz.More,
          iconSizeFactor: 0.6,
          margins: const EdgeInsets.symmetric(horizontal: Ratioz.appBarPadding),
          bubble: false,
          onTap:  () => _slideBzOptions(context, _bzModel),
        ),


      ],

      layoutWidget: GoHomeOnMaxBounce(
        child: AnimatedOpacity(
          opacity: _bubblesOpacity,
          duration: Ratioz.durationSliding400,
          curve: Curves.easeOut,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: <Widget>[

              Stratosphere(),

              /// --- PUBLISHED FLYERS
              if (_bzModel.nanoFlyers != null)
              InPyramidsBubble(
                title: 'Published Flyers',
                centered: false,
                actionBtIcon: Iconz.Clock,
                actionBtFunction: () => _showOldFlyersOnTap(_bzModel),
                columnChildren: <Widget>[

                  Gallery(
                    flyerZoneWidth: Scale.superBubbleClearWidth(context),
                    superFlyer: SuperFlyer.getSuperFlyerFromBzModelOnly(
                      bzModel: _bzModel,
                      onHeaderTap: () => print('on header tap in f 0 my bz Screen'),
                    ),
                    showFlyers: true,
                  ),

                ],
              ),

              if (_bzModel.nanoFlyers != null)
                BubblesSeparator(),

              /// --- SCOPE
              if (_bzModel.bzScope != null)
                ParagraphBubble(
                title: 'Scope of services',
                paragraph: _bzModel.bzScope,
                maxLines: 5,
              ),

              /// --- ABOUT
              if (_bzModel.bzAbout != null)
                ParagraphBubble(
                title: 'About ${_bzModel.bzName}',
                paragraph: _bzModel.bzAbout,
                maxLines: 5,
                centered: false,
              ),

              if (_bzModel.bzAbout != null)
              BubblesSeparator(),

              /// --- STATS
              if (_bzModel.bzTotalSlides != null)
                InPyramidsBubble(
                  title: 'Stats',
                  centered: false,
                  columnChildren: <Widget>[

                    /// FOLLOWERS
                    StatsLine(
                      verse: '${_bzModel.bzTotalFollowers} ${Wordz.followers(context)}',
                      icon: Iconz.Follow,
                    ),

                    /// CALLS
                    StatsLine(
                      verse: '${_bzModel.bzTotalCalls} ${Wordz.callsReceived(context)}',
                      icon: Iconz.ComPhone,
                    ),

                    /// SLIDES & FLYERS
                    StatsLine(
                      verse: '${_bzModel.bzTotalSlides} ${Wordz.slidesPublished(context)} ${Wordz.inn(context)} ${_bzModel.nanoFlyers.length} ${Wordz.flyers(context)}',
                      icon: Iconz.Gallery,
                    ),

                    /// SAVES
                    StatsLine(
                      verse: '${_bzModel.bzTotalSaves} ${Wordz.totalSaves(context)}',
                      icon: Iconz.SaveOn,
                    ),

                    /// VIEWS
                    StatsLine(
                      verse: '${_bzModel.bzTotalViews} ${Wordz.totalViews(context)}',
                      icon: Iconz.Views,
                    ),

                    /// SHARES
                    StatsLine(
                      verse: '${_bzModel.bzTotalShares} ${Wordz.totalShares(context)}',
                      icon: Iconz.Share,
                    ),

                    /// BIRTH
                    StatsLine(
                      verse: '${Timers.monthYearStringer(context,_bzModel.bldrBirth)}',
                      icon: Iconz.Calendar,
                    ),

                  ]
              ),

              PyramidsHorizon(heightFactor: 3,),

            ],
          ),
        ),
      ),

    );
  }
}
