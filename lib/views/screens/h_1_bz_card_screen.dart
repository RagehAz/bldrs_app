import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/streamerz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/models/super_flyer.dart';
import 'package:bldrs/models/tiny_models/tiny_bz.dart';
import 'package:bldrs/models/tiny_models/tiny_user.dart';
import 'package:bldrs/views/widgets/flyer/parts/flyer_zone.dart';
import 'package:bldrs/views/widgets/flyer/parts/flyer_header.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:flutter/material.dart';

class BzCardScreen extends StatefulWidget {
  final String bzID;

  BzCardScreen({
    @required this.bzID,
});

  @override
  _BzCardScreenState createState() => _BzCardScreenState();
}

class _BzCardScreenState extends State<BzCardScreen> {
  bool _bzPageIsOn = false;

  void _triggerMaxHeader(){
    setState(() {
      _bzPageIsOn = !_bzPageIsOn;
    });
  }

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
      //         flyerZoneWidth: superFlyerZoneWidth(context, flyerSizeFactor),
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

          double _flyerZoneWidth = Scale.superFlyerZoneWidth(context, flyerSizeFactor);

          SuperFlyer _superFlyer = SuperFlyer.getSuperFlyerFromBzModelOnly(_flyerZoneWidth, bz);

          return
            FlyerZone(
                  flyerSizeFactor: flyerSizeFactor,
                  onFlyerZoneTap: (){print('fuck you');},
                  stackWidgets: <Widget>[

                    FlyerHeader(
                      superFlyer: _superFlyer,
                      // tinyBz: TinyBz.getTinyBzFromBzModel(bz),
                      // tinyAuthor: TinyUser.getTinyAuthorFromAuthorModel(bz.bzAuthors[0]),
                      // flyerShowsAuthor: true,
                      // followIsOn: false, // TASK : fix following on/off issue
                      // flyerZoneWidth: Scale.superFlyerZoneWidth(context, flyerSizeFactor),
                      // bzPageIsOn: _bzPageIsOn,
                      // tappingHeader: _triggerMaxHeader,
                      // onCallTap: (){},
                      // onFollowTap: () async {
                      //   // await bz.toggleFollow();
                      //   // setState(() {});
                      //   // print('rebuilding widget with new followIsOn value : ${bz.followIsOn}');
                      // },
                    ),

                  ],
                );
        }
      ),

    );
  }
}
