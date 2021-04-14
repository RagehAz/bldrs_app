import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/firestore/auth/auth.dart';
import 'package:bldrs/firestore/crud/record_ops.dart';
import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/models/records/save_model.dart';
import 'package:bldrs/models/tiny_models/tiny_flyer.dart';
import 'package:bldrs/models/user_model.dart';
import 'package:bldrs/providers/flyers_provider.dart';
import 'package:bldrs/providers/users_provider.dart';
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

  AFlyer({
    @required this.flyer,
    @required this.flyerSizeFactor,
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
// ---------------------------------------------------------------------------
  @override
  void initState() {
    // UserModel _user = Provider.of<UserModel>(context, listen: false);
    _pro = Provider.of<FlyersProvider>(context, listen: false);
    _ankhIsOn = _pro.checkAnkh(widget.flyer.flyerID);
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
    setState(() {_currentSlideIndex = slideIndex;});
  }
// ---------------------------------------------------------------------------
  Future<void> _tapAnkh(String flyerID, int slideIndex) async {

    /// start save flyer ops
      await RecordCRUD.saveFlyerOps(
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
  @override
  Widget build(BuildContext context) {
    print('Building flyer : ${widget.flyer?.flyerID}');

    final double _flyerZoneWidth = superFlyerZoneWidth(context, widget.flyerSizeFactor);
// ---------------------------------------------------------------------------
    bool _barIsOn = _bzPageIsOn == false ? true : false;
// ---------------------------------------------------------------------------
    bool _microMode = superFlyerMicroMode(context, _flyerZoneWidth);
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
          sliding: _slidingPages,
          currentSlideIndex: _currentSlideIndex,
        ),

        if (widget.flyer != null)
        Header(
          tinyBz: widget.flyer.tinyBz,
          tinyAuthor: widget.flyer.tinyAuthor,
          flyerZoneWidth: _flyerZoneWidth,
          bzPageIsOn: _bzPageIsOn,
          tappingHeader: () {switchBzPage();},
          tappingFollow: (){},
          flyerShowsAuthor: widget.flyer?.flyerShowsAuthor,
          followIsOn: false,
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
