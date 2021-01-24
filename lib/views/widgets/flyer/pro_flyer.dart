import 'package:bldrs/providers/combined_models/co_author.dart';
import 'package:bldrs/providers/combined_models/co_bz.dart';
import 'package:bldrs/providers/combined_models/co_flyer.dart';
import 'package:bldrs/providers/combined_models/co_slide.dart';
import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'parts/ankh_button.dart';
import 'parts/flyer_zone.dart';
import 'parts/header.dart';
import 'parts/progress_bar.dart';
import 'parts/slides.dart';

class ProFlyer extends StatefulWidget {
  // final String flyerID;
  final double flyerSizeFactor;
  int currentSlideIndex;
  bool slidingIsOn;
  final Function tappingFlyerZone;
  final Function rebuildFlyerGrid;
  final bool flyerIsInGalleryNow;

  ProFlyer({
    @required this.flyerSizeFactor,
    // @required this.flyerID,
    this.currentSlideIndex = 0,
    this.slidingIsOn = true,
    this.tappingFlyerZone,
    this.rebuildFlyerGrid,
    this.flyerIsInGalleryNow = false,
  });

  @override
  _ProFlyerState createState() => _ProFlyerState();
}

class _ProFlyerState extends State<ProFlyer> with AutomaticKeepAliveClientMixin{

  // === === === === === === === === === === === === === === === === === === ===
  bool get wantKeepAlive => true;
  // === === === === === === === === === === === === === === === === === === ===
  bool bzPageIsOn;

  @override
  void initState() {
    bzPageIsOn = false;
    super.initState();
  }

  void switchBzPage (){
    setState(() {bzPageIsOn = !bzPageIsOn;});
    print('bzPageIsOn : $bzPageIsOn');
  }
  // === === === === === === === === === === === === === === === === === === ===
  void slidingPages (int slideIndex){
    setState(() {widget.currentSlideIndex = slideIndex;});
  }
  // === === === === === === === === === === === === === === === === === === ===

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

  @override
  Widget build(BuildContext context) {

    final pro = Provider.of<CoFlyer>(context, listen: false);
    // final koko= Provider.of<CoFlyer>(context, listen: true);
// ----------------------------------------------------------------------------
//     final CoFlyer         coFlyer           = pro.;
    final String          flyerID           = pro.flyer?.flyerID;
    final CoBz            coBz              = pro.coBz;
    final bool            flyerShowsAuthor  = pro.flyer?.flyerShowsAuthor;
    final String          authorID          = pro.flyer?.authorID;
    final int             numberOfSlides    = pro.coSlides?.length;
    // final List<CoFlyer>   bzGalleryCoFlyers = pro.;
    final List<CoAuthor>  bzAuthors         = pro.coBz?.coAuthors;
    final CoAuthor        coAuthor          = bzAuthors?.singleWhere((coA) => coA.author.authorID == authorID, orElse: ()=> null);
    final List<CoSlide>   coSlides          = pro.coSlides;
          // bool            followIsOn        = pro.followIsOn;
          // bool            ankhIsOn          = pro.ankhIsOn;
// ----------------------------------------------------------------------------
//     final CoFlyer         coFlyer           = pro.hatCoFlyerByFlyerID(widget.flyerID);
//     final String          flyerID           = coFlyer?.flyer?.flyerID;
//     final CoBz            coBz              = coFlyer?.coBz;
//     final bool            flyerShowsAuthor  = coFlyer?.flyer?.flyerShowsAuthor;
//     final String          authorID          = coFlyer?.flyer?.authorID;
//     final int             numberOfSlides    = coFlyer?.coSlides?.length;
//     final List<CoFlyer>   bzGalleryCoFlyers   = pro.hatCoFlyersByBzID(coBz?.bz?.bzId);
//     final List<CoAuthor>  bzAuthors         = coFlyer?.coBz?.coAuthors;
//     final CoAuthor        coAuthor          = pro.hatCoAuthorFromCoAuthorsByAuthorID(bzAuthors, authorID);
//     final List<CoSlide>   coSlides          = coFlyer?.coSlides;
//           bool            followIsOn        = pro.hatFollowIsOnByFlyerID(flyerID);
//           bool            ankhIsOn          = pro.hatAnkhByFlyerID(flyerID);
// ----------------------------------------------------------------------------
    // === === === === === === === === === === === === === === === === === === ===
    double screenWidth = superScreenWidth(context);
    double flyerZoneWidth = superFlyerZoneWidth(context, widget.flyerSizeFactor);
    // === === === === === === === === === === === === === === === === === === ===
    bool _barIsOn = widget.slidingIsOn == true && bzPageIsOn == false ? true : false;
    // === === === === === === === === === === === === === === === === === === ===
    bool microMode = superFlyerMicroMode(context, flyerZoneWidth);
    // === === === === === === === === === === === === === === === === === === ===
    // bool ankhIsOn = true;//flyerData.flyerAnkhIsOn;
    // === === === === === === === === === === === === === === === === === === ===

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
            coSlides: coSlides,

          ),

          Consumer<CoFlyer>(
            builder: (context, pro, _) =>
             Header(
              flyerZoneWidth: flyerZoneWidth,
              coBz: coBz,
              flyerShowsAuthor: flyerShowsAuthor,
              bzPageIsOn: bzPageIsOn,
              tappingHeader: () {switchBzPage();},
              tappingFollow: (){
                print('followIsOn : ${pro.followIsOn}');
                pro.toggleFollow();
                },
              tappingUnfollow: () {print('UnFollow Tapped');},
              // bzGalleryCoFlyers: bzGalleryCoFlyers,
              coAuthor: coAuthor,
              followIsOn: pro.followIsOn,
            ),
          ),

          ProgressBar(
            flyerZoneWidth: flyerZoneWidth,
            barIsOn: _barIsOn,
            currentSlide: widget.currentSlideIndex >= numberOfSlides ? 0 : widget.currentSlideIndex,
            numberOfSlides: numberOfSlides,
          ),

          Consumer<CoFlyer>(
            builder: (context, pro, _) =>
                AnkhButton(
                  flyerZoneWidth: flyerZoneWidth,
                  // flyerID: flyerID,
                  bzPageIsOn: bzPageIsOn,
                  slidingIsOn: widget.slidingIsOn,
                  microMode: microMode,
                  ankhIsOn: pro.ankhIsOn,
                  tappingAnkh: (){
                    pro.toggleAnkh();
                    print('ankh : ${pro.ankhIsOn}');
                    if(widget.flyerIsInGalleryNow) {widget.rebuildFlyerGrid();}
            },
            ),
          ),

        ],
      );

  }
}






