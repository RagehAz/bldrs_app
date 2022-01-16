import 'dart:math';

import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/flyer/mutables/super_flyer.dart';
import 'package:bldrs/b_views/widgets/general/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/widgets/general/layouts/night_sky.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/final_flyer.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/flyer_zone_box.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/pages_parts/slides_page_parts/footer.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/d_providers/flyers_provider.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/xxx_lab/animations/hero.dart';
import 'package:bldrs/xxx_lab/new_flyer/abstract_flyer.dart';
import 'package:flutter/material.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:provider/provider.dart';

double _flyerWidthSizeFactor({
  @required double tween,
  @required double minFactor,
  @required double maxFactor,
}) {
  /// EW3AAA
  final double _flyerWidthSizeFactor =
      minFactor + (tween * (maxFactor - minFactor));
  return _flyerWidthSizeFactor;
}

Widget _flyerShuttle({
  @required BuildContext flightContext,
  @required Animation<double> animation, // 0 to 1
  @required HeroFlightDirection flightDirection,
  @required BuildContext fromHeroContext,
  @required BuildContext toHeroContext,
  @required Color color,
}) {
  blog('animation value is : ${animation.value}');

  // final UiProvider _uiProvider = Provider.of<UiProvider>(fromHeroContext, listen: false);
  // _uiProvider.setFlyerWidthFactor(tween: animation.value);
  // _setFactor(animation.value);

  final Hero toHero = toHeroContext.widget;
  final double _flyerBoxWidth = FlyerBox.width(fromHeroContext, 1);
  final double _flyerZoneHeight =
      FlyerBox.height(fromHeroContext, _flyerBoxWidth);
  final double _headerHeight = FlyerBox.headerBoxHeight(
      bzPageIsOn: false, flyerBoxWidth: _flyerBoxWidth);

  final double _footerHeight = FlyerFooter.boxHeight(
      context: fromHeroContext, flyerBoxWidth: _flyerBoxWidth);

  final double _flyerSmallWidth = FlyerBox.width(fromHeroContext, 0.4);
  final double _flyerSmallHeight =
      FlyerBox.height(fromHeroContext, _flyerSmallWidth);
  final double _flyerBigWidth = Scale.superScreenWidth(fromHeroContext);
  final double _flyerBigHeight =
      FlyerBox.height(fromHeroContext, _flyerBigWidth);

  /// 'push' if expanding --- 'pop' if contracting
  final String _curveName = flightDirection.name;

  final Curve _curve = _curveName == 'push' ? Curves.fastOutSlowIn : Curves.fastOutSlowIn.flipped;

  final Tween<double> _tween = _curveName == 'push' ?
  Tween<double>(begin: 0, end: 1)
      :
  Tween<double>(begin: 1, end: 0);

  // return  AbstractFlyer(sizeFactor: animation.value, color: Colors.red);

  /// ---
  return  TweenAnimationBuilder(
      tween: _tween,
      duration: Ratioz.duration150ms,
      curve: _curve,
      builder: (ctx, double value, Widget child){


        final double _sizeFactor = _flyerWidthSizeFactor(
          tween: value,
          maxFactor: 1,
          minFactor: 0.3,
        );


        return

          AbstractFlyer(
            sizeFactor: _sizeFactor,
            color: color,
          );

      }
  );
  ///
  // return FlyerTransition(
  //   animation: animation,
  //   flyerSmallWidth: _flyerSmallWidth,
  //   flyerBigWidth: _flyerBigWidth,
  //   flyerSmallHeight: _flyerSmallHeight,
  //   flyerBigHeight: _flyerBigHeight,
  //   child: AbstractFlyer(
  //     sizeFactor: _sizeFactor,
  //   ),
  // );
}

class TheFlyerScreen extends StatelessWidget {
  const TheFlyerScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double _flyerBoxWidth = 200;
    final SuperFlyer _superFlyer = SuperFlyer.createEmptySuperFlyer(
      flyerBoxWidth: _flyerBoxWidth,
      goesToEditor: false,
    );

    final FlyersProvider _flyersProvider =
        Provider.of<FlyersProvider>(context, listen: false);
    final FlyerModel _flyer2 = _flyersProvider.savedFlyers[2];
    final FlyerModel _flyer3 = _flyersProvider.savedFlyers[3];

    return MainLayout(
      historyButtonIsOn: false,
      pyramidsAreOn: true,
      zoneButtonIsOn: false,
      sectionButtonIsOn: false,
      appBarType: AppBarType.basic,
      skyType: SkyType.black,
      layoutWidget: Container(
        width: Scale.superScreenWidth(context),
        height: Scale.superScreenHeight(context),
        color: Colorz.blue10,
        child: Column(
          children: <Widget>[
            const Stratosphere(),
            HeroFlyerWidget(
              flyer: _flyer2,
              color: Colorz.green255,
            ),
            const Spacer(),
            HeroFlyerWidget(
              flyer: _flyer3,
              color: Colorz.red255,
            ),
          ],
        ),
      ),
    );
  }
}

class HeroFlyerWidget extends StatelessWidget {
  const HeroFlyerWidget({@required this.flyer, @required this.color, Key key})
      : super(key: key);

