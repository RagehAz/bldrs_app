import 'package:bldrs/controllers/drafters/scrollers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/firestore/firestore.dart';
import 'package:bldrs/models/bz/author_model.dart';
import 'package:bldrs/models/user/user_model.dart';
import 'package:bldrs/views/widgets/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:flutter/material.dart';

class RandomTestSpace extends StatefulWidget {
final double flyerZoneWidth;

RandomTestSpace({
  @required this.flyerZoneWidth,
});

  @override
  _RandomTestSpaceState createState() => _RandomTestSpaceState();
}

class _RandomTestSpaceState extends State<RandomTestSpace> {
  // List<int> _list = <int>[1,2,3,4,5,6,7,8];
  // int _loops = 0;
  // Color _color = Colorz.BloodTest;
  // SuperFlyer _flyer;
  // bool _thing;

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
    if (_isInit) {
      _triggerLoading().then((_) async{

        /// do Futures here

        _triggerLoading(
          function: (){
            /// set new values here
          }
        );
      });


    }
    _isInit = false;
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {

// -----------------------------------------------------------------------------
//     double _screenWidth = Scale.superScreenWidth(context);
    // double _screenHeight = Scale.superScreenHeight(context);
// -----------------------------------------------------------------------------

    // double _gWidth = _screenWidth * 0.4;
    // double _gHeight = _screenWidth * 0.6;


    return MainLayout(
      appBarType: AppBarType.Basic,
      pyramids: Iconz.PyramidzYellow,
      loading: _loading,
      tappingRageh: (){
        print('wtf');
      },

      appBarRowWidgets: <Widget>[

        DreamBox(
          height: 40,
          width: 150,
          color: Colorz.BloodTest,
          verse: 'fix isAdmin in all users',
          verseMaxLines: 2,
          verseScaleFactor: 0.6,
          onTap: () async {

            List<dynamic> _usersMaps = await Fire.readCollectionDocs(
              limit: 200,
              addDocSnapshotToEachMap: false,
              startAfter: null,
              orderBy: 'userID',
              collectionName: FireCollection.users,
            );

            for (var userMap in _usersMaps){

              UserModel _user = UserModel.decipherUserMap(userMap);

              print('user : ${_user.userID} : ${_user.name} : _user.isAdmin : ${_user.isAdmin}');

              // if (_user.isAdmin != true){
              //   await Fire.updateDocField(
              //     context: context,
              //     collName: FireCollection.users,
              //     docName: _user.userID,
              //     field: 'isAdmin',
              //     input: false,
              //   );
              // }


              print('DONEEEEEEEEEEEEEEEEEEEEEEEEEEEE');

            }


          }
        ),


      ],

      layoutWidget: Center(
        child: GoHomeOnMaxBounce(
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: 100,
            itemBuilder: (ctx, index){
              return
                DreamBox(
                  height: 60,
                  width: 250,
                  verse: '$index : --',
                  verseScaleFactor: 0.7,
                );
              },
          ),
        ),
      ),
    );
  }

}
