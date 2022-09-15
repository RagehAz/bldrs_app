import 'dart:async';
import 'package:bldrs/a_models/chain/c_picker_model.dart';
import 'package:bldrs/a_models/flyer/sub/flyer_typer.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/info_button/expanded_info_page_parts/info_page_headline.dart';
import 'package:bldrs/b_views/z_components/layouts/separator_line.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/picker_protocols/picker_protocols.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/x_dashboard/d_pickers_editors/b_pickers_editor_screen.dart';
import 'package:bldrs/x_dashboard/z_widgets/layout/dashboard_layout.dart';
import 'package:bldrs/x_dashboard/z_widgets/wide_button.dart';
import 'package:flutter/material.dart';

class SpecPickerManager extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const SpecPickerManager({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  _SpecPickerManagerState createState() => _SpecPickerManagerState();
  /// --------------------------------------------------------------------------
}

class _SpecPickerManagerState extends State<SpecPickerManager> {
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void> _triggerLoading({
    bool setTo,
  }) async {
    if (mounted == true){
      if (setTo == null){
        _loading.value = !_loading.value;
      }
      else {
        _loading.value = setTo;
      }
      blogLoading(loading: _loading.value, callerName: 'SpecPickerManager',);
    }
  }
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      _triggerLoading().then((_) async {

        /// FUCK

        await _triggerLoading();
      });

      _isInit = false;
    }
    super.didChangeDependencies();
  }
  // --------------------
  /// TAMAM
  @override
  void dispose() {
    _loading.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  static const List<FlyerType> _allFlyerTypes = <FlyerType>[
    ...FlyerTyper.flyerTypesList,
  ];
  // --------------------
  /*
  FlyerType _selectedFlyerType;
// ------------------------
// ------------------------
  void _onTapPickerSelector(FlyerType flyerType){

    final bool _isSelected = _selectedFlyerType == flyerType;

    if (_isSelected == false){
      setState(() {
        _selectedFlyerType = flyerType;
      });
    }

  }
   */
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    // const FlyerType _flyerType = FlyerType.equipment;
    final double _screenWidth = Scale.superScreenWidth(context);

    return DashBoardLayout(
      // pageTitle: _flyerType?.toString(),
      appBarWidgets: <Widget>[

        AppBarButton(
          icon: Iconz.star,
          verse: Verse.plain('thing'),
          // buttonColor:
          // verseColor: Colorz.white255,
          onTap: (){
            blog('c');
          },
        ),

      ],
      listWidgets: <Widget>[

        // ------------------------------------------------------------

        /// EDIT PICKERS

        // ---------------------------------------

        const SeparatorLine(),

        /// VIEWING SPEC PICKERS
        InfoPageHeadline(
          pageWidth: _screenWidth - 20,
          headlineVerse: Verse.plain('Fetch Picker and go'),
        ),

        /// GO TO PICKERS SCREEN
        ...List.generate(_allFlyerTypes.length, (index){

          final FlyerType _flyerType = _allFlyerTypes[index];
          // final String _translatedFlyerType = FlyerTyper.cipherFlyerType(_flyerType);

          return WideButton(
            verse: Verse.plain('Edit ${FlyerTyper.cipherFlyerType(_flyerType).toUpperCase()} Pickers'),
            icon: FlyerTyper.flyerTypeIconOff(_flyerType),
            onTap: () async {

              final List<PickerModel> _pickers = await PickerProtocols.fetchFlyerTypPickers(
                context: context,
                flyerType: _flyerType,
              );

              if (_flyerType != null){
                await Nav.goToNewScreen(
                  context: context,
                  screen: SpecPickerEditorScreen(
                    specPickers: _pickers,
                    flyerType: _flyerType,
                    flyerZone: ZoneProvider.proGetCurrentZone(context: context, listen: false),
                  ),
                );
              }

            },
          );


        }),

        const SeparatorLine(),

        // ------------------------------------------------------------

        /// COMPOSE PICKERS

        // ---------------------------------------

        /// SPEC REAL OPS
        InfoPageHeadline(
          pageWidth: _screenWidth - 20,
          headlineVerse: Verse.plain('COMPOSING'),
        ),

        /// COMPOSE PICKERS
        WideButton(
          verse: Verse.plain('COMPOSE : first all pickers'),
          isActive: false,
          onTap: () async {


            // PickerModel.blogPickers(RawPickers.getPickersByFlyerType(_flyerType));
            //
            // final bool _continue = await Dialogs.confirmProceed(context: context);
            //
            // if (_continue == true){
            //
            //   for (final FlyerType type in FlyerTyper.flyerTypesList){
            //
            //     await PickerProtocols.composeFlyerTypePickers(
            //       context: context,
            //       pickers: RawPickers.getPickersByFlyerType(type),
            //       flyerType: type,
            //     );
            //
            //   }
            //
            //
            // }

          },
        ),

        const SeparatorLine(),

        // ------------------------------------------------------------

        /// PICKERS LDB

        // ---------------------------------------

        ///
        // WideButton(
        //   verse:  'INSERT in LDB',
        //   isActive: false,
        //   onTap: () async {
        //
        //     // await PickerLDBOps.insertPickers(
        //     //   pickers: _dummyPickers,
        //     //   flyerType: _dummyFlyerType,
        //     // );
        //
        //     // await LDBViewersScreen.goToLDBViewer(context, LDBDoc.pickers);
        //
        //   },
        // ),

        //
        // /// UPDATE DUMMY PICKERS
        // WideButton(
        //   verse:  'UPDATE LDB PICKERS',
        //   isActive: false,
        //   onTap: () async {
        //
        //     // final List<PickerModel> _existing = await PickerLDBOps.readPickers(
        //     //   flyerType: _dummyFlyerType,
        //     // );
        //     //
        //     // await PickerLDBOps.updatePickers(
        //     //   flyerType: _dummyFlyerType,
        //     //   pickers: [_existing[0]],
        //     // );
        //     //
        //     // await LDBViewersScreen.goToLDBViewer(context, LDBDoc.pickers);
        //
        //   },
        // ),

        // /// DELETE DUMMY PICKERS
        // WideButton(
        //   verse:  'DELETE LDB PICKERS',
        //   isActive: false,
        //   onTap: () async {
        //
        //     // await PickerLDBOps.deletePickers(
        //     //   flyerType: _dummyFlyerType,
        //     // );
        //     //
        //     // await LDBViewersScreen.goToLDBViewer(context, LDBDoc.pickers);
        //
        //   },
        // ),
        //

        // ------------------------------------------------------------

        /// BLOG LDB

        // ---------------------------------------

        /// VIEWING SPEC PICKERS
        InfoPageHeadline(
          pageWidth: _screenWidth - 20,
          headlineVerse: Verse.plain('BLOG PICKERS'),
        ),

        /// BLOG
        WideButton(
          verse: Verse.plain('BLOG ( FlyerType.project ) PICKERS'),
          // isActive: false,
          onTap: () async {

            /// GET FROM PRO
            // final List<PickerModel> _pickers = ChainsProvider.proGetPickersByFlyerType(
            //   context: context,
            //   flyerType: FlyerType.equipment,
            //   listen: false,
            // );

            /// GET FROM RAW
            // final List<PickerModel> _pickers = RawPickers.getPickersByFlyerType(FlyerType.project);
            //
            // final List<PickerModel> _updated = PickerModel.replaceAGroupID(
            //     pickers: _pickers,
            //     oldGroupName: 'Design Specificationsss',
            //     newGroupName: 'fuckkkyoooo'
            // );
            //
            // PickerModel.blogPickers(_updated);

          },
        ),

        const SeparatorLine(),

        // ---------------------------------------

        const Horizon(),

      ],
    );

  }
// -----------------------------------------------------------------------------
}
