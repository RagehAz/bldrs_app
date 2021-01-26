import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/models/sub_models/author_model.dart';
import 'package:bldrs/models/sub_models/slide_model.dart';
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
  final FlyerModel flyerModel;

  ProFlyer({
    @required this.flyerSizeFactor,
    // @required this.flyerID,
    this.currentSlideIndex = 0,
    this.slidingIsOn = true,
    this.tappingFlyerZone,
    this.rebuildFlyerGrid,
    this.flyerIsInGalleryNow = false,
    this.flyerModel,
  });

  @override
  _ProFlyerState createState() => _ProFlyerState();
}

class _ProFlyerState extends State<ProFlyer> with AutomaticKeepAliveClientMixin{
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

    final pro = Provider.of<FlyerModel>(context, listen: false);
    final bro = Provider.of<BzModel>(context, listen: false);

    // final koko= Provider.of<CoFlyer>(context, listen: true);
// ----------------------------------------------------------------------------
//     final CoFlyer         coFlyer           = pro.;
    final String          flyerID           = pro.flyerID;
    final BzModel         bz                = bro;
    final bool            flyerShowsAuthor  = pro.flyerShowsAuthor;
    final String          authorID          = pro.authorID;
    final int             numberOfSlides    = pro.slides?.length;
    // final List<CoFlyer>   bzGalleryCoFlyers = pro.;
    final List<AuthorModel>  bzAuthors         = bro.authors;
    final AuthorModel       author          = bzAuthors?.singleWhere((au) => au.userID == authorID, orElse: ()=> null);
    final List<SlideModel>   slides          = pro.slides;
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
// ---------------------------------------------------------------------------
    double flyerZoneWidth = superFlyerZoneWidth(context, widget.flyerSizeFactor);
// ---------------------------------------------------------------------------
    bool _barIsOn = widget.slidingIsOn == true && bzPageIsOn == false ? true : false;
// ---------------------------------------------------------------------------
    bool microMode = superFlyerMicroMode(context, flyerZoneWidth);
// ---------------------------------------------------------------------------
    // bool ankhIsOn = true;//flyerData.flyerAnkhIsOn;
// ---------------------------------------------------------------------------
    final bool bolbol = widget.flyerModel?.flyerShowsAuthor;
    print('bolbol is : $bolbol : $flyerID');

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

          Consumer<FlyerModel>(
            builder: (context, pro, _) =>
             Header(
              flyerZoneWidth: flyerZoneWidth,
              bz: bz,
              flyerShowsAuthor: flyerShowsAuthor,
              bzPageIsOn: bzPageIsOn,
              tappingHeader: () {switchBzPage();},
              tappingFollow: (){
                print('followIsOn : ${bro.followIsOn}');
                bro.toggleFollow();
                },
              tappingUnfollow: () {print('UnFollow Tapped');},
              // bzGalleryCoFlyers: bzGalleryCoFlyers,
              author: author,
              followIsOn: bro.followIsOn,
            ),
          ),

          ProgressBar(
            flyerZoneWidth: flyerZoneWidth,
            barIsOn: _barIsOn,
            currentSlide: widget.currentSlideIndex >= numberOfSlides ? 0 : widget.currentSlideIndex,
            numberOfSlides: numberOfSlides,
          ),

          Consumer<FlyerModel>(
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






