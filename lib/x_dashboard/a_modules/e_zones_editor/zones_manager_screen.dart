import 'dart:async';

import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/b_views/y_views/d_zoning/d_1a_all_countries_buttons.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/page_bubble.dart';
import 'package:bldrs/b_views/z_components/layouts/unfinished_night_sky.dart';
import 'package:bldrs/e_db/fire/methods/firestore.dart' as Fire;
import 'package:bldrs/e_db/fire/methods/paths.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
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
  /// --- LOCAL LOADING BLOCK
  final ValueNotifier<bool> _loading = ValueNotifier(false); /// tamam disposed
// -----------------------------------
  Future<void> _triggerLoading() async {
    _loading.value = !_loading.value;
    blogLoading(
      loading: _loading.value,
      callerName: 'ZonesEditorScreen',
    );
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
    super.dispose();
    _loading.dispose();
    _countries.dispose();
    _pageController.dispose();
    _scrollController.dispose();
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
      orderBy: 'id',
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

                    if (Mapper.canLoopList(_countries) == false){
                      return const SizedBox();
                    }

                    else {

                      return AllCountriesButtons(
                        padding: const EdgeInsets.only(
                            top: Ratioz.appBarMargin,
                            bottom: Ratioz.horizon
                        ),
                        onCountryTap: (String countryID) => onCountryEditorTap(
                          context: context,
                          countryID: countryID,
                        ),
                      );

                      // return ListView.builder(
                      //   physics: const BouncingScrollPhysics(),
                      //   controller: _scrollController,
                      //   padding: const EdgeInsets.only(top: Ratioz.stratosphere),
                      //   itemCount: _countries?.length,
                      //   itemBuilder: (BuildContext context, int index) {
                      //
                      //     final CountryModel _countryModel = _countries[index];
                      //     final String _countryName = CountryModel.getTranslatedCountryName(
                      //         context: context,
                      //         countryID: _countryModel.id,
                      //     );
                      //
                      //     return DreamBox(
                      //       height: 50,
                      //       width: PageBubble.clearWidth(context),
                      //       icon: Flag.getFlagIconByCountryID(_countryModel.id),
                      //       verse: _countryName,
                      //       bubble: false,
                      //       color: Colorz.white20,
                      //       verseMaxLines: 2,
                      //       verseScaleFactor: 0.8,
                      //       verseCentered: false,
                      //       margins: const EdgeInsets.only(bottom: 10),
                      //       onTap: () => onCountryEditorTap(
                      //         context: context,
                      //         countryModel: _countryModel,
                      //       ),
                      //     );
                      //
                      //   },
                      // );

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
