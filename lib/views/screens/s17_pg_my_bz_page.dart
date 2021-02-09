import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/user_model.dart';
import 'package:bldrs/providers/flyers_provider.dart';
import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/views/widgets/bubbles/in_pyramids_bubble.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/flyer/parts/flyer_zone.dart';
import 'package:bldrs/views/widgets/flyer/parts/header.dart';
import 'package:bldrs/views/widgets/flyer/parts/slides_parts/single_slide.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
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

    double _flyerSizeFactor = 0.70;
    double _flyerZoneWidth = superFlyerZoneWidth(context, _flyerSizeFactor);

    double _achievementsIconWidth = 60;

    return SliverList(
      delegate: SliverChildListDelegate([

        Stratosphere(),

        // --- ACHIEVEMENTS
        InPyramidsBubble(
          bubbleColor: Colorz.WhiteGlass,
          centered: true,
          columnChildren: <Widget>[

            GestureDetector(
              onTap: (){print('achievements are going to be awesome bitches');},
              child: Container(
                width: superBubbleClearWidth(context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    DreamBox(
                      height: _achievementsIconWidth,
                      width: _achievementsIconWidth,
                      bubble: false,
                      icon: Iconz.Achievement,
                    ),

                    Container(
                      width: superBubbleClearWidth(context) - _achievementsIconWidth,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[

                          SuperVerse(
                            verse: 'Achievements',
                            color: Colorz.Yellow,
                            size: 3,
                            maxLines: 2,
                          ),

                          SuperVerse(
                            verse: 'Perform specific tasks, '
                                'market your flyers, '
                                'grow your Bldrs network and reach your targeted customers.',
                            color: Colorz.Grey,
                            size: 2,
                            italic: true,
                            weight: VerseWeight.thin,
                            maxLines: 5,
                            centered: false,
                          ),

                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ),

          ],
        ),

        // --- BZ CARD
        Center(
          child: ChangeNotifierProvider.value(
            value: bz,
            child: Column(
              children: <Widget>[

                // --- Edit BZCARD
                Container(
                  width: _flyerZoneWidth,
                  height: _flyerZoneWidth * 0.14,
                  // color: Colorz.Facebook,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[

                      DreamBox(
                        // width: 30,
                        height: _flyerZoneWidth * 0.1,
                        icon: Iconz.Gears,
                        color: Colorz.WhiteGlass,
                        bubble: false,
                        iconSizeFactor: 0.6,
                        verse: 'Edit Your Business details',
                        verseItalic: true,
                        verseWeight: VerseWeight.thin,
                        boxMargins: EdgeInsets.symmetric(vertical : _flyerZoneWidth * 0.02),
                        boxFunction: (){print(30/_flyerZoneWidth);},
                      ),

                    ],
                  ),
                ),

                FlyerZone(
                  flyerSizeFactor: _flyerSizeFactor,
                  tappingFlyerZone: (){print('fuck you');},
                  stackWidgets: <Widget>[

                    SingleSlide(
                      flyerZoneWidth: _flyerZoneWidth,
                      slideColor: Colorz.WhiteSmoke,
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

              ],
            ),
          ),
        ),

        PyramidsHorizon(heightFactor: 5,),

      ]),
    );
  }
}
