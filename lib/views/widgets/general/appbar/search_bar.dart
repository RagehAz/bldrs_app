import 'package:bldrs/controllers/drafters/text_checkers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/widgets/general/appbar/bldrs_app_bar.dart';
import 'package:bldrs/views/widgets/general/buttons/back_anb_search_button.dart';
import 'package:bldrs/views/widgets/general/textings/super_text_field.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:flutter/material.dart';


class SearchBar extends StatefulWidget {
  final TextEditingController searchController;
  final ValueChanged<String> onSearchSubmit;
  final ValueChanged<String> onSearchChanged;
  final bool historyButtonIsOn;

  const SearchBar({
    this.searchController,
    @required this.onSearchSubmit,
    this.onSearchChanged,
    @required this.historyButtonIsOn,
});

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  TextEditingController _searchTextController;
  GlobalKey _key = GlobalKey(debugLabel: 'search_bar');

  @override
  void initState() {
    super.initState();
    _searchTextController = widget.searchController ?? TextEditingController(text: '');
  }

  @override
  void dispose() {
    if (TextChecker.textControllerHasNoValue(_searchTextController))_searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final double _appBarClearWidth = BldrsAppBar.width(context);

    const double _padding = Ratioz.appBarPadding;
    final double _historyButtonWidth = widget.historyButtonIsOn == true ? 40 : 0;
    const double _historyButtonHeight = 40;
    final int _numberOFPaddings = widget.historyButtonIsOn == true ? 3 : 2;
    final double _textFieldWidth = _appBarClearWidth - _historyButtonWidth - _padding * _numberOFPaddings;

        // _appBarClearWidth - (Ratioz.appBarButtonSize + Ratioz.appBarPadding * 3) - 3;

    return Container(
      width: _appBarClearWidth,
      height: Ratioz.appBarButtonSize + Ratioz.appBarPadding,
      // color: Colorz.BloodTest,
      alignment: Alignment.center,//Aligners.superTopAlignment(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          const SizedBox(
            width: _padding,
            height: _padding,
          ),

          /// SEARCH HISTORY BUTTON
          if (widget.historyButtonIsOn)
          Container(
            width: _historyButtonWidth,
            height: _historyButtonHeight,
            // color: Colorz.linkedIn,
            alignment: Alignment.topLeft,
            child: BackAndSearchButton(
              backAndSearchAction: BackAndSearchAction.ShowHistory,
              passSearchHistory: (String value){
                print('value aho is $value');
                setState(() {
                  _searchTextController.text = value;
                });
              },
            ),
          ),

          if (widget.historyButtonIsOn)
          const SizedBox(
            width: _padding,
            height: _padding,
          ),

          /// SEARCH TEXT FIELD
          Container(
            // color: Colorz.BloodTest,
            child: SuperTextField(
              fieldIsFormField: true,
              width: _textFieldWidth,
              height: Ratioz.appBarButtonSize * 0.5,
              textController: _searchTextController,
              labelColor: Colorz.yellow255,
              centered: false,
              italic: true,
              keyboardTextInputType: TextInputType.text,
              keyboardTextInputAction: TextInputAction.search,
              counterIsOn: false,
              fieldColor: null,
              corners: Ratioz.appBarButtonCorner,
              onTap: (){},
              onChanged: (val){

                if (widget.onSearchChanged != null){
                  if (val != null){
                    widget.onSearchChanged(val);
                  }
                }


              },
              hintText: ' Search ... ',
              inputColor: Colorz.yellow255,
              inputSize: 2,
              inputShadow: false,
              inputWeight: VerseWeight.thin,
              onSaved: (){
                print('on saved');
              },
              onSubmitted: (val){
                widget.onSearchSubmit(val);

              },

            ),
          ),

          const SizedBox(
            width: _padding,
            height: _padding,
          ),

        ],
      ),
    );
  }
}
