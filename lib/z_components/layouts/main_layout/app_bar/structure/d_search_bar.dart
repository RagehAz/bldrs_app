part of bldrs_app_bar;

class BldrsSearchBar extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const BldrsSearchBar({
    required this.onSearchSubmit,
    required this.searchButtonIsOn,
    required this.appBarType,
    this.searchController,
    this.onSearchChanged,
    this.onPaste,
    // this.boxWidth,
    this.hintVerse,
    this.height,
    this.onSearchCancelled,
    this.filtersAreOn,
    this.onFilterTap,
    this.width,
    this.onTextFieldTap,
    super.key
  });
  /// --------------------------------------------------------------------------
  final TextEditingController? searchController;
  final ValueChanged<String?>? onSearchSubmit;
  final ValueChanged<String?>? onPaste;
  final ValueChanged<String?>? onSearchChanged;
  final bool searchButtonIsOn;
  // final double boxWidth;
  final Verse ?hintVerse;
  final double? height;
  final Function? onSearchCancelled;
  final AppBarType? appBarType;
  final ValueNotifier<bool?>? filtersAreOn;
  final Function? onFilterTap;
  final double? width;
  final Function? onTextFieldTap;
  /// --------------------------------------------------------------------------
  @override
  _BldrsSearchBarState createState() => _BldrsSearchBarState();
  /// --------------------------------------------------------------------------
}

