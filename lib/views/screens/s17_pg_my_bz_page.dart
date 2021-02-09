import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/user_model.dart';
import 'package:bldrs/providers/flyers_provider.dart';
import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/views/widgets/flyer/parts/flyer_zone.dart';
import 'package:bldrs/views/widgets/flyer/parts/header.dart';
import 'package:bldrs/views/widgets/flyer/parts/slides_parts/single_slide.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart' show PyramidsHorizon, Stratosphere;
import 'package:provider/provider.dart';

class MyBzPage extends StatefulWidget {
  final UserModel userModel;

  MyBzPage({
    @required this.userModel,
});

  @override
  _MyBzPageState createState() => _MyBzPageState();
}

class _MyBzPageState extends State<MyBzPage> {
  bool _bzPageIsOn = false;
// ---------------------------------------------------------------------------
  void _triggerMaxHeader(){
    setState(() {
    _bzPageIsOn = !_bzPageIsOn;
    });
  }
// ---------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    String bzID = widget.userModel.followedBzzIDs[0];
    FlyersProvider prof = Provider.of<FlyersProvider>(context, listen: true);
    BzModel bz = prof.getBzByBzID(bzID);

    double _flyerSizeFactor = 0.7;
    double _flyerZoneWidth = superFlyerZoneWidth(context, _flyerSizeFactor);

    return SliverList(
      delegate: SliverChildListDelegate([

        Stratosphere(),

        Center(
          child: ChangeNotifierProvider.value(
            value: bz,
            child: FlyerZone(
              flyerSizeFactor: _flyerSizeFactor,
              tappingFlyerZone: (){print('fuck you');},
              stackWidgets: <Widget>[

                SingleSlide(
                  flyerZoneWidth: _flyerZoneWidth,
                  slideColor: Colorz.BloodRed,
                ),

                Header(
                  bz: bz,
                  author: bz.authors[0],
                  flyerShowsAuthor: true,
                  followIsOn: null,
                  flyerZoneWidth: _flyerZoneWidth,
                  bzPageIsOn: _bzPageIsOn,
                  tappingHeader: _triggerMaxHeader,
                  tappingFollow: null,
                  tappingUnfollow: null,
                ),

              ],
            ),
          ),
        ),

      ]),
    );
  }
}
