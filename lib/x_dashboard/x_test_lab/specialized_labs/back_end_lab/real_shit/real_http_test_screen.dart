import 'package:bldrs/a_models/g_counters/flyer_counter_model.dart';
import 'package:bldrs/a_models/x_secondary/record_model.dart';
import 'package:bldrs/b_views/z_components/buttons/settings_wide_button.dart';
import 'package:bldrs/b_views/z_components/layouts/custom_layouts/centered_list_layout.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/streamers/fire/fire_coll_streamer.dart';
import 'package:bldrs/b_views/z_components/texting/data_strip/data_strip.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/e_back_end/b_fire/fire_models/query_parameters.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/firestore.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/paths.dart';
import 'package:bldrs/e_back_end/x_ops/fire_ops/auth_fire_ops.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real_colls.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real_http.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/numeric.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:flutter/material.dart';

class RealHttpTestScreen extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const RealHttpTestScreen({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return CenteredListLayout(
      columnChildren: <Widget>[

        /// RECORD CREATION
        SettingsWideButton(
          verse: Verse.plain('CREATE RECORD'),
          icon: Iconz.addFlyer,
          onTap: () async {

            final String _randomID = Numeric.createUniqueID().toString();

            final RecordModel _recordModel = RecordModel.createSaveRecord(
              userID: AuthFireOps.superUserID(),
              flyerID: _randomID,
              slideIndex: 0,
            );

            await RealHttp.createDoc(
              context: context,
              collName: 'testRecords',
              input: _recordModel.toMap(toJSON: true),
            );

            // blog('doc ref id is : ${_docRef.id}');

          },
        ),

        /// CREATE NEW FLYER COUNTER
        SettingsWideButton(
          verse: Verse.plain('CREATE NEW FLYER COUNTER ( flyerID )'),
          icon: Iconz.addFlyer,
          onTap: () async {

            const String _randomID = 'flyerID';//createUniqueID().toString();

            final FlyerCounterModel _flyerStats = FlyerCounterModel.createInitialModel(_randomID);

            await RealHttp.createNamedDoc(
              context: context,
              collName: RealColl.countingBzz,
              docName: _flyerStats.flyerID,
              input: _flyerStats.copyWith(saves: 15402).toMap(),
            );

            // blog('doc ref id is : ${_docRef.id}');

          },
        ),

        /// UPDATE EXISTING FLYER COUNTER ( 1656001361010677 )
        SettingsWideButton(
          verse: Verse.plain('UPDATE FLYER COUNTER flyerID'),
          icon: Iconz.addFlyer,
          onTap: () async {

            final String _randomID = Numeric.createUniqueID().toString();

            final FlyerCounterModel _flyerStats = FlyerCounterModel.createInitialModel(_randomID);

            await RealHttp.updateDoc(
              context: context,
              collName: RealColl.countingFlyers,
              docName: 'flyerID',
              input: _flyerStats.copyWith(saves: 65464564054054).toMap(),
            );

            // blog('doc ref id is : ${_docRef.id}');

          },
        ),

        /// READ FLYER COUNTER
        SettingsWideButton(
          verse: Verse.plain('READ FLYER SCOUNTER'),
          icon: Iconz.addFlyer,
          onTap: () async {

            final Map<String, dynamic> _map = await RealHttp.readDoc(
                context: context,
                collName: RealColl.countingFlyers,
                docName: 'flyerID',
            );

            Mapper.blogMap(_map, invoker: 'REAL FUCKING TIME MAP IS :');

          },
        ),

        /// READ FLYER COUNTER
        SettingsWideButton(
          verse: Verse.plain('READ FLYER COUNTER'),
          icon: Iconz.addFlyer,
          onTap: () async {

            final Map<String, dynamic> _map = await RealHttp.readDoc(
              context: context,
              collName: RealColl.countingFlyers,
              docName: 'flyerID',
            );


            Mapper.blogMap(_map, invoker: 'REAL FUCKING TIME MAP IS :');

          },
        ),


        /// https://ee27-102-186-98-33.ngrok.io
        SettingsWideButton(
          verse: Verse.plain('TEST'),
          icon: Iconz.addFlyer,
          onTap: () async {

            final Map<String, dynamic> _map = await RealHttp.readDoc(
              context: context,
              collName: RealColl.countingFlyers,
              docName: 'flyerID',
            );


            Mapper.blogMap(_map, invoker: 'REAL FUCKING TIME MAP IS :');

          },
        ),

        Container(
          width: Scale.superScreenWidth(context),
          height: Scale.superScreenHeight(context),
          color: Colorz.bloodTest,
          child: FireCollStreamer(
            queryModel: FireQueryModel(
              collRef: Fire.createSuperCollRef(aCollName: FireColl.records),
              limit: 100,
              onDataChanged: (List<Map<String, dynamic>> newMaps){
                blog('realHTTPTestScreen : FireCollStreamer : onDataChanged : $newMaps');
              }
            ),
            builder: (_, List<Map<String, dynamic>> maps){

              return ListView.builder(
                itemCount: maps.length,
                  // padding: EdgeInsets.zero, /// AGAIN => ENTA EBN WES5A
                  itemBuilder: (_, int index){

                  final Map<String, dynamic> _map = maps[index];

                  return DataStrip(
                      dataKey: _map['id'],
                      dataValue: _map.toString(),
                  );

                  }
              );

            },
          ),
        ),

      ],
    );

  }
}
