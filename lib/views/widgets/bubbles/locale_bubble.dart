import 'package:bldrs/controllers/drafters/keyboarders.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/localization/localization_constants.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:bldrs/models/planet/zone_model.dart';
import 'package:bldrs/providers/country_provider.dart';
import 'package:bldrs/views/widgets/appbar/ab_localizer.dart';
import 'package:bldrs/views/widgets/buttons/bt_list.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/dialogs/bottom_sheet.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'in_pyramids_bubble.dart';


class LocaleBubble extends StatefulWidget {
  final Function changeCountry;
  final Function changeProvince;
  final Function changeArea;
  final Zone currentZone;
  final String title;

  LocaleBubble({
    @required this.changeCountry,
    @required this.changeProvince,
    @required this.changeArea,
    @required this.currentZone,
    this.title = 'Preferred Location',
});

  @override
  _LocaleBubbleState createState() => _LocaleBubbleState();
}

class _LocaleBubbleState extends State<LocaleBubble> {
  String _chosenCountryID;
  String _chosenProvinceID;
  String _chosenAreaID;
  Zone _userZone;


  @override
  void initState() {
    _userZone = widget.currentZone;
    CountryProvider _countryPro = Provider.of<CountryProvider>(context, listen: false);
    _chosenCountryID = _userZone.countryID ;// == null ? _countryPro.currentCountryID : _userZone.countryID;
    _chosenProvinceID = _userZone.provinceID ;// == null ? _countryPro.currentProvinceID : _userZone.provinceID;
    _chosenAreaID = _userZone.areaID ;// == null ? _countryPro.currentAreaID : _userZone.areaID;
    super.initState();
  }

  // ----------------------------------------------------------------------
  void _closeBottomSheet(){
    Navigator.of(context).pop();
  }
  // ----------------------------------------------------------------------
  void _tapCountryButton({BuildContext context, CountryProvider countryPro, List<Map<String, String>> flags}){
    minimizeKeyboardOnTapOutSide(context);
    slideBottomSheet(
      context: context,
      draggable: true,
      height: null,
      child: ButtonsList(
        listOfMaps: flags,
        mapValueIs: MapValueIs.flag,
        alignment: Alignment.center,
        provider: countryPro,
        localizerPage: LocalizerPage.BottomSheet,
        buttonTap: (countryID){
          setState(() {
            _chosenCountryID = countryID;
            _chosenProvinceID = null;
            _chosenAreaID = null;
          });
          widget.changeCountry(countryID);
          print('_currentCountryID : $_chosenCountryID');
          _closeBottomSheet();
        },
      ),
    );
  }
  // ----------------------------------------------------------------------
  void _tapProvinceButton({BuildContext context, CountryProvider countryPro, List<Map<String, String>> provinces}){
    minimizeKeyboardOnTapOutSide(context);
    slideBottomSheet(
      context: context,
      draggable: true,
      height: null,
      child: ButtonsList(
        listOfMaps: provinces,
        mapValueIs: MapValueIs.String,
        alignment: Alignment.center,
        provider: countryPro,
        localizerPage: LocalizerPage.Province,
        buttonTap: (provinceID){
          setState(() {
            _chosenProvinceID = provinceID;
            _chosenAreaID = null;
          });
          widget.changeProvince(provinceID);
          print('_currentProvince : $_chosenProvinceID');
          _closeBottomSheet();
        },
      ),
    );
  }
  // ----------------------------------------------------------------------
  void _tapAreaButton({BuildContext context, CountryProvider countryPro, List<Map<String, String>> areas}){
    minimizeKeyboardOnTapOutSide(context);
    slideBottomSheet(
      context: context,
      draggable: true,
      height: null,
      child: ButtonsList(
        listOfMaps: areas,
        mapValueIs: MapValueIs.String,
        alignment: Alignment.center,
        provider: countryPro,
        localizerPage: LocalizerPage.Province,
        buttonTap: (areaID){
          setState(() {
            _chosenAreaID = areaID;
          });
          widget.changeArea(areaID);
          print('_currentAreaID : $areaID');
          _closeBottomSheet();
        },
      ),
    );
  }
  // ----------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    CountryProvider _countryPro =  Provider.of<CountryProvider>(context, listen: true);

