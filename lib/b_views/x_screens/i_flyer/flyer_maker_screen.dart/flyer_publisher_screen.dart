import 'dart:async';
import 'dart:math';
import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/flyer/mutables/draft_flyer_model.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/flyer_maker/flyer_creator_shelf/flyer_creator_shelf.dart';
import 'package:bldrs/b_views/z_components/flyer_maker/flyer_creator_shelf/shelf_header.dart';
import 'package:bldrs/b_views/z_components/flyer_maker/flyer_creator_shelf/shelf_slide.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/unfinished_night_sky.dart';
import 'package:bldrs/b_views/z_components/texting/unfinished_super_verse.dart';
import 'package:bldrs/e_db/fire/ops/auth_ops.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/f_helpers/theme/standards.dart' as Standards;
import 'package:flutter/material.dart';


class FlyerPublisherScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const FlyerPublisherScreen({
    @required this.bzModel,
    this.flyerModel,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final BzModel bzModel;
  final FlyerModel flyerModel;
  /// --------------------------------------------------------------------------
  @override
  _FlyerPublisherScreenState createState() => _FlyerPublisherScreenState();
/// --------------------------------------------------------------------------
}

class _FlyerPublisherScreenState extends State<FlyerPublisherScreen> with AutomaticKeepAliveClientMixin{
// -----------------------------------------------------------------------------
  /// to keep out of screen objects alive
  @override
  bool get wantKeepAlive => true;
// -----------------------------------------------------------------------------
  final ScrollController _scrollController = ScrollController();
  final Curve _animationCurve = Curves.easeOut;
  final Duration _animationDuration = Ratioz.duration150ms;
  double _shelfMaxHeight(){
    return ShelfSlide.shelfSlideZoneHeight(context) + ShelfHeader.height;
  }
// -----------------------------------------------------------------------------
  final List<double> _shelvesOpacities = <double>[];
  final List<double> _shelvesHeights = <double>[];
  final List<int> _shelvesIndexes = <int>[];
  FlyerModel _flyerInput;
// -----------------------------------------------------------------------------
  /// --- LOADING BLOCK
  bool _loading = false;
  void _triggerLoading(){
    setState(() {_loading = !_loading;});
    _loading == true?
    blog('LOADING--------------------------------------') : blog('LOADING COMPLETE--------------------------------------');
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
  double _getCreatorPosition(int index){
    final double _verticalOffsetFromScreenTop =  (_shelfMaxHeight() * index) + Ratioz.appBarMargin;
    return _verticalOffsetFromScreenTop;
  }
// -----------------------------------------------------------------------------
  Future <void> _scrollToCreator(int index) async {

    final double _position = _getCreatorPosition(index);

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
  Future<void> _createNewShelf() async {

    /// A - if less than 5 drafts
    if (_shelvesIndexes.length < 5){

      final DraftFlyerModel _newDraft = DraftFlyerModel.createNewDraft(
          bzModel: widget.bzModel,
          authorID: superUserID(),
      );

      final int _newIndex = _shelvesIndexes.length;

      setState(() {
        _shelvesHeights.add(0);
        _shelvesOpacities.add(0);
        _shelvesIndexes.add(_newIndex);
      });

      await _fadeInAndExpandCreator(_newIndex);
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
  Future<void> _deleteShelf({int index}) async {

    await _fadeOutAndShrinkShelf(index);

    await Future.delayed(_animationDuration, () async {

      if (index != 0 ){
        await _scrollToCreator(index - 1);
      }

      setState(() {
        _shelvesIndexes.removeAt(index);
        _shelvesOpacities.removeAt(index);
        _shelvesHeights.removeAt(index);
      });

    });

  }
// -----------------------------------------------------------------------------
  Future<void> _fadeOutAndShrinkShelf(int index) async {

    /// FADE OUT
    await Future.delayed( _animationDuration, () async {
      setState(() {
      _shelvesOpacities[index] = 0;
      });
    });

    /// SHRINK
    setState(() {
      _shelvesHeights[index] = 0;
    });

  }
// -----------------------------------------------------------------------------
  Future<void> _fadeInAndExpandCreator(int index) async {

    /// FADE IN
    await Future.delayed(_animationDuration, () async {
      setState(() {
        _shelvesOpacities[index] = 1;

      });
    });

    /// EXPAND
    setState(() {
      _shelvesHeights[index] = _shelfMaxHeight();
    });

  }
// -----------------------------------------------------------------------------
  Future<void> _scrollToBottom() async {

    await Future.delayed(_animationDuration, () async {
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
      skyType: SkyType.black,
      pyramidsAreOn: true,
      appBarType: AppBarType.basic,
      // loading: _loading,
      sectionButtonIsOn: false,
      zoneButtonIsOn: false,
      appBarRowWidgets: const <Widget>[],
      layoutWidget: ListView.builder(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(top: Ratioz.stratosphere, bottom: Ratioz.horizon),
        itemCount: _shelvesIndexes.length + 2,
        itemBuilder: (_, int index){

          /// FIRST ITEM : INITIAL PARAGRAPH
          if (index == 0){
            return Container(
              width: Scale.superScreenWidth(context),
              height: Ratioz.appBarSmallHeight,
              padding: const EdgeInsets.symmetric(horizontal: Ratioz.appBarMargin),
              child: const SuperVerse(
                verse: 'Add a flyer',
                centered: false,
              ),
            );
          }

          /// LAST ITEM : ADD NEW FLYER BUTTON
          else if (index == _shelvesIndexes.length + 1){
            return Container(
              width: Scale.superScreenWidth(context),
              height: 100,
              alignment: Alignment.center,
              color: Colorz.white10,
              margin: const EdgeInsets.symmetric(vertical: Ratioz.appBarMargin),
              child: DreamBox(
                height: 70,
                icon: Iconz.addFlyer,
                iconSizeFactor: 0.7,
                verse: 'Add a new Flyer',
                // color: Colorz.white10,
                bubble: false,
                onTap: _createNewShelf,
                inActiveMode: _shelvesIndexes.length < Standards.maxDraftsAtOnce ? false : true,
              ),
            );
          }

          /// SHELVES
          else {

            final int _shelfIndex = index - 1;

            return AnimatedContainer(
              // key: ValueKey<String>(_shelvesIndexes[_shelfIndex].id),
              duration: _animationDuration,
              curve: _animationCurve,
              height: _shelvesHeights[_shelfIndex],
              margin: const EdgeInsets.only(bottom: Ratioz.appBarMargin),
              child: AnimatedOpacity(
                curve: _animationCurve,
                duration: _animationDuration,
                opacity: _shelvesOpacities[_shelfIndex],
                child: FlyerDraftShelf(
                  // chainKey: _chainsKeys[_chainIndex],
                  bzModel: widget.bzModel,
                  flyerModel: _flyerInput,
                  shelfNumber: _shelfIndex + 1,
                  shelfHeight: _shelfMaxHeight(),
                  onDeleteDraft: () => _deleteShelf(index: _shelfIndex),
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
            );
          }

        },

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

      ),
    );
  }
}
