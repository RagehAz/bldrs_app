import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/sliders.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/firestore/firestore.dart';
import 'package:bldrs/models/flyer/flyer_model.dart';
import 'package:bldrs/views/widgets/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/flyer/final_flyer.dart';
import 'package:bldrs/views/widgets/layouts/dashboard_layout.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class FlyersAuditor extends StatefulWidget {
  @override
  _FlyersAuditorState createState() => _FlyersAuditorState();
}

class _FlyersAuditorState extends State<FlyersAuditor> {
  PageController _pageController;
  List<FlyerModel> _flyers = [];
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
    _pageController = new PageController();
  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {

      _triggerLoading(function: (){}).then((_) async {
        /// ---------------------------------------------------------0

        _readMoreFlyers();

        /// ---------------------------------------------------------0
      });

    }
    _isInit = false;
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------
  QueryDocumentSnapshot _lastSnapshot;
  Future<void> _readMoreFlyers() async {

    List<dynamic> _maps = await Fire.readCollectionDocs(
      collectionName:  FireCollection.flyers,
      orderBy: 'flyerID',
      limit: 5,
      startAfter: _lastSnapshot,
      addDocSnapshotToEachMap: true,
    );

    List<FlyerModel> _fetchedModels = FlyerModel.decipherFlyersMaps(_maps);

    _fetchedModels[1].printFlyer();

    setState(() {
      _lastSnapshot = _maps[_maps.length - 1]['docSnapshot'];
      _flyers.addAll(_fetchedModels);
    });


  }
// -----------------------------------------------------------------------------


  @override
  Widget build(BuildContext context) {

    double _screenWidth = Scale.superScreenWidth(context);
    double _clearScreenHeight = DashBoardLayout.clearScreenHeight(context);
    const double _footerZoneHeight = 80;
    double _bodyZoneHeight = _clearScreenHeight - _footerZoneHeight;
    double _flyerSizeFactor = 0.7;

    return DashBoardLayout(
      pageTitle: 'Flyers Auditor',
      loading: false,
      listWidgets: <Widget>[

        Container(
          width: _screenWidth,
          height: _clearScreenHeight,
          child: Column(

            children: <Widget>[

              /// FLYERS
              Container(
                width: _screenWidth,
                height: _bodyZoneHeight,
                // color: Colorz.Yellow50,
                child:

                _flyers != null && _flyers.isNotEmpty == true ?

                PageView.builder(
                  scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemCount: _flyers.length,
                    controller: _pageController,
                    allowImplicitScrolling: true,
                    onPageChanged: (int i){
                    print('slide to page index : $i');
                    },
                    pageSnapping: true,
                    // scrollBehavior: ScrollBehavior().,
                    itemBuilder: (ctx, index){

                      return

                        FinalFlyer(
                          flyerZoneWidth: Scale.superFlyerZoneWidth(context, _flyerSizeFactor),
                          flyerModel: _flyers[index],
                          goesToEditor: false,
                          onSwipeFlyer: (SwipeDirection direction){
                            print('WTF : swiping the fucking flyer : direction is : $direction');

                            if (direction == SwipeDirection.next){
                              Sliders.slideToNext(_pageController, _flyers.length, index);
                            } else if (direction == SwipeDirection.back){
                              Sliders.slideToBackFrom(_pageController, index);
                            }

                          },
                        );

                    }
                )

                    :

                Container()

                ,
              ),

              /// BUTTONS
              Container(
                width: _screenWidth,
                height: _footerZoneHeight,
                // color: Colorz.Blue125,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[

                    AuditorButton(
                        verse: 'Ta3ala',
                        color: Colorz.Red255,
                        icon: Iconz.XSmall,
                        onTap: (){}
                    ),

                    AuditorButton(
                      verse: 'Tamam',
                      color: Colorz.Green255,
                      icon: Iconz.Check,
                      onTap: (){}
                    ),
                  ],
                ),
              ),

            ],

          ),
        ),

      ],
    );
  }

}

class AuditorButton extends StatelessWidget {
  final String verse;
  final Color color;
  final String icon;
  final Function onTap;

  const AuditorButton({
    @required this.verse,
    @required this.onTap,
    @required this.color,
    @required this.icon,
});

  @override
  Widget build(BuildContext context) {

    const int _numberOfItems = 2;
    double _buttonWidth = Scale.getUniformRowItemWidth(context, _numberOfItems);

    return DreamBox(
      height: 60,
      width: _buttonWidth,
      verse: verse,
      verseScaleFactor: 1.3,
      icon: icon,
      iconColor: Colorz.White230,
      iconSizeFactor: 0.5,
      onTap: onTap,
      color: color,
    );
  }
}
