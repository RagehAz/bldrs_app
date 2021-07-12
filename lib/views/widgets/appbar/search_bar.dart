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
  const SearchBar({Key key}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  TextEditingController _searchTextController = TextEditingController();

  @override
  void initState() {
    _searchTextController.text = '';
    super.initState();
  }

  @override
  void dispose() {
    if (TextChecker.textControllerHasNoValue(_searchTextController))_searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    double _appBarClearWidth = Scale.appBarClearWidth(context);

    return Container(
      width: _appBarClearWidth,
      height: Ratioz.appBarButtonSize + Ratioz.appBarPadding,
      // color: Colorz.BloodTest,
      alignment: Aligners.superTopAlignment(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          /// SEARCH HISTORY BUTTON
          Container(
            width: 50,
            height: 40,
            // color: Colorz.LinkedIn,
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

          /// SEARCH TEXT FIELD
          SuperTextField(
            fieldIsFormField: true,
            width: _appBarClearWidth - (Ratioz.appBarButtonSize + Ratioz.appBarPadding * 3) - 3,
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
            onChanged: (value){
              print('search field change : $value');
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
              print('onSubmitted : $val');
            },

          )

        ],
      ),
    );
  }
}
