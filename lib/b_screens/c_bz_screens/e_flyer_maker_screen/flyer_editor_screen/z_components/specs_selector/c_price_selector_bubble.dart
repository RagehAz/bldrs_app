// ignore_for_file: join_return_with_assignment
import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/components/bubbles/bubble/bubble.dart';
import 'package:basics/components/bubbles/tile_bubble/tile_bubble.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/maps/mapper.dart';
import 'package:basics/helpers/nums/numeric.dart';
import 'package:basics/helpers/strings/text_mod.dart';
import 'package:basics/components/drawing/spacing.dart';
import 'package:bldrs/a_models/d_zoning/world_zoning.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/price_model.dart';
import 'package:bldrs/b_screens/c_bz_screens/e_flyer_maker_screen/flyer_editor_screen/z_components/specs_selector/c_price_field.dart';
import 'package:bldrs/b_screens/c_currencies_screen/c_currencies_screen.dart';
import 'package:bldrs/z_components/bubbles/a_structure/bldrs_bubble_header_vm.dart';
import 'package:bldrs/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/z_components/texting/bldrs_text_field/bldrs_validator.dart';
import 'package:bldrs/z_components/texting/bullet_points/bldrs_bullet_points.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:bldrs/f_helpers/router/d_bldrs_nav.dart';
import 'package:flutter/material.dart';

class PriceSelectorBubble extends StatefulWidget {
  // --------------------------------------------------------------------------
  const PriceSelectorBubble({
    required this.draft,
    required this.onOldPriceChanged,
    required this.onCurrentPriceChanged,
    required this.onCurrencyChanged,
    required this.priceIsGood,
    required this.onSwitchPrice,
    super.key
  });
  // ----------------------
  final DraftFlyer? draft;
  final Function(double val) onOldPriceChanged;
  final Function(double val) onCurrentPriceChanged;
  final Function(PriceModel price) onCurrencyChanged;
  final ValueNotifier<bool> priceIsGood;
  final Function(bool val) onSwitchPrice;
  // --------------------------------------------------------------------------
  static String? validate({
    required DraftFlyer? draft,
    required String? currentPriceText,
    required String? oldPriceText,
  }){

    if (draft?.price == null){
      return null;
    }

    else {

      String? _error = Formers.currencyFieldValidator(
        selectedCurrencyID: draft?.price?.currencyID,
        text: currentPriceText,
        isRequired: false,
      );

      _error ??= Formers.currencyFieldValidator(
        selectedCurrencyID: draft?.price?.currencyID,
        text: oldPriceText,
        isRequired: false,
      );

      if (_error == null){

        final bool _currentIsNull = draft?.price?.current == null;
        final bool _currentIsZero = draft?.price?.current == 0;
        final bool _currentIsPositive = Numeric.isGreaterThan(
          number: draft?.price?.current,
          isGreaterThan: 0,
        );
        final bool _currentHasValue =
            _currentIsNull != true &&
            _currentIsZero != true &&
            _currentIsPositive == true;

        final bool _oldIsNull = draft?.price?.old == null;
        final bool _oldIsZero = draft?.price?.old == 0;
        final bool _oldIsPositive = Numeric.isGreaterThan(
          number: draft?.price?.old,
          isGreaterThan: 0,
        );
        final bool _oldHasValue =
            _oldIsNull != true &&
            _oldIsZero != true &&
            _oldIsPositive == true;

        if (_currentHasValue == false && _oldHasValue == true){
          _error = getWord('phid_should_add_current_price');
        }

      }

      return _error;
    }

  }
  // --------------------------------------------------------------------------
  @override
  State<PriceSelectorBubble> createState() => _PriceSelectorBubbleState();
  // --------------------------------------------------------------------------
}

