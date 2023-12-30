part of bldrs_app_bar;

class SearchBar extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const SearchBar({
    required this.onSearchSubmit,
    required this.searchButtonIsOn,
    required this.appBarType,
    required this.globalKey,
    this.searchController,
    this.onSearchChanged,
    this.onPaste,
    // this.boxWidth,
    this.hintVerse,
    this.height,
    this.onSearchCancelled,
    this.filtersAreOn,
    this.onFilterTap,
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
  final GlobalKey? globalKey;
  final ValueNotifier<bool?>? filtersAreOn;
  final Function? onFilterTap;
  /// --------------------------------------------------------------------------
  @override
  _SearchBarState createState() => _SearchBarState();
  /// --------------------------------------------------------------------------
}

class _SearchBarState extends State<SearchBar> {
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
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _appBarClearWidth = BldrsAppBar.width();
    const double _padding = Ratioz.appBarPadding;
    final double _searchButtonWidth = widget.searchButtonIsOn == true ? 40 : 0;
    const double _searchButtonHeight = 40;
    final int _numberOFPaddings = widget.searchButtonIsOn == true ? 4 : 2;
    // _appBarClearWidth - (Ratioz.appBarButtonSize + Ratioz.appBarPadding * 3) - 3;
    final double _textFieldWidth = _appBarClearWidth - (_searchButtonWidth*2) - (_padding * _numberOFPaddings);
    // --------------------
    return Container(
      width: _appBarClearWidth,
      height: widget.height ?? Ratioz.appBarButtonSize + Ratioz.appBarPadding,
      // color: Colorz.bloodTest,
      alignment: Alignment.center, //Aligners.superTopAlignment(context),
      margin: const EdgeInsets.only(top: Ratioz.appBarPadding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          /// STARTING SPACER
          const SizedBox(
            width: _padding,
            height: _padding,
          ),

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
            // onTap: () {},
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
            textScaleFactor: 1.15,
            autoCorrect: Keyboard.autoCorrectIsOn(),
            enableSuggestions: Keyboard.suggestionsEnabled(),
            onSubmitted: (String? val) {
              if (widget.onSearchSubmit != null){
                widget.onSearchSubmit?.call(val);
              }
            },
          ),

          /// MIDDLE SPACER
          // if (widget.searchIconIsOn == true)

          /// PASTE BUTTON
          if (widget.searchButtonIsOn == true && widget.filtersAreOn == null)
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

          /// END SPACER
          const SizedBox(
            width: _padding,
            height: _padding,
          ),

        ],
      ),
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
