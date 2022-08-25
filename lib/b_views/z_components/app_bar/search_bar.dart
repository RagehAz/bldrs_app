import 'package:bldrs/b_views/z_components/app_bar/a_bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_text_field/a_super_text_field.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:bldrs/f_helpers/drafters/text_mod.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const SearchBar({
    @required this.onSearchSubmit,
    @required this.searchIconIsOn,
    this.searchController,
    this.onSearchChanged,
    this.boxWidth,
    this.hintText,
    this.height,
    this.onSearchCancelled,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final TextEditingController searchController;
  final ValueChanged<String> onSearchSubmit;
  final ValueChanged<String> onSearchChanged;
  final bool searchIconIsOn;
  final double boxWidth;
  final String hintText;
  final double height;
  final Function onSearchCancelled;
  /// --------------------------------------------------------------------------
  @override
  _SearchBarState createState() => _SearchBarState();
  /// --------------------------------------------------------------------------
}

class _SearchBarState extends State<SearchBar> {
// -----------------------------------------------------------------------------
  TextEditingController _searchTextController;
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _searchTextController = widget.searchController ?? TextEditingController();
  }
// -----------------------------------------------------------------------------
  /// TAMAM
  @override
  void dispose() {

    if (widget.searchController == null){
      _searchTextController.dispose();
    }

    super.dispose();
  }
// -----------------------------------------------------------------------------
  void _onClearSearch(){

    Keyboard.closeKeyboard(context);

    if (widget.searchController == null){
      _searchTextController.text = '';
    }

    if (widget.onSearchCancelled != null){
      widget.onSearchCancelled();
    }

  }

// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _appBarClearWidth = BldrsAppBar.width(context, boxWidth: widget.boxWidth);
    const double _padding = Ratioz.appBarPadding;
    final double _searchButtonWidth = widget.searchIconIsOn == true ? 40 : 0;
    const double _searchButtonHeight = 40;
    final int _numberOFPaddings = widget.searchIconIsOn == true ? 5 : 2;
    final double _textFieldWidth = _appBarClearWidth - (_searchButtonWidth*2) - _padding * _numberOFPaddings;

    // _appBarClearWidth - (Ratioz.appBarButtonSize + Ratioz.appBarPadding * 3) - 3;

    return Container(
      width: _appBarClearWidth,
      height: widget.height ?? Ratioz.appBarButtonSize + Ratioz.appBarPadding,
      // color: Colorz.bloodTest,
      alignment: Alignment.center, //Aligners.superTopAlignment(context),
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[

          /// STARTING SPACER
          const SizedBox(
            width: _padding,
            height: _padding,
          ),

          /// SEARCH BUTTON
          if (widget.searchIconIsOn == true)
          ValueListenableBuilder(
              valueListenable: _searchTextController,
              builder: (_, TextEditingValue value, Widget child){

                final bool _canSubmit = value.text.length >= Standards.minSearchChar;

                return Row(
                  children: <Widget>[

                    /// BUTTON
                    DreamBox(
                      width: _searchButtonWidth,
                      height: _searchButtonHeight,
                      icon: Iconz.search,
                      isDeactivated: !_canSubmit,
                      iconSizeFactor: 0.5,
                      bubble: false,
                      onTap: () async {

                        if (widget.onSearchSubmit != null){
                          widget.onSearchSubmit(value.text);
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
          SuperTextField(
            title: 'Search',
            // fieldIsFormField: true,
            // onSavedForForm: (String val) {
            //   blog('on saved');
            // },
            // labelColor: Colorz.yellow255,
            width: _textFieldWidth,

            textController: _searchTextController,
            textItalic: true,
            textInputAction: TextInputAction.search,
            corners: Ratioz.appBarButtonCorner,
            // onTap: () {},
            onChanged: (String val) {
              if (widget.onSearchChanged != null) {
                if (val != null) {
                  widget.onSearchChanged(val);
                }
              }
            },
            hintText: widget.hintText ?? 'Search ...',
            textColor: Colorz.yellow255,
            textWeight: VerseWeight.thin,
            textSizeFactor: 1.15,
            onSubmitted: (String val) {
              widget.onSearchSubmit(val);
            },
          ),

          /// MIDDLE SPACER
          if (widget.searchIconIsOn == true)

          /// SEARCH SUBMIT
          if (widget.searchIconIsOn == true)
            ValueListenableBuilder(
                valueListenable: _searchTextController,
                builder: (_, TextEditingValue value, Widget child){

                  final bool _canSubmit = value.text.length >= Standards.minSearchChar;

                  return Row(
                    children: <Widget>[

                      const SizedBox(
                        width: _padding,
                        height: _padding,
                      ),

                      DreamBox(
                        width: _searchButtonWidth,
                        height: _searchButtonHeight,
                        icon: _canSubmit == true ? Iconz.xSmall : Iconz.paste,
                        iconSizeFactor: 0.5,
                        bubble: false,
                        onTap: () async {

                          if (_canSubmit == true){
                            _onClearSearch();
                          }
                          else {
                            await TextMod.controllerPaste(_searchTextController);
                          }

                        },
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
  }
}
