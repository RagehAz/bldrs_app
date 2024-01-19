import 'dart:async';

import 'package:basics/bldrs_theme/night_sky/night_sky.dart';
import 'package:basics/components/bubbles/bubble/bubble.dart';
import 'package:basics/helpers/checks/object_check.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/strings/text_check.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/sub/bz_typer.dart';
import 'package:bldrs/a_models/d_zoning/world_zoning.dart';
import 'package:bldrs/a_models/f_flyer/publication_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/flyer_typer.dart';
import 'package:bldrs/a_models/g_statistics/records/record_type.dart';
import 'package:bldrs/a_models/m_search/search_model.dart';
import 'package:bldrs/a_models/m_search/user_search_model.dart';
import 'package:bldrs/b_screens/x_keywords_picker_screen/keywords_picker_screen.dart';
import 'package:bldrs/b_screens/a_home_screen/x_home_screen_controllers.dart';
import 'package:bldrs/b_views/c_main_search/views/search_view_splitter.dart';
import 'package:bldrs/b_views/c_main_search/z_components/building_blocks/search_type_button.dart';
import 'package:bldrs/b_views/c_main_search/z_components/filters_tiles/bz_search_filters_list.dart';
import 'package:bldrs/b_views/c_main_search/z_components/filters_tiles/flyer_search_filters_list.dart';
import 'package:bldrs/b_views/c_main_search/z_components/filters_tiles/users_search_filters_list.dart';
import 'package:bldrs/b_screens/d_zoning/x_zone_selection_ops.dart';
import 'package:bldrs/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/z_components/layouts/pyramids/pyramids.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/fire/bz_search.dart';
import 'package:bldrs/c_protocols/flyer_protocols/fire/flyer_search.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/search_protocols/search_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/fire/user_fire_search.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/provider/zone_provider.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:fire/super_fire.dart';
import 'package:flutter/material.dart';

class SuperSearchScreen extends StatefulWidget {
  // --------------------------------------------------------------------------
  const SuperSearchScreen({
    super.key
  });
  // --------------------
  @override
  _SuperSearchScreenState createState() => _SuperSearchScreenState();
  // --------------------------------------------------------------------------
  static double getFilterTileWidth(BuildContext context){
    final double _appBarWidth = Bubble.bubbleWidth(context: context);
    return _appBarWidth - 20;
  }
  // --------------------
  static Verse getSearchHintVerse(){

    final ZoneModel? _zone = ZoneProvider.proGetCurrentZone(
      context: getMainContext(),
      listen: false,
    );

    final String _countryName = _zone?.countryName ?? '';
    final String _cityName = _zone?.cityName ?? '...';

    final String _hintText =  '${getWord('phid_search_flyers_in')} '
                              '$_cityName, $_countryName';

    return Verse(
      id: _hintText,
      translate: false,
    );

  }
  // --------------------
  static const Verse search = Verse(
        id: 'phid_search',
        translate: true,
        casing: Casing.capitalizeFirstChar,
      );
  // --------------------------------------------------------------------------
}

class _SuperSearchScreenState extends State<SuperSearchScreen> {
  // -----------------------------------------------------------------------------
  late PaginationController _flyersController;
  FireQueryModel? _flyersQuery;
  // --------------------
  late PaginationController _bzzController;
  FireQueryModel? _bzzQuery;
  // --------------------
  late PaginationController _usersController;
  FireQueryModel? _usersQuery;
  // --------------------
  final TextEditingController _searchController = TextEditingController();
  final ValueNotifier<bool?> _filtersAreOn = ValueNotifier(null);
  // --------------------
  ModelType? _searchType;
  SearchModel? _searchModel;
  UserSearchModel? _userSearchModel;
  List<SearchModel> _searchHistoryModels = [];
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void> _triggerLoading({required bool setTo}) async {
    setNotifier(
      notifier: _loading,
      mounted: mounted,
      value: setTo,
    );
  }
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    _searchModel = SearchModel.createInitialModel(
        searchType: ModelType.flyer,
      );

