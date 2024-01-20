part of chains;

class PriceDataCreator extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const PriceDataCreator({
    required this.zone,
    required this.picker,
    required this.initialValue,
    required this.initialCurrencyID,
    required this.onKeyboardSubmitted,
    required this.onExportSpecs,
    required this.dataCreatorType,
    required this.onlyUseZoneChains,
    required this.appBarType,
    this.width,
    super.key
  });
  /// --------------------------------------------------------------------------
  final ZoneModel? zone;
  final PickerModel? picker;
  final SpecModel? initialValue;
  final String initialCurrencyID;
  final ValueChanged<String?>? onKeyboardSubmitted;
  final ValueChanged<List<SpecModel>>? onExportSpecs;
  final DataCreator? dataCreatorType;
  final bool onlyUseZoneChains;
  final AppBarType appBarType;
  final double? width;
  /// --------------------------------------------------------------------------
  @override
  State<PriceDataCreator> createState() => _PriceDataCreatorState();
  /// --------------------------------------------------------------------------
}

class _PriceDataCreatorState extends State<PriceDataCreator> {
  // -----------------------------------------------------------------------------
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _textController = TextEditingController();
  final ValueNotifier<String?> _selectedCurrencyID = ValueNotifier(null);
  final ValueNotifier<double?> _priceValue = ValueNotifier(null); // specValue
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    initializeCurrencyData(
      zone: widget.zone,
      selectedCurrencyID: _selectedCurrencyID,
      textController: _textController,
      initialValue: widget.initialValue,
      initialCurrencyID: widget.initialCurrencyID,
      priceValue: _priceValue,
      dataCreatorType: widget.dataCreatorType,
      mounted: mounted,
    );

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
  @override
  void dispose() {
    _textController.dispose();
    _selectedCurrencyID.dispose();
    _priceValue.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  String? _validator(String? text){
    return Formers.currencyFieldValidator(
      selectedCurrencyID: _selectedCurrencyID.value,
      text: _textController.text,
      isRequired: widget.picker?.isRequired,
    );
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    // blog('the fucking widget.dataCreatorType : ${widget.dataCreatorType} ${DataCreator.}');

    return Bubble(
      key: const ValueKey('PriceDataCreator'),
      bubbleColor: Formers.validatorBubbleColor(
        validator: () => _validator(_textController.text),
      ),
      bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
        context: context,
        headlineVerse: const Verse(
          id: 'phid_add_with_dots',
          translate: true,
        ),
      ),
      width: widget.width,
      columnChildren: <Widget>[

        // /// BULLET POINTS
        // BubbleBulletPoints(
        //     bulletPoints: bulletPoints,
        // ),

        /// DATA CREATOR ROW
        NumberDataCreatorFieldRow(
          width: widget.width,
          appBarType: widget.appBarType,
          hasUnit: true,
          hintVerse: const Verse(
            id: 'phid_add_price',
            translate: true,
          ),
          validator: (String? text) => _validator(_textController.text),
          textController: _textController,
          formKey: _formKey,
          selectedUnitID: _selectedCurrencyID,
          onUnitSelectorButtonTap: () => onCurrencySelectorButtonTap(
            specValue: _priceValue,
            onExportSpecs: widget.onExportSpecs,
            picker: widget.picker,
            text: _textController.text,
            context: context,
            zone: widget.zone,
            formKey: _formKey,
            selectedCurrencyID: _selectedCurrencyID,
            mounted: mounted,
          ),
          onKeyboardChanged: (String? text) => onDataCreatorKeyboardChanged(
            formKey: _formKey,
            specValue: _priceValue,
            dataCreatorType: widget.dataCreatorType,
            text: _textController.text,
            selectedUnitID: _selectedCurrencyID.value,
            picker: widget.picker,
            onExportSpecs: widget.onExportSpecs,
            mounted: mounted,
          ),
          onKeyboardSubmitted: (String? text) => onDataCreatorKeyboardSubmittedAnd(
            context: context,
            onKeyboardSubmitted: widget.onKeyboardSubmitted,
            formKey: _formKey,
            specValue: _priceValue,
            dataCreatorType: widget.dataCreatorType,
            text: _textController.text,
            selectedUnitID: _selectedCurrencyID.value,
            picker: widget.picker,
            onExportSpecs: widget.onExportSpecs,
            mounted: mounted,
          ),
        ),

      ],
    );

  }
  // -----------------------------------------------------------------------------
}
