import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/sub_models/author_model.dart';
import 'package:bldrs/models/tiny_models/tiny_bz.dart';
import 'package:bldrs/models/tiny_models/tiny_user.dart';
import 'package:bldrs/views/screens/x_0_flyer_editor_screen.dart';
import 'package:bldrs/views/widgets/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/flyer/parts/flyer_header.dart';
import 'package:bldrs/views/widgets/flyer/parts/flyer_zone.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

class BzCardPreview extends StatefulWidget {
  final BzModel bz;
  final AuthorModel author;
  final double flyerSizeFactor;
  final bool addFlyerButton;

  BzCardPreview({
    @required this.bz,
    @required this.author,
    @required this.flyerSizeFactor,
    this.addFlyerButton = false,
});

  @override
  _BzCardPreviewState createState() => _BzCardPreviewState();
}

class _BzCardPreviewState extends State<BzCardPreview> {
  bool _bzPageIsOn = false;
// -----------------------------------------------------------------------------
  @override
  void initState() {
    _bzPageIsOn = false;

    super.initState();
  }
// -----------------------------------------------------------------------------
  Future<void> _triggerMaxHeader() async {
    bool _mini = Scale.superFlyerMiniMode(context, Scale.superFlyerZoneWidth(context, widget.flyerSizeFactor));

    if (_mini == true && widget.addFlyerButton == false){
      // Nothing to be done
    } else if (_mini == true && widget.addFlyerButton == true){
      await _goToFlyerEditor();
    } else {
      setState(() {_bzPageIsOn = !_bzPageIsOn;});
    }

  }
// -----------------------------------------------------------------------------
  Future<void> _goToFlyerEditor() async {
    dynamic _result = await Nav.goToNewScreen(context,
        FlyerEditorScreen(
          firstTimer: true,
          bzModel: widget.bz,
          flyerModel: null,
        )
    );
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    double _flyerZoneWidth = Scale.superFlyerZoneWidth(context, widget.flyerSizeFactor);

    return FlyerZone(
      flyerSizeFactor: widget.flyerSizeFactor,
      onFlyerZoneTap: () async {
        if (widget.addFlyerButton){
          await _goToFlyerEditor();
          print('ohh');
        } else {
        print('fuck you');
        }

        },
      stackWidgets: <Widget>[

        // FlyerHeader(
        //   tinyBz: TinyBz.getTinyBzFromBzModel(widget.bz),
        //   tinyAuthor: TinyUser.getTinyAuthorFromAuthorModel(widget.author),
        //   flyerShowsAuthor: true,
        //   followIsOn: false,
        //   flyerZoneWidth: Scale.superFlyerZoneWidth(context, widget.flyerSizeFactor),
        //   bzPageIsOn: _bzPageIsOn,
        //   tappingHeader: () async {
        //     await _triggerMaxHeader();
        //   },
        //   onFollowTap: (){},
        //   onCallTap: (){},
        // ),

        // --- ADD FLYER BUTTON
        if (widget.addFlyerButton)
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            // --- FAKE HEADER FOOTPRINT
            SizedBox(
                height: Scale.superHeaderHeight(false, _flyerZoneWidth),
            ),

            DreamBox(
              height: _flyerZoneWidth * 0.4,
              width: _flyerZoneWidth * 0.4,
              icon: Iconz.Plus,
              iconColor: Colorz.White200,
              iconSizeFactor: 0.6,
              bubble: false,
              onTap: () async {
                await _goToFlyerEditor();
              },
            ),

            SuperVerse(
              verse: 'Add\nNew\nFlyer',
              maxLines: 5,
              size: 2,
              scaleFactor: widget.flyerSizeFactor * 5,
              color: Colorz.White200,
            ),

          ],
        ),

      ],
    );
  }
}
