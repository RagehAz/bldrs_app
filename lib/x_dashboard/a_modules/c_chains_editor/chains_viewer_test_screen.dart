import 'package:bldrs/a_models/chain/spec_models/spec_model.dart';
import 'package:bldrs/a_models/flyer/sub/flyer_typer.dart';
import 'package:bldrs/b_views/x_screens/j_chains/a_chains_screen.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
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
  FlyerType _flyerType;
// -----------------------------------------------------------------------------
  static const List<FlyerType> _flyerTypes = <FlyerType>[
    null,
    ...FlyerTyper.flyerTypesList,
  ];
// -------------------------------------------------
  void _onTapPickerSelector(FlyerType flyerType){

    setState(() {
      _flyerType = flyerType;
    });

  }

  @override
  Widget build(BuildContext context) {

    return DashBoardLayout(
      pageTitle: _flyerType?.toString(),
      listWidgets: <Widget>[

        /// PICKERS SELECTORS
        SizedBox(
          width: Scale.superScreenWidth(context),
          height: Ratioz.appBarButtonSize + 5,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: _flyerTypes.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index){

                final bool _isSelected = _flyerTypes[index] == _flyerType;

                return AppBarButton(
                  verse: _flyerTypes[index].toString(),
                  buttonColor: _isSelected == true ? Colorz.green255 : null,
                  onTap: () => _onTapPickerSelector(_flyerTypes[index]),
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
                  flyerTypeChainFilter: _flyerType,
                  onlyUseCityChains: true,
                  isMultipleSelectionMode: true,
                  pageTitle: 'CITY CHAINS + MULTIPLE SELECTION',

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
                  flyerTypeChainFilter: _flyerType,
                  onlyUseCityChains: false,
                  isMultipleSelectionMode: true,
                  pageTitle: 'ALL CHAINS + MULTIPLE SELECTION',

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
                  flyerTypeChainFilter: _flyerType,
                  onlyUseCityChains: true,
                  isMultipleSelectionMode: false,
                  pageTitle: 'CITY CHAINS + SINGLE SELECTION',

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
                  flyerTypeChainFilter: _flyerType,
                  onlyUseCityChains: false,
                  isMultipleSelectionMode: false,
                  pageTitle: 'ALL CHAINS + SINGLE SELECTION',

                )
            );

            blog('ALL CHAINS + SINGLE SELECTION : string : $string');

          },
        ),

      ],
    );
  }

}
