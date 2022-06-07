import 'dart:async';

import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/b_views/z_components/streamers/clock_rebuilder.dart';
import 'package:bldrs/b_views/z_components/streamers/streamer.dart';
import 'package:bldrs/e_db/fire/foundation/firestore.dart' as Fire;
import 'package:bldrs/f_helpers/drafters/colorizers.dart' as Colorizers;
import 'package:bldrs/f_helpers/drafters/numeric.dart' as Numeric;
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/timerz.dart' as Timers;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/x_dashboard/b_widgets/layout/dashboard_layout.dart';
import 'package:bldrs/x_dashboard/b_widgets/wide_button.dart';
import 'package:flutter/material.dart';

class StreamingTest extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const StreamingTest({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  _StreamingTestState createState() => _StreamingTestState();
/// --------------------------------------------------------------------------
}

class _StreamingTestState extends State<StreamingTest> {
// -----------------------------------------------------------------------------
  /// --- LOCAL LOADING BLOCK
  final ValueNotifier<bool> _loading = ValueNotifier(false); /// tamam disposed
// -----------------------------------
  Future<void> _triggerLoading() async {
    _loading.value = !_loading.value;
    blogLoading(
      loading: _loading.value,
      callerName: 'BzAuthorsPage',
    );
  }
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

  }
// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      _triggerLoading().then((_) async {


        await _triggerLoading();
      });

      _isInit = false;
    }
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    _loading.dispose();
    super.dispose(); /// tamam
  }
// -----------------------------------------------------------------------------
  final ValueNotifier<List<Map<String, dynamic>>> _localMaps = ValueNotifier(<Map<String, dynamic>>[]);

  Future<void> onDataChanged(List<Map<String, dynamic>> newMaps) async {

    final bool _result = await CenterDialog.showCenterDialog(
      context: context,
      title: 'New data has arrived !',
      body: 'Would you like to update local Data ?',
      boolDialog: true,
    );

    if (_result == true){
      _localMaps.value = newMaps;
      unawaited(
        TopDialog.showTopDialog(
          context: context,
          firstLine: 'Local Data is synced',
          seconds: 1,
        )
      );
    }

  }

// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    blog('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');

    return DashBoardLayout(
      pageTitle: 'Streaming Test',
        loading: _loading,
        listWidgets: <Widget>[

          WideButton(
            verse: 'Add Data',
            onTap: () async {

              await Fire.createDoc(
                  context: context,
                  collName: 'testing',
                  input: {
                    'time' : Timers.cipherTime(time: DateTime.now(), toJSON: false),
                    'id' : Numeric.createUniqueID(),
                    'color' : Colorizers.cipherColor(Colorizers.createRandomColor()),
                  },
              );

              await TopDialog.showSuccessDialog(context : context);

            },
          ),

          Row(
            children: <Widget>[

              /// left stream
              SizedBox(
                width: superScreenWidth(context) * 0.5,
                child: FireCollStreamer(
                  collName: 'testing',
                  limit: 100,
                  orderBy: const Fire.QueryOrderBy(fieldName: 'time', descending: true),
                  onDataChanged: onDataChanged,
                  builder: (_, List<Map<String, dynamic>> _maps){

                    return Column(
                      children: <Widget>[

                        ...List.generate(_maps.length, (index){

                          return ColorButton(
                              map: _maps[index],
                          );

                        }),

                      ],
                    );

                  },
                ),
              ),

              /// right local
              SizedBox(
                width: superScreenWidth(context) * 0.5,
                child: ValueListenableBuilder(
                  valueListenable: _localMaps,
                  builder: (_, List<Map<String, dynamic>> maps, Widget child){

                    return Column(
                      children: <Widget>[

                        ...List.generate(maps.length, (index){

                          return ColorButton(
                            map: maps[index],
                          );

                        }),


                      ],
                    );

                  },
                ),
              ),

            ],
          ),


        ],
    );

  }
}


class ColorButton extends StatelessWidget {

  const ColorButton({
    @required this.map,
    Key key
  }) : super(key: key);

  final Map<String, dynamic> map;

  @override
  Widget build(BuildContext context) {

    return ClockRebuilder(
      startTime: Timers.decipherTime(time: map['time'], fromJSON: false),
      builder: (int seconds){

        final DateTime _time = Timers.createClockFromSeconds(seconds);
        final String _mmss = Timers.generateString_hh_i_mm_i_ss(_time);

        return DreamBox(
          height: 60,
          width: superScreenWidth(context) * 0.5,
          verse: map['id'],
          verseColor: Colorz.white30,
          verseShadow: false,
          iconSizeFactor: 0.9,
          secondLine: '( $_mmss )',
          color: Colorizers.decipherColor(map['color']),
          verseCentered: false,
          onTap: () async {

            blog(map['id']);

            final Color _newColor = Colorizers.createRandomColor();

            await Fire.updateDocField(
              context: context,
              collName: 'testing',
              docName: map['id'],
              field: 'color',
              input: Colorizers.cipherColor(_newColor),
            );

          },
        );

      },
    );
  }
}
