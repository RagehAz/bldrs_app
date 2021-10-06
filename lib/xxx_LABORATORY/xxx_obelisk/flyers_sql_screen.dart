import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:bldrs/controllers/drafters/imagers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/scrollers.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/dashboard/widgets/ldb_viewer.dart';
import 'package:bldrs/firestore/bz_ops.dart';
import 'package:bldrs/firestore/flyer_ops.dart';
import 'package:bldrs/models/bz/author_model.dart';
import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/models/bz/tiny_bz.dart';
import 'package:bldrs/models/flyer/flyer_model.dart';
import 'package:bldrs/models/flyer/sub/flyer_type_class.dart';
import 'package:bldrs/models/flyer/sub/slide_model.dart';
import 'package:bldrs/models/flyer/tiny_flyer.dart';
import 'package:bldrs/models/helpers/image_size.dart';
import 'package:bldrs/providers/flyers_and_bzz/flyers_provider.dart';
import 'package:bldrs/providers/local_db/sql_ops/bzz_ldb.dart';
import 'package:bldrs/providers/local_db/sql_ops/flyers_ldb.dart';
import 'package:bldrs/views/screens/i_flyer/h_0_flyer_screen.dart';
import 'package:bldrs/views/screens/i_flyer/x_3_slide_full_screen.dart';
import 'package:bldrs/views/widgets/general/bubbles/following_bzz_bubble.dart';
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
  List<TinyFlyer> _savedTinyFlyers = <TinyFlyer>[];
  FlyersProvider _prof;
  List<BzModel> _followedBzz = <BzModel>[];

  @override
  void initState() {
    super.initState();

    _prof = Provider.of<FlyersProvider>(context, listen: false);
    _savedTinyFlyers =  _prof.getSavedTinyFlyers;
  }
// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if(_isInit){
      _triggerLoading().then((_) async {

        _followedBzz = await getFollowedBzz(_prof.getFollows);

        await _createFlyersLDB();
        await _createBzzLDB();


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
//   List<TinyFlyer> _convertedTinyFlyers = <TinyFlyer>[];
  Future<void> _readFlyersLDB() async {

    final List<FlyerModel> _flyersFromLDB = await FlyersLDB.readFlyersLDB(
      context: context,
      flyersLDB: _flyersLDB,
    );

    // final List<TinyFlyer> _tinyFlyersFromLDB = TinyFlyer.getTinyFlyersFromFlyersModels(_flyersFromLDB);

    final List<Map<String, Object>> _slidesMaps = await SlideModel.sqlCipherFlyersSlides(_flyersFromLDB);
    final List<Map<String, Object>> _flyersMaps = await FlyerModel.sqlCipherFlyers(_flyersFromLDB);

    setState(() {
      // _convertedTinyFlyers = _tinyFlyersFromLDB;
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
  BzzLDB _bzzLDB;
  Future<void> _createBzzLDB() async {

    _bzzLDB = await BzzLDB.createBzzLDB(
      context: context,
      LDBName: 'followedBzz',
    );

    if (_bzzLDB.bzzTable.db.isOpen == true){
      await _readBzzLDB();
    }

  }
// -----------------------------------------------------------------------------
  Future<void> _readBzzLDB() async {

    final List<BzModel> _allBzzFromLDB = await BzzLDB.readBzzLDB(
      context: context,
      bzzLDB: _bzzLDB,
    );

    final List<AuthorModel> _allAuthors = AuthorModel.combineAllBzzAuthors(_allBzzFromLDB);


    final List<Map<String, Object>> _authorsMaps = await AuthorModel.sqlCipherAuthors(authors: _allAuthors);
    final List<Map<String, Object>> _bzzMaps = await BzModel.sqlCipherBzz(_allBzzFromLDB);

    setState(() {
      // _convertedTinyFlyers = _tinyFlyersFromLDB;
      _bzzLDB.authorsTable.maps = _authorsMaps;
      _bzzLDB.bzzTable.maps =  _bzzMaps;
      _loading = false;
    });

    await _scrollToBottomOfListView();

  }
// -----------------------------------------------------------------------------
  Future<void> _insertBzToLDB({BzModel bz}) async {

    await BzzLDB.insertBzToLDB(
      bzzLDB: _bzzLDB,
      bz: bz,
    );

    await _readBzzLDB();

  }
// -----------------------------------------------------------------------------
  Future<void> _onBzLDBTap(BzModel bz) async {

     await _insertBzToLDB(bz: bz);

  }

// -----------------------------------------------------------------------------
  Future<List<BzModel>> getFollowedBzz(List<String> followedBzzIDs) async {

    List<BzModel> _bzz = <BzModel>[];

    for (var id in followedBzzIDs) {
      final BzModel _bz = await BzOps.readBzOps(
        context: context,
        bzID: id,
      );
      _bzz.add(_bz);
    }

    return _bzz;
  }
// -----------------------------------------------------------------------------
  Future<void> _deleteBzFromBzzLDB(String bzID) async {

    await BzzLDB.deleteBzFromLDB(
      bzzLDB: _bzzLDB,
      bzID: bzID,
    );

    _readBzzLDB();

  }
// -----------------------------------------------------------------------------
  Future<void> _onBzRowTap(String bzID) async {

    final BzModel _bz = BzModel.getBzFromBzzByBzID(_followedBzz, bzID);

    await BottomDialog.showButtonsBottomDialog(
      context: context,
      draggable: true,
      buttonHeight: 40,
      buttons: <Widget>[

        DreamBox(
          height: 40,
          width: BottomDialog.dialogClearWidth(context),
          verse: 'PRINT BZ',
          verseItalic: true,
          onTap: () async {

            _bz.printBzModel();

            await Nav.goBack(context);

          },
        ),


        DreamBox(
          height: 40,
          width: BottomDialog.dialogClearWidth(context),
          verse: 'DELETE BZ',
          verseItalic: true,
          onTap: () async {

            await _deleteBzFromBzzLDB(bzID);

            await Nav.goBack(context);

          },
        ),

      ],
    );


  }
// -----------------------------------------------------------------------------
  List<String> _convertedPics = <String>[];
  List<String> _convertedPicsStrings = <String>[];
  Future<void> _convertImageURL({String url}) async {

    print('staring to convert image url : $url');

    final String _base64 = await Imagers.urlOrImageFileToBase64(url);

    print('_base64Image is : ${_base64}');

    setState(() {
    _convertedPicsStrings.add(_base64);
    _convertedPics.add(url);
    });

  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    const double _flyerSizeFactor = 0.2;
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

        FollowingBzzBubble(
          tinyBzz: TinyBz.getTinyBzzFromBzzModels(_followedBzz),
          onBzTap: (String bzID) async {

            final BzModel _bz = BzModel.getBzFromBzzByBzID(_followedBzz, bzID);

            await _onBzLDBTap(_bz);

          },
        ),

        /// BZZ LDB
        LDBViewer(
          table: _bzzLDB?.bzzTable,
          onRowTap: (String bzID) => _onBzRowTap(bzID),
          color: Colorz.Yellow80,
        ),

        /// BZZ LDB
        LDBViewer(
          table: _bzzLDB?.authorsTable,
          onRowTap: null,
          color: Colorz.Black125,
        ),

        /// FLYERS SHELF
        FlyersShelf(
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

        /// Flyers LDB
        LDBViewer(
          table: _flyersLDB?.flyersTable,
          onRowTap: (String flyerID) => _onLDBFlyerTap(flyerID),
        ),

        /// SLIDES SHELF
        SlidesShelf(
          shelfHeight: FlyersShelf.shelfHeight(context: context, flyerSizeFactor: _flyerSizeFactor),
          title: 'All Slides',
          onImageTap: (int index) async {
            await _convertImageURL(url: _slidesPics[index]);
          },
          pics: _slidesPics,
          onAddButtonOnTap: (){print('xxx');},
        ),

        /// CONVERTED SLIDES SHELF
        if (_convertedPicsStrings != null && _convertedPicsStrings.length != 0)
          SlidesShelf(
            shelfHeight: FlyersShelf.shelfHeight(context: context, flyerSizeFactor: _flyerSizeFactor),
            title: 'Converted Slides',
            onImageTap: (int index) async {

              final Uint8List _fileAgainAsInt = await base64Decode(_convertedPicsStrings[index]);

              final File _fileAgain = await Imagers.getFileFromUint8List(
                Uint8List: _fileAgainAsInt,
                fileName: 'p#${index}',
              );

              final ImageSize _size = await ImageSize.superImageSize(_fileAgain);

              await Nav.goToNewScreen(context, SlideFullScreen(
                image: _fileAgain,
                imageSize: _size,
              ),
              );

              },

            pics: _convertedPics,
            onAddButtonOnTap: (){print('xxx');},
          ),

        /// SLIDES LDB
        LDBViewer(
          table:_flyersLDB?.slidesTable,
          color: Colorz.Green125,
          // onRowTap: (String flyerID) => _onLDBFlyerTap(flyerID),
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
