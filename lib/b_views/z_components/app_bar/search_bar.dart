import 'package:bldrs/b_views/z_components/app_bar/bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_text_field/a_super_text_field.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const SearchBar({
    @required this.onSearchSubmit,
    @required this.historyButtonIsOn,
    this.searchController,
    this.onSearchChanged,
    this.boxWidth,
    this.hintText,
    this.height,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final TextEditingController searchController;
  final ValueChanged<String> onSearchSubmit;
  final ValueChanged<String> onSearchChanged;
  final bool historyButtonIsOn;
  final double boxWidth;
  final String hintText;
  final double height;
  /// --------------------------------------------------------------------------
  @override
  _SearchBarState createState() => _SearchBarState();
  /// --------------------------------------------------------------------------
}

class _SearchBarState extends State<SearchBar> {

  TextEditingController _searchTextController;
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _searchTextController = widget.searchController ?? TextEditingController(text: '');
  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {

    if (widget.searchController == null){
      _searchTextController.dispose();
    }

    super.dispose(); /// tamam
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _appBarClearWidth = BldrsAppBar.width(context, boxWidth: widget.boxWidth);
    const double _padding = Ratioz.appBarPadding;
    final double _historyButtonWidth = widget.historyButtonIsOn == true ? 40 : 0;
    const double _historyButtonHeight = 40;
    final int _numberOFPaddings = widget.historyButtonIsOn == true ? 3 : 2;
    final double _textFieldWidth = _appBarClearWidth - _historyButtonWidth - _padding * _numberOFPaddings;

    // _appBarClearWidth - (Ratioz.appBarButtonSize + Ratioz.appBarPadding * 3) - 3;

    return Container(
      width: _appBarClearWidth,
      height: widget.height ?? Ratioz.appBarButtonSize + Ratioz.appBarPadding,
      // color: Colorz.bloodTest,
      alignment: Alignment.center, //Aligners.superTopAlignment(context),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          /// STARTING SPACER
          const SizedBox(
            width: _padding,
            height: _padding,
          ),

          /// SEARCH HISTORY BUTTON
          if (widget.historyButtonIsOn)
            DreamBox(
              width: _historyButtonWidth,
              height: _historyButtonHeight,
              // color: Colorz.linkedIn,
              icon: Iconz.search,
              iconSizeFactor: 0.5,
              bubble: false,
              // onTap: (){blog('tapping on search button');},
            ),

          /// MIDDLE SPACER
          if (widget.historyButtonIsOn)
            const SizedBox(
              width: _padding,
              height: _padding,
            ),

          /// SEARCH TEXT FIELD
          SuperTextField(
            title: 'Search',
            // fieldIsFormField: true,
            // onSavedForForm: (String val) {
            //   blog('on saved');
            // },
            // height: widget.height ?? Ratioz.appBarButtonSize + Ratioz.appBarPadding,
            // height: Ratioz.appBarButtonSize * 0.5 * 2,
            // labelColor: Colorz.yellow255,
            width: _textFieldWidth - 5,
            textController: _searchTextController,
            textItalic: true,
            textInputAction: TextInputAction.search,
            corners: Ratioz.appBarButtonCorner,
            onTap: () {},
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
            onSubmitted: (String val) {
              widget.onSearchSubmit(val);
            },
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
