import 'package:bldrs/ambassadors/database/db_user.dart';
import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/models/sub_models/author_model.dart';
import 'package:bldrs/models/sub_models/slide_model.dart';
import 'package:bldrs/view_brains/controllers/flyer_controllers.dart';
import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:bldrs/views/widgets/flyer/parts/header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'parts/ankh_button.dart';
import 'parts/flyer_zone.dart';
import 'parts/progress_bar.dart';
import 'parts/slides.dart';

class Flyer extends StatefulWidget {
  final BzModel bz;
  final double flyerSizeFactor;
  int currentSlideIndex;
  bool slidingIsOn;
  final Function tappingFlyerZone;
  final Function rebuildFlyerGrid;
  final bool flyerIsInGalleryNow;

  Flyer({
    @required this.flyerSizeFactor,
    this.bz,
    this.currentSlideIndex = 0,
    this.slidingIsOn = true,
    this.tappingFlyerZone,
    this.rebuildFlyerGrid,
    this.flyerIsInGalleryNow = false,
  });

  @override
  _FlyerState createState() => _FlyerState();
}

class _FlyerState extends State<Flyer> with AutomaticKeepAliveClientMixin{
  bool get wantKeepAlive => true;
  bool bzPageIsOn;
// ---------------------------------------------------------------------------
  @override
  void initState() {
    bzPageIsOn = false;
    super.initState();
  }
// ---------------------------------------------------------------------------
  void switchBzPage (){
    setState(() {bzPageIsOn = !bzPageIsOn;});
    print('bzPageIsOn : $bzPageIsOn');
  }
// ---------------------------------------------------------------------------
  void slidingPages (int slideIndex){
    setState(() {widget.currentSlideIndex = slideIndex;});
  }
// ---------------------------------------------------------------------------

  // void tappingFollow (){
  //   setState(() {
  //     // we should save a new entry to database in this function
  //   });
  // }

  // we removed 'widget.' before ankhsOn temporarily
  // dynamic tappingSave (int slideIndex){
  // setState(() {
  //   widget.flyerData.flyerAnkhIsOn =! widget.flyerData.flyerAnkhIsOn;
  //   // theoretically,, we should save a new entry to the database
  //   xSavesList.add(FlyerSaveData(saveID: 's0${xSavesList.length + 1}', userID: 'u21', slideID: widget.flyerData.slidesIDsList[slideIndex]));
  // });
  // }


  // void _tappingMiniFlyer(){
  //   widget.tappingMiniFlyer();
  //   _triggerSliding();
  // }

  // void _triggerSliding(){
  //   setState(() {
  //     widget.slidingIsOn = !widget.slidingIsOn;
  //   });
  // }
// ---------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final flyer = Provider.of<FlyerModel>(context, listen: false);
    final bz = Provider.of<BzModel>(context, listen: true);
// ----------------------------------------------------------------------------
    final String flyerID = flyer.flyerID;
    final String authorID = flyer.authorID;
    final AuthorModel author = getAuthorModelFromUserModelAndBzModel(geebUserByUserID(authorID), bz);
    final bool flyerShowsAuthor = flyer.flyerShowsAuthor;
    final int numberOfSlides = flyer.slides?.length;
    print('authorID is = ${author.userID}');
    // final List<CoFlyer>   bzGalleryCoFlyers = pro.;
    // final List<AuthorModel>  bzAuthors         = bro.authors;
    // final AuthorModel       author          = bzAuthors?.singleWhere((au) => au.userID == authorID, orElse: ()=> null);
    final List<SlideModel>   slides          = flyer.slides;
          // bool            followIsOn        = pro.followIsOn;
          // bool            ankhIsOn          = pro.ankhIsOn;
// ----------------------------------------------------------------------------
//     final List<CoFlyer>   bzGalleryCoFlyers   = pro.hatCoFlyersByBzID(coBz?.bz?.bzId);
//     final List<CoAuthor>  bzAuthors         = coFlyer?.coBz?.coAuthors;
//     final CoAuthor        coAuthor          = pro.hatCoAuthorFromCoAuthorsByAuthorID(bzAuthors, authorID);
//     final List<CoSlide>   coSlides          = coFlyer?.coSlides;
//           bool            followIsOn        = pro.hatFollowIsOnByFlyerID(flyerID);
//           bool            ankhIsOn          = pro.hatAnkhByFlyerID(flyerID);
// ---------------------------------------------------------------------------
    double flyerZoneWidth = superFlyerZoneWidth(context, widget.flyerSizeFactor);
// ---------------------------------------------------------------------------
    bool _barIsOn = widget.slidingIsOn == true && bzPageIsOn == false ? true : false;
// ---------------------------------------------------------------------------
    bool microMode = superFlyerMicroMode(context, flyerZoneWidth);
// ---------------------------------------------------------------------------
    // bool ankhIsOn = true;//flyerData.flyerAnkhIsOn;
// ---------------------------------------------------------------------------
    print('flyer widget builds fID : $flyerID');

    return

       FlyerZone(
         flyerSizeFactor: superFlyerSizeFactor(context, flyerZoneWidth),
         tappingFlyerZone: widget.tappingFlyerZone,
         stackWidgets: <Widget>[

          Slides(
            flyerZoneWidth: flyerZoneWidth,
            slidingIsOn: widget.slidingIsOn,
            currentSlideIndex: widget.currentSlideIndex,
            sliding: slidingPages,
            slides: slides,
          ),

          Consumer<BzModel>(
            builder: (context, bz, _) =>
             Header(
              flyerZoneWidth: flyerZoneWidth,
              bz: bz,
              flyerShowsAuthor: flyerShowsAuthor,
              bzPageIsOn: bzPageIsOn,
              tappingHeader: () {switchBzPage();},
              tappingFollow: (){
                print('followIsOn : ${bz.followIsOn}');
                bz.toggleFollow();
                },
              tappingUnfollow: () {print('UnFollow Tapped');},
              author: author,
              followIsOn: bz.followIsOn,
            ),
          ),

          ProgressBar(
            flyerZoneWidth: flyerZoneWidth,
            barIsOn: _barIsOn,
            currentSlide: widget.currentSlideIndex >= numberOfSlides ? 0 : widget.currentSlideIndex,
            numberOfSlides: numberOfSlides,
          ),

          Consumer<FlyerModel>(
            builder: (context, flyer, _) =>
                AnkhButton(
                  flyerZoneWidth: flyerZoneWidth,
                  // flyerID: flyerID,
                  bzPageIsOn: bzPageIsOn,
                  slidingIsOn: widget.slidingIsOn,
                  microMode: microMode,
                  ankhIsOn: flyer.ankhIsOn,
                  tappingAnkh: (){
                    flyer.toggleAnkh();
                    print('ankh : ${flyer.ankhIsOn}');
                    if(widget.flyerIsInGalleryNow) {widget.rebuildFlyerGrid();}
            },
            ),
          ),

        ],
      );

  }
}






