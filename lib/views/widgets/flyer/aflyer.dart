import 'package:bldrs/controllers/drafters/animators.dart';
import 'package:bldrs/controllers/drafters/sliders.dart';
import 'package:bldrs/controllers/drafters/launchers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/firestore/auth_ops.dart';
import 'package:bldrs/firestore/record_ops.dart';
import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/models/tiny_models/tiny_flyer.dart';
import 'package:bldrs/providers/flyers_provider.dart';
import 'package:bldrs/views/widgets/flyer/parts/flyer_zone.dart';
import 'package:bldrs/views/widgets/flyer/parts/flyer_header.dart';
import 'package:bldrs/views/widgets/flyer/parts/pages_parts/slides_page_parts/footer_parts/ankh_button.dart';
import 'package:bldrs/views/widgets/flyer/parts/pages_parts/slides_page_parts/slides_parts/slides_old.dart';
import 'package:bldrs/views/widgets/flyer/parts/progress_bar_parts/strips.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NormalFlyerWidget extends StatefulWidget {
  final FlyerModel flyer;
  final double flyerSizeFactor;
  final Function onSwipeFlyer;

  NormalFlyerWidget({
    @required this.flyer,
    @required this.flyerSizeFactor,
    this.onSwipeFlyer,
  });

  @override
  _NormalFlyerWidgetState createState() => _NormalFlyerWidgetState();
}

