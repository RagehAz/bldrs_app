import 'package:bldrs/controllers/drafters/launchers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/firestore/auth_ops.dart';
import 'package:bldrs/firestore/record_ops.dart';
import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/models/tiny_models/tiny_flyer.dart';
import 'package:bldrs/providers/flyers_provider.dart';
import 'package:bldrs/views/widgets/flyer/parts/ankh_button.dart';
import 'package:bldrs/views/widgets/flyer/parts/flyer_zone.dart';
import 'package:bldrs/views/widgets/flyer/parts/header.dart';
import 'package:bldrs/views/widgets/flyer/parts/progress_bar.dart';
import 'package:bldrs/views/widgets/flyer/parts/slides.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AFlyer extends StatefulWidget {
  final FlyerModel flyer;
  final double flyerSizeFactor;
  final Function swipe;

  AFlyer({
    @required this.flyer,
    @required this.flyerSizeFactor,
    this.swipe,
  });

  @override
  _AFlyerState createState() => _AFlyerState();
}

class _AFlyerState extends State<AFlyer> with AutomaticKeepAliveClientMixin{
  bool get wantKeepAlive => true;
  bool _bzPageIsOn;
  int _currentSlideIndex;
  bool _ankhIsOn;
  String _user;
  FlyersProvider _pro;
  bool _followIsOn;
// ---------------------------------------------------------------------------
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
// ---------------------------------------------------------------------------
  void switchBzPage (){
    setState(() {_bzPageIsOn = !_bzPageIsOn;});
    print('bzPageIsOn : $_bzPageIsOn');
  }
// ---------------------------------------------------------------------------
  void _slidingPages (int slideIndex){
    print('sliding pages recieved slideIndex :  $slideIndex');
    setState(() {_currentSlideIndex = slideIndex;});
    print('rebuild parent flyer with _currentSlideIndex : $_currentSlideIndex');

  }
// ---------------------------------------------------------------------------
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
// ---------------------------------------------------------------------------
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
// ---------------------------------------------------------------------------
  Future<void> _onCallTap() async {

    String _userID = superUserID();
    String _bzID = widget.flyer.tinyBz.bzID;
    String _contact = widget.flyer.tinyAuthor.contact;

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
// ---------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    super.build(context);
    print('Building flyer : ${widget.flyer?.flyerID}');

    final double _flyerZoneWidth = Scale.superFlyerZoneWidth(context, widget.flyerSizeFactor);
// ---------------------------------------------------------------------------
    bool _barIsOn = _bzPageIsOn == false ? true : false;
// ---------------------------------------------------------------------------
    bool _microMode = Scale.superFlyerMicroMode(context, _flyerZoneWidth);
// ---------------------------------------------------------------------------
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
          sliding: (index) => _slidingPages(index),
          currentSlideIndex: _currentSlideIndex,
          swipeFlyer: widget.swipe,
        ),

        if (widget.flyer != null)
        Header(
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
        ProgressBar(
          flyerZoneWidth: _flyerZoneWidth,
          numberOfSlides: widget.flyer?.slides?.length,
          barIsOn: _barIsOn,
          currentSlide: _currentSlideIndex,
        ),

        AnkhButton(
            microMode: _microMode,
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
