import 'dart:async';

import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/e_flyer_box.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/c_protocols/bz_protocols/a_bz_protocols.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';

class BzCardScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const BzCardScreen({
    @required this.bzID,
    @required this.flyerBoxWidth,
    Key key,
  }) : super(key: key);

  /// --------------------------------------------------------------------------
  final String bzID;
  final double flyerBoxWidth;

  /// --------------------------------------------------------------------------
  @override
  _BzCardScreenState createState() => _BzCardScreenState();

  /// --------------------------------------------------------------------------
}

class _BzCardScreenState extends State<BzCardScreen> {
  // ZoneProvider _zoneProvider;

  // BzModel _bzModel;
  // CountryModel _bzCountry;
  // CityModel _bzCity;
  // -----------------------------------------------------------------------------
  /// --- FUTURE LOADING BLOCK
  bool _loading = false;
  Future<void> _triggerLoading({Function function}) async {
    if (mounted) {
      if (function == null) {
        setState(() {
          _loading = !_loading;
        });
      } else {
        setState(() {
          _loading = !_loading;
          function();
        });
      }
    }

    _loading == true
        ? blog('LOADING--------------------------------------')
        : blog('LOADING COMPLETE--------------------------------------');
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
      _triggerLoading().then((_) async {

        final BzModel _bz = await BzProtocols.fetchBz(
            context: context,
            bzID: widget.bzID,
        );

        // CountryModel _country;
        // CityModel _city;

        if (_bz != null) {

          // _country = await _zoneProvider.fetchCountryByID(
          //     context: context,
          //     countryID: _bz.zone.countryID,
          // );

          // _city = await _zoneProvider.fetchCityByID(
          //     context: context,
          //     cityID: _bz.zone.cityID,
          // );

        }


      }
      );
    }
    _isInit = false;
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    blog('building bz : ${widget.bzID}');

    // FlyersProvider pro = Provider.of<FlyersProvider>(context, listen: false);
    // final bz = pro.getBzByBzID(widget.bzID);

    const double flyerSizeFactor = 0.8;

    final double _flyerBoxWidth = FlyerBox.width(context, flyerSizeFactor);

    // final SuperFlyer _superFlyer = SuperFlyer.getSuperFlyerFromBzModelOnly(
    //   bzModel: _bzModel,
    //   onHeaderTap: () {
    //     blog('onHeader tap in h 1 bz card screen');
    //   },
    //   bzCountry: _bzCountry,
    //   bzCity: _bzCity,
    // );

    return MainLayout(
      pyramidsAreOn: true,

      // appBarType: AppBarType.Basic,
      // layoutWidget: ChangeNotifierProvider.value(
      //   value: bz,
      //   child: FlyerZone(
      //     flyerSizeFactor: flyerSizeFactor,
      //     tappingFlyerZone: (){blog('fuck you');},
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
      //           // blog('rebuilding widget with new followIsOn value : ${bz.followIsOn}');
      //         },
      //         tappingUnfollow: null, // Task : delete unfollow function and combine all following operations in one method
      //       ),
      //
      //     ],
      //   ),
      // ),

      layoutWidget: FlyerBox(
        flyerBoxWidth: _flyerBoxWidth,
        stackWidgets: <Widget>[
          // FlyerHeader(
          //   superFlyer: _superFlyer,
          //
          //   flyerBoxWidth: widget.flyerBoxWidth,
          // ),

          Container(),

        ],
      ),
    );
  }
}
