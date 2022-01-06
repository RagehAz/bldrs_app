import 'package:bldrs/a_models/secondary_models/name_model.dart';
import 'package:bldrs/a_models/zone/city_model.dart';
import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/b_views/widgets/general/appbar/bldrs_app_bar.dart';
import 'package:bldrs/b_views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/widgets/general/textings/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/super_text_field.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart' as TextChecker;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  // GlobalKey _key = GlobalKey(debugLabel: 'search_bar');

  @override
  void initState() {
    super.initState();
    _searchTextController = widget.searchController ?? TextEditingController(text: '');
  }

  @override
  void dispose() {
    if (TextChecker.textControllerIsEmpty(_searchTextController)) {
      _searchTextController.dispose();
    }
    super.dispose();
  }

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
              onTap: (){blog('tapping on search button');},
            ),

          if (widget.historyButtonIsOn)
            const SizedBox(
              width: _padding,
              height: _padding,
            ),

          /// SEARCH TEXT FIELD
          Consumer<ZoneProvider>(
            builder: (_,ZoneProvider zoneProvider, Widget child){

              final CountryModel _country = zoneProvider.currentCountry;
              final CityModel _city = zoneProvider.currentCity;
              final String _countryName = Name.getNameByCurrentLingoFromNames(context: context, names: _country.names)?.value;
              final String _cityName = Name.getNameByCurrentLingoFromNames(context: context, names: _city.names)?.value;

              final String _hintText = 'Search flyers in $_cityName, $_countryName';

              return SuperTextField(
                fieldIsFormField: true,
                width: _textFieldWidth - 5,
                // height: Ratioz.appBarButtonSize * 0.5 * 2,
                textController: _searchTextController,
                labelColor: Colorz.yellow255,
                italic: true,
                keyboardTextInputAction: TextInputAction.search,
                counterIsOn: false,
                corners: Ratioz.appBarButtonCorner,
                onTap: () {},
                onChanged: (String val) {
                  if (widget.onSearchChanged != null) {
                    if (val != null) {
                      widget.onSearchChanged(val);
                    }
                  }
                },
                hintText: widget.hintText ?? _hintText,
                inputColor: Colorz.yellow255,
                inputWeight: VerseWeight.thin,
                onSaved: (String val) {
                  blog('on saved');
                },
                onSubmitted: (String val) {
                  widget.onSearchSubmit(val);
                },
              );

            },
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
