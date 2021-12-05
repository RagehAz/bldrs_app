import 'package:bldrs/controllers/drafters/scalers.dart' as Scale;
import 'package:bldrs/controllers/drafters/sliders.dart' as Sliders;
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/flyer/flyer_model.dart';
import 'package:bldrs/views/widgets/specific/flyer/final_flyer.dart';
import 'package:bldrs/views/widgets/specific/flyer/parts/flyer_zone_box.dart';
import 'package:flutter/material.dart';

class FlyersShelfListBuilder extends StatefulWidget {
  final List<FlyerModel> flyers;
  final double flyerSizeFactor;
  final Function flyerOnTap;
  final Function onScrollEnd;

  const FlyersShelfListBuilder({
    @required this.flyers,
    @required this.flyerSizeFactor,
    @required this.flyerOnTap,
    this.onScrollEnd,
    Key key,
}) : super(key: key);

  @override
  _FlyersShelfListBuilderState createState() => _FlyersShelfListBuilderState();
}

class _FlyersShelfListBuilderState extends State<FlyersShelfListBuilder> {
  final ScrollController _controller = ScrollController();
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _controller.addListener(listenToScrolling);
  }
// -----------------------------------------------------------------------------
  void listenToScrolling(){
    if(_controller.position.atEdge){
      print('at edge');
      final bool isTop = _controller.position.pixels == 0;
      print('isTOp is : $isTop');

      if(isTop){
        print('we reached the scroll start');
      } else {
        print('we reached the scroll end');
        if (widget.onScrollEnd != null){
          widget.onScrollEnd();
        }
      }

    }
  }
// -----------------------------------------------------------------------------
  bool _absorbingFlyerTap(){
    bool _absorbing;

    if (widget.flyerOnTap == null){
      _absorbing = false;
    }
    else {
      _absorbing = true;
    }

    return _absorbing;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final List<FlyerModel> _flyers = widget.flyers;
    final double _flyerBoxWidth = FlyerBox.width(context, widget.flyerSizeFactor);

    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemCount: _flyers.length,
      controller: _controller,
      scrollDirection: Axis.horizontal,
      padding: Scale.superPadding(
        context: context,
        enLeft: Ratioz.appBarMargin,
        enRight: _flyerBoxWidth,
        bottom: 0,
        top: 0,
      ),

      // cacheExtent: screenHeight*5,
      // dragStartBehavior: DragStartBehavior.start,
      separatorBuilder: (BuildContext context, int _y) => const SizedBox(height: 1,width: Ratioz.appBarMargin,),
      // key: const PageStorageKey<String>('flyers'),
      // cacheExtent: screenHeight*5,
      itemBuilder: (BuildContext context, int _x) {

        // print('_flyers[_x].flyerID = ${_flyers[_x].flyerID}');

        // SuperFlyer _superFlyer = SuperFlyer.createViewSuperFlyerFromTinyFlyer(
        //     context: context,
        //     flyerBoxWidth: _flyerBoxWidth,
        //     tinyFlyer: _flyers[_x],
        //     onMicroFlyerTap: null,
        //     onAnkhTap: null
        // );

        return

          // --- works
          // ChangeNotifierProvider.value(
          //   value: _flyers[_x],
          //   child: ChangeNotifierProvider.value(
          //     value: _tinyBzz[_x],
          //     // child:
          //     // Flyer(
          //     //   flyerSizeFactor: flyerSizeFactor,
          //     //   slidingIsOn: _slidingIsOn,
          //     //   tappingFlyerZone: (){
          //     //     openFlyer(context, _flyers[_x].flyerID);
          //     //     // _slidingIsOff = false;
          //     //     },
          //     // ),
          ///
          //     // FlyerZone(
          //     //   flyerSizeFactor: flyerSizeFactor,
          //     //   stackWidgets: <Widget>[
          //     //
          //     //     MiniHeader(
          //     //
          //     //     )
          //     //
          //     //     SingleSlide(
          //     //         flyerBoxWidth: superFlyerBoxWidth(context, flyerSizeFactor),
          //     //
          //     //     ),
          //     //
          //     //   ],
          //     // ),
          //
          //   ),
          // )
        ///
          // TinyFlyerWidget(
          //   superFlyer: _superFlyer,
          //   // flyerSizeFactor: widget.flyerSizeFactor,
          //   // tinyFlyer: _flyers[_x],
          //   // onTap: (tinyFlyer){
          //   //
          //   //   if (widget.flyerOnTap == null){
          //   //     Nav().openFlyer(context, tinyFlyer.flyerID);
          //   //   }
          //   //
          //   //   else {
          //   //     widget.flyerOnTap(tinyFlyer);
          //   //   }
          //   //
          //   // },
          // );
        ///
          GestureDetector(
            onTap: widget.flyerOnTap == null ? null : (){
              widget.flyerOnTap(_flyers[_x]);
            },
            child: AbsorbPointer(
              absorbing: _absorbingFlyerTap(),
              child: FinalFlyer(
                flyerBoxWidth: _flyerBoxWidth,
                flyerModel: _flyers[_x],
                onSwipeFlyer: (Sliders.SwipeDirection direction){
                  // print('Direction is ${direction}');
                },
              ),
            ),
          );

      },

    );
  }
}
