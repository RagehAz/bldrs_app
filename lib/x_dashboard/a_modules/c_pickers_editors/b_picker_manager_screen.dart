import 'dart:async';

import 'package:bldrs/a_models/chain/c_picker_model.dart';
import 'package:bldrs/a_models/flyer/sub/flyer_typer.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/info_button/expanded_info_page_parts/info_page_headline.dart';
import 'package:bldrs/b_views/z_components/layouts/separator_line.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/c_protocols/picker_protocols/picker_protocols.dart';
import 'package:bldrs/d_providers/chains_provider.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/x_dashboard/a_modules/c_pickers_editors/a_pickers_editor_screen.dart';
import 'package:bldrs/x_dashboard/b_widgets/layout/dashboard_layout.dart';
import 'package:bldrs/x_dashboard/b_widgets/wide_button.dart';
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
// -----------
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
// -----------------------------------------------------------------------------
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
// -----------------------------------------------------------------------------
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
// -----------------------------------------------------------------------------
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

    final double _screenWidth = Scale.superScreenWidth(context);
    blog('c');
    return DashBoardLayout(
      // pageTitle: _flyerType?.toString(),
      appBarWidgets: <Widget>[

        AppBarButton(
          icon: Iconz.star,
          verse:  'thing',
          // buttonColor:
          // verseColor: Colorz.white255,
          onTap: (){
            blog('c');
          },
        ),

      ],
      listWidgets: <Widget>[

        // ---------------------------------------

        // const SeparatorLine(),

        /// VIEWING SPEC PICKERS
        InfoPageHeadline(
          pageWidth: _screenWidth - 20,
          headlineVerse: 'Fetch Picker and go',
        ),

        /// GO TO PICKERS SCREEN
        ...List.generate(_allFlyerTypes.length, (index){

          final FlyerType _flyerType = _allFlyerTypes[index];
          // final String _translatedFlyerType = FlyerTyper.cipherFlyerType(_flyerType);

          return WideButton(
            translate: false,
            verse:  '${FlyerTyper.cipherFlyerType(_flyerType).toUpperCase()} Pickers',
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
                    flyerZone: ZoneProvider.proGetCurrentZone(context: context, listen: true),
                  ),
                );
              }

            },
          );


        }),

        /// TESTERS

        // /// VIEWING SPEC PICKERS
        // InfoPageHeadline(
        //   pageWidth: _screenWidth - 20,
        //   headline: 'go to Initial $_translatedFlyerType Pickers',
        // ),
        // /// PICKERS SELECTORS
        // SizedBox(
        //   width: Scale.superScreenWidth(context),
        //   height: Ratioz.appBarButtonSize + 5,
        //   child: ListView.builder(
        //       physics: const BouncingScrollPhysics(),
        //       itemCount: _allTypes.length,
        //       scrollDirection: Axis.horizontal,
        //       itemBuilder: (_, index){
        //
        //         final FlyerType _flyerType = _allTypes[index];
        //         final bool _isSelected = _flyerType == _selectedFlyerType;
        //
        //         return DreamBox(
        //           height: 40,
        //           verse: FlyerTyper.cipherFlyerType(_flyerType).toUpperCase(),
        //           icon: FlyerTyper.flyerTypeIconOff(_flyerType),
        //           color: _isSelected == true ? Colorz.yellow255 : Colorz.white200,
        //           verseColor: Colorz.black255,
        //           verseScaleFactor: 0.7,
        //           verseWeight: VerseWeight.black,
        //           margins: const EdgeInsets.symmetric(horizontal: 5),
        //           verseItalic: true,
        //           onTap: () async {
        //
        //             _onTapPickerSelector(_flyerType);
        //
        //           },
        //         );
        //
        //       }
        //   ),
        // ),
        // // ---------------------------------------
        //
        // const SeparatorLine(),
        //
        //
        // /// SPEC REAL OPS
        // InfoPageHeadline(
        //   pageWidth: _screenWidth - 20,
        //   headline: 'PICKER PROTOCOLS',
        // ),
        //
        // /// COMPOSE PICKERS
        // WideButton(
        //   verse:  'COMPOSE : first pickers for ( $_translatedFlyerType )',
        //   // isActive: false,
        //   onTap: () async {
        //
        //     await PickerProtocols.composeFlyerTypePickers(
        //         context: context,
        //         pickers: PickerModel.getPickersByFlyerType(_selectedFlyerType),
        //         flyerType: _selectedFlyerType,
        //     );
        //
        //
        //   },
        // ),
        //
        // /// FETCH PICKERS
        // WideButton(
        //   verse:  'FETCH : Pickers for ( $_translatedFlyerType )',
        //   onTap: () async {
        //
        //     final List<PickerModel> _pickers = await PickerProtocols.fetchFlyerTypPickers(
        //       context: context,
        //       flyerType: _selectedFlyerType,
        //     );
        //
        //     PickerModel.blogPickers(_pickers);
        //
        //   },
        // ),

        // ---------------------------------------

        // /// SPEC REAL OPS
        // InfoPageHeadline(
        //   pageWidth: _screenWidth - 20,
        //   headline: 'PICKER LDB OPS',
        // ),
        //
        // /// CREATE DUMMY PICKERS
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
        // /// READ DUMMY PICKERS
        // WideButton(
        //   verse:  'READ LDB PICKERS ( $_translatedFlyerType )',
        //   onTap: () async {
        //
        //     await LDBViewersScreen.goToLDBViewer(context, LDBDoc.pickers);
        //
        //     // final List<PickerModel> _pickers = await PickerLDBOps.readPickers(
        //     //   flyerType: _selectedFlyerType,
        //     // );
        //     //
        //     // PickerModel.blogPickers(_pickers);
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
        // // ---------------------------------------
        //
        // const SeparatorLine(),
        //
        //
        // /// SPEC PRO
        // InfoPageHeadline(
        //   pageWidth: _screenWidth - 20,
        //   headline: 'PRO ALL PICKERS',
        // ),
        //
        // /// SET PICKERS READ
        // WideButton(
        //   verse:  'SET PRO PICKERS for ( $_translatedFlyerType )',
        //   // isActive: false,
        //   onTap: () async {
        //
        //
        //
        //     final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(context, listen: false);
        //     _chainsProvider.setFlyerTypePickers(
        //         context: context,
        //         flyerType: _selectedFlyerType,
        //         pickers: _pickers,
        //         notify: true,
        //     );
        //
        //     blog('done : SET PRO PICKERS for ( $_translatedFlyerType )');
        //
        //   },
        // ),
        //
        // /// SET PICKERS READ
        // WideButton(
        //   verse:  'PRO FETCH SET ALL PICKERS',
        //   // isActive: false,
        //   onTap: () async {
        //
        //     final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(context, listen: false);
        //     await _chainsProvider.fetchSetAllPickers(
        //       context: context,
        //       notify: true,
        //     );
        //
        //     blog('done : PRO FETCH SET ALL PICKERS');
        //
        //   },
        // ),
        //
        // /// PRO PICKERS READ
        WideButton(
          translate: false,
          verse:  'GET PRO PICKERS for ( equipment )',
          // isActive: false,
          onTap: () async {

            final List<PickerModel> _pickers = ChainsProvider.proGetPickersByFlyerType(
              context: context,
              flyerType: FlyerType.equipment,
              listen: false,
            );

            PickerModel.blogPickers(_pickers);

          },
        ),
        //
        //
        // // ---------------------------------------


        const SeparatorLine(),

        const Horizon(),

      ],
    );
  }
// -----------------------------------------------------------------------------
}
