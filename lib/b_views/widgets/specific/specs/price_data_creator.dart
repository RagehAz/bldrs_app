import 'package:bldrs/a_models/zone/currency_model.dart';
import 'package:bldrs/b_views/widgets/general/appbar/bldrs_app_bar.dart';
import 'package:bldrs/b_views/widgets/general/bubbles/bubbles_separator.dart';
import 'package:bldrs/b_views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/widgets/general/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/b_views/widgets/general/layouts/navigation/max_bounce_navigator.dart';
import 'package:bldrs/b_views/widgets/general/textings/super_text_field.dart';
import 'package:bldrs/b_views/widgets/general/textings/super_verse.dart';
import 'package:bldrs/b_views/widgets/specific/specs/currency_button.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart' as Borderers;
import 'package:bldrs/f_helpers/drafters/keyboarders.dart' as Keyboarders;
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/drafters/text_mod.dart' as TextMod;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PriceDataCreator extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const PriceDataCreator(
      {@required this.onCurrencyChanged,
      @required this.onValueChanged,
      @required this.initialPriceValue,
      @required this.onSubmitted,
      Key key})
      : super(key: key);

  /// --------------------------------------------------------------------------
  final ValueChanged<CurrencyModel> onCurrencyChanged;
  final ValueChanged<String> onValueChanged;
  final double initialPriceValue;
  final Function onSubmitted;

  /// --------------------------------------------------------------------------
  static Future<void> showCurrencyDialog({
    @required BuildContext context,
    @required ValueChanged<CurrencyModel> onSelectCurrency,
    // @required
  }) async {
    final ZoneProvider _zoneProvider =
        Provider.of<ZoneProvider>(context, listen: false);
    final List<CurrencyModel> _allCurrencies = _zoneProvider.allCurrencies;
    final CurrencyModel _currentCurrency = _zoneProvider.currentCurrency;
    final CurrencyModel _usdCurrency =
        CurrencyModel.getCurrencyFromCurrenciesByCountryID(
      currencies: _allCurrencies,
      countryID: 'usa',
    );

    final double _clearWidth = BottomDialog.dialogClearWidth(context);

    await BottomDialog.showBottomDialog(
      context: context,
      draggable: true,
      child: SizedBox(
        width: _clearWidth,
        height:
            BottomDialog.dialogClearHeight(context: context, draggable: true),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CurrencyButton(
              width: _clearWidth,
              currency: _currentCurrency,
              countryID: _currentCurrency.countriesIDs[0],
              onTap: () => onSelectCurrency(_currentCurrency),
            ),
            CurrencyButton(
              width: _clearWidth,
              currency: _usdCurrency,
              countryID: 'USA',
              onTap: () => onSelectCurrency(_usdCurrency),
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
              icon: Iconz.dollar,
              iconSizeFactor: 0.6,
              color: Colorz.blackSemi255,
              bubble: false,
              onTap: () async {
                await BottomDialog.showBottomDialog(
                  context: context,
                  draggable: true,
                  child: SizedBox(
                    width: _clearWidth,
                    height: BottomDialog.dialogClearHeight(
                        context: context, draggable: true),
                    child: MaxBounceNavigator(
                      child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: _allCurrencies.length,
                          itemBuilder: (BuildContext ctx, int index) {
                            final CurrencyModel _currency =
                                _allCurrencies[index];

                            return CurrencyButton(
                              width: _clearWidth,
                              currency: _currency,
                              countryID: _currency.countriesIDs[0],
                              onTap: () {
                                onSelectCurrency(_currency);
                                // await null;

                                Nav.goBack(context);
                                // await null;
                              },
                            );
                          }),
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
  @override
  State<PriceDataCreator> createState() => _PriceDataCreatorState();
}

class _PriceDataCreatorState extends State<PriceDataCreator> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController controller = TextEditingController();
  final ValueNotifier<CurrencyModel> _currency =
      ValueNotifier<CurrencyModel>(null);
// -----------------------------------------------------------------------------
  @override
  void initState() {
    final ZoneProvider _zoneProvider =
        Provider.of<ZoneProvider>(context, listen: false);
    _currency.value = _zoneProvider.currentCurrency;
    controller.text = widget.initialPriceValue?.toString() ?? '';
    super.initState();
  }

// -----------------------------------------------------------------------------
  void _onSelectCurrency(CurrencyModel currency) {
    // setState(() {
    _currency.value = currency;
    // });

    _validate();

    widget.onCurrencyChanged(currency);

    Nav.goBack(context);
    // await null;
  }

// -----------------------------------------------------------------------------
  Future<void> _onCurrencyTap() async {
    await PriceDataCreator.showCurrencyDialog(
      context: context,
      onSelectCurrency: (CurrencyModel currency) => _onSelectCurrency(currency),
    );
  }

// -----------------------------------------------------------------------------
  void _validate() {
    _formKey.currentState.validate();
  }

// -----------------------------------------------------------------------------
  String _validator(String val) {
    final int _maxDigits = _currency.value.digits;

    final String _numberString = controller.text;
    final String _fractionsStrings =
        TextMod.removeTextBeforeFirstSpecialCharacter(_numberString, '.');
    final int _numberOfFractions = _fractionsStrings.length;

    final bool _invalidDigits = _numberOfFractions > _maxDigits;

    blog(
        '_numberOfFractions : $_numberOfFractions : _numberString : $_numberString : _fractionsStrings : $_fractionsStrings');

    if (_invalidDigits == true) {
      final String _error = 'Can not add more than $_maxDigits fractions';

      blog(_error);

      return _error;
    } else {
      blog('tamam');

      return null;
    }
  }

// -----------------------------------------------------------------------------
  void _onTextChanged(String val) {
    _validate();

    widget.onValueChanged(val);
    widget.onCurrencyChanged(_currency.value);
  }

// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    final double _screenWidth = Scale.superScreenWidth(context);
    const double _bubbleHeight = 150;
    final double _bubbleWidth = BldrsAppBar.width(context);
    final BorderRadius _bubbleCorners =
        Borderers.superBorderAll(context, Ratioz.appBarCorner);

    const double _currencyFieldWidth = 70;
    final double _textFieldWidth =
        _bubbleWidth - _currencyFieldWidth - (Ratioz.appBarMargin * 2);
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
                  onChanged: (String val) => _onTextChanged(val),
                  onSubmitted: (String val) async {
                    _onTextChanged(val);
                    Keyboarders.minimizeKeyboardOnTapOutSide(context);
                    // await null;

                    await Future<void>.delayed(Ratioz.durationSliding400,
                        () async {
                      widget.onSubmitted();
                    });
                  },
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
                child: ValueListenableBuilder<CurrencyModel>(
                  valueListenable: _currency,
                  builder:
                      (BuildContext ctx, CurrencyModel value, Widget child) {
                    return SuperVerse(
                      verse: _currency.value.symbol,
                      weight: VerseWeight.black,
                      size: 3,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
