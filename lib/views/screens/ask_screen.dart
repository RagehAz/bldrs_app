import 'package:bldrs/models/enums/enum_bz_type.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/views/widgets/ask/ask.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/space/pyramids_horizon.dart';
import 'package:bldrs/views/widgets/space/stratosphere.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

class AskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainLayout(
      layoutWidget: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            // key: ,
            delegate: SliverChildListDelegate(<Widget>[
              Stratosphere(),
              SuperVerse(
                verse: 'Go Bissssooooo Goooo',
                size: 5,
                shadow: true,
                color: Colorz.Yellow,
                margin: 10,
                weight: VerseWeight.black,
                labelColor: Colorz.GreenSmoke,
              ),
              SuperVerse(
                verse: '😇😇😇',
                size: 5,
                shadow: true,
                color: Colorz.Yellow,
                margin: 10,
                weight: VerseWeight.black,
                labelColor: Colorz.GreenSmoke,
              ),
              Ask(
                tappingAskInfo: () {
                  print('Ask info is tapped aho');
                },
              ),
              PyramidsHorizon(heightFactor: 10),
            ]),
          ),
        ],
      ),
    );
  }
}
