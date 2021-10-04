import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/scrollers.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/firestore/flyer_ops.dart';
import 'package:bldrs/models/flyer/flyer_model.dart';
import 'package:bldrs/models/flyer/sub/flyer_type_class.dart';
import 'package:bldrs/models/flyer/sub/slide_model.dart';
import 'package:bldrs/models/flyer/tiny_flyer.dart';
import 'package:bldrs/providers/flyers_and_bzz/flyers_provider.dart';
import 'package:bldrs/providers/local_db/sql_ops/flyers_ldb.dart';
import 'package:bldrs/views/screens/i_flyer/h_0_flyer_screen.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/views/widgets/general/layouts/testing_layout.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:bldrs/views/widgets/specific/flyer/stacks/flyers_shelf.dart';
import 'package:bldrs/views/widgets/specific/flyer/stacks/slides_shelf.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FlyersSQLScreen extends StatefulWidget {


  @override
  _FlyersSQLScreenState createState() => _FlyersSQLScreenState();
}

class _FlyersSQLScreenState extends State<FlyersSQLScreen> {
  ScrollController _verticalController = ScrollController();
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

        await _createFlyersLDB();


      });

    }
    _isInit = false;

  }
// -----------------------------------------------------------------------------
  FlyersLDB _flyersLDB;
  Future<void> _createFlyersLDB() async {

    _flyersLDB = await FlyersLDB.createFlyersLDB(
      context: context,
      LDBName: 'savedFlyers',
    );

    if (_flyersLDB.flyersTable.db.isOpen == true && _flyersLDB.slidesTable.db.isOpen == true){
      await _readFlyersLDB();
    }

  }
// -----------------------------------------------------------------------------
  List<TinyFlyer> _convertedTinyFlyers = <TinyFlyer>[];
  Future<void> _readFlyersLDB() async {

    final List<FlyerModel> _flyersFromLDB = await FlyersLDB.readFlyersLDB(
      context: context,
      flyersLDB: _flyersLDB,
    );

    final List<TinyFlyer> _tinyFlyersFromLDB = TinyFlyer.getTinyFlyersFromFlyersModels(_flyersFromLDB);

    final List<Map<String, Object>> _slidesMaps = SlideModel.sqlCipherFlyersSlides(_flyersFromLDB);
    final List<Map<String, Object>> _flyersMaps = FlyerModel.sqlCipherFlyers(_flyersFromLDB);

    setState(() {
      _convertedTinyFlyers = _tinyFlyersFromLDB;
      _flyersLDB.flyersTable.maps =  _flyersMaps;
      _flyersLDB.slidesTable.maps = _slidesMaps;
      _loading = false;
    });

    await _scrollToBottomOfListView();

  }
// -----------------------------------------------------------------------------
  Future<void> _insertFlyerToLDB({FlyerModel flyer}) async {

    await FlyersLDB.insertFlyerToLDB(
      flyersLDB: _flyersLDB,
      flyer: flyer,
    );

    await _readFlyersLDB();

  }
// -----------------------------------------------------------------------------
  Future<void> _deleteFlyersLDB() async {

    await FlyersLDB.deleteFlyersLDB(
      context: context,
      flyersLDB: _flyersLDB,
    );

    await _readFlyersLDB();

  }
// -----------------------------------------------------------------------------
  Future<void> _replaceFlyerInLDB({String oldFlyerID, FlyerModel newFlyer}) async {

    await FlyersLDB.replaceAFlyerInLDB(
      flyersLDB: _flyersLDB,
      oldFlyerID: oldFlyerID,
      newFlyer: newFlyer,
    );

  }
// -----------------------------------------------------------------------------
  Future<void> _deleteFlyerFromLDB({String flyerID}) async {

    await FlyersLDB.deleteFlyerFromLDB(
      flyersLDB: _flyersLDB,
      flyerID: flyerID,
    );

    await _readFlyersLDB();

  }
