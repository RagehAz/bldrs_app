import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/sub_models/author_model.dart';
import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:flutter/material.dart';
import 'parts/flyer_zone.dart';
import 'parts/header.dart';

class BzCardPreview extends StatefulWidget {
  final BzModel bz;
  final AuthorModel author;
  final double flyerSizeFactor;

  BzCardPreview({
    @required this.bz,
    @required this.author,
    @required this.flyerSizeFactor,
});

  @override
  _BzCardPreviewState createState() => _BzCardPreviewState();
}

class _BzCardPreviewState extends State<BzCardPreview> {
  // -------------------------
  bool _bzPageIsOn = false;
  // -------------------------
  @override
  void initState() {
    _bzPageIsOn = false;
    super.initState();
  }

  void _triggerMaxHeader(){
    setState(() {_bzPageIsOn = !_bzPageIsOn;});
  }
  // ----------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return FlyerZone(
      flyerSizeFactor: widget.flyerSizeFactor,
      tappingFlyerZone: (){print('fuck you');},
      stackWidgets: <Widget>[

        Header(
          bz: widget.bz,
          author: widget.author,
          flyerShowsAuthor: true,
          followIsOn: false,
          flyerZoneWidth: superFlyerZoneWidth(context, widget.flyerSizeFactor),
          bzPageIsOn: _bzPageIsOn,
          tappingHeader: _triggerMaxHeader,
          tappingFollow: (){},
          tappingUnfollow: (){},
        ),

      ],
    );
  }
}