    _userSearchModel = UserSearchModel.initialModel;

    _flyersController = PaginationController.initialize(
      mounted: mounted,
      addExtraMapsAtEnd: true,
    );

    _bzzController = PaginationController.initialize(
      mounted: mounted,
      addExtraMapsAtEnd: true,
    );

    _usersController = PaginationController.initialize(
      mounted: mounted,
      addExtraMapsAtEnd: true,
    );

    _listenToPaginationLoading();

  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {

    if (_isInit && mounted) {
      _isInit = false; // good

      _triggerLoading(setTo: true).then((_) async {

        await _reloadSearchHistory();

        await _triggerLoading(setTo: false);
      });

    }
    super.didChangeDependencies();
  }
  // --------------------
  /*
  @override
  void didUpdateWidget(TheStatefulScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.thing != widget.thing) {
      unawaited(_doStuff());
    }
  }
   */
  // --------------------
  @override
  void dispose() {
    _loading.dispose();
    _searchController.dispose();
    _removeIsPaginatingListeners();
    _flyersController.dispose();
    _bzzController.dispose();
    _usersController.dispose();
    _filtersAreOn.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  void _listenToPaginationLoading(){
    /// REMOVED
    _flyersController.isPaginating.addListener(_flyerControllerListener);
    /// REMOVED
    _bzzController.isPaginating.addListener(_bzControllerListener);
    /// REMOVED
    _usersController.isPaginating.addListener(_usersControllerListener);
  }
  // --------------------
  void _removeIsPaginatingListeners(){
    _flyersController.isPaginating.removeListener(_flyerControllerListener);
    _bzzController.isPaginating.removeListener(_bzControllerListener);
    _usersController.isPaginating.removeListener(_usersControllerListener);
  }
  // --------------------
  void _flyerControllerListener() {
    _triggerLoading(setTo: _flyersController.isPaginating.value);
  }
  // --------------------
  void _bzControllerListener(){
    _triggerLoading(setTo: _bzzController.isPaginating.value);
  }
  // --------------------
  void _usersControllerListener(){
    _triggerLoading(setTo: _usersController.isPaginating.value);
  }
  // -----------------------------------------------------------------------------
  /// SEARCH TYPE
  // --------------------
  Future<void> selectSearchType(ModelType modelType) async {

    await _triggerLoading(setTo: true);

    /// SEARCH
    if (_searchType != modelType){
      setNotifier(notifier: _filtersAreOn, mounted: mounted, value: false);
      setState(() {
        _searchType = modelType;
        _searchModel = SearchModel.createInitialModel(searchType: modelType);
      });
      await _generateQuery();
    }

    /// SWITCH OFF SEARCHING
    else {
      setNotifier(notifier: _filtersAreOn, mounted: mounted, value: null);
      setState(() {
        _searchModel = null;
        _searchType = null;
      });
    }

    await _triggerLoading(setTo: false);

  }
  // -----------------------------------------------------------------------------
  /// QUERY GENERATION
  // --------------------
  Future<void> _generateQuery() async {

    await _triggerLoading(setTo: true);

    if (_searchModel != null){

      if (_searchType == ModelType.flyer) {
        _flyersQuery = FlyerSearch.createQuery(
          searchModel: _searchModel?.copyWith(
            text: _getSearchText(),
          ),
          gtaLink: _getSearchURL(),
          // orderBy: ,
          // descending:,
          limit: 6,
        );
      }

      else if (_searchType == ModelType.bz) {
        _bzzQuery = BzSearch.createQuery(
          searchModel: _searchModel,
          bzName: _getSearchText(),
          // orderBy: ,
          // descending:,
          // limit: 4,
        );

      }

      else if (_searchType == ModelType.user) {
        _usersQuery = UserFireSearchOps.createQuery(
          zoneModel: _searchModel?.zone,
          searchText: _getSearchText(),
          userSearchModel: _userSearchModel,
          // orderBy: ,
          // descending:,
          limit: 10,
        );
      }

      final SearchModel? _model = await _composeOrRenovateSearchHistoryModel();

        if (mounted == true){
          setState(() {
            _searchModel = _model;
          });
        }

    }

    await _triggerLoading(setTo: false);

  }
  // --------------------
  void _setSearchModel({
    required SearchModel? model,
  }){
    setState(() {
      _searchModel = model;
    });
  }
  // --------------------
  void _setUserSearchModel({
    required UserSearchModel? model,
  }){
    setState(() {
      _userSearchModel = model;
    });
  }
  // -----------------------------------------------------------------------------
  /// TEXT SEARCH
  // --------------------
  Future<void> _onSearch(String? text) async {
      await _generateQuery();
  }
  // --------------------
  Future<void> _onSearchCancelled() async {
      _searchController.clear();
      await _generateQuery();
  }
  // --------------------
  String? _getSearchText(){
    if (TextCheck.isEmpty(_searchController.text) == true){
      return null;
    }
    else if (ObjectCheck.isAbsoluteURL(_searchController.text) == true){
      return null;
    }
    else {
      return _searchController.text;
    }
  }
  // --------------------
  String? _getSearchURL(){
    if (TextCheck.isEmpty(_searchController.text) == true){
      return null;
    }
    else if (ObjectCheck.isAbsoluteURL(_searchController.text) == true){
      return _searchController.text;
    }
    else {
      return null;
    }
  }
  // -----------------------------------------------------------------------------
  /// FILTERS GENERATION
  // --------------------
  Widget _getFilters(){

    /*
         _setSearchModel(
             model: ,
          );

     */

    /// FLYERS
    if (_searchType == ModelType.flyer){
     return FlyersSearchFiltersList(
       searchModel: _searchModel,
       onZoneSwitchTap: _onZoneSwitchTap,
       onZoneTap: () async {

         final ZoneModel? _newZone = await ZoneSelection.goBringAZone(
           depth: ZoneDepth.city,
           settingCurrentZone: false,
           zoneViewingEvent: ViewingEvent.homeView,
           viewerZone: UsersProvider.proGetUserZone(context: context, listen: false),
           selectedZone: ZoneProvider.proGetCurrentZone(context: context, listen: false),
         );

         await ZoneProvider.proSetCurrentZone(
           zone: _newZone,
         );

         if (_newZone == null){
           _searchModel = _searchModel?.nullifyField(
             zone: true,
           );
         }

         else {
           _searchModel = _searchModel?.copyWith(
             zone: _newZone,
           );
         }

         _setSearchModel(model: _searchModel);
         await _generateQuery();

         },
       onFlyerTypeSwitchTap: (bool value) async {
         if (value == false){

           _searchModel = _searchModel?.copyWith(
             flyerSearchModel: _searchModel?.flyerSearchModel?.nullifyField(
               flyerType: true,
               phid: true,
             ),
           );
           _setSearchModel(model: _searchModel);
           await _generateQuery();

         }
         },
       onFlyerTypeTap: (FlyerType flyerType) async {

         _searchModel = _searchModel?.copyWith(
           flyerSearchModel: _searchModel?.flyerSearchModel?.copyWith(
             flyerType: flyerType,
           ),
         );

         if (
         _searchModel?.flyerSearchModel?.flyerType != FlyerType.product
             &&
             _searchModel?.flyerSearchModel?.flyerType != FlyerType.equipment
         ) {
           _searchModel = _searchModel?.copyWith(
             flyerSearchModel: _searchModel?.flyerSearchModel?.copyWith(
               onlyAmazonProducts: false,
             ),
           );
         }

         _setSearchModel(model: _searchModel);
         await _generateQuery();

         },
       onPickPhidTap: () async {

         /// KEYWORDS_PICKER_SCREEN
         final String? _phid = await KeywordsPickerScreen.goPickPhid(
           flyerType: _searchModel?.flyerSearchModel?.flyerType,
           event: ViewingEvent.homeView,
           onlyUseZoneChains: true,
           slideScreenFromEnLeftToRight: false,
         );

         if (_phid != null) {

           await setActivePhidK(
             phidK: _phid,
             flyerType: _searchModel?.flyerSearchModel?.flyerType,
           );

           _searchModel = _searchModel?.copyWith(
             flyerSearchModel: _searchModel?.flyerSearchModel?.copyWith(
               phid: _phid,
             ),
           );


           _setSearchModel(model: _searchModel);
           await _generateQuery();

         }

         },
       onOnlyShowAuthorSwitchTap: (bool value) async {

         _searchModel = _searchModel?.copyWith(
           flyerSearchModel: _searchModel?.flyerSearchModel?.copyWith(
             onlyShowingAuthors: value,
           ),
         );
         _setSearchModel(model: _searchModel);
         await _generateQuery();

         },
       onOnlyWithPriceSwitchTap: (bool value) async {
         _searchModel = _searchModel?.copyWith(
           flyerSearchModel: _searchModel?.flyerSearchModel?.copyWith(
             onlyWithPrices: value,
           ),
         );
         _setSearchModel(model: _searchModel);
         await _generateQuery();
         },
       onOnlyWithPDFSwitchTap: (bool value) async {

         _searchModel = _searchModel?.copyWith(
           flyerSearchModel: _searchModel?.flyerSearchModel?.copyWith(
             onlyWithPDF: value,
           ),
         );
         _setSearchModel(model: _searchModel);
         await _generateQuery();

         },
       onOnlyAmazonProductsSwitchTap: (bool value) async {

         _searchModel = _searchModel?.copyWith(
           flyerSearchModel: _searchModel?.flyerSearchModel?.copyWith(
             onlyAmazonProducts: value,
             flyerType: value == true ? FlyerType.product : null,
           ),
         );

         _setSearchModel(model: _searchModel);
         await _generateQuery();

         },
       onPublishStateSwitchTap: (bool value) async {
         if (value == false) {

           _searchModel = _searchModel?.copyWith(
             flyerSearchModel: _searchModel?.flyerSearchModel?.nullifyField(
               publishState: true,
             ),
           );
           _setSearchModel(model: _searchModel);
           await _generateQuery();

         }
         },
       onPublishStateTap: (PublishState state) async {

         _searchModel = _searchModel?.copyWith(
           flyerSearchModel: _searchModel?.flyerSearchModel?.copyWith(
             publishState: state,
           ),
         );
         _setSearchModel(model: _searchModel);
         await _generateQuery();
         },

     );
    }

    /// BZZ
    else if (_searchType == ModelType.bz){
      return BzSearchFiltersList(
        searchModel: _searchModel,
        onZoneSwitchTap: _onZoneSwitchTap,
        onZoneTap: _goBringBzZone,
        onBzIsVerifiedSwitchTap: (bool value) async {

          _setSearchModel(
            model: _searchModel?.copyWith(
              bzSearchModel: _searchModel?.bzSearchModel?.copyWith(
                onlyVerified: value,
              ),
            ),
          );

          await _generateQuery();

          },
        onBzFormSwitchTap: (bool value) async {
          if (value == false){

            _setSearchModel(
              model: _searchModel?.copyWith(
                bzSearchModel: _searchModel?.bzSearchModel?.nullifyField(
                  bzForm: true,
                ),
              ),
            );
            await _generateQuery();

          }
          },
        onBzFormTap: (BzForm form) async {

          _setSearchModel(
            model: _searchModel?.copyWith(
              bzSearchModel: _searchModel?.bzSearchModel?.copyWith(
                bzForm: form,
              ),
            ),
          );

          await _generateQuery();

          },
        onBzTypeSwitchTap: (bool value) async {
          if (value == false){
            _setSearchModel(
              model: _searchModel?.copyWith(
                bzSearchModel: _searchModel?.bzSearchModel?.nullifyField(
                  bzType: true,
                  scopePhid: true,
                ),
              ),
            );

            await _generateQuery();

          }
          },
        onBzTypeTap: (BzType type) async {

            _searchModel = _searchModel?.copyWith(
              bzSearchModel: _searchModel?.bzSearchModel?.copyWith(
                bzType: type,
              ),
            );

            _searchModel = _searchModel?.copyWith(
              bzSearchModel: _searchModel?.bzSearchModel?.nullifyField(
                scopePhid: true,
              ),
            );

            _setSearchModel(
              model: _searchModel,
            );

            await _generateQuery();

          },
        onScopeSwitchTap: (bool value) async {

            if (value == false){

              _searchModel = _searchModel?.copyWith(
                bzSearchModel: _searchModel?.bzSearchModel?.nullifyField(
                  scopePhid: true,
                ),
              );
              _setSearchModel(model: _searchModel);
              await _generateQuery();

            }

          },
        onScopeTap: (FlyerType flyerType) async {

          /// KEYWORDS_PICKER_SCREEN
            final String? _phid = await KeywordsPickerScreen.goPickPhid(
              flyerType: flyerType,
              event: ViewingEvent.homeView,
              onlyUseZoneChains: true,
              slideScreenFromEnLeftToRight: false,
            );

            if (_phid != null) {

                _searchModel = _searchModel?.copyWith(
                  bzSearchModel: _searchModel?.bzSearchModel?.copyWith(
                    scopePhid: _phid,
                  ),
                );
                _setSearchModel(model: _searchModel);
                await _generateQuery();

            }

          },
        onBzzShowingTeamOnlySwitchTap: (bool value) async {

            _searchModel = _searchModel?.copyWith(
              bzSearchModel: _searchModel?.bzSearchModel?.copyWith(
                onlyShowingTeams: value,
              ),
            );
            _setSearchModel(model: _searchModel);
            await _generateQuery();

          },
        onAccountTypeSwitchTap: (bool value) async {
            if (value == false) {

              _searchModel = _searchModel?.copyWith(
                bzSearchModel: _searchModel?.bzSearchModel?.nullifyField(
                  bzAccountType: true,
                ),
              );
              _setSearchModel(model: _searchModel);
              await _generateQuery();

            }
          },
        onAccountTypeTap: (BzAccountType type) async {

          _searchModel = _searchModel?.copyWith(
            bzSearchModel: _searchModel?.bzSearchModel?.copyWith(
              bzAccountType: type,
            ),
          );
          _setSearchModel(model: _searchModel);
          await _generateQuery();

          },
      );
    }

    /// USERS
    else if (_searchType == ModelType.user){
      return UserSearchFiltersList(
        userSearchModel: _userSearchModel,
        onZoneSwitchTap: _onZoneSwitchTap,
        onZoneTap: () async {

          final ZoneModel? _newZone = await ZoneSelection.goBringAZone(
            depth: ZoneDepth.city,
            settingCurrentZone: false,
            zoneViewingEvent: ViewingEvent.homeView,
            viewerZone: UsersProvider.proGetUserZone(context: context, listen: false),
            selectedZone: ZoneProvider.proGetCurrentZone(context: context, listen: false),
          );


          await ZoneProvider.proSetCurrentZone(
            zone: _newZone,
          );

          if (_newZone == null){
            _searchModel = _searchModel?.nullifyField(
              zone: true,
            );
          }

          else {
            _searchModel = _searchModel?.copyWith(
              zone: _newZone,
            );
          }

          _setSearchModel(model: _searchModel);
          await _generateQuery();

          },
        onUserSearchTypeSwitchTap: (bool value) async {
          if (value == false){
            _userSearchModel = _userSearchModel?.nullifyField(searchType: true);
            _setUserSearchModel(model: _userSearchModel);
            await _generateQuery();
          }
          },
        onUserSearchTypeTap: (UserSearchType type) async {

            _userSearchModel = _userSearchModel?.copyWith(searchType: type);
            _setUserSearchModel(model: _userSearchModel);
            await _generateQuery();

          },
        onSignInMethodSwitchTap: (bool value) async {
          if (value == false){

              _userSearchModel = _userSearchModel?.nullifyField(
                signInMethod: true,
              );
            _setUserSearchModel(model: _userSearchModel);
            await _generateQuery();

          }
          },
        onSignInMethodTap: (SignInMethod method) async {

            _userSearchModel = _userSearchModel?.copyWith(
              signInMethod: method,
            );
            _setUserSearchModel(model: _userSearchModel);
            await _generateQuery();

          },
        onGenderSwitchTap: (bool value) async {
          if (value == false){

            _userSearchModel = _userSearchModel?.nullifyField(gender: true);
            _setUserSearchModel(model: _userSearchModel);
            await _generateQuery();

          }
          },
        onGenderTap: (Gender gender) async {

          _userSearchModel = _userSearchModel?.copyWith(gender: gender);
          _setUserSearchModel(model: _userSearchModel);
          await _generateQuery();

          },
        onLangSwitchTap: (bool value) async {
          if (value == false){

            _userSearchModel = _userSearchModel?.nullifyField(language: true);
            _setUserSearchModel(model: _userSearchModel);
            await _generateQuery();

          }
          },
        onLangTap: (String lang) async {

          _userSearchModel = _userSearchModel?.copyWith(language: lang);
          _setUserSearchModel(model: _userSearchModel);
          await _generateQuery();

          },
        onOnlyPublicContactsSwitchTap: (bool value) async {
          _userSearchModel = _userSearchModel?.copyWith(onlyWithPublicContacts: value);
          _setUserSearchModel(model: _userSearchModel);
          await _generateQuery();
          },
        onOnlyAuthorsSwitchTap: (bool value) async {

          _userSearchModel = _userSearchModel?.copyWith(onlyBzAuthors: value);
          _setUserSearchModel(model: _userSearchModel);
          await _generateQuery();

        },
        onOnlyAdminsSwitchTap: (bool value) async {
          _userSearchModel = _userSearchModel?.copyWith(onlyBldrsAdmins: value);
          _setUserSearchModel(model: _userSearchModel);
          await _generateQuery();
          },
        onOnlyVerifiedEmailsSwitchTap: (bool value) async {

          _userSearchModel = _userSearchModel?.copyWith(onlyVerifiedEmails: value);
          _setUserSearchModel(model: _userSearchModel);
          await _generateQuery();

          },
        onOnlyCanReceiveNotification: (bool value) async {

          _userSearchModel = _userSearchModel?.copyWith(onlyCanReceiveNotification: value);
          _setUserSearchModel(model: _userSearchModel);
          await _generateQuery();

        },
      );
    }

    /// OTHERWISE
    else {
      return const SizedBox();
    }

  }
  // --------------------
  Future<void> _onZoneSwitchTap(bool value) async {

    if (value == true){

      final ZoneModel? _currentZone = ZoneProvider.proGetCurrentZone(
        context: context,
        listen: false,
      );

      if (_currentZone == null && _searchModel?.zone == null){
        await _goBringBzZone();
      }
      else {
        _searchModel = _searchModel?.copyWith(
          zone: _currentZone,
        );
        await _generateQuery();

      }

    }

    else {
      _searchModel = _searchModel?.nullifyField(
        zone: true,
      );

      _setSearchModel(model: _searchModel);
      await _generateQuery();
    }

  }
  // --------------------
  Future<void> _goBringBzZone() async {

    final ZoneModel? _newZone = await ZoneSelection.goBringAZone(
      depth: ZoneDepth.city,
      settingCurrentZone: false,
      zoneViewingEvent: ViewingEvent.homeView,
      viewerZone: UsersProvider.proGetUserZone(context: context, listen: false),
      selectedZone: ZoneProvider.proGetCurrentZone(context: context, listen: false),
    );

    await ZoneProvider.proSetCurrentZone(
      zone: _newZone,
    );

    if (_newZone == null){
      _searchModel = _searchModel?.nullifyField(
        zone: true,
      );
    }

    else {
      _searchModel = _searchModel?.copyWith(
        zone: _newZone,
      );
    }

    _setSearchModel(model: _searchModel);
    await _generateQuery();
  }
  // -----------------------------------------------------------------------------
  /// SEARCH HISTORY PROTOCOLS
  // --------------------
  Future<void> _reloadSearchHistory() async {

    final List<SearchModel> _searches = await SearchProtocols.fetchAll(
      userID: Authing.getUserID(),
    );

    if (mounted == true) {
      setState(() {
        _searchHistoryModels = _searches;
      });
    }
  }
  // --------------------
  Future<SearchModel?> _composeOrRenovateSearchHistoryModel() async {
    SearchModel? _output;

    // blog('SearchHistoryModels: ${_searchHistoryModels.length} models');
    // blog(_searchModel);

    if (_searchModel?.id == null){

      _output = await SearchProtocols.compose(
          searchModel: _searchModel,
          userID: Authing.getUserID(),
      );

    }

    else {

      await SearchProtocols.renovate(
        searchModel: _searchModel,
        userID: Authing.getUserID(),
      );

      _output = _searchModel;

    }

    _searchHistoryModels = await SearchProtocols.fetchAll(
      userID: Authing.getUserID(),
    );

    return _output;
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return MainLayout(
      canSwipeBack: true,
      loading: _loading,
      appBarType: AppBarType.search,
      skyType: SkyType.grey,
      pyramidsAreOn: true,
      pyramidType: PyramidType.crystalBlue,
      listenToHideLayout: true,

      /// SEARCH
      searchController: _searchController,
      onSearchSubmit: _onSearch,
      // onSearchChanged: _onSearch,
      onSearchCancelled: _onSearchCancelled,

      // searchButtonIsOn: true,

      filtersAreOn: _filtersAreOn,
      filters: _getFilters(),

      appBarRowWidgets: <Widget>[

        /// FLYERS
        SearchTypeButton(
          currentModel: _searchType,
          modelType: ModelType.flyer,
          onTap: () => selectSearchType(ModelType.flyer),
        ),

        /// BZZ
        SearchTypeButton(
          currentModel: _searchType,
          modelType: ModelType.bz,
          onTap: () => selectSearchType(ModelType.bz),
        ),

        /// USERS
        if (UsersProvider.userIsAdmin() == true)
        SearchTypeButton(
          currentModel: _searchType,
          modelType: ModelType.user,
          onTap: () => selectSearchType(ModelType.user),
        ),

      ],
      child: SearchViewSplitter(
        searchType: _searchType,
        flyersQuery: _flyersQuery,
        flyersController: _flyersController,
        bzzQuery: _bzzQuery,
        bzzController: _bzzController,
        usersQuery: _usersQuery,
        usersController: _usersController,
        searchHistoryModels: _searchHistoryModels,
        onHistoryModelTap: (SearchModel model) async {

          setNotifier(notifier: _filtersAreOn, mounted: mounted, value: true);
          _searchType = SearchModel.concludeSearchType(
            model: model,
          );
          _searchModel = model;
          await _generateQuery();

        },
        onDeleteHistoryModel: (SearchModel model) async {

          await SearchProtocols.wipe(
              modelID: model.id,
              userID: Authing.getUserID(),
          );

          await _reloadSearchHistory();

        },
      ),

    );

  }
  // -----------------------------------------------------------------------------
}
