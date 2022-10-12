import 'dart:async';

import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/animators/clock_rebuilder.dart';
import 'package:bldrs/e_back_end/b_fire/widgets/fire_coll_streamer.dart';
import 'package:bldrs/e_back_end/b_fire/widgets/fire_doc_streamer.dart';
import 'package:bldrs/e_back_end/b_fire/fire_models/fire_query_model.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/fire.dart';
import 'package:bldrs/f_helpers/drafters/colorizers.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/numeric.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/timers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/x_dashboard/z_widgets/layout/dashboard_layout.dart';
import 'package:bldrs/x_dashboard/z_widgets/wide_button.dart';
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
  FireQueryModel _queryParameters;
// -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
// -----------
  Future<void> _triggerLoading({bool setTo}) async {
    if (mounted == true){
      if (setTo == null){
        _loading.value = !_loading.value;
      }
      else {
        _loading.value = setTo;
      }
      blogLoading(loading: _loading.value, callerName: 'StreamingTest',);
    }
  }
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    _queryParameters = FireQueryModel(
      collRef: Fire.getSuperCollRef(aCollName: 'testing'),
      limit: 100,
      orderBy: const QueryOrderBy(fieldName: 'time', descending: true),
      onDataChanged: onDataChanged,
    );

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
  /// TAMAM
  @override
  void dispose() {
    _loading.dispose();
    _localMaps.dispose();
    super.dispose();
  }
// -----------------------------------------------------------------------------
  final ValueNotifier<List<Map<String, dynamic>>> _localMaps = ValueNotifier(<Map<String, dynamic>>[]);

  Future<void> onDataChanged(List<Map<String, dynamic>> newMaps) async {

    _localMaps.value = newMaps;

    // final bool _result = await CenterDialog.showCenterDialog(
    //   context: context,
    //   title: 'New data has arrived !',
    //   body: 'Would you like to update local Data ?',
    //   boolDialog: true,
    // );
    //
    // if (_result == true){
    //   _localMaps.value = newMaps;
    //   unawaited(
    //     TopDialog.showTopDialog(
    //       context: context,
    //       firstLine: 'Local Data is synced',
    //       seconds: 1,
    //     )
    //   );
    // }

  }

// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    blog('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');

    return DashBoardLayout(
      pageTitle: 'Streaming Test',
        loading: _loading,
        onBldrsTap: (){



        },
        listWidgets: <Widget>[

          FireDocStreamer(
              collName: 'testing',
              docName: 'NGavNzHByT4vDm925mYd',
              onDataChanged: (BuildContext ctx, Map<String, dynamic> oldMap, Map<String, dynamic> newMaw){

                blog('streamed map old :-');
                Mapper.blogMap(oldMap);
                blog('streamed map new :-');
                Mapper.blogMap(newMaw);

              },
              builder: (_, Map<String, dynamic> map){

                return WideButton(
                  verse: Verse.plain('Add Data'),
                  color: Colorizer.decipherColor(map['color']),
                  onTap: () async {

                    await Fire.createDoc(
                      context: context,
                      collName: 'testing',
                      input: {
                        'time' : Timers.cipherTime(time: DateTime.now(), toJSON: false),
                        'id' : Numeric.createUniqueID(),
                        'color' : Colorizer.cipherColor(Colorizer.createRandomColor()),
                      },
                    );

                    await Dialogs.showSuccessDialog(context : context);

                  },
                );

              }
          ),


          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              /// left stream
              SizedBox(
                width: Scale.superScreenWidth(context) * 0.5,
                child: FireCollStreamer(
                  queryModel: _queryParameters,
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
                width: Scale.superScreenWidth(context) * 0.5,
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
    this.mapIsFromJSON = false,
    Key key
  }) : super(key: key);

  final Map<String, dynamic> map;
  final bool mapIsFromJSON;

  @override
  Widget build(BuildContext context) {

    return ClockRebuilder(
      startTime: Timers.decipherTime(time: map['time'], fromJSON: mapIsFromJSON),
      builder: (int seconds, Widget child){

        final DateTime _time = Timers.createClockFromSeconds(seconds);
        final String _mmss = Timers.generateString_hh_i_mm_i_ss(_time);

        return DreamBox(
          height: 100,
          width: 100,
          verse: Verse.plain(map['id']),
          verseColor: Colorz.white30,
          verseShadow: false,
          iconSizeFactor: 0.5,
          secondLine: Verse.plain('( $_mmss )'),
          color: Colorizer.decipherColor(map['color']),
          verseCentered: false,
          onTap: () async {

            blog(map['id']);

            final Color _newColor = Colorizer.createRandomColor();

            await Fire.updateDocField(
              context: context,
              collName: 'testing',
              docName: map['id'],
              field: 'color',
              input: Colorizer.cipherColor(_newColor),
            );

          },
        );

      },
    );
  }
}
