import 'dart:async';
import 'dart:math';
import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/flyer/mutables/draft_flyer_model.dart';
import 'package:bldrs/b_views/y_views/i_flyer/flyer_maker/flyer_maker_screen_view.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/flyer_maker/flyer_maker_structure/flyer_creator_shelf/shelf_box.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/unfinished_night_sky.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/e_db/fire/ops/auth_ops.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
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
  final int _maxDraftsCount = Standards.maxDraftsAtOnce;

  final Curve _animationCurve = Curves.easeOut;
  final Duration _animationDuration = Ratioz.duration150ms;
// -----------------------------------------------------------------------------
  final List<ValueNotifier<ShelfUI>> _shelvesUIs =  <ValueNotifier<ShelfUI>>[];

  // final List<double> _shelvesOpacities = <double>[];
  // final List<double> _shelvesHeights = <double>[];
  // final List<int> _shelvesIndexes = <int>[];
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
    final double _verticalOffsetFromScreenTop =  (ShelfBox.maxHeight(context) * index) + Ratioz.appBarMargin;
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

    /// A - if less than max drafts drafts possible
    if (_shelvesUIs.length < _maxDraftsCount){

      final DraftFlyerModel _newDraft = DraftFlyerModel.createNewDraft(
          bzModel: widget.bzModel,
          authorID: superUserID(),
      );

      final int _newIndex = _shelvesUIs.length;
      final ShelfUI _newShelfUI = ShelfUI(
          height: 0,
          opacity: 0,
          index: _newIndex,
      );

      setState(() {
        _shelvesUIs.add(ValueNotifier<ShelfUI>(_newShelfUI));
      });

      await _fadeInAndExpandShelf(_newIndex);
      await _scrollToBottom();

    }

    /// A - if max drafts reached
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
        _shelvesUIs.removeAt(index);
      });

    });

  }
// -----------------------------------------------------------------------------
  Future<void> _fadeOutAndShrinkShelf(int index) async {

    /// FADE OUT
    await Future.delayed( _animationDuration, () async {
      _shelvesUIs[index].value = _shelvesUIs[index].value.copyWith(
        opacity: 0,
      );
    });

    /// SHRINK
    _shelvesUIs[index].value = _shelvesUIs[index].value.copyWith(
      height: 0,
    );

  }
// -----------------------------------------------------------------------------
  Future<void> _fadeInAndExpandShelf(int index) async {

    /// FADE IN
    _shelvesUIs[index].value = _shelvesUIs[index].value.copyWith(
      opacity: 1,
    );

    /// EXPAND
    await Future.delayed(_animationDuration, () async {
      _shelvesUIs[index].value = _shelvesUIs[index].value.copyWith(
        height: ShelfBox.maxHeight(context),
      );
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
      pageTitle: superPhrase(context, 'phid_flyers_creator'),
      skyType: SkyType.black,
      pyramidsAreOn: true,
      appBarType: AppBarType.basic,
      // loading: _loading,
      sectionButtonIsOn: false,
      zoneButtonIsOn: false,
      appBarRowWidgets: const <Widget>[],
      layoutWidget: FlyerMakerScreenView(
        bzModel: widget.bzModel,
        scrollController: _scrollController,
        flyerInput: widget.flyerModel,
        onCreateNewShelf: _createNewShelf,
        onDeleteShelf: (int index) => _deleteShelf(index: index),
        shelvesUIs: _shelvesUIs,
      ),
    );
  }
}
