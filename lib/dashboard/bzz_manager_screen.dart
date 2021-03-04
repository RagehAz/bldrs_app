import 'package:bldrs/ambassadors/services/firestore.dart';
import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/sub_models/author_model.dart';
import 'package:bldrs/providers/flyers_provider.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/views/widgets/bubbles/bzz_bubble.dart';
import 'package:bldrs/views/widgets/dialogs/bz_bottom_sheet.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/loading/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BzzManagerScreen extends StatefulWidget {

  @override
  _BzzManagerScreenState createState() => _BzzManagerScreenState();
}

class _BzzManagerScreenState extends State<BzzManagerScreen> {
  List<BzModel> _bzz;
  // BzModel _someBz;
  final String _bzID = '85XtJiWDEmPJ54ZPHmzO';
  // dynamic _name;
  List<QueryDocumentSnapshot> _bzzSnapshots;
  dynamic thing;
// ---------------------------------------------------------------------------
  Future<dynamic> getFirestoreBzz() async {

    List<QueryDocumentSnapshot> _bzzMaps = await getFireStoreCollectionMaps(FireStoreCollection.bzz);

    setState(() {
    _bzz = decipherBzMapsFromFireStore(_bzzMaps);
    thing = '${_bzz[0].bzID} - ${_bzz[1].bzID}';
    });

    print(thing);

  }
// ---------------------------------------------------------------------------
  void _printer(){
    print(thing);
  }
// ---------------------------------------------------------------------------
  @override
  void initState() {
    getFirestoreBzz();
    super.initState();
  }
// ---------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return

    _bzz == null ?
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
            future: getFireStoreDocumentMap(FireStoreCollection.bzz, _bzID),
            builder: (ctx, snapshot){

              if (snapshot.connectionState == ConnectionState.waiting){
                return Loading();
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
                        bzz: _bzz,
                        title: '${_bzz.length} Firestore Businesses',
                        numberOfColumns: 5,
                        numberOfRows: 7,
                        scrollDirection: Axis.vertical,
                        onTap: (bzID){

                          BzModel _bz = getBzFromBzzByBzID(_bzz, bzID);
                          AuthorModel _author = _bz.bzAuthors[0];

                          slideBzBottomSheet(
                            context: context,
                            bz: _bz,
                            author: _author,
                          );
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
