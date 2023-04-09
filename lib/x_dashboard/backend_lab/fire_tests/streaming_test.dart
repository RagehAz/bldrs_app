import 'dart:async';

import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/buttons/wide_button.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:space_time/space_time.dart';
import 'package:filers/filers.dart';
import 'package:bldrs/x_dashboard/zz_widgets/dashboard_layout.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:clock_rebuilder/clock_rebuilder.dart';
import 'package:colorizer/colorizer.dart';
import 'package:fire/fire.dart';
import 'package:flutter/material.dart';
import 'package:mapper/mapper.dart';
import 'package:numeric/numeric.dart';
import 'package:scale/scale.dart';

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
  FireQueryModel _queryParameters;
  final ValueNotifier<List<Map<String, dynamic>>> _localMaps = ValueNotifier(<Map<String, dynamic>>[]);
  // -----------------------------------------------------------------------------
  /*
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
// -----------
  Future<void> _triggerLoading({@required bool setTo}) async {
    setNotifier(
      notifier: _loading,
      mounted: mounted,
      value: setTo,
    );
  }
   */
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    _queryParameters = FireQueryModel(
      collRef: Fire.getSuperCollRef(aCollName: 'testing'),
      // idFieldName: 'id',
      limit: 100,
      orderBy: const QueryOrderBy(fieldName: 'time', descending: true),
    );

  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      // _triggerLoading(setTo: true).then((_) async {
      //
      //
      //   await _triggerLoading(setTo: false);
      // });

      _isInit = false;
    }
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void dispose() {
    // _loading.dispose();
    _localMaps.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  Future<void> onDataChanged(BuildContext ctx, Map<String, dynamic> oldMap, Map<String, dynamic> newMaw) async {

    blog('streamed map old :-');
    Mapper.blogMap(oldMap);
    blog('streamed map new :-');
    Mapper.blogMap(newMaw);

    // _localMaps.value  = newMaps;

    // final bool _result = await CenterDialog.showCenterDialog(
    //   context: context,
    //   title: 'New data has arrived !',
    //   body: 'Would you like to update local Data ?',
    //   boolDialog: true,
    // );
    //
    // if (_result == true){
    //   _localMaps.value  = newMaps;
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

    return DashBoardLayout(
      pageTitle: 'Streaming Test',
        // loading: _loading,
        // onBldrsTap: (){
        //
        // },
        listWidgets: <Widget>[

          FireDocStreamer(
              collName: 'testing',
              docName: 'NGavNzHByT4vDm925mYd',
              onDataChanged: onDataChanged,
              builder: (_, Map<String, dynamic> map){

                if (map == null){
                  return ColorButton(
                    map: {
                      'id' : Numeric.createUniqueID().toString(),
                      'time' : Timers.cipherTime(time: DateTime.now(), toJSON: false),
                      'color' : Colorizer.cipherColor(Colorizer.createRandomColor()),
                    },
                  );
                }

                else {
                   return WideButton(
                  verse: Verse.plain('Add Data'),
                  color: Colorizer.decipherColor(map['color']),
                  onTap: () async {

                    await Fire.createDoc(
                      collName: 'testing',
                      input: {
                        'time' : Timers.cipherTime(time: DateTime.now(), toJSON: false),
                        'id' : Numeric.createUniqueID().toString(),
                        'color' : Colorizer.cipherColor(Colorizer.createRandomColor()),
                      },
                    );

                    await Dialogs.showSuccessDialog(context : context);

                  },
                );
                }


              }
          ),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              /// left stream
              SizedBox(
                width: Scale.screenWidth(context) * 0.5,
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
                width: Scale.screenWidth(context) * 0.5,
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
  // -----------------------------------------------------------------------------
}

class ColorButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ColorButton({
    @required this.map,
    this.mapIsFromJSON = false,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Map<String, dynamic> map;
  final bool mapIsFromJSON;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return ClockRebuilder(
      startTime: Timers.decipherTime(
          time: map['time'],
          fromJSON: mapIsFromJSON,
      ),
      builder: (int seconds, Widget child){

        blog('the time is : $seconds');

        final DateTime _time = Timers.createClockFromSeconds(seconds);
        final String _mmss = Timers.generateString_hh_i_mm_i_ss(_time);

        return BldrsBox(
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
  /// --------------------------------------------------------------------------
}