class _BldrsSearchBarState extends State<BldrsSearchBar> {
  // -----------------------------------------------------------------------------
  final GlobalKey globalKey = GlobalKey();
  // --------------------
  late TextEditingController _searchTextController;
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _searchTextController = widget.searchController ?? TextEditingController();
  }
  // --------------------
  @override
  void dispose() {

    if (widget.searchController == null){
      _searchTextController.dispose();
    }

    super.dispose();
  }
  // -----------------------------------------------------------------------------
  Future<void> _onClearSearch() async {

    await Keyboard.closeKeyboard();

    if (widget.searchController == null){
      _searchTextController.text = '';
    }

    if (widget.onSearchCancelled != null){
      widget.onSearchCancelled?.call();
    }

  }
  // -----------------------------------------------------------------------------
  int _getNumberOfSpacings(){
    int _output = 0;

    if (widget.searchButtonIsOn == true){
      _output++;
    }
    if (widget.filtersAreOn != null){
      _output++;
    }
    if (_checkPasteButtonIsOn() == true){
      _output++;
    }

    return _output;
  }
  // --------------------
  bool _checkPasteButtonIsOn(){
    return widget.searchButtonIsOn == true && widget.filtersAreOn == null;
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _appBarClearWidth = widget.width ?? BldrsAppBar.clearWidth(context);
    const double _padding = Ratioz.appBarPadding;
    final double _searchButtonWidth = widget.searchButtonIsOn == true ? 40 : 0;
    const double _searchButtonHeight = 40;
    final int _numberOFPaddings = _getNumberOfSpacings();
    // _appBarClearWidth - (Ratioz.appBarButtonSize + Ratioz.appBarPadding * 3) - 3;
    final double _textFieldWidth = _appBarClearWidth - (_searchButtonWidth*2) - (_padding * _numberOFPaddings);
    final double _boxHeight = widget.height ?? Ratioz.appBarButtonSize;
    // --------------------
    return Container(
      width: _appBarClearWidth,
      height: _boxHeight,
      // color: Colorz.bloodTest,
      alignment: Alignment.center, //Aligners.superTopAlignment(context),
      // margin: const EdgeInsets.only(top: Ratioz.appBarPadding),
      child: Row(
        children: <Widget>[

          /// SEARCH BUTTON
          if (widget.searchButtonIsOn == true)
            ValueListenableBuilder(
                valueListenable: _searchTextController,
                builder: (_, TextEditingValue value, Widget? child){

                  final bool _canSubmit = value.text.length >= Standards.minSearchChar;

                  return Row(
                    children: <Widget>[

                      /// BUTTON
                      BldrsBox(
                        width: _searchButtonWidth,
                        height: _searchButtonHeight,
                        icon: Iconz.search,
                        isDisabled: !_canSubmit,
                        iconSizeFactor: 0.5,
                        bubble: false,
                        onTap: () async {

                          if (widget.onSearchSubmit != null){
                            widget.onSearchSubmit?.call(value.text);
                          }

                        },
                      ),

                      /// SPACER
                      const SizedBox(
                        width: _padding,
                        height: _padding,
                      ),

                    ],
                  );
                }
            ),

          /// SEARCH TEXT FIELD
          BldrsTextField(
            height: _boxHeight,
            appBarType: widget.appBarType,
            globalKey: globalKey,
            // autofocus: false,
            // titleVerse: const Verse(
            //   id: 'phid_search',
            //   translate: true,
            // ),
            // fieldIsFormField: true,
            // onSavedForForm: (String val) {
            //   blog('on saved');
            // },
            // labelColor: Colorz.yellow255,
            width: _textFieldWidth,
            // isFloatingField: false,
            textController: _searchTextController,
            textItalic: true,

            textInputAction: TextInputAction.search,
            corners: Ratioz.appBarButtonCorner,
            onTap: widget.onTextFieldTap,
            onChanged: (String? val) {
              if (widget.onSearchChanged != null) {
                if (val != null) {
                  widget.onSearchChanged?.call(val);
                }
              }
            },
            hintVerse: widget.hintVerse ?? const Verse(
              id: 'phid_search',
              translate: true,
            ),
            textColor: Colorz.yellow255,
            textWeight: VerseWeight.thin,
            textScaleFactor: _boxHeight * 0.0365,
            autoCorrect: Keyboard.autoCorrectIsOn(),
            enableSuggestions: Keyboard.suggestionsEnabled(),
            onSubmitted: (String? val) {
              if (widget.onSearchSubmit != null){
                widget.onSearchSubmit?.call(val);
              }
            },
          ),

          /// PASTE BUTTON
          if (_checkPasteButtonIsOn() == true)
            ValueListenableBuilder(
                valueListenable: _searchTextController,
                builder: (_, TextEditingValue value, Widget? child){

                  final bool _canSubmit = value.text.length >= 2;

                  return Row(
                    children: <Widget>[

                      const SizedBox(
                        width: _padding,
                        height: _padding,
                      ),

                      BldrsBox(
                        width: _searchButtonWidth,
                        height: _searchButtonHeight,
                        icon: _canSubmit == true ? Iconz.xSmall : Iconz.paste,
                        iconSizeFactor: 0.5,
                        bubble: false,
                        onTap: () async {

                          if (_canSubmit == true){
                            await _onClearSearch();
                          }
                          else {
                            await TextMod.controllerPaste(_searchTextController);
                            if (widget.onPaste != null){
                              widget.onPaste?.call(_searchTextController.text);
                            }
                          }

                        },
                      ),

                    ],
                  );
                }
            ),

          /// FILTER BUTTON
          if (widget.filtersAreOn != null)
            ValueListenableBuilder(
                valueListenable: widget.filtersAreOn!,
                builder: (_, bool? filtersAreOn, Widget? child){

                  return Row(
                    children: <Widget>[

                      const SizedBox(
                        width: _padding,
                        height: _padding,
                      ),

                      BldrsBox(
                        width: _searchButtonWidth,
                        height: _searchButtonHeight,
                        icon: Iconz.filter,
                        iconSizeFactor: 0.5,
                        color: Mapper.boolIsTrue(filtersAreOn) == true ? Colorz.yellow255 : Colorz.nothing,
                        isDisabled: filtersAreOn == null,
                        bubble: false,
                        onTap: widget.onFilterTap,
                      ),

                    ],
                  );
                }
                ),

        ],
      ),
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
