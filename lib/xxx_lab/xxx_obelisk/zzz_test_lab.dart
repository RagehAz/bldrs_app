import 'dart:async';

import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/b_views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/widgets/general/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/widgets/general/layouts/navigation/max_bounce_navigator.dart';
import 'package:bldrs/b_views/widgets/general/textings/super_verse.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/final_flyer.dart';
import 'package:bldrs/d_providers/flyers_provider.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:bldrs/e_db/fire/methods/firestore.dart';
import 'package:bldrs/e_db/fire/methods/paths.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/xxx_dashboard/widgets/wide_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TestLab extends StatefulWidget {
  const TestLab({Key key}) : super(key: key);

  @override
  _TestLabState createState() => _TestLabState();
}

class _TestLabState extends State<TestLab> with SingleTickerProviderStateMixin {
  ScrollController _scrollController;
  AnimationController _animationController;

// -----------------------------------------------------------------------------
  /// --- FUTURE LOADING BLOCK
  bool _loading = false;
  Future<void> _triggerLoading({Function function}) async {
    if (mounted) {
      if (function == null) {
        setState(() {
          _loading = !_loading;
        });
      } else {
        setState(() {
          _loading = !_loading;
          function();
        });
      }
    }

    _loading == true
        ? blog('LOADING--------------------------------------')
        : blog('LOADING COMPLETE--------------------------------------');
  }

// -----------------------------------------------------------------------------
  @override
  void initState() {
    _scrollController = ScrollController();

    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    // works
    // Provider.of<FlyersProvider>(context,listen: false).fetchAndSetBzz();

    // hack around
    // Future.delayed(Duration.zero).then((_){
    //   Provider.of<FlyersProvider>(context,listen: true).fetchAndSetBzz();
    // });

    super.initState();
  }

// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      _triggerLoading().then((_) async {
        /// do Futures here
        unawaited(_triggerLoading(function: () {
          /// set new values here
        }));
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

// -----------------------------------------------------------------------------
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

// -----------------------------------------------------------------------------
  /// VALUE NOTIFIER
  final ValueNotifier<int> _counter = ValueNotifier<int>(0);
  void _incrementCounter() {
    _counter.value += 3;
  }
// -----------------------------------------------------------------------------
//   File _file;

  @override
  Widget build(BuildContext context) {
// -----------------------------------------------------------------------------
//     double _screenWidth = Scale.superScreenWidth(context);
    // double _screenHeight = Scale.superScreenHeight(context);
// -----------------------------------------------------------------------------

    // double _gWidth = _screenWidth * 0.4;
    // double _gHeight = _screenWidth * 0.6;

    // final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: true);

    return MainLayout(
      appBarType: AppBarType.basic,
      pyramids: Iconz.pyramidzYellow,
      loading: _loading,
      appBarRowWidgets: const <Widget>[],
      layoutWidget: Center(
        child: MaxBounceNavigator(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            controller: _scrollController,
            children: <Widget>[
              const Stratosphere(),

              /// AVOID SET STATE : WAY # 1
              ValueListenableBuilder<int>(
                  valueListenable: _counter,
                  child: Container(),
                  builder: (BuildContext ctx, int value, Widget child) {
                    return DreamBox(
                      height: 50,
                      width: 300,
                      verse: 'increment by 3 : $value',
                      verseScaleFactor: 0.6,
                      verseWeight: VerseWeight.black,
                      onTap: _incrementCounter,
                    );
                  }),

              /// AVOID SET STATE : WAY # 2
              Consumer<UiProvider>(
                builder:
                    (BuildContext ctx, UiProvider uiProvider, Widget child) {
                  final bool _loading = uiProvider.loading;
                  return DreamBox(
                    height: 50,
                    width: 300,
                    verse: '_loading is : $_loading',
                    verseScaleFactor: 0.6,
                    verseWeight: VerseWeight.black,
                    onTap: uiProvider.triggerLoading,
                  );
                },
              ),

              // /// AVOID SET STATE : WAY # 3
              // Selector<UiProvider, int>(
              //   selector: (_, UiProvider uiProvider) => uiProvider.theCounter,
              //   builder: (BuildContext ctx, int value, Widget child){
              //
              //     return
              //       DreamBox(
              //         height: 50,
              //         width: 300,
              //         verse: 'increment by 1 : $value',
              //         verseScaleFactor: 0.6,
              //         verseWeight: VerseWeight.black,
              //         onTap: _uiProvider.incrementCounter,
              //       );
              //
              //   },
              // ),

              /// Builder child pattern
              AnimatedBuilder(
                  animation: _animationController,
                  child: DreamBox(
                    height: 50,
                    width: 50,
                    verse: 'X',
                    verseScaleFactor: 0.6,
                    verseWeight: VerseWeight.black,
                    color: Colorz.bloodTest,
                    onTap: () => _animationController.forward(from: 0),
                  ),
                  builder: (BuildContext ctx, Widget child) {
                    return Transform.rotate(
                      angle: _animationController.value * 2.0 * 3.14,
                      child: child,

                      /// passing child here will prevent its rebuilding with each tick
                    );
                  }),

              /// DO SOMETHING
              WideButton(
                  color: Colorz.bloodTest,
                  verse: 'get maps',
                  icon: Iconz.share,
                  onTap: () async {
                    unawaited(_triggerLoading());

                    // final List<Map<String, dynamic>> _maps = await mapsByTwoValuesEqualTo(
                    //     context: context,
                    //     collRef: getCollectionRef(FireColl.bzz),
                    //     fieldA: 'id',
                    //     valueA: 'mn3',
                    //     fieldB: 'flyersIDs.0',
                    //     valueB: 'f013',
                    // );

                    QuerySnapshot<Object> _collectionSnapshot;

                    _collectionSnapshot = await getCollectionRef(FireColl.bzz)
                        .where('id', isEqualTo: 'mn3')
                        .where('flyersIDs', isEqualTo: 'f013')
                        .get();

                    blog('is not equal to null aho');

                    final List<Map<String, dynamic>> _maps =
                        Mapper.getMapsFromQuerySnapshot(
                      querySnapshot: _collectionSnapshot,
                      addDocsIDs: false,
                      addDocSnapshotToEachMap: false,
                    );

                    Mapper.printMaps(_maps);

                    unawaited(_triggerLoading());
                  }),

              /// MANIPULATE LOCAL ASSETS TESTING
              // GestureDetector(
              //   onTap: () async {
              //
              //     _triggerLoading();
              //
              //     File file = await Imagers.getFileFromLocalRasterAsset(
              //       context: context,
              //       width: 200,
              //       localAsset: Iconz.BldrsAppIcon,
              //     );
              //
              //     if (file != null){
              //       setState(() {
              //         _file = file;
              //       });
              //
              //     }
              //
              //     _triggerLoading();
              //   },
              //   child: Container(
              //     width: 100,
              //     height: 100,
              //     color: Colorz.facebook,
              //     alignment: Alignment.center,
              //     child: SuperImage(
              //       _file ?? Iconz.DumAuthorPic,
              //       width: 100,
              //       height: 100,
              //
              //     ),
              //   ),
              // ),

              Selector<FlyersProvider, List<FlyerModel>>(
                selector: (_, FlyersProvider flyersProvider) => flyersProvider.promotedFlyers,
                builder: (BuildContext ctx, List<FlyerModel> flyers, Widget child){

                  FlyerModel _flyer;

                  return
                    FinalFlyer(
                      flyerBoxWidth: 300,
                      onSwipeFlyer: (){},
                      flyerModel: _flyer,
                    );

                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}
