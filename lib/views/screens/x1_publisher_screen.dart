import 'dart:io';

import 'package:bldrs/controllers/drafters/imagers.dart';
import 'package:bldrs/controllers/drafters/numberers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/controllers/theme/standards.dart';
import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/dialogs/alert_dialog.dart';
import 'package:bldrs/views/widgets/flyer/stacks/flyer_chain.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'package:bldrs/controllers/drafters/text_checkers.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';

class DraftFlyerModel{
  List<TextEditingController> headlinesControllers;
  List<Asset> assetsSources;
  List<File> assetsFiles;
  List<BoxFit> boxesFits;
  final ValueKey key;
  FlyerState state;

  DraftFlyerModel({
    @required this.headlinesControllers,
    @required this.assetsSources,
    @required this.assetsFiles,
    @required this.boxesFits,
    @required this.key,
    @required this.state,
});

  static List<ValueKey> getKeysOfDrafts(List<DraftFlyerModel> drafts){
    List<ValueKey> _keys = new List();

    if(drafts != null){
      drafts.forEach((draft) {
        _keys.add(draft.key);
      });

    }

    return _keys;
  }

}


class PublisherScreen extends StatefulWidget {
  final BzModel bzModel;
  final bool firstTimer;
  final FlyerModel flyerModel;

  PublisherScreen({
    @required this.bzModel,
    this.firstTimer = false,
    this.flyerModel,
  });

  @override
  _PublisherScreenState createState() => _PublisherScreenState();
}

class _PublisherScreenState extends State<PublisherScreen> with AutomaticKeepAliveClientMixin{
// -----------------------------------------------------------------------------
  /// to keep out of screen objects alive
  @override
  bool get wantKeepAlive => true;
// -----------------------------------------------------------------------------
  ScrollController _scrollController = new ScrollController();
  Curve _animationCurve = Curves.easeOut;
  Duration _animationDuration = Ratioz.duration150ms;
  double _chainMaxHeight = 340;
// -----------------------------------------------------------------------------
  List<double> _chainsOpacities = new List();
  List<double> _chainsHeights = new List();
  List<ValueKey> _chainsKeys = new List();
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
    super.initState();
  }
// -----------------------------------------------------------------------------
  @override
  void dispose(){
    _scrollController.dispose();
    super.dispose();
  }
// -----------------------------------------------------------------------------
  double _getChainPosition(int index){
    double _verticalOffsetFromScreenTop = ( (_chainMaxHeight * (index)) + Ratioz.appBarMargin);
    return _verticalOffsetFromScreenTop;
  }
// -----------------------------------------------------------------------------
  Future <void> _scrollToChain(int index) async {

    double _position = _getChainPosition(index);

    await _scrollController.animateTo(
      _position,
        duration: Ratioz.durationFading200,
        curve: _animationCurve,
    );
  }
// -----------------------------------------------------------------------------
  int _createKeyValue(List<ValueKey> keys){
    Random _random = new Random();
    int _randomNumber = _random.nextInt(100000); // from 0 upto 99 included

    if(keys.contains(ValueKey(_randomNumber))){
      _randomNumber = _createKeyValue(keys);
    }

    return _randomNumber;
  }
// -----------------------------------------------------------------------------
  Future<void> _createNewChain() async {

    /// A - if less than 5 drafts
    if (_chainsKeys.length < 5){

      int _newIndex = _chainsKeys.length;
      ValueKey _newKey = Numberers.createUniqueKeyFrom(existingKeys: _chainsKeys);

      setState(() {

        _chainsHeights.add(0);
        _chainsOpacities.add(0);
        _chainsKeys.add(_newKey);

      });

      await _fadeInAndExpandChain(_newIndex);
      await _scrollToBottom();

    }

    /// A - if 5 drafts reached
    else {

      await superDialog(
        context: context,
        title: 'Too many Draft flyers',
        body: 'Please Publish or remove any of the previous draft flyers to be able to add a new flyer',
        boolDialog: false,
      );

    }

  }
// -----------------------------------------------------------------------------
  Future<void> _deleteChain({int index}) async {

    await _fadeOutAndShrinkChain(index);

    await Future.delayed(_animationDuration, () async {

      if (index != 0 ){
        await _scrollToChain(index - 1);
      }

      setState(() {
        _chainsKeys.removeAt(index);
        _chainsOpacities.removeAt(index);
        _chainsHeights.removeAt(index);
      });
    });

  }
