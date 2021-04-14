import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/models/sub_models/author_model.dart';
import 'package:bldrs/models/sub_models/slide_model.dart';
import 'package:bldrs/models/tiny_models/tiny_bz.dart';
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
  final int initialSlide;
  final bool slidingIsOn;
  final Function tappingFlyerZone;
  final Function rebuildFlyerGrid;
  final bool flyerIsInGalleryNow;

  Flyer({
    @required this.flyerSizeFactor,
    this.bz,
    this.initialSlide = 0,
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
  int _currentSlideIndex;
// ---------------------------------------------------------------------------
  @override
  void initState() {
    _currentSlideIndex = widget.initialSlide ?? 0;
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
    setState(() {_currentSlideIndex = slideIndex;});
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
    super.build(context);
    final _flyer = Provider.of<FlyerModel>(context, listen: false);
    final _bz = Provider.of<BzModel>(context, listen: true);
// ----------------------------------------------------------------------------
    final String _flyerID = _flyer?.flyerID;
    final String _authorID = _flyer?.tinyAuthor?.userID;
    final AuthorModel _author = AuthorModel.getAuthorFromBzByAuthorID(_bz, _flyer.tinyAuthor.userID);//createAuthorModelFromUserModelAndBzModel(geebUserByUserID(_authorID), _bz);
    final bool _flyerShowsAuthor = _flyer?.flyerShowsAuthor;
    final int _numberOfSlides = _flyer?.slides?.length ?? 0;
    // print('authorID is = ${_author.userID}');
    // final List<CoFlyer>   bzGalleryCoFlyers = pro.;
    // final List<AuthorModel>  bzAuthors         = bro.authors;
    // final AuthorModel       author          = bzAuthors?.singleWhere((au) => au.userID == authorID, orElse: ()=> null);
    final List<SlideModel>   _slides          = _flyer?.slides;
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
    double _flyerZoneWidth = superFlyerZoneWidth(context, widget.flyerSizeFactor);
// ---------------------------------------------------------------------------
    bool _barIsOn = widget.slidingIsOn == true && bzPageIsOn == false ? true : false;
// ---------------------------------------------------------------------------
    bool _microMode = superFlyerMicroMode(context, _flyerZoneWidth);
// ---------------------------------------------------------------------------
    // bool ankhIsOn = true;//flyerData.flyerAnkhIsOn;
// ---------------------------------------------------------------------------
//     print('flyer widget builds fID : $_flyerID');

    return

       FlyerZone(
         flyerSizeFactor: superFlyerSizeFactor(context, _flyerZoneWidth),
         tappingFlyerZone: widget.tappingFlyerZone,
         stackWidgets: <Widget>[

          Slides(
            flyerID: _flyerID,
            flyerZoneWidth: _flyerZoneWidth,
            slidingIsOn: widget.slidingIsOn,
            currentSlideIndex: _currentSlideIndex,
            sliding: slidingPages,
            slides: _slides,
          ),

          Consumer<BzModel>(
            builder: (context, bz, _) =>
             Header(
              flyerZoneWidth: _flyerZoneWidth,
              tinyBz: TinyBz.getTinyBzFromBzModel(bz),
              tinyAuthor: AuthorModel.getTinyAuthorFromAuthorModel(_author),
              flyerShowsAuthor: _flyerShowsAuthor,
              bzPageIsOn: bzPageIsOn,
              tappingHeader: () {switchBzPage();},
              onFollowTap: (){
                // TASK : fix following issue
                // print('followIsOn : ${bz.followIsOn}');
                // bz.toggleFollow();
                },
              followIsOn: false, // TASK : fix following issue
               onCallTap: (){},
            ),
          ),

          ProgressBar(
            flyerZoneWidth: _flyerZoneWidth,
            barIsOn: _barIsOn,
            currentSlide: _currentSlideIndex >= _numberOfSlides ? 0 : _currentSlideIndex,
            numberOfSlides: _numberOfSlides,
          ),

          Consumer<FlyerModel>(
            builder: (context, flyer, _) =>
                AnkhButton(
                  flyerZoneWidth: _flyerZoneWidth,
                  // flyerID: flyerID,
                  bzPageIsOn: bzPageIsOn,
                  slidingIsOn: widget.slidingIsOn,
                  microMode: _microMode,
                  ankhIsOn: flyer?.ankhIsOn ?? false,
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