class _NormalFlyerWidgetState extends State<NormalFlyerWidget> with AutomaticKeepAliveClientMixin{
  @override
  bool get wantKeepAlive => true;
  bool _bzPageIsOn;
  int _currentSlideIndex;
  bool _ankhIsOn;
  String _user;
  FlyersProvider _pro;
  bool _followIsOn;
// -----------------------------------------------------------------------------
  @override
  void initState() {
    // UserModel _user = Provider.of<UserModel>(context, listen: false);
    _pro = Provider.of<FlyersProvider>(context, listen: false);
    _ankhIsOn = _pro.checkAnkh(widget.flyer.flyerID);
    _followIsOn = _pro.checkFollow(widget.flyer.tinyBz.bzID);
    _currentSlideIndex = 0;//= widget.initialSlide ?? 0;
    _bzPageIsOn = false;
    super.initState();
  }
// -----------------------------------------------------------------------------
  void switchBzPage (){
    setState(() {_bzPageIsOn = !_bzPageIsOn;});
    print('bzPageIsOn : $_bzPageIsOn');
  }
// -----------------------------------------------------------------------------
  /// SLIDING BLOCK
  /// usage :  onPageChanged: (i) => _onPageChanged(i),
  SwipeDirection _swipeDirection = SwipeDirection.next;
  void _onPageChanged (int newIndex){
    print('flyer onPageChanged oldIndex: $_currentSlideIndex, newIndex: $newIndex, _numberOfSlides: ${widget.flyer.slides.length}');
    SwipeDirection _direction = Animators.getSwipeDirection(newIndex: newIndex, oldIndex: _currentSlideIndex,);
    setState(() {
      _swipeDirection = _direction;
      _currentSlideIndex = newIndex;
    });
  }
// -----------------------------------------------------------------------------
  /// SLIDING BLOCK
  /// usage :  onPageChanged: (i) => _onPageChanged(i),
  // bool _slidingNext;
  // void _onPageChanged (int newIndex){
  //   _slidingNext = Animators.slidingNext(newIndex: newIndex, currentIndex: currentSlide,);
  //   setState(() {currentSlide = newIndex;})
  //   ;}
// -----------------------------------------------------------------------------
  Future<void> _tapAnkh(String flyerID, int slideIndex) async {

    /// start save flyer ops
      await RecordOps.saveFlyerOps(
        context: context,
        userID: superUserID(),
        flyerID: flyerID,
        slideIndex: slideIndex
      );

      TinyFlyer _tinyFlyer = TinyFlyer.getTinyFlyerFromFlyerModel(widget.flyer);

      /// add or remove tiny flyer in local saved flyersList
      _pro.addOrDeleteTinyFlyerInLocalSavedTinyFlyers(_tinyFlyer);

    setState(() {
      _ankhIsOn = !_ankhIsOn;
    });
    print('ankh is $_ankhIsOn');
  }
// -----------------------------------------------------------------------------
  Future<void> _onFollowTap(String bzID) async {

    /// start follow bz ops
    List<String> _updatedBzFollows = await RecordOps.followBzOPs(
      context: context,
      bzID: bzID,
      userID: superUserID(),
    );

    /// add or remove tinyBz from local followed bzz
    _pro.updatedFollowsInLocalList(_updatedBzFollows);

    /// trigger current follow value
    setState(() {
      _followIsOn = !_followIsOn;
    });
  }
// -----------------------------------------------------------------------------
  Future<void> _onCallTap() async {

    String _userID = superUserID();
    String _bzID = widget.flyer.tinyBz.bzID;
    String _contact = widget.flyer.tinyAuthor.email;

    /// alert user there is no contact to call
    if (_contact == null){print('no contact here');}

    /// or launch call and start call bz ops
    else {

        /// launch call
        launchCall('tel: $_contact');

        /// start call bz ops
        await RecordOps.callBzOPs(
          context: context,
          bzID: _bzID,
          userID: _userID,
          slideIndex: _currentSlideIndex,
        );

      }

  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    super.build(context);
    print('Building flyer : ${widget.flyer?.flyerID}');

    final double _flyerZoneWidth = Scale.superFlyerZoneWidth(context, widget.flyerSizeFactor);
// -----------------------------------------------------------------------------
    bool _barIsOn = _bzPageIsOn == false ? true : false;
// -----------------------------------------------------------------------------
    bool _microMode = Scale.superFlyerMicroMode(context, _flyerZoneWidth);
// -----------------------------------------------------------------------------
    return FlyerZone(
      flyerSizeFactor: widget.flyerSizeFactor,
      tappingFlyerZone: (){},
      stackWidgets: <Widget>[

        if (widget.flyer != null)
        Slides(
          flyerID: widget.flyer?.flyerID,
          slides: widget.flyer?.slides,
          flyerZoneWidth: _flyerZoneWidth,
          slidingIsOn: true,
          onPageChanged: (index) => _onPageChanged(index),
          currentSlideIndex: _currentSlideIndex,
          onSwipeFlyer: widget.onSwipeFlyer,
          onTap: (){
            print('tapping slide in aFlyer widget');
          },
        ),

        if (widget.flyer != null)
        FlyerHeader(
          tinyBz: widget.flyer.tinyBz,
          tinyAuthor: widget.flyer.tinyAuthor,
          flyerZoneWidth: _flyerZoneWidth,
          bzPageIsOn: _bzPageIsOn,
          tappingHeader: () {switchBzPage();},
          onFollowTap: () => _onFollowTap(widget.flyer.tinyBz.bzID),
          onCallTap: _onCallTap,
          flyerShowsAuthor: widget.flyer?.flyerShowsAuthor,
          followIsOn: _followIsOn,
          stripBlurIsOn: true,
        ),

        if (widget.flyer != null)
        Strips(
          flyerZoneWidth: _flyerZoneWidth,
          numberOfStrips: widget.flyer?.slides?.length,
          barIsOn: _barIsOn,
          slideIndex: _currentSlideIndex,
          swipeDirection: _swipeDirection,
        ),

        AnkhButton(
            bzPageIsOn: _bzPageIsOn,
            flyerZoneWidth: _flyerZoneWidth,
            slidingIsOn: true,
            ankhIsOn: _ankhIsOn,
            tappingAnkh: () => _tapAnkh(widget.flyer.flyerID, _currentSlideIndex),
        ),

      ],
    );
  }
}
