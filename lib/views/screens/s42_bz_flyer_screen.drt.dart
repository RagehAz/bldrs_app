import 'package:bldrs/controllers/drafters/iconizers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/streamerz.dart';
import 'package:bldrs/controllers/drafters/text_generators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:bldrs/firestore/crud/bz_ops.dart';
import 'package:bldrs/firestore/firestore.dart';
import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/tiny_models/tiny_bz.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/flyer/aflyer.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

class BzFlyerScreen extends StatelessWidget {
  final String flyerID;

  BzFlyerScreen({
    @required this.flyerID,
});

  @override
  Widget build(BuildContext context) {

    double _flyerSizeFactor = 0.75;

    return MainLayout(
      pyramids: Iconz.DvBlankSVG,
      appBarType: AppBarType.Basic,
      appBarBackButton: true,
      sky: Sky.Black,
      tappingRageh: () async {

        String _bzID = 'dr2';

        BzModel _bz = await BzCRUD.readBzOps(
          context: context,
          bzID: _bzID,
        );

        Map<String, dynamic> _tinyBzMap = await getFireStoreDocumentMap(
          context: context,
          collectionName: FireStoreCollection.tinyBzz,
          documentName: _bzID,
        );

        TinyBz _tinyBz = TinyBz.decipherTinyBzMap(_tinyBzMap);

        print(_tinyBz.bzLogo);
        print(_bz.bzLogo);

      },
      layoutWidget: flyerModelBuilder(
        context: context,
        flyerID: flyerID,
        flyerSizeFactor: _flyerSizeFactor,
        builder: (ctx, flyerModel){

          print(flyerModel.flyerID);
          print(flyerModel.tinyBz.bzZone.countryID);

          return
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[

                    Stratosphere(),

                    Container(
                      width: superFlyerZoneWidth(context, _flyerSizeFactor),
                      height: 50,
                      // color: Colorz.BloodTest,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[

                          // --- PUBLISH TIME
                          DreamBox(
                            height: 50,
                            icon: Iconizer.flyerTypeIconOn(flyerModel.flyerType),
                            verse: '${TextGenerator.flyerTypeSingleStringer(context, flyerModel.flyerType)} ${Wordz.flyer(context)}',
                            secondLine: '${TextGenerator.dayMonthYearStringer(context, flyerModel.publishTime)}',
                            iconSizeFactor: 0.6,
                            bubble: false,
                            verseWeight: VerseWeight.thin,
                            verseItalic: true,
                          ),

                          // --- EXPANDER
                          Expanded(child: Container()),

                          // --- MORE BUTTON
                          DreamBox(
                            height: 35,
                            width: 35,
                            icon: Iconz.More,
                            iconSizeFactor: 0.5,
                            bubble: false,
                          ),

                        ],
                      ),
                    ),

                    AFlyer(
                      flyer: flyerModel,
                      flyerSizeFactor: _flyerSizeFactor,
                    ),

                  ],

                ),
              );

        }
      ),
    );
  }
}
