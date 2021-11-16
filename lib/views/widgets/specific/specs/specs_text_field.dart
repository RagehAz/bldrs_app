

import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/numeric.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/text_mod.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/secondary_models/name_model.dart';
import 'package:bldrs/models/zone/currency_model.dart';
import 'package:bldrs/models/zone/flag_model.dart';
import 'package:bldrs/providers/zone_provider.dart';
import 'package:bldrs/views/widgets/general/appbar/bldrs_app_bar.dart';
import 'package:bldrs/views/widgets/general/bubbles/bubbles_separator.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/buttons/flagbox_button.dart';
import 'package:bldrs/views/widgets/general/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/views/widgets/general/layouts/navigation/max_bounce_navigator.dart';
import 'package:bldrs/views/widgets/general/textings/super_text_field.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:bldrs/views/widgets/specific/specs/currency_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SpecsTextField extends StatefulWidget {

  const SpecsTextField({
    Key key
  }) : super(key: key);

  @override
  State<SpecsTextField> createState() => _SpecsTextFieldState();
}

class _SpecsTextFieldState extends State<SpecsTextField> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController controller = TextEditingController();
  CurrencyModel _currency;
// -----------------------------------------------------------------------------
  @override
  void initState() {

    final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);
    _currency = _zoneProvider.currentCurrency;

    super.initState();
  }
// -----------------------------------------------------------------------------
  Future<void> _onSelectCurrency(CurrencyModel currency) async {


    setState(() {
      _currency = currency;
    });

    _validate();

    await Nav.goBack(context);

  }
// -----------------------------------------------------------------------------
  Future<void> _onCurrencyTap() async {

    final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);
    final List<CurrencyModel> _allCurrencies = _zoneProvider.allCurrencies;
    final CurrencyModel _currentCurrency = _zoneProvider.currentCurrency;
    final CurrencyModel _USDCurrency = CurrencyModel.getCurrencyFromCurrenciesByCountryID(
        currencies: _allCurrencies,
        countryID: 'usa',
    );

    final double _clearWidth = BottomDialog.dialogClearWidth(context);

    await BottomDialog.showBottomDialog(
        context: context,
        draggable: true,
        child: Container(
          width: _clearWidth,
          height: BottomDialog.dialogClearHeight(context: context, draggable: true),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              CurrencyButton(
                width: _clearWidth,
                currency: _currentCurrency,
                countryID: _currentCurrency.countriesIDs[0],
                onTap: () => _onSelectCurrency(_currentCurrency),
              ),

              CurrencyButton(
                width: _clearWidth,
                currency: _USDCurrency,
                countryID: 'USA',
                onTap: () => _onSelectCurrency(_USDCurrency),
              ),

              const BubblesSeparator(),

              DreamBox(
                height: 60,
                width: _clearWidth,
                verse: 'More Currencies',
                verseShadow: false,
                verseWeight: VerseWeight.thin,
                verseCentered: false,
                verseItalic: true,
                icon: Iconz.Dollar,
                iconSizeFactor: 0.6,
                color: Colorz.blackSemi255,
                bubble: false,
                onTap: () async {

                  await BottomDialog.showBottomDialog(
                    context: context,
                    draggable: true,
                    child: Container(
                      width: _clearWidth,
                      height: BottomDialog.dialogClearHeight(context: context, draggable: true),
                      child: MaxBounceNavigator(
                        child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: _allCurrencies.length,
                            itemBuilder: (ctx, index){

                              final CurrencyModel _currency = _allCurrencies[index];

                              return

                                CurrencyButton(
                                  width: _clearWidth,
                                  currency: _currency,
                                  countryID: _currency.countriesIDs[0],
                                  onTap: () async {

                                    await _onSelectCurrency(_currency);

                                    await Nav.goBack(context);

                                  },
                                );

                            }
                        ),
                      ),
                    ),
                  );


                },
              ),

            ],


          ),
        ),
    );


  }
// -----------------------------------------------------------------------------
  void _validate(){
    _formKey.currentState.validate();
  }
// -----------------------------------------------------------------------------
  String _validator(String val){

    final int _maxDigits = _currency.digits;

    final String _numberString = controller.text;
    final String _fractionsStrings = TextMod.removeTextBeforeFirstSpecialCharacter(_numberString, '.');
    final int _numberOfFractions = _fractionsStrings.length;

    bool _invalidDigits = _numberOfFractions > _maxDigits;

    print('_numberOfFractions : $_numberOfFractions : _numberString : $_numberString : _fractionsStrings : $_fractionsStrings');

    if (_invalidDigits == true){

      final String _error = 'Can not add more than ${_maxDigits} fractions';

      print(_error);

      return _error;

    } else {

      print('tamam');

      return null;

    }


  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _screenWidth = Scale.superScreenWidth(context);
    const double _bubbleHeight = 150;
    final double _bubbleWidth = BldrsAppBar.width(context);
    final BorderRadius _bubbleCorners = Borderers.superBorderAll(context, Ratioz.appBarCorner);

    const double _currencyFieldWidth = 70;
    final double _textFieldWidth = _bubbleWidth - _currencyFieldWidth - (Ratioz.appBarMargin * 2);
    const double _fieldHeight = 100;

    const String _hintText = 'Add price';

    return Container(
      width: _screenWidth,
      height: _bubbleHeight,
      alignment: Alignment.center,
      // color: Colorz.red230,
      child: Container(
        width: _bubbleWidth,
        height: _bubbleHeight - (2 * Ratioz.appBarMargin),
        decoration: BoxDecoration(
            color: Colorz.white10,
            borderRadius: _bubbleCorners,
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            /// NUMBER INPUT
            Container(
              width: _textFieldWidth,
              height: _fieldHeight,
              alignment: Alignment.center,
              child: Form(
                key: _formKey,
                child: SuperTextField(
                  fieldIsFormField: true,
                  // key: ValueKey('price_text_field'),
                  autofocus: true,
                  width: _textFieldWidth,
                  height: _fieldHeight,
                  textController: controller,
                  hintText: _hintText,
                  fieldColor: Colorz.black20,
                  centered: true,
                  counterIsOn: false,
                  inputSize: 4,
                  inputWeight: VerseWeight.black,
                  corners: Ratioz.appBarCorner,
                  keyboardTextInputType: TextInputType.number,
                  labelColor: Colorz.blackSemi255,

                  validator: (String val) => _validator(val),
                  onChanged: (String val) => _validate(),
                ),
              ),
            ),

            /// CURRENCY SELECTOR
            GestureDetector(
              onTap: _onCurrencyTap,
              child: Container(
                width: _currencyFieldWidth,
                height: _fieldHeight,
                alignment: Alignment.topCenter,
                color: Colorz.nothing,
                child: SuperVerse(
                  verse: _currency.symbol,
                  weight: VerseWeight.black,
                  size: 3,
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
