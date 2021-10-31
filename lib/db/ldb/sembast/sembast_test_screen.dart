import 'package:bldrs/controllers/drafters/mappers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/dashboard/ldb_manager/ldb_viewer_screen.dart';
import 'package:bldrs/db/ldb/ldb_ops.dart';
import 'package:bldrs/db/ldb/sembast/sembast.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/layouts/testing_layout.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:flutter/material.dart';

class SembastTestScreen extends StatefulWidget {

  @override
  _SembastTestScreenState createState() => _SembastTestScreenState();
}

class _SembastTestScreenState extends State<SembastTestScreen> {

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
    // TODO: implement initState
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
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
// -----------------------------------------------------------------------------
  Future<void> _search() async {

    List<Map<String, dynamic>> _result = await LDBOps.searchTrigram(searchValue: 'Cairo', docName: LDBDoc.sessionCities, lingoCode: 'en');

    Mapper.printMaps(_result);

  }
// -----------------------------------------------------------------------------
  List<Map<String, Object>>_tinyFlyersMaps;
  Future<void> _readSembast() async {

    final List<Map<String, Object>> _maps = await Sembast.readAll(
      docName: LDBDoc.sessionCities,
    );

    setState(() {
      _tinyFlyersMaps = _maps;
      _loading = false;
    });

  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return TestingLayout(
      screenTitle: 'Sembast test',
      appbarButtonVerse: 'thing',
      appbarButtonOnTap: (){print('fuck');},
      listViewWidgets: <Widget>[

        /// LDB Buttons
        Row(
          children: <Widget>[

            /// READ AL  LDB
            SmallFuckingButton(
              verse: 'read all',
              onTap: _readSembast,
            ),

            /// REPLACE FROM LDB
            SmallFuckingButton(
              verse: 'Search',
              onTap: _search,
            ),

          ],
        ),



        if (Mapper.canLoopList(_tinyFlyersMaps))
        ...LDBViewerScreen.rows(
          context: context,
          color: Colorz.green125,
          primaryKey: 'flyerID',
          maps: _tinyFlyersMaps,
          onRowTap: null,
        ),

      ],
    );
  }
}

class SmallFuckingButton extends StatelessWidget {
  final String verse;
  final Function onTap;

  const SmallFuckingButton({
    @required this.verse,
    @required this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    final double _screenWidth = Scale.superScreenWidth(context);
    final double _buttonWidth = _screenWidth / 8;

    return DreamBox(
      height: 30,
      width: _buttonWidth,
      color: Colorz.blue80,
      margins: const EdgeInsets.symmetric(horizontal: 1),
      verse: verse,
      verseScaleFactor: 0.4,
      verseWeight: VerseWeight.thin,
      verseMaxLines: 2,
      onTap: onTap,
    );

  }
}
