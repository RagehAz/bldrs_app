import 'dart:async';

import 'package:bldrs/a_models/counters/flyer_counter_model.dart';
import 'package:bldrs/a_models/secondary_models/record_model.dart';
import 'package:bldrs/b_views/z_components/buttons/settings_wide_button.dart';
import 'package:bldrs/b_views/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/b_views/z_components/layouts/custom_layouts/centered_list_layout.dart';
import 'package:bldrs/b_views/z_components/streamers/fire/fire_coll_streamer.dart';
import 'package:bldrs/b_views/z_components/texting/data_strip.dart';
import 'package:bldrs/e_db/fire/fire_models/query_parameters.dart';
import 'package:bldrs/e_db/fire/foundation/paths.dart';
import 'package:bldrs/e_db/fire/ops/auth_ops.dart';
import 'package:bldrs/e_db/real/real.dart';
import 'package:bldrs/e_db/real/real_colls.dart';
import 'package:bldrs/e_db/real/real_http.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/numeric.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:flutter/material.dart';

class RealHttpTestScreen extends StatelessWidget {

  const RealHttpTestScreen({
    Key key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return CenteredListLayout(
      columnChildren: <Widget>[

        /// RECORD CREATION
        SettingsWideButton(
          verse: 'CREATE RECORD',
          icon: Iconz.addFlyer,
          onTap: () async {

            final String _randomID = createUniqueID().toString();

            final RecordModel _recordModel = RecordModel.createSaveRecord(
              userID: superUserID(),
              flyerID: _randomID,
              slideIndex: 0,
            );

            await RealHttp.createDoc(
              context: context,
              collName: RealColl.records,
              input: _recordModel.toMap(toJSON: true),
            );

            // blog('doc ref id is : ${_docRef.id}');

          },
        ),

        /// CREATE NEW FLYER COUNTER
        SettingsWideButton(
          verse: 'CREATE NEW FLYER COUNTER ( flyerID )',
          icon: Iconz.addFlyer,
          onTap: () async {

            const String _randomID = 'flyerID';//createUniqueID().toString();

            final FlyerCounterModel _flyerStats = FlyerCounterModel.createInitialModel(_randomID);

            await RealHttp.createNamedDoc(
              context: context,
              collName: RealColl.bzzCounters,
              docName: _flyerStats.flyerID,
              input: _flyerStats.copyWith(saves: 15402).toMap(),
            );

            // blog('doc ref id is : ${_docRef.id}');

          },
        ),

        /// UPDATE EXISTING FLYER COUNTER ( 1656001361010677 )
        SettingsWideButton(
          verse: 'UPDATE FLYER COUNTER flyerID',
          icon: Iconz.addFlyer,
          onTap: () async {

            final String _randomID = createUniqueID().toString();

            final FlyerCounterModel _flyerStats = FlyerCounterModel.createInitialModel(_randomID);

            await RealHttp.updateDoc(
              context: context,
              collName: RealColl.flyersCounters,
              docName: 'flyerID',
              input: _flyerStats.copyWith(saves: 65464564054054).toMap(),
            );

            // blog('doc ref id is : ${_docRef.id}');

          },
        ),

        /// READ FLYER COUNTER
        SettingsWideButton(
          verse: 'READ FLYER SCOUNTER',
          icon: Iconz.addFlyer,
          onTap: () async {

            final Map<String, dynamic> _map = await RealHttp.readDoc(
                context: context,
                collName: RealColl.flyersCounters,
                docName: 'flyerID',
            );

            blogMap(_map, methodName: 'REAL FUCKING TIME MAP IS :');

          },
        ),

        /// READ FLYER COUNTER
        SettingsWideButton(
          verse: 'READ FLYER COUNTER',
          icon: Iconz.addFlyer,
          onTap: () async {

            final Map<String, dynamic> _map = await RealHttp.readDoc(
              context: context,
              collName: RealColl.flyersCounters,
              docName: 'flyerID',
            );


            blogMap(_map, methodName: 'REAL FUCKING TIME MAP IS :');

          },
        ),

        /// INCREMENT FLYER COUNTER
        SettingsWideButton(
          verse: 'INCREMENT FLYER COUNTER',
          icon: Iconz.addFlyer,
          onTap: () async {

            unawaited(TopDialog.showTopDialog(
                context: context,
                firstLine: 'sending request to nour')
            );


            // await CounterOps.incrementFlyerCounter(
            //   context: context,
            //   flyerID: 'flyerID',
            //   fieldName: 'shares',
            //   collName: 'bzzCounters',
            //   increment: true,
            // );


            const int _numberOfTimes = 1000;

            final List<Future<dynamic>> futures = <Future<dynamic>>[];

            for (int i = 0; i < _numberOfTimes; i++){
              futures.add(Real.incrementDocField(
                context: context,
                docID: 'flyerID',
                fieldName: 'shares',
                collName: 'bzzCounters',
                increment: true,
              ));
            }

            await Future.wait(futures);

            // blogMap(_map, methodName: 'REAL FUCKING TIME MAP IS :');


            await TopDialog.showTopDialog(
                context: context,
                firstLine: '$_numberOfTimes requestS sent',
            );

            // blogMap(_map, methodName: 'REAL FUCKING TIME MAP IS :');

          },
        ),

        Container(
          width: superScreenWidth(context),
          height: superScreenHeight(context),
          color: Colorz.bloodTest,
          child: FireCollStreamer(
            queryParameters: FireQueryModel(
              collName: FireColl.records,
              limit: 100,
              onDataChanged: (List<Map<String, dynamic>> newMaps){

              }
            ),
            builder: (_, List<Map<String, dynamic>> maps){

              return ListView.builder(
                itemCount: maps.length,
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