// -----------------------------------------------------------------------------
  Future<void> _fadeOutAndShrinkChain(int index) async {
    await Future.delayed( _animationDuration, () async {
      setState(() {
      _chainsOpacities[index] = 0;
      });
    });

    setState(() {
      _chainsHeights[index] = 0;
    });

  }
// -----------------------------------------------------------------------------
  Future<void> _fadeInAndExpandChain(int index) async {

    await Future.delayed(Ratioz.durationFading200, () async {
      setState(() {
        _chainsOpacities[index] = 1;

      });
    });

    setState(() {
      _chainsHeights[index] = _chainMaxHeight;
    });

  }
// -----------------------------------------------------------------------------
  Future<void> _scrollToBottom() async {

    await Future.delayed(Ratioz.durationFading200, () async {
      await _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: _animationDuration,
        curve: _animationCurve,
      );
    });

  }
// -----------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    /// when using with AutomaticKeepAliveClientMixin
    super.build(context);

    return MainLayout(
      pageTitle: 'Add multiple flyers',
      pyramids: Iconz.PyramidzYellow,
      appBarType: AppBarType.Basic,
      loading: _loading,
      appBarRowWidgets: <Widget>[

      ],
      layoutWidget: ListView(
        controller: _scrollController,
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        reverse: false,
        addAutomaticKeepAlives: true,
        children: <Widget>[

          /// STRATOSPHERE
          Stratosphere(),

          /// Initial Paragraph
          // Container(
          //   width: Scale.superScreenWidth(context),
          //   height: Ratioz.appBarSmallHeight,
          //   padding: EdgeInsets.symmetric(horizontal: Ratioz.appBarMargin),
          //   child: SuperVerse(
          //     verse: 'Add a flyer',
          //     centered: false,
          //     labelColor: Colorz.WhiteAir,
          //   ),
          // ),

          /// CHAINS
          ...List.generate(
              _chainsKeys.length,
                  (_chainIndex) => AnimatedContainer(
                    duration: _animationDuration,
                    curve: _animationCurve,
                    height: _chainsHeights[_chainIndex],
                    child: AnimatedOpacity(
                      key: _chainsKeys[_chainIndex],
                      curve: _animationCurve,
                      duration: _animationDuration,
                      opacity: _chainsOpacities[_chainIndex],
                      child: FlyerChain(
                        chainKey: _chainsKeys[_chainIndex],
                        bzModel: widget.bzModel,
                        firstTimer: widget.firstTimer,
                        chainNumber: _chainIndex + 1,
                        chainHeight: _chainMaxHeight,
                        onDeleteChain: () => _deleteChain(index: _chainIndex),
                        // onAddPics: () => _getMultiImages(
                        //   accountType: BzAccountType.Super,
                        //   draftIndex: _chainIndex,
                        // ),
                        // onDeleteImage: (int imageIndex){
                        //   setState(() {
                        //     _draftFlyers[_chainIndex].assetsAsFiles.removeAt(imageIndex);
                        //     _draftFlyers[_chainIndex].assets.removeAt(imageIndex);
                        //   });
                        // },
          ),
                    ),
                  )
          ),

          /// ADD NEW FLYER BUTTON
          Container(
            width: Scale.superScreenWidth(context),
            height: 100,
            alignment: Alignment.center,
            color: Colorz.White10,
            margin: EdgeInsets.symmetric(vertical: Ratioz.appBarMargin),
            child: DreamBox(
              height: 70,
              icon: Iconz.AddFlyer,
              iconSizeFactor: 0.7,
              verse: 'Add a new Flyer',
              color: Colorz.White10,
              bubble: false,
              onTap: _createNewChain,
              inActiveMode: _chainsKeys.length < Standards.maxDraftsAtOnce ? false : true,
            ),
          ),

          /// HORIZON
          SizedBox(
            width: Scale.superScreenWidth(context),
            height: (Scale.superScreenHeight(context) - (Ratioz.stratosphere + _chainMaxHeight + 100 + (Ratioz.appBarMargin * 4))),
          ),

          /// GIF THING
          // check this
          // https://stackoverflow.com/questions/67173576/how-to-get-or-pick-local-gif-file-from-device
          // https://pub.dev/packages/file_picker
          // Container(
          //   width: 200,
          //   height: 200,
          //   margin: EdgeInsets.all(30),
          //   color: Colorz.BloodTest,
          //   child: Image.network('https://media.giphy.com/media/hYUeC8Z6exWEg/giphy.gif'),
          // ),


        ],
      ),
    );
  }
}