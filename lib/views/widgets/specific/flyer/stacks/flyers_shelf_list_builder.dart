import 'package:bldrs/controllers/drafters/spacers.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/flyer/tiny_flyer.dart';
import 'package:bldrs/views/widgets/specific/flyer/final_flyer.dart';
import 'package:bldrs/views/widgets/specific/flyer/parts/flyer_zone_box.dart';
import 'package:flutter/material.dart';

class FlyersShelfListBuilder extends StatefulWidget {
  final List<TinyFlyer> tinyFlyers;
  final double flyerSizeFactor;
  final Function flyerOnTap;
  final Function onScrollEnd;

  const FlyersShelfListBuilder({
    @required this.tinyFlyers,
    @required this.flyerSizeFactor,
    @required this.flyerOnTap,
    this.onScrollEnd,
});

  @override
  _FlyersShelfListBuilderState createState() => _FlyersShelfListBuilderState();
}

class _FlyersShelfListBuilderState extends State<FlyersShelfListBuilder> {
  final _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(listenToScrolling);
  }

  void listenToScrolling(){
    if(_controller.position.atEdge){
      print('at edge');
      final bool isTop = _controller.position.pixels == 0;
      print('isTOp is : $isTop');

      if(isTop){
        print('we reached the top');
      } else {
        print('we reached the end');
        widget.onScrollEnd();
      }

    }
  }

  @override
  Widget build(BuildContext context) {

    final List<TinyFlyer> _tinyFlyers = widget.tinyFlyers;
    final double _flyerBoxWidth = FlyerBox.width(context, widget.flyerSizeFactor);

    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemCount: _tinyFlyers.length,
      controller: _controller,
      scrollDirection: Axis.horizontal,
      padding: Spacers.superPadding(
        context: context,
        enLeft: Ratioz.appBarMargin,
        enRight: _flyerBoxWidth,
        bottom: 0,
        top: 0,
      ),
      addAutomaticKeepAlives: true,

      // cacheExtent: screenHeight*5,
      // dragStartBehavior: DragStartBehavior.start,
      separatorBuilder: (context, _y) => const SizedBox(height: 1,width: Ratioz.appBarMargin,),
      // key: const PageStorageKey<String>('flyers'),
      // cacheExtent: screenHeight*5,
      itemBuilder: (context,_x) {

        // print('_tinyFlyers[_x].flyerID = ${_tinyFlyers[_x].flyerID}');

        // SuperFlyer _superFlyer = SuperFlyer.createViewSuperFlyerFromTinyFlyer(
        //     context: context,
        //     flyerBoxWidth: _flyerBoxWidth,
        //     tinyFlyer: _tinyFlyers[_x],
        //     onMicroFlyerTap: null,
        //     onAnkhTap: null
        // );

        return

          // --- works
          // ChangeNotifierProvider.value(
          //   value: _tinyFlyers[_x],
          //   child: ChangeNotifierProvider.value(
          //     value: _tinyBzz[_x],
          //     // child:
          //     // Flyer(
          //     //   flyerSizeFactor: flyerSizeFactor,
          //     //   slidingIsOn: _slidingIsOn,
          //     //   tappingFlyerZone: (){
          //     //     openFlyer(context, _tinyFlyers[_x].flyerID);
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
          //   // tinyFlyer: _tinyFlyers[_x],
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
              widget.flyerOnTap(_tinyFlyers[_x]);
            },
            child: AbsorbPointer(
              absorbing: widget.flyerOnTap == null ? false : true,
              child: FinalFlyer(
                flyerBoxWidth: _flyerBoxWidth,
                tinyFlyer: _tinyFlyers[_x],
                goesToEditor: false,

              ),
            ),
          );

      },

    );
  }
}
