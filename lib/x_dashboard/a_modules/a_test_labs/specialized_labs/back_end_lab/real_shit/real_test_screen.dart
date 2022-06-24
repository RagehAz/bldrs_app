import 'dart:async';

import 'package:bldrs/a_models/counters/flyer_counter_model.dart';
import 'package:bldrs/a_models/secondary_models/map_model.dart';
import 'package:bldrs/a_models/secondary_models/record_model.dart';
import 'package:bldrs/b_views/z_components/buttons/settings_wide_button.dart';
import 'package:bldrs/b_views/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/b_views/z_components/layouts/custom_layouts/centered_list_layout.dart';
import 'package:bldrs/b_views/z_components/streamers/fire_coll_streamer.dart';
import 'package:bldrs/b_views/z_components/texting/data_strip.dart';
import 'package:bldrs/e_db/fire/fire_models/query_parameters.dart';
import 'package:bldrs/e_db/fire/foundation/paths.dart';
import 'package:bldrs/e_db/fire/ops/auth_ops.dart';
import 'package:bldrs/e_db/real/real.dart';
import 'package:bldrs/e_db/real/real_colls.dart';
import 'package:bldrs/e_db/real/real_http.dart';
import 'package:bldrs/f_helpers/drafters/colorizers.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/numeric.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/timerz.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/back_end_lab/real_shit/real_coll_streamer.dart';
import 'package:flutter/material.dart';

class RealTestScreen extends StatelessWidget {

  const RealTestScreen({
    Key key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    const String _collName = 'colors';
    const String _dummyDocName = 'colorID';

    return CenteredListLayout(
      columnChildren: <Widget>[

        /// CREATE
        SettingsWideButton(
          verse: 'CREATE',
          onTap: () async {

            final Color _color = createRandomColor();

            final Map<String, dynamic> _map = {
              'index' : createRandomIndex(listLength: 10),
              'color' : cipherColor(_color),
            };

            final Map<String, dynamic> _maw = await Real.createDoc(
              context: context,
              collName: _collName,
              map: _map,
              addDocIDToOutput: true,
            );

            blogMap(_maw, methodName: 'MAW IS');

          },
        ),

        /// CREATE NAMED
        SettingsWideButton(
          verse: 'CREATE NAMED',
          onTap: () async {

            final Color _color = createRandomColor();

            final Map<String, dynamic> _map = {
              // 'id' : createUniqueID().toString(),
              'color' : cipherColor(_color),
            };

            await Real.createNamedDoc(
                context: context,
                collName: _collName,
                docName: _dummyDocName,
                map: _map,
            );

          },
        ),

        /// READ
        SettingsWideButton(
          verse: 'READ',
          onTap: () async {

            final Map<String, dynamic> _map = await Real.readDoc(
                context: context,
                collName: _collName,
                docName: _dummyDocName,
            );

            blogMap(_map, methodName: 'REAL READ DOC TEST');

          },
        ),

        /// READ ONCE
        SettingsWideButton(
          verse: 'READ ONCE',
          onTap: () async {

            final Map<String, dynamic> _map = await Real.readDocOnce(
              context: context,
              collName: _collName,
              docName: _dummyDocName,
            );

            blogMap(_map, methodName: 'REAL READ DOC TEST');

          },
        ),

        /// UPDATE
        SettingsWideButton(
          verse: 'UPDATE',
          onTap: () async {

            final Color _color = createRandomColor();

            final Map<String, dynamic> _map = {
              // 'id' : createUniqueID().toString(),
              'color' : cipherColor(_color),
              'name' : 'Ahmed',
            };

            await Real.updateDoc(
              context: context,
              collName: _collName,
              docName: _dummyDocName,
              map: _map,
            );

          },
        ),

        /// UPDATE FIELD
        SettingsWideButton(
          verse: 'UPDATE FIELD',
          onTap: () async {

            await Real.updateDocField(
              context: context,
              collName: _collName,
              docName: _dummyDocName,
              fieldName: 'name',
              value: 'diko',
            );

          },
        ),

        /// DELETE FIELD
        SettingsWideButton(
          verse: 'DELETE FIELD',
          onTap: () async {

            await Real.deleteField(
              context: context,
              collName: _collName,
              docName: _dummyDocName,
              fieldName: 'name',
            );

          },
        ),

        /// DELETE DOC
        SettingsWideButton(
          verse: 'DELETE DOC',
          onTap: () async {

            await Real.deleteDoc(
                context: context,
                collName: _collName,
                docName: _dummyDocName,
            );

          },
        ),

        Container(
          width: superScreenWidth(context),
          height: superScreenHeight(context) * .5,
          color: Colorz.bloodTest,
          child: const RealCollStreamer(),
        ),

      ],
    );

  }
}
