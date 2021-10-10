import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/models/flyer/mutables/super_flyer.dart';
import 'package:bldrs/providers/streamers/bz_streamer.dart';
import 'package:bldrs/views/widgets/specific/flyer/parts/flyer_zone_box.dart';
import 'package:bldrs/views/widgets/specific/flyer/parts/flyer_header.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout.dart';
import 'package:flutter/material.dart';

class BzCardScreen extends StatefulWidget {
  final String bzID;
  final double flyerBoxWidth;

  BzCardScreen({
    @required this.bzID,
    @required this.flyerBoxWidth,
});

  @override
  _BzCardScreenState createState() => _BzCardScreenState();
}

class _BzCardScreenState extends State<BzCardScreen> {
  // bool _bzPageIsOn = false;

  // void _triggerMaxHeader(){
  //   setState(() {
  //     _bzPageIsOn = !_bzPageIsOn;
  //   });
  // }

  // void _tappingFollow(){
  //   print('follow is tapped');
  // }

  @override
  Widget build(BuildContext context) {
    print('building bz : ${widget.bzID}');

    // FlyersProvider pro = Provider.of<FlyersProvider>(context, listen: false);
    // final bz = pro.getBzByBzID(widget.bzID);


    double flyerSizeFactor = 0.8;

    return MainLayout(
      pyramids: Iconz.PyramidsYellow,

      // appBarType: AppBarType.Basic,
      // layoutWidget: ChangeNotifierProvider.value(
      //   value: bz,
      //   child: FlyerZone(
      //     flyerSizeFactor: flyerSizeFactor,
      //     tappingFlyerZone: (){print('fuck you');},
      //     stackWidgets: <Widget>[
      //
      //       Header(
      //         tinyBz: TinyBz.getTinyBzFromBzModel(bz),
      //         tinyAuthor: getTinyAuthorFromAuthorModel(bz.bzAuthors[0]),
      //         flyerShowsAuthor: true,
      //         followIsOn: false, // TASK : fix following on/off issue
      //         flyerBoxWidth: superFlyerBoxWidth(context, flyerSizeFactor),
      //         bzPageIsOn: _bzPageIsOn,
      //         tappingHeader: _triggerMaxHeader,
      //         tappingFollow: () async {
      //           // await bz.toggleFollow();
      //           // setState(() {});
      //           // print('rebuilding widget with new followIsOn value : ${bz.followIsOn}');
      //         },
      //         tappingUnfollow: null, // Task : delete unfollow function and combine all following operations in one method
      //       ),
      //
      //     ],
      //   ),
      // ),

      layoutWidget: bzModelBuilder(
        context: context,
        bzID: widget.bzID,
        builder: (ctx, bz){

          double _flyerBoxWidth = FlyerBox.width(context, flyerSizeFactor);

          SuperFlyer _superFlyer = SuperFlyer.getSuperFlyerFromBzModelOnly(
              bzModel: bz,
              onHeaderTap: (){print('onHeader tap in h 1 bz card screen');},
          );

          return
            FlyerBox(
              flyerBoxWidth: _flyerBoxWidth,
              superFlyer: _superFlyer,
              onFlyerZoneTap: (){print('tapping flyer zone in h 1 bz card screen ');},
              stackWidgets: <Widget>[

                FlyerHeader(
                  superFlyer: _superFlyer,
                  flyerBoxWidth: widget.flyerBoxWidth,
                ),

                  ],
                );
        }
      ),

    );
  }
}
