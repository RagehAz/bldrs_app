import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/firestore/firestore.dart';
import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/tiny_models/tiny_bz.dart';
import 'package:bldrs/views/widgets/bubbles/bzz_bubble.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/loading/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BzzManagerScreen extends StatefulWidget {

  @override
  _BzzManagerScreenState createState() => _BzzManagerScreenState();
}

class _BzzManagerScreenState extends State<BzzManagerScreen> {
  List<TinyBz> _tinyBzz;
  // BzModel _someBz;
  final String _bzID = '85XtJiWDEmPJ54ZPHmzO';
  // dynamic _name;
  List<QueryDocumentSnapshot> _bzzSnapshots;
  dynamic _toPrint;
// ---------------------------------------------------------------------------
  Future<dynamic> getFirestoreBzz() async {
    _triggerLoading();
    List<QueryDocumentSnapshot> _bzzMaps = await getFireStoreCollectionMaps(FireStoreCollection.tinyBzz);

    setState(() {
    _tinyBzz = TinyBz.decipherTinyBzzMaps(_bzzMaps);
    _toPrint = '${_tinyBzz[0].bzID} - ${_tinyBzz[1].bzID}';
    });

    print(_toPrint);
    _triggerLoading();
  }
// ---------------------------------------------------------------------------
  void _printer(){
    print(_toPrint);
  }
// ---------------------------------------------------------------------------
  @override
  void initState() {
    getFirestoreBzz();
    super.initState();
  }
  // LOADING BLOCK -----------------------------------------------------------
  bool _loading = false;
  void _triggerLoading(){
    print('loading------------------');
    setState(() {
      _loading = !_loading;
    });
    print('loading complete --------');

  }
  // -------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return

    _tinyBzz == null ?
    LoadingFullScreenLayer()
        :
      MainLayout(
        pyramids: Iconz.PyramidzYellow,
        appBarType: AppBarType.Basic,
        pageTitle: 'Firebase Reader',
        appBarBackButton: true,
        tappingRageh: _printer,
        // loading: _loading,
        layoutWidget: FutureBuilder(
          // TASK : can use bzModelBuilder here
            future: getFireStoreDocumentMap(
                collectionName: FireStoreCollection.bzz,
                documentName: _bzID,
            ),
            builder: (ctx, snapshot){

              if (snapshot.connectionState == ConnectionState.waiting){
                return Loading(loading: _loading,);
              } else {
                if (snapshot.error != null){
                  return Container(); // superDialog(context, snapshot.error, 'error');
                } else {

                  Map<String, dynamic> _map = snapshot.data;
                  BzModel _someBz = decipherBzMap(_map['bzID'], _map);

                  return ListView(
                    children: <Widget>[

                      Stratosphere(),

                      // if(_bzz != null)
                      BzzBubble(
                        tinyBzz: _tinyBzz,
                        title: '${_tinyBzz.length} Firestore Businesses',
                        numberOfColumns: 5,
                        numberOfRows: 7,
                        scrollDirection: Axis.vertical,
                        onTap: (bzID){

                          // BzModel _bz = getBzFromBzzByBzID(_bzz, bzID);
                          // AuthorModel _author = _bz.bzAuthors[0];

                          // slideBzBottomSheet(
                          //   context: context,
                          //   bz: _bz,
                          //   author: _author,
                          // );
                          },
                      ),


                    ],
                  );
                }
              }
            }
            ),

    );
  }
}
