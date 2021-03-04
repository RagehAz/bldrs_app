import 'package:bldrs/ambassadors/services/firestore.dart';
import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/views/widgets/bubbles/bzz_bubble.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/flyer/bz_card_preview.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/loading/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FireBaseReader extends StatefulWidget {

  @override
  _FireBaseReaderState createState() => _FireBaseReaderState();
}

class _FireBaseReaderState extends State<FireBaseReader> {
  List<BzModel> _bzz;
  // BzModel _someBz;
  final String _bzID = '85XtJiWDEmPJ54ZPHmzO';
  // dynamic _name;
  List<QueryDocumentSnapshot> _bzzSnapshots;
  dynamic thing;
// ---------------------------------------------------------------------------
  Future<dynamic> getFirestoreBzz() async {

    List<QueryDocumentSnapshot> _bzzMaps = await getFireStoreCollectionMaps(FireStoreCollection.bzz);

    _bzz = decipherBzMapsFromFireStore(_bzzMaps);

    thing = '${_bzz[0].bzID} - ${_bzz[1].bzID}';

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
    return MainLayout(
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
                  BzzBubble(bzz: _bzz),

                  // if(_someBz?.bzAuthors != null)
                    DreamBox(
                      height: 50,
                      icon: _someBz?.bzAuthors[0].authorPic,
                      verse: _someBz?.bzAuthors[0].authorName,
                      boxMargins: EdgeInsets.all(10),
                    ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 50),
                    child: Column(
                      children: <Widget>[

                        Container(),

                        BzCardPreview(
                          bz: _bzz[0],
                          author: _bzz[0]?.bzAuthors[0],
                          flyerSizeFactor: 0.8,
                        ),

                        BzCardPreview(
                          bz: _bzz[1],
                          author: _bzz[1]?.bzAuthors[0],
                          flyerSizeFactor: 0.8,
                        ),



                      ],
                    ),
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