class _PriceSelectorBubbleState extends State<PriceSelectorBubble> {
  // --------------------------------------------------------------------------
  final TextEditingController _currentController = TextEditingController();
  final TextEditingController _oldController = TextEditingController();
  String? _error;
  // -----------------------------------------------------------------------------
  @override
  void initState() {

    _defineControllers();

    super.initState();
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {

    if (_isInit && mounted) {
      _isInit = false; // good

      asyncInSync(() async {

        _validate(
          draft: widget.draft,
        );

      });

    }
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void didUpdateWidget(PriceSelectorBubble oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.draft != widget.draft) {
      if (oldWidget.draft?.hasPriceTag != widget.draft?.hasPriceTag){
        _onSwitchListener(
          draft: widget.draft,
        );
      }
    }
  }
  // --------------------
  @override
  void dispose() {
    _currentController.dispose();
    _oldController.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------

  /// INITIALIZATION

  // --------------------
  /// TESTED : WORKS PERFECT
  void _defineControllers() {

    if (mounted == true){
      if (Mapper.boolIsTrue(widget.draft?.hasPriceTag) == true){
        _currentController.text = Numeric.stringifyDouble(widget.draft?.price?.current);
        _oldController.text = Numeric.stringifyDouble(widget.draft?.price?.old);
      }

      else {
        _currentController.text = '';
        _oldController.text = '';
      }

      _currentController.selection = TextMod.setCursorAtTheEnd(controller: _currentController);
      _oldController.selection = TextMod.setCursorAtTheEnd(controller: _oldController);

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onSwitchListener({
    required DraftFlyer? draft,
  }) async {

    await Future.delayed(const Duration(milliseconds: 10));

    _defineControllers();

    _validate(
      draft: draft,
    );

}
  // -----------------------------------------------------------------------------

  /// VALIDATION

  // --------------------
  /// TESTED : WORKS PERFECT
  void _validate({
      required DraftFlyer? draft,
  }){

    if (Mapper.boolIsTrue(draft?.hasPriceTag) == true){

      if (mounted == true){
        setState(() {
          _error = PriceSelectorBubble.validate(
            draft: draft,
            currentPriceText: _currentController.text,
            oldPriceText: _oldController.text,
          );
        });
      }

      setNotifier(
        notifier: widget.priceIsGood,
        mounted: mounted,
        value: _error == null,
      );

    }

    else {

      if (mounted == true && _error != null){
        setState(() {
          _error = null;
        });
      }

      setNotifier(
        notifier: widget.priceIsGood,
        mounted: mounted,
        value: true,
      );

    }

  }
  // -----------------------------------------------------------------------------

  /// ON CHANGES

  // --------------------
  /// TESTED : WORKS PERFECT
  void _onChangeCurrent(String? text){

    double? _val = Numeric.transformStringToDouble(text);
    _val ??= 0;

    PriceModel _priceModel = widget.draft?.price ?? PriceModel.emptyPrice;
      _priceModel = _priceModel.copyWith(
        current: _val,
      );

    _validate(
      draft: widget.draft?.copyWith(
          price: _priceModel,
        ),
    );

    widget.onCurrentPriceChanged(_val);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void _onChangeOld(String? text){

    double? _val = Numeric.transformStringToDouble(text);
    _val ??= 0;
    widget.onOldPriceChanged(_val);

    PriceModel _priceModel = widget.draft?.price ?? PriceModel.emptyPrice;
      _priceModel = _priceModel.copyWith(
        old: _val,
      );

      _validate(
        draft: widget.draft?.copyWith(
          price: _priceModel,
        ),
      );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onChangeCurrency() async {

    final CurrencyModel? _currency = await BldrsNav.goToNewScreen(
      screen: CurrenciesScreen(
        viewerCountryID: widget.draft?.zone?.countryID,
        selectedCurrencyID: widget.draft?.price?.currencyID,
      ),
    );

    if (_currency != null){


      PriceModel _priceModel = widget.draft?.price ?? PriceModel.emptyPrice;
      _priceModel = _priceModel.copyWith(
        currencyID: _currency.id,
      );

      _validate(
        draft: widget.draft?.copyWith(
          price: _priceModel,
        ),
      );

      widget.onCurrencyChanged(_priceModel);

    }


  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void _onSwitch(bool value){
    widget.onSwitchPrice(value);
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _bubbleWidth = Bubble.bubbleWidth(context: context);
    // --------------------
    final double _clearWidth = Bubble.clearWidth(context: context);
    // --------------------
    const double _spacing = 5;
    final _fieldWidth = (_clearWidth - (_spacing * 2)) / 3;
    const double _fieldHeight = 60;
    // --------------------
    return Opacity(
      opacity: Mapper.boolIsTrue(widget.draft?.hasPriceTag) == true ? 1 : 0.5,
      child: Bubble(
          bubbleColor: TileBubble.validatorBubbleColor(
            validator: (){
              return _error;
              },
          ),
          bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
            context: context,
            headlineVerse: const Verse(
              id: 'phid_s_price',
              translate: true,
              casing: Casing.capitalizeFirstChar,
            ),
            hasSwitch: true,
            switchValue: widget.draft?.hasPriceTag,
            onSwitchTap: _onSwitch,
          ),
          width: _bubbleWidth,
          columnChildren: <Widget>[

            /// BULLET POINTS
            const BldrsBulletPoints(
              bulletPoints: <Verse>[
                Verse(id: 'phid_change_price_anytime', translate: true),
                Verse(id: 'phid_old_price_is_optional', translate: true),
              ],
              showBottomLine: false,
            ),

            /// FIELDS
            SizedBox(
              width: _clearWidth,
              height: _fieldHeight,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[

                  /// CURRENT PRICE
                  PriceField(
                    controller: _currentController,
                    initialValue: widget.draft?.price?.current,
                    isRequired: widget.draft?.price?.current != null && widget.draft!.price!.current > 0,
                    width: _fieldWidth,
                    height: _fieldHeight,
                    selectedCurrencyID: widget.draft?.price?.currencyID,
                    title: const Verse(
                      id: 'phid_current_price',
                      translate: true,
                    ),
                    lineThrough: false,
                    isBold: true,
                    onChanged: _onChangeCurrent,
                  ),

                  /// SPACING
                  const Spacing(
                    size: _spacing,
                  ),

                  /// OLD PRICE
                  PriceField(
                    controller: _oldController,
                    initialValue: widget.draft?.price?.old,
                    isRequired: false,
                    width: _fieldWidth,
                    height: _fieldHeight,
                    selectedCurrencyID: widget.draft?.price?.currencyID,
                    title: const Verse(
                      id: 'phid_old_price',
                      translate: true,
                    ),
                    lineThrough: true,
                    isBold: false,
                    onChanged: _onChangeOld,
                  ),

                  /// SPACING
                  const Spacing(
                    size: _spacing,
                  ),

                  /// CURRENCY BUTTON
                  BldrsBox(
                    height: _fieldHeight * 0.6,
                    width: _fieldWidth,
                    color: Colorz.white10,
                    margins: const EdgeInsets.symmetric(
                      vertical: 9,
                    ),
                    verseScaleFactor: 0.7,
                    verse: CurrencyModel.getCurrencyButtonVerse(
                      currencyID: widget.draft?.price?.currencyID,
                    ),
                    verseMaxLines: 2,
                    verseWeight: VerseWeight.thin,
                    onTap: _onChangeCurrency,
                  ),

                ],
              ),
            ),

            /// DISCOUNT LINE
            if (
            Mapper.boolIsTrue(widget.draft?.hasPriceTag) == true
                &&
            PriceModel.checkCanShowDiscount(price: widget.draft?.price) == true
            )
            BldrsText(
              verse: PriceModel.generatePriceDiscountLine(
                price: widget.draft?.price,
              ),
              width: _clearWidth,
              italic: true,
              maxLines: 3,
              centered: false,
              color: Colorz.green255,
              weight: VerseWeight.thin,
              leadingDot: true,
            ),

            /// VALIDATOR
            BldrsValidator(
              width: _clearWidth,
              validator: (){
                return _error;
              },
            ),

            ]
      ),
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
