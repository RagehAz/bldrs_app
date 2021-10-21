import 'package:bldrs/controllers/drafters/aligners.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/timerz.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:bldrs/models/user/user_model.dart';
import 'package:bldrs/models/zone/city_model.dart';
import 'package:bldrs/models/zone/country_model.dart';
import 'package:bldrs/models/zone/district_model.dart';
import 'package:bldrs/models/zone/flag_model.dart';
import 'package:bldrs/models/zone/zone_model.dart';
import 'package:bldrs/providers/zone_provider.dart';
import 'package:bldrs/views/widgets/general/bubbles/bubble.dart';
import 'package:bldrs/views/widgets/general/buttons/balloons/user_balloon.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/buttons/flagbox_button.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserBubble extends StatefulWidget {
  final UserModel user;
  final Function switchUserType;
  final Function editProfileBtOnTap;
  final bool loading;

  UserBubble({
    @required this.user,
    @required this.switchUserType,
    @required this.editProfileBtOnTap,
    @required this.loading,
  });

  @override
  State<UserBubble> createState() => _UserBubbleState();
}

class _UserBubbleState extends State<UserBubble> {
  CountryModel _userCountry;
  // -----------------------------------------------------------------------------
  /// --- FUTURE LOADING BLOCK
  bool _loading = false;
  Future <void> _triggerLoading({Function function}) async {

    if(mounted){

      if (function == null){
        setState(() {
          _loading = !_loading;
        });
      }

      else {
        setState(() {
          _loading = !_loading;
          function();
        });
      }

    }

    _loading == true?
    print('LOADING--------------------------------------') : print('LOADING COMPLETE--------------------------------------');
  }
// -----------------------------------------------------------------------------
  @override
  void initState() {

    super.initState();
  }
// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      _triggerLoading().then((_) async{

        final ZoneProvider _zoneProvider =  Provider.of<ZoneProvider>(context, listen: false);

        final Zone _userZone = widget.user?.zone;
        final CountryModel _country = await _zoneProvider.fetchCountryByID(context: context, countryID: _userZone.countryID);


        _triggerLoading(
            function: (){
              _userCountry = _country;
            }
        );
      });


    }
    _isInit = false;
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------


  @override
  Widget build(BuildContext context) {

    final String _countryName = CountryModel.getTranslatedCountryNameByID(context: context, countryID: _userCountry?.countryID);
    final String _countryFlag = Flag.getFlagIconByCountryID(_userCountry?.countryID);

    final String _cityName = CityModel.getTranslatedCityNameFromCountry(
        context: context,
        country: _userCountry,
        cityID: widget.user?.zone?.cityID
    );

    final String _districtName = DistrictModel.getTranslatedDistrictNameFromCountry(
      context: context,
      country: _userCountry,
      cityID: widget.user?.zone?.cityID,
      districtID: widget.user?.zone?.districtID,
    );

    final double _screenWidth = Scale.superScreenWidth(context);
    final double _screenHeight = Scale.superScreenHeight(context);

    final double _topPadding = _screenHeight * 0.05;
    final double _editProfileBtSize = _topPadding ;

    return Bubble(

      centered: true,
      columnChildren: <Widget>[

        Container(
          height: _topPadding,
          alignment: Aligners.superInverseCenterAlignment(context),
          child: DreamBox(
            height: _editProfileBtSize,
            width: _editProfileBtSize,
            icon: Iconz.Gears,
            iconSizeFactor: 0.6,
            bubble: true,
            onTap: widget.editProfileBtOnTap,
          ),
        ),

        UserBalloon(
          balloonWidth: 80,
          balloonType: widget.user?.status,
          userModel: widget.user,
          onTap: (){print(widget.user.userID);},
          loading: widget.loading,
        ),

        /// USER NAME
        SuperVerse(
          verse: widget.user?.name,
          shadow: true,
          size: 4,
          margin: 5,
          maxLines: 2,
          labelColor: Colorz.white10,
        ),

        /// USER JOB TITLE
        SuperVerse(
          verse: '${widget.user?.title} @ ${widget.user?.company}',
          size: 2,
          italic: true,
          weight: VerseWeight.thin,
        ),

        /// USER LOCALE
        Container(
          height: 35,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

              FlagBox(
                size: 20,
                flag: _countryFlag,
              ),

              const SizedBox(
                width: 5,
                height: 5,
              ),

              SuperVerse(
                verse: '${Wordz.inn(context)} $_districtName, $_cityName, $_countryName',
                weight: VerseWeight.thin,
                italic: true,
                color: Colorz.grey225,
                size: 2,
                margin: 5,
              ),

            ],
          ),
        ),

        /// Joined at
        SuperVerse(
          verse: Timers.monthYearStringer(context,widget.user?.createdAt),
          weight: VerseWeight.thin,
          italic: true,
          color: Colorz.grey225,
          size: 1,
        ),

        SizedBox(
          width: _screenWidth,
          height: _screenHeight * 0.05,
        ),

      ],
    );
  }
}
