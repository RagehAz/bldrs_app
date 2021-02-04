import 'package:bldrs/providers/country_provider.dart';
import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:bldrs/view_brains/localization/localization_constants.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/flagz.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:bldrs/view_brains/theme/wordz.dart';
import 'package:bldrs/views/widgets/appbar/ab_localizer.dart';
import 'package:bldrs/views/widgets/buttons/bt_list.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/layouts/bottom_sheet.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'in_pyramids_bubble.dart';

class LocaleBubble extends StatefulWidget {
  final Function changeCountry;
  final Function changeProvince;
  final Function changeArea;

  LocaleBubble({
    @required this.changeCountry,
    @required this.changeProvince,
    @required this.changeArea,
});

  @override
  _LocaleBubbleState createState() => _LocaleBubbleState();
}

class _LocaleBubbleState extends State<LocaleBubble> {
  String _chosenCountryID;
  String _chosenProvinceID;
  String _chosenAreaID;

  @override
  void initState() {
    _chosenCountryID = Provider.of<CountryProvider>(context, listen: false).currentCountryID;
    _chosenProvinceID = Provider.of<CountryProvider>(context, listen: false).currentProvinceID;
    _chosenAreaID = Provider.of<CountryProvider>(context, listen: false).currentAreaID;
    super.initState();
  }

  // ----------------------------------------------------------------------
  void _closeBottomSheet(){
    Navigator.of(context).pop();
  }
  // ----------------------------------------------------------------------
  void _tapCountryButton({BuildContext context, CountryProvider countryPro, List<Map<String, String>> flags}){
    print('_tapCountryButton');
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

    String _chosenCountryName = translate(context, _chosenCountryID);
    String _chosenCountryFlag = _countryPro.getFlagByIso3(_chosenCountryID);
    String _chosenProvinceName = _countryPro.getProvinceNameWithCurrentLanguageIfPossible(context, _chosenProvinceID);
    String _chosenAreaName = _countryPro.getAreaNameWithCurrentLanguageIfPossible(context, _chosenAreaID);


    double _bubbleClearWidth = superBubbleClearWidth(context);
    double _buttonsSpacing = Ratioz.ddAppBarMargin;
    double _buttonWidth = (_bubbleClearWidth / 3)-((2*_buttonsSpacing)/3);

    return InPyramidsBubble(
        bubbleColor: Colorz.WhiteAir,
        columnChildren: <Widget>[

          SuperVerse(
            verse: Wordz.hqCity(context),
            margin: 5,
          ),

          Row(
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
    double _buttonsSpacing = Ratioz.ddAppBarMargin;
    double _buttonWidth = (_bubbleClearWidth / 3)-((2*_buttonsSpacing)/3);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[

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

        DreamBox(
          height: 40,
          width: _buttonWidth,
          verseScaleFactor: 0.7,
          iconSizeFactor: 0.8,
          icon: icon == null ? null : icon,
          bubble: false,
          verse: verse == null ? '' : verse,
          verseMaxLines: 2,
          color: Colorz.WhiteAir,
          boxFunction: onTap,
        ),

      ],
    );
  }
}
