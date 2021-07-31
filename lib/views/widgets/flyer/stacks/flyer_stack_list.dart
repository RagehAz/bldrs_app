import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/spacers.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/tiny_models/tiny_flyer.dart';
import 'package:bldrs/views/widgets/flyer/final_flyer.dart';
import 'package:flutter/material.dart';

class FlyerStackList extends StatefulWidget {
  final List<TinyFlyer> tinyFlyers;
  final double flyerSizeFactor;
  final Function flyerOnTap;
  final Function onScrollEnd;

  FlyerStackList({
    @required this.tinyFlyers,
    @required this.flyerSizeFactor,
    @required this.flyerOnTap,
    this.onScrollEnd,
});

  @override
  _FlyerStackListState createState() => _FlyerStackListState();
}

class _FlyerStackListState extends State<FlyerStackList> {
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

    List<TinyFlyer> _tinyFlyers = widget.tinyFlyers;

    double _flyerZoneWidth = Scale.superFlyerZoneWidth(context, widget.flyerSizeFactor);

    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemCount: _tinyFlyers.length,
      controller: _controller,
      scrollDirection: Axis.horizontal,
      padding: Spacers.superPadding(
        context: context,
        enLeft: Ratioz.appBarMargin,
        enRight: _flyerZoneWidth,
        bottom: 0,
        top: 0,
      ),
      addAutomaticKeepAlives: true,

      // cacheExtent: screenHeight*5,
      // dragStartBehavior: DragStartBehavior.start,
      separatorBuilder: (context, _y) => SizedBox(height: 1,width: Ratioz.appBarMargin,),
      // key: const PageStorageKey<String>('flyers'),
      // cacheExtent: screenHeight*5,
      itemBuilder: (context,_x) {

        // print('_tinyFlyers[_x].flyerID = ${_tinyFlyers[_x].flyerID}');

        // SuperFlyer _superFlyer = SuperFlyer.createViewSuperFlyerFromTinyFlyer(
        //     context: context,
        //     flyerZoneWidth: _flyerZoneWidth,
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
          //     //         flyerZoneWidth: superFlyerZoneWidth(context, flyerSizeFactor),
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
          FinalFlyer(
            flyerZoneWidth: _flyerZoneWidth,
            tinyFlyer: _tinyFlyers[_x],
            goesToEditor: false,
          );

      },

    );
  }
}
