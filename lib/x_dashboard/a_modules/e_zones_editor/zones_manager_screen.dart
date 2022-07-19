import 'dart:async';
import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/b_views/x_screens/h_zoning/aaa_select_country_screen_all_countries_view.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/custom_layouts/page_bubble.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/e_db/fire/foundation/firestore.dart';
import 'package:bldrs/e_db/fire/foundation/paths.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/x_dashboard/a_modules/e_zones_editor/zones_manager_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ZonesEditorScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const ZonesEditorScreen({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  _ZonesEditorScreenState createState() => _ZonesEditorScreenState();
/// --------------------------------------------------------------------------
}

class _ZonesEditorScreenState extends State<ZonesEditorScreen> {
// -----------------------------------------------------------------------------
  ValueNotifier<List<CountryModel>> _countries;
  ScrollController _scrollController; /// tamam disposed
  PageController _pageController; /// tamam disposed
  QueryDocumentSnapshot<Object> _lastSnap;
// -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false); /// tamam disposed
// -----------
  Future<void> _triggerLoading({bool setTo}) async {
    if (mounted == true){
      if (setTo == null){
        _loading.value = !_loading.value;
      }
      else {
        _loading.value = setTo;
      }
      blogLoading(loading: _loading.value, callerName: 'ZonesEditorScreen',);
    }
  }
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _pageController = PageController();
    _countries = ValueNotifier<List<CountryModel>>(<CountryModel>[]);
  }
// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {

      _triggerLoading().then((_) async {
        // -------------------------------
        await _readMoreCountries();
        // -------------------------------
        await _triggerLoading();

      });

    }
    _isInit = false;
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    _loading.dispose();
    _countries.dispose();
    _pageController.dispose();
    _scrollController.dispose();
    super.dispose(); /// tamam
  }
// -----------------------------------------------------------------------------
  Future<void> _readMoreCountries() async {

    if (_loading.value == false) {
      _loading.value = true;
    }

    final List<Map<String, dynamic>> _maps = await Fire.readSubCollectionDocs(
      context: context,
      collName: FireColl.zones,
      docName: 'countries',
      subCollName: 'countries',
      limit: 5,
      orderBy: const QueryOrderBy(fieldName: 'id', descending: true),
      startAfter: _lastSnap,
      addDocSnapshotToEachMap: true,
    );

    final List<CountryModel> _countriesModels = CountryModel.decipherCountriesMaps(
        maps: _maps,
        fromJSON: false,
    );

    final QueryDocumentSnapshot<Object> _snap = _maps[_maps.length - 1]['docSnapshot'];

      _countries.value = _countriesModels;
      _lastSnap = _snap;
      _loading.value = false;

  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _screenHeight = Scale.superScreenHeightWithoutSafeArea(context);

    return MainLayout(
        pyramidsAreOn: true,
        sectionButtonIsOn: false,
        zoneButtonIsOn: false,
        appBarType: AppBarType.search,
        pageTitle: 'Zones Manager',
        skyType: SkyType.black,
        layoutWidget: PageView(
          physics: const BouncingScrollPhysics(),
          controller: _pageController,
          children: <Widget>[

            /// COUNTRIES PAGE
            PageBubble(
                screenHeightWithoutSafeArea: _screenHeight,
                appBarType: AppBarType.search,
                color: Colorz.white10,
                child: ValueListenableBuilder(
                  valueListenable: _countries,
                  builder: (_, List<CountryModel> _countries, Widget child){

                    if (Mapper.checkCanLoopList(_countries) == false){
                      return const SizedBox();
                    }

                    else {

                      return SelectCountryScreenAllCountriesView(
                        padding: const EdgeInsets.only(
                            top: Ratioz.appBarMargin,
                            bottom: Ratioz.horizon
                        ),
                        onCountryTap: (String countryID) => onCountryEditorTap(
                          context: context,
                          countryID: countryID,
                        ),
                      );

                    }
                  },
                ),
            ),

            /// CITIES PAGE
            PageBubble(
              screenHeightWithoutSafeArea: _screenHeight,
              appBarType: AppBarType.search,
              color: Colorz.bloodTest,
              child: Container(),
            ),

          ],
        ),
    );
  }
}
