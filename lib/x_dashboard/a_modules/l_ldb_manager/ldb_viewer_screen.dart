import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/e_db/ldb/foundation/ldb_ops.dart';
import 'package:bldrs/f_helpers/drafters/colorizers.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/x_dashboard/a_modules/l_ldb_manager/value_box.dart';
import 'package:bldrs/x_dashboard/b_widgets/layout/dashboard_layout.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LDBViewerScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const LDBViewerScreen({
    @required this.ldbDocName,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final String ldbDocName;
  /// --------------------------------------------------------------------------
  static List<Widget> rows({
    @required BuildContext context,
    @required List<Map<String, Object>> maps,
    @required ValueChanged<Map<String, dynamic>> onRowOptionsTap,
    /// if there is field with name ['color']
    bool userColorField = false,
  }) {

    final double _screenWidth = Scale.superScreenWidth(context);
    final bool _bubbleIsOn = onRowOptionsTap != null;

    return List<Widget>.generate(maps?.length ?? 0, (int index) {

      final Map<String, Object> _map = maps[index];
      final List<Object> _keys = _map.keys.toList();
      final List<Object> _values = _map.values.toList();
      // final String _primaryValue = _map[_primaryKey];

      return SizedBox(
        width: _screenWidth,
        height: 42,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          children: <Widget>[

            /// MORE OPTIONS
            DreamBox(
              height: 37,
              width: 37,
              icon: Iconz.more,
              iconSizeFactor: 0.4,
              bubble: _bubbleIsOn,
              onTap: () {
                if (onRowOptionsTap != null) {
                  onRowOptionsTap(_map);
                }
              },
              // margins: EdgeInsets.all(5),
            ),

            /// ROW NUMBER
            DreamBox(
              height: 40,
              width: 40,
              verse:  '${index + 1}',
              verseScaleFactor: 0.6,
              margins: const EdgeInsets.all(5),
              bubble: false,
              color: Colorz.white10,
            ),

            /// ROW VALUES
            ...List<Widget>.generate(_values.length, (int i) {
              final String _key = _keys[i];
              final String _value = _values[i].toString();

              return ValueBox(
                dataKey: _key,
                value: _value,
                color: userColorField == true ? Colorizer.decipherColor(_map['color']) ?? Colorz.bloodTest : Colorz.green125,
              );
            }),

          ],
        ),
      );
    });
  }
  /// --------------------------------------------------------------------------
  @override
  State<LDBViewerScreen> createState() => _LDBViewerScreenState();
  /// --------------------------------------------------------------------------
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('ldbDocName', ldbDocName));
  }
  /// --------------------------------------------------------------------------
}

class _LDBViewerScreenState extends State<LDBViewerScreen> {
// -----------------------------------------------------------------------------
  /// --- FUTURE LOADING BLOCK
  bool _loading = false;
  Future<void> _triggerLoading({Function function}) async {
    if (mounted) {
      if (function == null) {
        setState(() {
          _loading = !_loading;
        });
      } else {
        setState(() {
          _loading = !_loading;
          function();
        });
      }
    }

    _loading == true
        ? blog('LOADING--------------------------------------')
        : blog('LOADING COMPLETE--------------------------------------');
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
    super.didChangeDependencies();

    if (_isInit) {
      _triggerLoading().then((_) async {
        await _readSembast();
      });
    }
    _isInit = false;
  }
// -----------------------------------------------------------------------------
  List<Map<String, Object>> _maps;
  Future<void> _readSembast() async {
    final List<Map<String, Object>> _sembastMaps = await LDBOps.readAllMaps(
      docName: widget.ldbDocName,
    );

    setState(() {
      _maps = _sembastMaps;
      _loading = false;
    });
  }
// -----------------------------------------------------------------------------
  Future<void> _onRowTap(Map<String, dynamic> map) async {
    // blog('Bldrs local data base : _bldbName : ${widget.ldbDocName} : row id : $id');
    Mapper.blogMap(map);
  }
// -----------------------------------------------------------------------------
  Future<void> _onClearLDB() async {

    final bool _result = await CenterDialog.showCenterDialog(
      title: 'Confirm ?',
      boolDialog: true,
      body: 'you will never see this data here again,, you can search for it elsewhere,, but never here, do you Understand ?',
      context: context,
    );

    if (_result == true) {
      await LDBOps.deleteAllMapsAtOnce(docName: widget.ldbDocName);
      await _readSembast();
    }

    else {
      await TopDialog.showTopDialog(
          context: context,
          firstLine: 'Ana 2olt keda bardo',
      );
    }

  }
// -----------------------------------------------------------------------------
  Future<void> _onBldrsTap() async {

    await BottomDialog.showButtonsBottomDialog(
        context: context,
        draggable: true,
        buttonHeight: 40,
        numberOfWidgets: 1,
        builder: (xxx, phrasePro){

        return <Widget>[

          DreamBox(
            width: BottomDialog.clearWidth(context),
            height: 40,
            verse:  'Clear ${widget.ldbDocName} data',
            verseWeight: VerseWeight.thin,
            verseScaleFactor: 0.7,
            onTap: _onClearLDB,
          ),

        ];

        }

    );
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return DashBoardLayout(
      pageTitle: 'Tap Bldrs.net to wipe this:\n${widget.ldbDocName}',
      onBldrsTap: _onBldrsTap,
      listWidgets: <Widget>[

        const Horizon(),

        if (Mapper.checkCanLoopList(_maps))
          ...LDBViewerScreen.rows(
            context: context,
            // color: Colorz.Green125,
            maps: _maps,
            onRowOptionsTap: _onRowTap,
          ),

        const Horizon(),

      ],
    );
  }
}