// -----------------------------------------------------------------------------
  Future<void> _readAFlyerFromLDB(String flyerID) async {

    final FlyerModel _flyer = await FlyersLDB.readAFlyerFromLDB(
      flyersLDB: _flyersLDB,
      flyerID: flyerID,
    );

    _flyer.printFlyer();

    await Nav.goToNewScreen(context, FlyerScreen(
      flyerModel: _flyer,
    ));

  }
// -----------------------------------------------------------------------------
  Future<void> _scrollToBottomOfListView() async {

    if (_verticalController.hasClients == true){
      await Scrollers.scrollTo(
        controller: _verticalController,
        offset: _verticalController.position.maxScrollExtent,
      );
    }

// -----------------------------------------------------------------------------
  }
// -----------------------------------------------------------------------------
  Widget valueBox({String key, String value, Color color = Colorz.BloodTest}){
    return
      Container(
        height: 40,
        width: 80,
        color: color,
        margin: const EdgeInsets.all(2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            SuperVerse(
              verse: key,
              weight: VerseWeight.thin,
              italic: true,
              size: 1,
            ),

            SuperVerse(
              verse: value,
              weight: VerseWeight.bold,
              italic: false,
              size: 1,
            ),

          ],
        ),
      );
  }
// -----------------------------------------------------------------------------
  List<dynamic> getSlidesFromMaps(var maps){
    List<dynamic> _pics = <dynamic>[];

    if (maps != null && maps.length != 0){
      for (var x in maps){

        final String _pic = x['pic'];

        _pics.add(_pic);

      }
    }

    return _pics;
  }
