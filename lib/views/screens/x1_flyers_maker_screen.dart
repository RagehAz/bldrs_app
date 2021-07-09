import 'package:bldrs/controllers/drafters/aligners.dart';
import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/imagers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/text_checkers.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/dumz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/controllers/theme/standards.dart';
import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/models/tiny_models/tiny_flyer.dart';
import 'package:bldrs/views/screens/x2_draft_picture_screen.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/dialogs/alert_dialog.dart';
import 'package:bldrs/views/widgets/flyer/stacks/flyer_maker_stack.dart';
import 'package:bldrs/views/widgets/flyer/stacks/flyer_stack.dart';
import 'package:bldrs/views/widgets/flyer/stacks/flyer_stack_list.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/textings/super_text_field.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'dart:math';

class MultiImagePicker2 extends StatefulWidget {
  @override
  _MultiImagePicker2State createState() => _MultiImagePicker2State();
}

class _MultiImagePicker2State extends State<MultiImagePicker2> with AutomaticKeepAliveClientMixin{
// -----------------------------------------------------------------------------
  @override
  bool get wantKeepAlive => true;
// -----------------------------------------------------------------------------
  List<int> _draftFlyersIndexes = new List();
  List<double> _stacksOpacities = new List();
  List<Key> _keys;

// -----------------------------------------------------------------------------
  /// --- LOADING BLOCK
  bool _loading = false;
  void _triggerLoading(){
    setState(() {_loading = !_loading;});
    _loading == true?
    print('LOADING--------------------------------------') : print('LOADING COMPLETE--------------------------------------');
  }
// -----------------------------------------------------------------------------
  @override
  void initState() {
    _keys = new List();
    super.initState();
  }
// -----------------------------------------------------------------------------
  @override
  void dispose(){
    super.dispose();
  }
// -----------------------------------------------------------------------------
  int _createKeyValue(){
    Random _random = new Random();
    int _randomNumber = _random.nextInt(100000); // from 0 upto 99 included

    if(_keys.contains(ValueKey(_randomNumber))){
      _randomNumber = _createKeyValue();
    }


    return _randomNumber;
  }
// -----------------------------------------------------------------------------
  void _printAfter(bool after){

    if(after == true){
      print('---This line is AFTER EVENTS ----------------------------------------');
    } else {
      print('---This line is BEFORE EVENTS ----------------------------------------');
    }

    print('_draftFlyersIndexes : ${_draftFlyersIndexes.toString()}');
    print('_stacksOpacities : ${_stacksOpacities.toString()}');
    print('_keys : ${_keys.toString()}');

    if(after == true){
      print('--- EVENTS & CHECK PRINT ENDED ----------------------------------------');
    } else {
      print('---EVENTS START HERE ----------------------------------------');
    }

  }
// -----------------------------------------------------------------------------
  void _addFlyer(){

    _printAfter(false);

      setState(() {
        _stacksOpacities.add(1);
        _keys.add(ValueKey(_createKeyValue()));
        _draftFlyersIndexes.add(_draftFlyersIndexes.length);
      });

    _printAfter(true);

  }
// -----------------------------------------------------------------------------
  Future<void> _fadeStack(int index) async {

    _printAfter(false);

    setState(() {
        _stacksOpacities[index] = 0;
      });

    _printAfter(true);

  }

  Future<void> _deleteFlyer({int index}) async {

    _printAfter(false);

    await _fadeStack(index);

    _printAfter(true);

    _printAfter(false);
    await Future.delayed(Ratioz.fadingDuration, (){

      print('deleting flyer number ${index+1}, ');

        List<int> _newIndexes = _draftFlyersIndexes.toList();
      _newIndexes.removeAt(index);
        _stacksOpacities.removeAt(index);
        _keys.removeAt(index);

      setState(() {
        _draftFlyersIndexes = _newIndexes;
      });

      print('flyer should have been deleted number ${index+1},');

      _printAfter(true);

    });

  }

  @override
  Widget build(BuildContext context) {

    return MainLayout(
      pageTitle: 'Create flyers',
      pyramids: Iconz.DvBlankSVG,
      appBarType: AppBarType.Basic,
      loading: _loading,
      appBarRowWidgets: <Widget>[

      ],
      layoutWidget: ListView(
        addAutomaticKeepAlives: true,
        children: <Widget>[

          Stratosphere(),

          /// Initial Paragraph
          Container(
            width: Scale.superScreenWidth(context),
            height: Ratioz.appBarSmallHeight,
            padding: EdgeInsets.symmetric(horizontal: Ratioz.appBarMargin),
            child: SuperVerse(
              verse: 'Add a flyer',
              centered: false,
              labelColor: Colorz.WhiteAir,
            ),
          ),

          ...List.generate(
              _draftFlyersIndexes.length,
                  (index) => AnimatedOpacity(
                    key: _keys[index],
                    duration: Ratioz.fadingDuration,
                    opacity: _stacksOpacities[index],
                    child: FlyerMakerStack(
                      key: _keys[index],
                      flyerNumber: index + 1,
                      deleteFlyer: () => _deleteFlyer(index: index),
          ),
                  )
          ),

          Container(
            width: Scale.superScreenWidth(context),
            height: 200,
            alignment: Alignment.center,
            color: Colorz.WhiteAir,
            margin: EdgeInsets.symmetric(vertical: Ratioz.appBarMargin),
            child: DreamBox(
              height: 70,
              icon: Iconz.AddFlyer,
              iconSizeFactor: 0.7,
              verse: 'Add new Flyer',
              color: Colorz.WhiteAir,
              bubble: false,
              boxFunction: _addFlyer,
            ),
          ),

          PyramidsHorizon(heightFactor: 5,),


        ],
      ),
    );
  }
}