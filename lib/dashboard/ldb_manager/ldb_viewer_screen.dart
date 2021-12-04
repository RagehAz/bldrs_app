import 'package:bldrs/controllers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/db/ldb/ldb_ops.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/views/widgets/general/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/views/widgets/general/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/views/widgets/general/layouts/dashboard_layout.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout/main_layout.dart';
import 'package:bldrs/views/widgets/general/textings/value_box.dart';
import 'package:flutter/material.dart';

class LDBViewerScreen extends StatefulWidget {
  final String ldbDocName;


  const LDBViewerScreen({
    @required this.ldbDocName,
    Key key,
}) : super(key: key);
// -----------------------------------------------------------------------------
  static List<Widget> rows({
    @required BuildContext context,
    @required List<Map<String, Object>>maps,
    @required String primaryKey,
    @required Function onRowTap,
    Color color = Colorz.bloodTest,
  }){

    final String _primaryKey = primaryKey;
    final double _screenWidth = Scale.superScreenWidth(context);

    bool _bubbleIsOn = true;
    if (onRowTap == null){
      _bubbleIsOn = false;
    }


    return
      List<Widget>.generate(
          maps?.length ?? 0,
              (int index){

            final Map<String, Object> _map = maps[index];

            final List<Object> _keys = _map.keys.toList();
            final List<Object> _values = _map.values.toList();


            final String _primaryValue = _map['$_primaryKey'];
            // int _idInt = Numberers.stringToInt(_id);

            return
              Container(
                width: _screenWidth,
                height: 42,
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: false,
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[

                    DreamBox(
                      height: 37,
                      width: 37,
                      icon: Iconz.Flyer,
                      iconSizeFactor: 0.7,
                      bubble: _bubbleIsOn,
                      onTap: (){

                        if (onRowTap !=  null){
                          onRowTap(_primaryValue);
                        }

                      },
                      // margins: EdgeInsets.all(5),
                    ),

                    DreamBox(
                      height: 40,
                      width: 40,
                      verse: '${index + 1}',
                      verseScaleFactor: 0.6,
                      margins: const EdgeInsets.all(5),
                      bubble: false,
                      color: Colorz.white10,
                    ),

                    ...List<Widget>.generate(
                        _values.length,
                            (int i){

                          String _key = _keys[i];
                          String _value = _values[i].toString();

                          return
                            ValueBox(
                              dataKey: _key,
                              value: _value,
                              color: color,
                            );

                        }
                    ),

                  ],
                ),
              );

          });
  }
// -----------------------------------------------------------------------------
  @override
  State<LDBViewerScreen> createState() => _LDBViewerScreenState();
}

class _LDBViewerScreenState extends State<LDBViewerScreen> {
// -----------------------------------------------------------------------------
  /// --- FUTURE LOADING BLOCK
  bool _loading = false;
  Future <void> _triggerLoading({Function function}) async {

    if(mounted){

      if (function == null){
        setState(() {
          _loading = !_loading;
        });
      }

      else {
        setState(() {
          _loading = !_loading;
          function();
        });
      }

    }

    _loading == true?
    print('LOADING--------------------------------------') : print('LOADING COMPLETE--------------------------------------');
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

    if(_isInit){
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
  Future<void> _onRowTap(String id) async {


    print('Bldrs local data base : _bldbName : ${widget.ldbDocName} : row id : $id');

  }
// -----------------------------------------------------------------------------
  Future<void> _onClearLDB() async {

    final bool _result = await CenterDialog.showCenterDialog(
      title: 'Confirm ?',
      boolDialog: true,
      body: 'you will never see this data here again,, you can search for it elsewhere,, but never here, do you Understand ?',
      context: context,
    );

    if (_result == true){
      await LDBOps.deleteAllMaps(docName: widget.ldbDocName);
      _readSembast();
    }

    else {
      await TopDialog.showTopDialog(context: context, verse: 'Ana 2olt keda bardo');
    }


  }
// -----------------------------------------------------------------------------
  Future<void> _onBldrsTap() async {

    await BottomDialog.showButtonsBottomDialog(
        context: context,
        draggable: true,
        buttonHeight: 40,
        buttons: <Widget>[

          DreamBox(
            width: BottomDialog.dialogClearWidth(context),
            height: 40,
            verse: 'Clear ${widget.ldbDocName} data',
            onTap: _onClearLDB,
          ),

        ],
    );

  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return DashBoardLayout(
      pageTitle: 'Local db :\n${widget.ldbDocName}',
      loading: false,
      onBldrsTap: _onBldrsTap,
      listWidgets: <Widget>[

        if (Mapper.canLoopList(_maps))
          ...LDBViewerScreen.rows(
            context: context,
            // color: Colorz.Green125,
            primaryKey: LDBOps.getPrimaryKey(widget.ldbDocName),
            maps: _maps,
            onRowTap: (String id) => _onRowTap(id),
          ),

        const PyramidsHorizon(),

      ],
    );
  }
}