// -----------------------------------------------------------------------------
  Future<void> _onLDBFlyerTap(String flyerID) async {

    await BottomDialog.showButtonsBottomDialog(
      context: context,
      draggable: true,
      buttonHeight: 40,
      buttons: <Widget>[

        DreamBox(
          height: 40,
          width: BottomDialog.dialogClearWidth(context),
          verse: 'READ FLYER',
          verseItalic: true,
          onTap: () async {

            await _readAFlyerFromLDB(flyerID);

            await Nav.goBack(context);

          },
        ),


        DreamBox(
          height: 40,
          width: BottomDialog.dialogClearWidth(context),
          verse: 'DELETE FLYER',
          verseItalic: true,
          onTap: () async {

            await _deleteFlyerFromLDB(flyerID: flyerID,);

            await Nav.goBack(context);

          },
        ),

      ],
    );

  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _screenWidth = Scale.superScreenWidth(context);
    // double _screenHeight = Scale.superScreenHeight(context);

    final FlyersProvider _prof = Provider.of<FlyersProvider>(context, listen: false);
    final List<TinyFlyer> _savedTinyFlyers =  _prof.getSavedTinyFlyers;
    const double _flyerSizeFactor = 0.25;

    final List<dynamic> _slidesPics = getSlidesFromMaps(_flyersLDB?.slidesTable?.maps);

    return TestingLayout(
      screenTitle: 'SQL Test Screen',
      appbarButtonVerse: _loading == true ? 'xxx Loading ......... ' : _flyersLDB.flyersTable.db.isOpen == true ? ' ---> Loaded' : 'LDB IS OFF',
      scrollable: true,
      appbarButtonOnTap: (){
        _triggerLoading();
        print('_flyersLDB?.slidesTable?.maps : ${_flyersLDB?.slidesTable?.maps}');
        _triggerLoading();
        },
      listViewWidgets: <Widget>[

        /// LDB Buttons
        Row(
          children: <Widget>[

            /// CREATE LDB
            SmallFuckingButton(
              verse: 'create Flyers LDB',
              onTap: _createFlyersLDB,
            ),

            /// Delete LDB
            SmallFuckingButton(
              verse: 'delete Flyers LDB',
              onTap: _deleteFlyersLDB,
            ),

          ],
        ),

        /// SAVED TINY FLYERS
        Container(
          height: FlyersShelf.shelfHeight(context: context, flyerSizeFactor: _flyerSizeFactor),
          width: _screenWidth,
          color: Colorz.BlackSemi230,
          child: FlyersShelf(
            title: 'Saved Flyers',
            titleIcon: Iconz.SavedFlyers,
            flyersType: FlyerType.non,
            tinyFlyers: _savedTinyFlyers,
            flyerOnTap: (TinyFlyer tinyFlyer) async {
              print('tapped on ${tinyFlyer.flyerID}');

              final FlyerModel _flyer = await FlyerOps().readFlyerOps(
                context: context,
                flyerID: tinyFlyer.flyerID,
              );

              await _insertFlyerToLDB(flyer: _flyer);
            },

            onScrollEnd: (){print('fuck this');},
            flyerSizeFactor: _flyerSizeFactor,
          ),
        ),

        SlidesShelf(
          shelfHeight: FlyersShelf.shelfHeight(context: context, flyerSizeFactor: _flyerSizeFactor),
          title: 'All Slides',
          onImageTap: (){print('tapped');},
          pics: _slidesPics,
          onAddButtonOnTap: (){print('xxx');},
        ),

        /// Flyers LDB data
        Container(
          width: _screenWidth,
          color: Colorz.White10,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            controller: ScrollController(),
            child: Column(
              children: <Widget>[

                ...List.generate(
                    _flyersLDB?.flyersTable?.maps?.length ?? 0,
                        (index){

                          Map<String, Object> _flyerMap = _flyersLDB?.flyersTable?.maps[index];

                          List<Object> _keys = _flyerMap.keys.toList();
                          List<Object> _values = _flyerMap.values.toList();

                          String _flyerID = _flyerMap['flyerID'];
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
                                    onTap: () => _onLDBFlyerTap(_flyerID),
                                    // margins: EdgeInsets.all(5),
                                  ),

                                  DreamBox(
                                    height: 40,
                                    width: 40,
                                    verse: '${index + 1}',
                                    verseScaleFactor: 0.6,
                                    margins: EdgeInsets.all(5),
                                    bubble: false,
                                    color: Colorz.White10,
                                  ),

                                  ...List.generate(
                                      _values.length,
                                          (i){

                                        String _key = _keys[i];
                                        String _value = _values[i].toString();

                                        return
                                          valueBox(
                                            key: _key,
                                            value: _value,
                                          );

                                      }
                                  ),

                                ],
                              ),
                            );

                    }),

              ],
            ),
          ),
        ),

        /// Slides LDB data
        Container(
          width: _screenWidth,
          color: Colorz.Black10,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            controller: ScrollController(),
            child: Column(
              children: <Widget>[

                ...List.generate(
                    _flyersLDB?.slidesTable?.maps?.length ?? 0,
                        (index){

                          Map<String, Object> _slideMap = _flyersLDB?.slidesTable?.maps[index];

                          List<Object> _keys = _slideMap.keys.toList();
                          List<Object> _values = _slideMap.values.toList();

                          // String _flyerID = SlideModel.getFlyerIDFromSlideID(_slideMap['slideID']);

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
                                icon: Iconz.FlyerScale,
                                iconSizeFactor: 0.7,
                                bubble: false,
                                color: Colorz.White10,
                              ),

                              DreamBox(
                                height: 40,
                                width: 40,
                                verse: '${index + 1}',
                                verseScaleFactor: 0.6,
                                margins: EdgeInsets.all(5),
                                bubble: false,
                                color: Colorz.White10,
                              ),

                              ...List.generate(
                                  _values.length,
                                      (i){

                                    String _key = _keys[i];
                                    String _value = _values[i].toString();

                                    return
                                      valueBox(
                                          key: _key,
                                          value: _value,
                                          color: Colorz.Green125
                                      );

                                  }
                              ),

                            ],
                          ),
                        );

                        }),

              ],
            ),
          ),
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
      color: Colorz.Blue80,
      margins: const EdgeInsets.symmetric(horizontal: 1),
      verse: verse,
      verseScaleFactor: 0.4,
      verseWeight: VerseWeight.thin,
      verseMaxLines: 2,
      onTap: onTap,
    );

  }
}
