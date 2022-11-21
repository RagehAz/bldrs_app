import 'dart:async';

import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/deck_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/flyer_typer.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/x_dashboard/zz_widgets/layout/dashboard_layout.dart';
import 'package:flutter/material.dart';

class DeckModelTester extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const DeckModelTester({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  _TheStatefulScreenState createState() => _TheStatefulScreenState();
/// --------------------------------------------------------------------------
}

class _TheStatefulScreenState extends State<DeckModelTester> {
  // -----------------------------------------------------------------------------
  DeckModel _deckModel;
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void> _triggerLoading({@required bool setTo}) async {
    setNotifier(
      notifier: _loading,
      mounted: mounted,
      value: setTo,
    );
  }
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    _deckModel = DeckModel.newDeck();
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      _triggerLoading(setTo: true).then((_) async {

        /// FUCK

        await _triggerLoading(setTo: false);
      });

      _isInit = false;
    }
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void dispose() {
    _loading.dispose();
    super.dispose();
  }

  // -----------------------------------------------------------------------------
  int _num = 0;
  // --------------------
  String _generateID(FlyerType type){
    return '${FlyerTyper.getFlyerTypePhid(flyerType: type)}_$_num';
  }
  // --------------------
  Future<void> _onAdd(FlyerType type) async {

    final String _id = _generateID(type);

    unawaited(Dialogs.topNotice(context: context, verse: Verse.plain(
      'added : $_id',
    )));

    setState(() {
      _deckModel = DeckModel.addFlyer(
          oldDeck: _deckModel,
          flyer: FlyerModel.dummyFlyer().copyWith(
            id: _id,
            flyerType: type,
          ),
      );
    });

  }
  // --------------------
  void _onRemove(FlyerType type){

    final String _id = _generateID(type);

    unawaited(Dialogs.topNotice(context: context, verse: Verse.plain(
      'removed : $_id',
    )));

    setState(() {
      _deckModel = DeckModel.removeFlyer(
        oldDeck: _deckModel,
        flyer: FlyerModel.dummyFlyer().copyWith(
          id: _id,
          flyerType: type,
        ),
      );
    });


  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------

    final double _boxWidth = Scale.screenWidth(context);

    final double _parcelWidth = Scale.getUniformRowItemWidth(
      context: context,
      numberOfItems: FlyerTyper.savedFlyersTabs.length,
      boxWidth: _boxWidth,
      spacing: 5,
    );

    const double _parcelHeight = 80;

    blog('wtf');

    return DashBoardLayout(
      key: const ValueKey('DeckModelTester'),
      loading: _loading,
      appBarWidgets: [

        const Expander(),

        SuperVerse(
          verse: Verse.plain('$_num'),
          labelColor: Colorz.white20,
          size: 4,
        ),

        AppBarButton(
          icon: Iconz.arrowUp,
          onTap: () => setState(() {
            _num++;
          }),
        ),

        AppBarButton(
          icon: Iconz.arrowDown,
          onTap: () => setState(() {
            _num--;
          }),
        ),

      ],
      listWidgets: <Widget>[

        // Container(
        //   key: const ValueKey('DeckModelTesterBoxThing'),
        //   width: _boxWidth,
        //   height: _parcelHeight*3,
        //   color: Colorz.bloodTest,
        //   child: Column(
        //     children: <Widget>[
        //
        //       /// COUNTS
        //       Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //         children: <Widget>[
        //
        //           ...List.generate(FlyerTyper.savedFlyersTabs.length, (index){
        //
        //             final FlyerType _type = FlyerTyper.savedFlyersTabs[index];
        //             final int _count = DeckModel.getCountByFlyerType(
        //                 flyerType: _type,
        //                 deckModel: _deckModel,
        //             );
        //
        //             return SuperVerse(
        //               width: _parcelWidth,
        //               // height: _parcelWidth * 0.5,
        //               verse: Verse.plain(_count.toString()),
        //               weight: VerseWeight.black,
        //               scaleFactor: 0.8,
        //               size: 3,
        //               labelColor: Colorz.white20,
        //             );
        //
        //           }),
        //
        //         ],
        //       ),
        //
        //       /// ICONS
        //       Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //         children: <Widget>[
        //
        //           ...List.generate(FlyerTyper.savedFlyersTabs.length, (index){
        //
        //             final FlyerType _type = FlyerTyper.savedFlyersTabs[index];
        //             final String _icon = FlyerTyper.flyerTypeIconOn(_type);
        //
        //             return DreamBox(
        //               width: _parcelWidth,
        //               height: _parcelWidth,
        //               icon: _icon,
        //               iconSizeFactor: 0.7,
        //             );
        //
        //           }),
        //
        //         ],
        //       ),
        //
        //       /// VERSES
        //       Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //         children: <Widget>[
        //
        //           ...List.generate(FlyerTyper.savedFlyersTabs.length, (index){
        //
        //             final FlyerType _type = FlyerTyper.savedFlyersTabs[index];
        //             final String _phid = FlyerTyper.getFlyerTypePhid(flyerType: _type);
        //
        //             return SuperVerse(
        //               width: _parcelWidth,
        //               // height: _parcelWidth * 0.5,
        //               verse: Verse(text: _phid, translate: true),
        //               weight: VerseWeight.thin,
        //               scaleFactor: 0.5,
        //               size: 3,
        //               maxLines: 1,
        //             );
        //
        //           }),
        //
        //         ],
        //       ),
        //
        //       /// PLUS
        //       Row(
        //         key: const ValueKey<String>('plus'),
        //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //         children: <Widget>[
        //
        //           ...List.generate(FlyerTyper.savedFlyersTabs.length, (index){
        //
        //             final FlyerType _type = FlyerTyper.savedFlyersTabs[index];
        //
        //             if (_type == FlyerType.all){
        //               return SizedBox(
        //                 width: _parcelWidth,
        //                 height: _parcelWidth,
        //               );
        //             }
        //
        //             else {
        //               return DreamBox(
        //                 key: ValueKey('plus_$_type'),
        //                 width: _parcelWidth,
        //                 height: _parcelWidth,
        //                 icon: Iconz.arrowUp,
        //                 iconSizeFactor: 0.5,
        //                 onTap: () => _onAdd(_type),
        //               );
        //             }
        //
        //           }),
        //
        //         ],
        //       ),
        //
        //       /// MINUS
        //       Row(
        //         key: const ValueKey('minus'),
        //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //         children: <Widget>[
        //
        //           ...List.generate(FlyerTyper.savedFlyersTabs.length, (index){
        //
        //             final FlyerType _type = FlyerTyper.savedFlyersTabs[index];
        //
        //             if (_type == FlyerType.all){
        //               return SizedBox(
        //                 width: _parcelWidth,
        //                 height: _parcelWidth,
        //               );
        //             }
        //
        //             else {
        //               return DreamBox(
        //                 key: ValueKey('minus_$_type'),
        //                 width: _parcelWidth,
        //                 height: _parcelWidth,
        //                 icon: Iconz.arrowDown,
        //                 iconSizeFactor: 0.5,
        //                 onTap: () => _onRemove(_type),
        //               );
        //             }
        //
        //           }),
        //
        //         ],
        //       ),
        //
        //     ],
        //   ),
        // ),
        //
        // SuperVerse(
        //   width: Scale.screenWidth(context),
        //   verse: Verse.plain(_deckModel.toString()),
        //   maxLines: 850,
        //   centered: false,
        // ),

        DreamBox(
          key: ValueKey('plus_${FlyerType.equipment}'),
          width: _parcelWidth,
          height: _parcelWidth,
          icon: Iconz.arrowUp,
          iconSizeFactor: 0.5,
          onTap: () => _onAdd(FlyerType.equipment),
        ),

      ],
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}
