import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/models/flyer/mutables/super_flyer.dart';
import 'package:bldrs/models/zone/city_model.dart';
import 'package:bldrs/models/zone/country_model.dart';
import 'package:bldrs/providers/bzz_provider.dart';
import 'package:bldrs/providers/zone_provider.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/specific/flyer/parts/flyer_header.dart';
import 'package:bldrs/views/widgets/specific/flyer/parts/flyer_zone_box.dart';
import 'package:flutter/material.dart';

class BzCardScreen extends StatefulWidget {
  final String bzID;
  final double flyerBoxWidth;

  BzCardScreen({
    @required this.bzID,
    @required this.flyerBoxWidth,
});

  @override
  _BzCardScreenState createState() => _BzCardScreenState();
}

class _BzCardScreenState extends State<BzCardScreen> {

  ZoneProvider _zoneProvider;
  BzzProvider _bzzProvider;

  BzModel _bzModel;
  CountryModel _bzCountry;
  CityModel _bzCity;
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

        final BzModel _bz = await _bzzProvider.fetchBzModel(context: context, bzID: widget.bzID);
        CountryModel _country;
        CityModel _city;

        if (_bz != null){

          _country = await _zoneProvider.fetchCountryByID(context: context, countryID: _bz.zone.countryID);
          _city = await _zoneProvider.fetchCityByID(context: context, cityID: _bz.zone.cityID);

        }

        _triggerLoading(
            function: (){

              _bzModel = _bz;
              _bzCountry = _country;
              _bzCity = _city;

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
    print('building bz : ${widget.bzID}');

    // FlyersProvider pro = Provider.of<FlyersProvider>(context, listen: false);
    // final bz = pro.getBzByBzID(widget.bzID);


    const double flyerSizeFactor = 0.8;

    final double _flyerBoxWidth = FlyerBox.width(context, flyerSizeFactor);

    final SuperFlyer _superFlyer = SuperFlyer.getSuperFlyerFromBzModelOnly(
      bzModel: _bzModel,
      onHeaderTap: (){print('onHeader tap in h 1 bz card screen');},
      bzCountry: _bzCountry,
      bzCity: _bzCity,
    );


    return MainLayout(
      pyramids: Iconz.PyramidsYellow,

      // appBarType: AppBarType.Basic,
      // layoutWidget: ChangeNotifierProvider.value(
      //   value: bz,
      //   child: FlyerZone(
      //     flyerSizeFactor: flyerSizeFactor,
      //     tappingFlyerZone: (){print('fuck you');},
      //     stackWidgets: <Widget>[
      //
      //       Header(
      //         tinyBz: TinyBz.getTinyBzFromBzModel(bz),
      //         tinyAuthor: getTinyAuthorFromAuthorModel(bz.bzAuthors[0]),
      //         flyerShowsAuthor: true,
      //         followIsOn: false, // TASK : fix following on/off issue
      //         flyerBoxWidth: superFlyerBoxWidth(context, flyerSizeFactor),
      //         bzPageIsOn: _bzPageIsOn,
      //         tappingHeader: _triggerMaxHeader,
      //         tappingFollow: () async {
      //           // await bz.toggleFollow();
      //           // setState(() {});
      //           // print('rebuilding widget with new followIsOn value : ${bz.followIsOn}');
      //         },
      //         tappingUnfollow: null, // Task : delete unfollow function and combine all following operations in one method
      //       ),
      //
      //     ],
      //   ),
      // ),

      layoutWidget: FlyerBox(
        flyerBoxWidth: _flyerBoxWidth,
        superFlyer: _superFlyer,
        onFlyerZoneTap: (){print('tapping flyer zone in h 1 bz card screen ');},
        stackWidgets: <Widget>[

          FlyerHeader(
            superFlyer: _superFlyer,
            flyerBoxWidth: widget.flyerBoxWidth,
          ),

        ],
      ),

    );
  }
}
