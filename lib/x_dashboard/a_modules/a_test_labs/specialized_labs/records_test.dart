import 'package:bldrs/a_models/secondary_models/record_model.dart';
import 'package:bldrs/b_views/z_components/buttons/settings_wide_button.dart';
import 'package:bldrs/b_views/z_components/layouts/custom_layouts/centered_list_layout.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/streamers/fire_coll_streamer.dart';
import 'package:bldrs/b_views/z_components/texting/data_strip.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/e_db/fire/fire_models/query_parameters.dart';
import 'package:bldrs/e_db/fire/ops/auth_ops.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/e_db/fire/foundation/firestore.dart' as Fire;

class RecordsTestScreen extends StatelessWidget {

  const RecordsTestScreen({
    Key key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return CenteredListLayout(
      columnChildren: <Widget>[

        SettingsWideButton(
          verse: 'create save flyer record',
          icon: Iconz.addFlyer,
          onTap: () async {
            
            final RecordModel _recordModel = RecordModel.createSaveRecord(
                userID: superUserID(), 
                flyerID: 'flyerID',
                slideIndex: 0,
            );
            
            final DocumentReference<Object> _docRef = await Fire.createDoc(
                context: context,
                collName: 'nour',
                input: _recordModel.toMap(toJSON: false),
            );

            blog('doc ref id is : ${_docRef.id}');
            
          },
        ),


        Container(
          width: superScreenWidth(context),
          height: superScreenHeight(context),
          color: Colorz.bloodTest,
          child: FireCollStreamer(
            queryParameters: const QueryModel(
              collName: 'nour',
              limit: 100,
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
