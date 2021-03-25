import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/firestore/auth/auth.dart';
import 'package:bldrs/firestore/crud/user_ops.dart';
import 'package:bldrs/firestore/firestore.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/dialogs/alert_dialog.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Firebasetesting extends StatefulWidget {

  @override
  _FirebasetestingState createState() => _FirebasetestingState();
}

class _FirebasetestingState extends State<Firebasetesting> {
  List<Map<String, Object>> functions;
// ---------------------------------------------------------------------------
  /// --- LOADING BLOCK
  bool _loading = false;
  void _triggerLoading(){
    setState(() {_loading = !_loading;});
    _loading == true?
    print('LOADING--------------------------------------') : print('LOADING COMPLETE--------------------------------------');
  }
// ---------------------------------------------------------------------------

  @override
  void initState() {

    final FirebaseFirestore _fireInstance = FirebaseFirestore.instance;
    CollectionReference _collection = _fireInstance.collection('test');

    functions = [
      // -----------------------------------------------------------------------
      {'Name' : 'name', 'function' : (){

      },},
      // -----------------------------------------------------------------------
      {'Name' : 'saving a reference to cloud firestore', 'function' : () async {
        _triggerLoading();

        tryAndCatch(
          context: context,
          functions: () async {
            dynamic ref = {
              'content' : 'Content ...',
              'test' : UserCRUD().userCollectionRef().doc('/' + superUserID()),
            };
            await _collection.add(ref);
          }
        );

        _triggerLoading();
      },},
      // -----------------------------------------------------------------------
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {



    return MainLayout(
      pyramids: Iconz.PyramidzYellow,
      appBarType: AppBarType.Basic,
      appBarBackButton: true,
      pageTitle: 'Firebase Testers',
      loading: _loading,
      layoutWidget: ListView(
        children: <Widget>[

          Stratosphere(),

          ...List.generate(
              functions.length, (index){
                return
                    DreamBox(
                      height: 60,
                      width: 300,
                      boxMargins: EdgeInsets.all(5),
                      verseMaxLines: 3,
                      verseScaleFactor: 0.7,
                      verse: functions[index]['Name'],
                      color: Colorz.BloodTest,
                      boxFunction: functions[index]['function'],
                    );
          }),

          PyramidsHorizon(),

        ],
      ),
    );
  }
}
