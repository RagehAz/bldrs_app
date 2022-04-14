import 'dart:async';
import 'dart:async';
import 'dart:io';
import 'dart:io';
import 'dart:math';

import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/flyer/mutables/draft_flyer_model.dart';
import 'package:bldrs/b_views/x_screens/i_flyer/flyer_maker_screen.dart/flyer_chain.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogz.dart' as Dialogz;
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/e_flyer_box.dart';
import 'package:bldrs/b_views/z_components/images/unfinished_super_image.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/unfinished_night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/unfinished_super_text_field.dart';
import 'package:bldrs/b_views/z_components/texting/unfinished_super_verse.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart' as Aligners;
import 'package:bldrs/f_helpers/drafters/borderers.dart' as Borderers;
import 'package:bldrs/f_helpers/drafters/imagers.dart' as Imagers;
import 'package:bldrs/f_helpers/drafters/keyboarders.dart' as Keyboarders;
import 'package:bldrs/f_helpers/drafters/numeric.dart' as Numeric;
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/drafters/text_checkers.dart' as TextChecker;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/f_helpers/theme/standards.dart' as Standards;
import 'package:bldrs/x_dashboard/bldrs_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';


class PublisherScreen extends StatefulWidget {

  PublisherScreen({
    @required this.bzModel,
    this.firstTimer = false,
    this.flyerModel,
  });

  final BzModel bzModel;
  final bool firstTimer;
  final FlyerModel flyerModel;

  @override
  _PublisherScreenState createState() => _PublisherScreenState();
}

class _PublisherScreenState extends State<PublisherScreen> with AutomaticKeepAliveClientMixin{
// -----------------------------------------------------------------------------
  /// to keep out of screen objects alive
  @override
  bool get wantKeepAlive => true;
// -----------------------------------------------------------------------------
  final ScrollController _scrollController = ScrollController();
  final Curve _animationCurve = Curves.easeOut;
  final Duration _animationDuration = Ratioz.duration150ms;
  final double _chainMaxHeight = 340;
// -----------------------------------------------------------------------------
  final List<double> _chainsOpacities = <double>[];
  List<double> _chainsHeights = <double>[];
  final List<ValueKey<int>> _chainsKeys = <ValueKey<int>>[];
// -----------------------------------------------------------------------------
  /// --- LOADING BLOCK
  bool _loading = false;
  void _triggerLoading(){
    setState(() {_loading = !_loading;});
    _loading == true?
    blog('LOADING--------------------------------------') : print('LOADING COMPLETE--------------------------------------');
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
    final double _verticalOffsetFromScreenTop =  (_chainMaxHeight * (index)) + Ratioz.appBarMargin;
    return _verticalOffsetFromScreenTop;
  }
// -----------------------------------------------------------------------------
  Future <void> _scrollToChain(int index) async {

    final double _position = _getChainPosition(index);

    await _scrollController.animateTo(
      _position,
        duration: Ratioz.durationFading200,
        curve: _animationCurve,
    );
  }
// -----------------------------------------------------------------------------
  int _createKeyValue(List<ValueKey> keys){
    final Random _random = Random();
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

      final int _newIndex = _chainsKeys.length;
      final ValueKey _newKey = Numeric.createUniqueKeyFrom(existingKeys: _chainsKeys);

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

      await CenterDialog.showCenterDialog(
        context: context,
        title: 'Too many Draft flyers',
        body: 'Please Publish or remove any of the previous draft flyers to be able to add a new flyer',
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
      appBarType: AppBarType.basic,
      // loading: _loading,
      navBarIsOn: false,
      sectionButtonIsOn: false,
      zoneButtonIsOn: false,
      appBarRowWidgets: const <Widget>[],
      layoutWidget: ListView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        children: <Widget>[

          /// STRATOSPHERE
          const Stratosphere(),

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
                        // chainKey: _chainsKeys[_chainIndex],
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
            color: Colorz.white10,
            margin: EdgeInsets.symmetric(vertical: Ratioz.appBarMargin),
            child: DreamBox(
              height: 70,
              icon: Iconz.addFlyer,
              iconSizeFactor: 0.7,
              verse: 'Add a new Flyer',
              color: Colorz.white10,
              bubble: false,
              onTap: _createNewChain,
              inActiveMode: _chainsKeys.length < Standards.maxDraftsAtOnce ? false : true,
            ),
          ),

          /// HORIZON
          SizedBox(
            width: Scale.superScreenWidth(context),
            height: Scale.superScreenHeight(context) - (Ratioz.stratosphere + _chainMaxHeight + 100 + (Ratioz.appBarMargin * 4)),
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