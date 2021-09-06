import 'package:bldrs/controllers/drafters/aligners.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/text_checkers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/widgets/buttons/back_anb_search_button.dart';
import 'package:bldrs/views/widgets/textings/super_text_field.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';


class SearchBar extends StatefulWidget {
  final TextEditingController searchController;
  final Function onSearchSubmit;
  final Function onSearchChanged;
  final bool historyButtonIsOn;

  const SearchBar({
    @required this.searchController,
    @required this.onSearchSubmit,
    @required this.onSearchChanged,
    @required this.historyButtonIsOn,
});

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  TextEditingController _searchTextController;

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

    double _appBarClearWidth = Scale.appBarClearWidth(context);

    const double _padding = Ratioz.appBarPadding;
    double _historyButtonWidth = widget.historyButtonIsOn == true ? 40 : 0;
    const double _historyButtonHeight = 40;
    int _numberOFPaddings = widget.historyButtonIsOn == true ? 3 : 2;
    double _textFieldWidth = _appBarClearWidth - _historyButtonWidth - _padding * _numberOFPaddings;

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

          SizedBox(
            width: _padding,
            height: _padding,
          ),

          /// SEARCH HISTORY BUTTON
          if (widget.historyButtonIsOn)
          Container(
            width: _historyButtonWidth,
            height: _historyButtonHeight,
            color: Colorz.LinkedIn,
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
          SizedBox(
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
              labelColor: Colorz.Yellow255,
              centered: false,
              italic: true,
              keyboardTextInputType: TextInputType.text,
              keyboardTextInputAction: TextInputAction.search,
              designMode: false,
              counterIsOn: false,
              fieldColor: null,
              corners: Ratioz.appBarButtonCorner,
              onTap: (){},
              onChanged: (val){
                widget.onSearchChanged(val);
              },
              hintText: ' Search ... ',
              inputColor: Colorz.Yellow255,
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

          SizedBox(
            width: _padding,
            height: _padding,
          ),

        ],
      ),
    );
  }
}
