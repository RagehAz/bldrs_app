import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:bldrs/views/widgets/flyer/header/header.dart';
import 'package:bldrs/views/widgets/flyer/header/max_header/max_header.dart';
import 'package:bldrs/views/widgets/flyer/header/mini_header/mini_header.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/pro_flyer/flyer_parts/flyer_zone.dart';
import 'package:flutter/material.dart';

class AddBzScreen2 extends StatefulWidget {
  @override
  _AddBzScreen2State createState() => _AddBzScreen2State();
}

class _AddBzScreen2State extends State<AddBzScreen2> {
  bool bzPageIsOn;
  // ----------------------------------------------------------------------
  void initState(){
    super.initState();
    bzPageIsOn = false;
  }
  // ----------------------------------------------------------------------
  void triggerMaxHeader(){
    setState(() {
      bzPageIsOn = !bzPageIsOn;
    });
  }
  // ----------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      layoutWidget: Stack(
        children: <Widget>[

          FlyerZone(
            flyerSizeFactor: 0.8,
            tappingFlyerZone: (){print('fuckyou');},
            stackWidgets: <Widget>[

              Header(
                  coBz: null,
                  coAuthor: null,
                  flyerShowsAuthor: true,
                  followIsOn: null,
                  flyerZoneWidth: superFlyerZoneWidth(context, 0.8),
                  bzPageIsOn: bzPageIsOn,
                  tappingHeader: triggerMaxHeader,
                  tappingFollow: null,
                  tappingUnfollow: null,
              ),

            ],
          ),

        ],
      ),
    );
  }
}
