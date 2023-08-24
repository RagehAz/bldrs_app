// ignore_for_file: join_return_with_assignment
import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bubbles/bubble/bubble.dart';
import 'package:basics/bubbles/tile_bubble/tile_bubble.dart';
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/nums/numeric.dart';
import 'package:basics/helpers/widgets/drawing/spacing.dart';
import 'package:bldrs/a_models/d_zoning/world_zoning.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/price_model.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/z_components/specs_selector/c_price_field.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bldrs_bubble_header_vm.dart';
import 'package:bldrs/b_views/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/b_views/z_components/texting/bldrs_text_field/bldrs_validator.dart';
import 'package:bldrs/b_views/z_components/texting/bullet_points/bldrs_bullet_points.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:flutter/material.dart';

class PriceSelectorBubble extends StatefulWidget {
  // --------------------------------------------------------------------------
  const PriceSelectorBubble({
    required this.draft,
    required this.onOldPriceChanged,
    required this.onCurrentPriceChanged,
    required this.onCurrencyChanged,
    super.key
  });
  // ----------------------
  final DraftFlyer? draft;
  final Function(double val) onOldPriceChanged;
  final Function(double val) onCurrentPriceChanged;
  final Function() onCurrencyChanged;
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
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    _currentController.text = widget.draft?.price?.current.toString() ?? '';
    _oldController.text = widget.draft?.price?.old.toString() ?? '';
    super.initState();
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {

    if (_isInit && mounted) {
      _isInit = false; // good

      asyncInSync(() async {

      });

    }
    super.didChangeDependencies();
  }
  // --------------------
  /*
  @override
  void didUpdateWidget(TheStatefulScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.thing != widget.thing) {
      unawaited(_doStuff());
    }
  }
   */
  // --------------------
  @override
  void dispose() {
    _currentController.dispose();
    _oldController.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  String? _validate(){

    return PriceSelectorBubble.validate(
      draft: widget.draft,
      currentPriceText: _currentController.text,
      oldPriceText: _oldController.text,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void _onChangeCurrent(String? text){

    final double? _val = Numeric.transformStringToDouble(text);
    if (_val != null){
      widget.onCurrentPriceChanged(_val);
    }
    else{
      widget.onCurrentPriceChanged(0);
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void _onChangeOld(String? text){

    final double? _val = Numeric.transformStringToDouble(text);
    if (_val != null){
      widget.onOldPriceChanged(_val);
    }
    else {
      widget.onOldPriceChanged(0);
    }

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
    final String? _error = _validate();
    // --------------------
    return Bubble(
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
                  onTap: widget.onCurrencyChanged,
                  verseScaleFactor: 0.7,
                  verse: CurrencyModel.getCurrencyButtonVerse(
                    currencyID: widget.draft?.price?.currencyID,
                  ),
                  verseMaxLines: 2,
                  verseWeight: VerseWeight.thin,
                ),

              ],
            ),
          ),

          /// DISCOUNT LINE
          if (PriceModel.checkCanShowDiscount(price: widget.draft?.price) == true)
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
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