    List<Map<String,String>> _flags = _countryPro.getAvailableCountries(context);
    List<Map<String,String>> _provinces = _countryPro.getProvincesNamesByIso3(context, _chosenCountryID);//_chosenCountry);
    List<Map<String,String>> _areas = _countryPro.getAreasNamesByProvinceID(context, _chosenProvinceID);//_chosenProvince);

    String _chosenCountryName = _chosenCountryID == null ? '...' : translate(context, _chosenCountryID);
    String _chosenCountryFlag = _chosenCountryID == null ? '' : getFlagByIso3(_chosenCountryID);
    String _chosenProvinceName = _chosenProvinceID == null ? '...' : _countryPro.getProvinceNameWithCurrentLanguageIfPossible(context, _chosenProvinceID);
    String _chosenAreaName = _chosenAreaID == null ? '...' : _countryPro.getAreaNameWithCurrentLanguageIfPossible(context, _chosenAreaID);


    double _bubbleClearWidth = superBubbleClearWidth(context);
    double _buttonsSpacing = Ratioz.ddAppBarMargin;
    // double _buttonWidth = (_bubbleClearWidth / 3)-((2*_buttonsSpacing)/3);

    return InPyramidsBubble(
        columnChildren: <Widget>[

          SuperVerse(
            verse: widget.title,
            margin: 5,
            redDot: true,

          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              // --- COUNTRY BUTTON
              LocaleButton(
                  title: Wordz.country(context),
                  icon: _chosenCountryFlag, //geebCountryFlagByCountryName(context),
                  verse: _chosenCountryName,
                  onTap: () => _tapCountryButton(context: context, flags: _flags, countryPro: _countryPro ),
              ),

              // --- PROVINCE BUTTON
              LocaleButton(
                title: 'Province', //Wordz.province(context),
                verse: _chosenProvinceName,
                onTap: () => _tapProvinceButton(context: context, provinces: _provinces, countryPro: _countryPro ),
              ),

              // --- AREA BUTTON
              LocaleButton(
                title: 'Area', //Wordz.area(context),
                verse: _chosenAreaName,
                onTap: ()=>_tapAreaButton(context: context, areas: _areas, countryPro: _countryPro),
              ),

            ],
          ),
        ]
    );
  }
}

class LocaleButton extends StatelessWidget {
  final String title;
  final String verse;
  final String icon;
  final Function onTap;

  LocaleButton({
    @required this.title,
    @required this.verse,
    this.icon,
    @required this.onTap,
});

  @override
  Widget build(BuildContext context) {

    double _bubbleClearWidth = superBubbleClearWidth(context);
    const double _buttonsSpacing = Ratioz.ddAppBarPadding;
    double _buttonWidth = (_bubbleClearWidth / 3)-((2*_buttonsSpacing)/3);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: _buttonsSpacing),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          // --- TITLE
          Container(
            width: _buttonWidth,
            child: SuperVerse(
              verse: title,
              centered: false,
              italic: true,
              weight: VerseWeight.thin,
              size: 2,
              color: Colorz.WhiteSmoke,
            ),
          ),

          // --- BUTTON CONTENTS
          DreamBox(
            height: 40,
            // width: _buttonWidth,
            verseScaleFactor: 0.8,
            iconSizeFactor: 0.8,
            icon: icon == null ? null : icon,
            bubble: false,
            verse: verse == null ? '' : '$verse    ',
            verseMaxLines: 2,
            color: Colorz.WhiteAir,
            boxFunction: onTap,
          ),

        ],
      ),
    );
  }
}
