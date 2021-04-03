import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/firestore/auth/auth.dart';
import 'package:bldrs/firestore/firestore.dart';
import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/models/tiny_models/tiny_flyer.dart';
import 'package:bldrs/models/user_model.dart';
import 'package:bldrs/providers/flyers_provider.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FlyersSizesScreen extends StatefulWidget {
  final double flyerSizeFactor;
  final TinyFlyer tinyFlyer;

  FlyersSizesScreen({
    this.flyerSizeFactor,
    this.tinyFlyer,
});

  @override
  _FlyersSizesScreenState createState() => _FlyersSizesScreenState();
}

class _FlyersSizesScreenState extends State<FlyersSizesScreen> {
  // ----------------------------------------------------------------------
  /// --- LOADING BLOCK
  bool _loading = false;
  void _triggerLoading(){
    setState(() {_loading = !_loading;});
    _loading == true?
    print('LOADING--------------------------------------') : print('LOADING COMPLETE--------------------------------------');
  }
  // ----------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    String _flyerID = 'f001';//'JeLtoYclzeDFNZ5VJ9PA';
    final FlyersProvider _pro = Provider.of<FlyersProvider>(context, listen: false);

    // final List<FlyerModel> _allFlyers = _pro.getAllFlyers;
    // final List<TinyFlyer> _allTinyFlyers = _pro.getAllTinyFlyers;
    // List<String> _flyerIDs = getListOfFlyerIDsFromFlyers(_allFlyers);
    final FlyerModel _flyer = _pro.getFlyerByFlyerID(_flyerID);
    final TinyFlyer _tinyFlyer = getTinyFlyerFromFlyerModel(_flyer);
    final BzModel _bz = _pro.getBzByBzID(_flyer.tinyBz.bzID);

    double _flyerSizeFactor = widget.flyerSizeFactor ?? 0.5;

    return MainLayout(
      pageTitle: 'FlyerSizes Screen',
      appBarBackButton: true,
      appBarType: AppBarType.Basic,
      pyramids: Iconz.PyramidsYellow,
      loading: _loading,
      tappingRageh: () async {
        // print(_flyerIDs);

        _triggerLoading();
        // -----------------------------------------------------------------------------
        dynamic _userMap = await getFireStoreDocumentMap(collectionName: FireStoreCollection.users, documentName: superUserID());
        UserModel _userModel = decipherUserMap(_userMap);

        /// uploading flyers 27, 28, 29

        List<dynamic> _allFlyersMaps = await getFireStoreCollectionMaps(FireStoreCollection.flyers);
        List<FlyerModel> _allFlyers = decipherFlyersMapsFromFireStore(_allFlyersMaps);

        List<FlyerModel> _flyersOfHanySaad = new List();
        String _hanyBzID = _allFlyers.firstWhere((flyer) => flyer.tinyBz.bzName.contains('HSI')).tinyBz.bzID;

        _allFlyers.forEach((flyer) {
          if (flyer.tinyBz.bzID == _hanyBzID){
            _flyersOfHanySaad.add(flyer);
          }
        });

        List<TinyFlyer> _hanyTinyFlyers = new List();
        _flyersOfHanySaad.forEach((flyer) {
          TinyFlyer _tinyFlyer = getTinyFlyerFromFlyerModel(flyer);
          _hanyTinyFlyers.add(_tinyFlyer);
        });

        await updateFieldOnFirestore(
          context: context,
          collectionName: FireStoreCollection.bzz,
          documentName: _hanyBzID,
          input: cipherTinyFlyers(_hanyTinyFlyers),
          field: 'bzFlyers',
        );

        print('done');


        _triggerLoading();

      },
      layoutWidget: ListView(
        children: <Widget>[

          Stratosphere(),

          // flyerModelBuilder(
          //     context: context,
          //     flyerID: 'Z6mmaU5ETompAIsW5hau',//_tinyFlyer.flyerID,
          //     flyerSizeFactor: 0.78,
          //     builder: (ctx, flyerModel){
          //       return
          //         bzModelBuilder(
          //             context: context,
          //             bzID: flyerModel.tinyBz.bzID,
          //             builder: (xxx, bzModel){
          //               return
          //                 AFlyer(
          //                     flyer: flyerModel,
          //                     bz: bzModel,
          //                     flyerSizeFactor: 0.78
          //                 );
          //             }
          //       );
          //   }
          // ),


          PyramidsHorizon(heightFactor: 5,),

        ],
      ),
    );
  }
}



