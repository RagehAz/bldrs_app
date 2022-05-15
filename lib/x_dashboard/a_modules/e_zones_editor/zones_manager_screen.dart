import 'dart:async';

import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/a_models/zone/flag_model.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/unfinished_night_sky.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/e_db/fire/methods/firestore.dart' as Fire;
import 'package:bldrs/e_db/fire/methods/paths.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/x_dashboard/a_modules/e_zones_editor/country_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ZonesEditorScreen extends StatefulWidget {
  const ZonesEditorScreen({Key key}) : super(key: key);

  @override
  _ZonesEditorScreenState createState() => _ZonesEditorScreenState();
}

class _ZonesEditorScreenState extends State<ZonesEditorScreen> {
  List<CountryModel> _countries;
  ScrollController _scrollController;
  QueryDocumentSnapshot<Object> _lastSnap;
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
    _scrollController = ScrollController();
    super.initState();
  }

// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      _triggerLoading().then((_) async {
        await _readMoreCountries();

        unawaited(_triggerLoading(function: () {
          /// set new values here
        }));
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------
  Future<void> _readMoreCountries() async {
    if (_loading == false) {
      setState(() {
        _loading = true;
      });
    }

    final List<Map<String, dynamic>> _maps = await Fire.readSubCollectionDocs(
      context: context,
      collName: FireColl.zones,
      docName: 'countries',
      subCollName: 'countries',
      limit: 5,
      orderBy: 'id',
      startAfter: _lastSnap,
      addDocSnapshotToEachMap: true,
    );

    final List<CountryModel> _countriesModels = CountryModel.decipherCountriesMaps(
        maps: _maps,
        fromJSON: false,
    );

    final QueryDocumentSnapshot<Object> _snap = _maps[_maps.length - 1]['docSnapshot'];

    setState(() {
      _countries = _countriesModels;
      _lastSnap = _snap;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double _screenWidth = Scale.superScreenWidth(context);

    return MainLayout(
        pyramidsAreOn: true,
        appBarType: AppBarType.basic,
        pageTitle: 'Zones Manager',
        // appBarBackButton: true,
        skyType: SkyType.black,
        layoutWidget: Mapper.canLoopList(_countries) == false ?
        Container()
            :
        ListView.builder(
          physics: const BouncingScrollPhysics(),
          controller: _scrollController,
          padding: const EdgeInsets.only(top: Ratioz.stratosphere),
          itemCount: _countries?.length,
          itemBuilder: (BuildContext context, int index) {

            final CountryModel _countryModel = _countries[index];
            final String _countryName = superPhrase(context, _countryModel.id);

            return DreamBox(
              height: 100,
              width: _screenWidth - (Ratioz.appBarMargin * 2),
              icon: Flag.getFlagIconByCountryID(_countries[index].id),
              verse: _countryName,
              bubble: false,
              color: Colorz.white20,
              verseMaxLines: 2,
              verseScaleFactor: 0.6,
              margins: const EdgeInsets.all(7.5),
              onTap: () => Nav.goToNewScreen(
                  context: context,
                  screen: CountryEditorScreen(country: _countries[index])
              ),
            );
            },
        ));
  }
}