  final FlyerModel flyer;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushTransparentRoute(FlyerHeroPage(
          flyer: flyer,
          color: color,
        )
        );
      },
      child: Hero(
        tag: flyer.id,
        flightShuttleBuilder: (
          BuildContext flightContext,
          Animation<double> animation,
          HeroFlightDirection flightDirection,
          BuildContext fromHeroContext,
          BuildContext toHeroContext,
        ) {

          // return FadeTransition(
          //
          //   opacity:   animation,
          //
          //   //filterQuality: FilterQuality.high,
          //   child: (toHeroContext.widget as Hero).child,
          // );
          return _flyerShuttle(
            color: color,
            animation: animation,
            flightContext: flightContext,
            flightDirection: flightDirection,
            fromHeroContext: fromHeroContext,
            toHeroContext: toHeroContext,
          );
        },
        // child: AbsorbPointer(
        //   child: FinalFlyer(
        //     flyerBoxWidth: 150,
        //     flyerModel: flyer,
        //     onSwipeFlyer: (){
        //       blog('Swiping flyer');
        //     },
        //   ),
        // ),

        child: AbstractFlyer(
          sizeFactor: 0.3,
          color: color,
        ),
      ),
    );
  }
}

class FlyerHeroPage extends StatefulWidget {
  const FlyerHeroPage({
    this.flyer,
    @required this.color,
    Key key
  }) : super(key: key);
  final FlyerModel flyer;
  final Color color;
  @override
  State<FlyerHeroPage> createState() => _FlyerHeroPageState();
}

class _FlyerHeroPageState extends State<FlyerHeroPage> {
// -----------------------------------------------------------------------------

  // final ValueNotifier<double> _flyerFactor = ValueNotifier(1);
  // void _setFactor(double value){
  //   _flyerFactor.value = value;
  // }

  // double _flyerWidthSizeFactor({
  //   @required double tween,
  //   @required double minFactor,
  //   @required double maxFactor,
  // }){
  //   /// EW3AAA
  //   final double _flyerWidthSizeFactor = minFactor + (tween * (maxFactor - minFactor));
  //   return _flyerWidthSizeFactor;
  // }
  @override
  Widget build(BuildContext context) {
    final double _screenWidth = Scale.superScreenWidth(context);
    // final double _scaleFactor = 1; // 0.3 min <-> 1 max * _screenWidth

    return DismissiblePage(
      onDismiss: () => Navigator.of(context).pop(),
      isFullScreen: false,
      dragSensitivity: .4,
      maxTransformValue: 4,
      direction: DismissDirection.vertical,
      reverseDuration: Ratioz.duration150ms,

      child: Material(
        color: widget.color,
        type: MaterialType.transparency,
        child: Hero( /// howa ba2a ebn el wes5a da elly me7tageen nezbot el duration bta3o
          tag: widget.flyer.id,
          flightShuttleBuilder: (
            BuildContext flightContext,
            Animation<double> animation,
            HeroFlightDirection flightDirection,
            BuildContext fromHeroContext,
            BuildContext toHeroContext,
          ) {
            return _flyerShuttle(
              color: widget.color,
              animation: animation,
              flightContext: flightContext,
              flightDirection: flightDirection,
              fromHeroContext: fromHeroContext,
              toHeroContext: toHeroContext,
            );
          },
          // placeholderBuilder: (BuildContext context, Size size, Widget child){
          //
          //   blog('the fucking size is : $size');
          //
          //   final double _flyerWidthFactor = _flyerWidthSizeFactor(
          //     tween: size.width,
          //     minFactor: 0.3,
          //     maxFactor: 1,
          //   );
          //
          //   final double _flyerBoxWidth = _screenWidth * _flyerWidthFactor;
          //
          //   return
          //     Container(
          //       width: _flyerBoxWidth,
          //       height: FlyerBox.height(context, _flyerBoxWidth),
          //       color: Colorz.red255,
          //     );
          // },
          child: AbstractFlyer(
            sizeFactor: 1,
            color: widget.color,
          ),

          // Container(
          //   width: 100,
          //   height: FlyerBox.height(context, 100),
          //   color: Colorz.red255,
          // ),
        ),

        // child: ,

        // Consumer<UiProvider>(
        //   builder: (_, UiProvider uiProvider, Widget child){
        //
        //     final double _flyerWidthFactor = uiProvider.flyerWidthFactor;
        //     final double _flyerBoxWidth = _screenWidth * _flyerWidthFactor;
        //
        //     return
        //     Container(
        //       width: _flyerBoxWidth,
        //       height: FlyerBox.height(context, _flyerBoxWidth),
        //       color: Colorz.red255,
        //     );
        //
        //   },
        // ),

        // ValueListenableBuilder(
        //   valueListenable: _flyerFactor,
        //   builder: (_, double factor, Widget child){
        //
        //         final double _flyerWidthFactor = _flyerWidthSizeFactor(
        //             tween: factor,
        //             minFactor: 0.3,
        //             maxFactor: 1,
        //         );
        //
        //         final double _flyerBoxWidth = _screenWidth * _flyerWidthFactor;
        //
        //         blog('bitch is : $_flyerWidthFactor');
        //
        //         return
        //         ;
        //
        //   },
        // ),
      ),
    );
  }
}

// class StoryModel {
//   final storyId = UniqueKey();
//   final String title;
//   String imageUrl;
//
//   String get nextVehicleUrl =>
//       'https://source.unsplash.com/collection/1989985/${Random().nextInt(20) + 400}x${Random().nextInt(20) + 800}';
//
//   StoryModel({this.title, this.imageUrl}) {
//     imageUrl = nextVehicleUrl;
//   }
// }
