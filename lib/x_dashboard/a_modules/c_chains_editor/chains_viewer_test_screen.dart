import 'package:bldrs/a_models/chain/spec_models/spec_model.dart';
import 'package:bldrs/a_models/flyer/sub/flyer_typer.dart';
import 'package:bldrs/b_views/x_screens/j_chains/a_chains_screen.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/x_dashboard/b_widgets/layout/dashboard_layout.dart';
import 'package:bldrs/x_dashboard/b_widgets/wide_button.dart';
import 'package:flutter/material.dart';

class ChainsViewTestScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const ChainsViewTestScreen({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  _ChainsViewTestScreenState createState() => _ChainsViewTestScreenState();
/// --------------------------------------------------------------------------
}

class _ChainsViewTestScreenState extends State<ChainsViewTestScreen> {
// -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false); /// tamam disposed
// -----------
  Future<void> _triggerLoading({bool setTo}) async {
    if (mounted == true){
      if (setTo == null){
        _loading.value = !_loading.value;
      }
      else {
        _loading.value = setTo;
      }
      blogLoading(loading: _loading.value, callerName: 'TestingTemplate',);
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
  @override
  void dispose() {
    _loading.dispose();
    super.dispose(); /// tamam
  }
// -----------------------------------------------------------------------------
  final List<FlyerType> _selectedTypes = <FlyerType>[];
// -----------------------------------------------------------------------------
  static const List<FlyerType> _allTypes = <FlyerType>[
    // null,
    ...FlyerTyper.flyerTypesList,
  ];
// -------------------------------------------------
  void _onTapPickerSelector(FlyerType flyerType){

    final bool _isSelected = FlyerTyper.checkFlyerTypesIncludeThisType(
        flyerType: flyerType,
        flyerTypes: _selectedTypes,
    );

    if (_isSelected == true){
      setState(() {
        _selectedTypes.remove(flyerType);
      });
    }

    else {
      setState(() {
        _selectedTypes.insert(0, flyerType);
      });
    }

  }

  bool onlyPhidKs = false;

  @override
  Widget build(BuildContext context) {

    return DashBoardLayout(
      // pageTitle: _flyerType?.toString(),
      appBarWidgets: <Widget>[

        AppBarButton(
          icon: Iconz.keyword,
          verse: onlyPhidKs == true ? 'Only phidKs' : 'All Chains',
          buttonColor: onlyPhidKs == true ? Colorz.yellow255 : null,
          verseColor: onlyPhidKs == true ? Colorz.black255 : Colorz.white255,
          onTap: (){

            setState(() {
              onlyPhidKs = !onlyPhidKs;
            });

          },
        ),

      ],
      listWidgets: <Widget>[

        /// PICKERS SELECTORS
        SizedBox(
          width: Scale.superScreenWidth(context),
          height: Ratioz.appBarButtonSize + 5,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: _allTypes.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index){

                final bool _isSelected = FlyerTyper.checkFlyerTypesIncludeThisType(
                  flyerType: _allTypes[index],
                  flyerTypes: _selectedTypes,
                );


                return AppBarButton(
                  verse: _allTypes[index].toString(),
                  buttonColor: _isSelected == true ? Colorz.green255 : null,
                  onTap: () => _onTapPickerSelector(_allTypes[index]),
                );

              }
          ),
        ),

        /// CITY CHAINS + MULTIPLE SELECTION
        WideButton(
          verse: 'CITY CHAINS + MULTIPLE SELECTION',
          onTap: () async {

            final List<SpecModel> _specs =  await Nav.goToNewScreen(
                context: context,
                screen: ChainsScreen(
                  flyerTypesChainFilters: _selectedTypes,
                  onlyUseCityChains: true,
                  isMultipleSelectionMode: true,
                  pageTitle: 'CITY CHAINS + MULTIPLE SELECTION',
                  onlyChainKSelection: onlyPhidKs,
                )
            );

            blog('CITY CHAINS + MULTIPLE SELECTION : List<SpecModel> ');
            SpecModel.blogSpecs(_specs);

          },
        ),

        /// ALL CHAINS + MULTIPLE SELECTION
        WideButton(
          verse: 'ALL CHAINS + MULTIPLE SELECTION',
          color: Colorz.bloodTest,
          onTap: () async {

            final List<SpecModel> _specs =  await Nav.goToNewScreen(
                context: context,
                screen: ChainsScreen(
                  flyerTypesChainFilters: _selectedTypes,
                  onlyUseCityChains: false,
                  isMultipleSelectionMode: true,
                  pageTitle: 'ALL CHAINS + MULTIPLE SELECTION',
                  onlyChainKSelection: onlyPhidKs,
                )
            );

            blog('ALL CHAINS + MULTIPLE SELECTION : List<SpecModel>');
            SpecModel.blogSpecs(_specs);

          },
        ),

        /// CITY CHAINS + SINGLE SELECTION
        WideButton(
          verse: 'CITY CHAINS + SINGLE SELECTION',
          color: Colorz.bloodTest,
          onTap: () async {

            final String string =  await Nav.goToNewScreen(
                context: context,
                screen: ChainsScreen(
                  flyerTypesChainFilters: _selectedTypes,
                  onlyUseCityChains: true,
                  isMultipleSelectionMode: false,
                  pageTitle: 'CITY CHAINS + SINGLE SELECTION',
                  onlyChainKSelection: onlyPhidKs,
                )
            );

            blog('CITY CHAINS + SINGLE SELECTION : string : $string');

          },
        ),

        /// ALL CHAINS + SINGLE SELECTION
        WideButton(
          verse: 'ALL CHAINS + SINGLE SELECTION',
          onTap: () async {

            final String string =  await Nav.goToNewScreen(
                context: context,
                screen: ChainsScreen(
                  flyerTypesChainFilters: _selectedTypes,
                  onlyUseCityChains: false,
                  isMultipleSelectionMode: false,
                  pageTitle: 'ALL CHAINS + SINGLE SELECTION',
                  onlyChainKSelection: onlyPhidKs,
                )
            );

            blog('ALL CHAINS + SINGLE SELECTION : string : $string');

          },
        ),

      ],
    );
  }

}
