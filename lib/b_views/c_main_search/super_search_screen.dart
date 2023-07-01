import 'package:basics/bubbles/bubble/bubble.dart';
import 'package:basics/helpers/classes/checks/object_check.dart';
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/strings/text_check.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/sub/bz_typer.dart';
import 'package:bldrs/a_models/d_zone/a_zoning/staging_model.dart';
import 'package:bldrs/a_models/d_zone/a_zoning/zone_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/flyer_typer.dart';
import 'package:bldrs/a_models/m_search/search_model.dart';
import 'package:bldrs/a_models/m_search/user_search_model.dart';
import 'package:bldrs/a_models/x_secondary/bldrs_model_type.dart';
import 'package:bldrs/b_views/a_starters/b_home_screen/x_home_screen_controllers.dart';
import 'package:bldrs/b_views/c_main_search/views/search_view_splitter.dart';
import 'package:bldrs/b_views/c_main_search/z_components/building_blocks/search_type_button.dart';
import 'package:bldrs/b_views/c_main_search/z_components/filters_tiles/bz_search_filters_list.dart';
import 'package:bldrs/b_views/c_main_search/z_components/filters_tiles/flyer_search_filters_list.dart';
import 'package:bldrs/b_views/c_main_search/z_components/filters_tiles/users_search_filters_list.dart';
import 'package:bldrs/b_views/g_zoning/x_zone_selection_ops.dart';
import 'package:bldrs/b_views/i_phid_picker/phids_picker_screen.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/pyramids/pyramids.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/fire/bz_search.dart';
import 'package:bldrs/c_protocols/flyer_protocols/fire/flyer_search.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/search_protocols/search_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/fire/user_fire_search.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/provider/zone_provider.dart';
import 'package:fire/super_fire.dart';
import 'package:flutter/material.dart';
import 'package:basics/bldrs_theme/night_sky/night_sky.dart';

class SuperSearchScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const SuperSearchScreen({
    super.key
  });
  /// --------------------------------------------------------------------------
  @override
  _SuperSearchScreenState createState() => _SuperSearchScreenState();
  // --------------------------------------------------------------------------
    static double getFilterTileWidth(BuildContext context){
    final double _appBarWidth = Bubble.bubbleWidth(context: context);
    return _appBarWidth - 20;
  }
  // --------------------------------------------------------------------------
}

class _SuperSearchScreenState extends State<SuperSearchScreen> {
  // -----------------------------------------------------------------------------
  late PaginationController _flyersController;
  late FireQueryModel _flyersQuery;
  // --------------------
  late PaginationController _bzzController;
  late FireQueryModel _bzzQuery;
  // --------------------
  late PaginationController _usersController;
  late FireQueryModel _usersQuery;
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
      addExtraMapsAtEnd: true,
    );

    _bzzController = PaginationController.initialize(
      addExtraMapsAtEnd: true,
    );

    _usersController = PaginationController.initialize(
      addExtraMapsAtEnd: true,
    );

    _listenToPaginationLoading();

  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      _triggerLoading(setTo: true).then((_) async {

        await _reloadSearchHistory();

        await _triggerLoading(setTo: false);
      });

      _isInit = false;
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
    _flyersController.dispose();
    _bzzController.dispose();
    _usersController.dispose();
    _filtersAreOn.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  void _listenToPaginationLoading(){
    _flyersController.isPaginating.addListener(() {
        _triggerLoading(setTo: _flyersController.isPaginating.value);
    });

    _bzzController.isPaginating.addListener(() {
        _triggerLoading(setTo: _bzzController.isPaginating.value);
    });

    _usersController.isPaginating.addListener(() {
        _triggerLoading(setTo: _usersController.isPaginating.value);
    });
  }
  // -----------------------------------------------------------------------------
  /// SEARCH TYPE
  // --------------------
  void selectSearchType(ModelType modelType){
    if (_searchType != modelType){
      setNotifier(notifier: _filtersAreOn, mounted: mounted, value: false);
      _searchType = modelType;
      _searchModel = SearchModel.createInitialModel(
        searchType: _searchType,
      );
      _generateQuery();
    }
    else {
      setNotifier(notifier: _filtersAreOn, mounted: mounted, value: null);
      setState(() {
        _searchModel = null;
        _searchType = null;
      });
    }
  }
  // -----------------------------------------------------------------------------
  /// QUERY GENERATION
  // --------------------
  Future<void> _generateQuery() async {

    if (_searchModel != null){

      if (_searchType == ModelType.flyer) {
        _flyersQuery = FlyerSearch.createQuery(
          searchModel: _searchModel,
          title: _getSearchText(),
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

      _searchModel = await _composeOrRenovateSearchHistoryModel();

      if (mounted == true){
        setState(() {});
      }

    }

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

    /// FLYERS
    if (_searchType == ModelType.flyer){
     return FlyersSearchFiltersList(
       searchModel: _searchModel,
       onZoneSwitchTap: (bool value) async {
          if (value == true){

              _searchModel = _searchModel?.copyWith(
                zone:  ZoneProvider.proGetCurrentZone(
                  context: context,
                  listen: false,
                ),
              );
              await _generateQuery();

          }
          else {

              _searchModel = _searchModel?.nullifyField(
                zone: true,
              );
              await _generateQuery();

          }
          },
       onZoneTap: () async {

          final ZoneModel? _newZone = await ZoneSelection.goBringAZone(
            context: context,
            depth: ZoneDepth.city,
            settingCurrentZone: false,
            zoneViewingEvent: ViewingEvent.homeView,
            viewerCountryID: UsersProvider.proGetUserZone()?.countryID,
          );

          if (_newZone != null){
            await ZoneSelection.setCurrentZone(
              zone: _newZone,
            );

              _searchModel = _searchModel?.copyWith(
                zone: _newZone,
              );
              await _generateQuery();

          }

          },
       onFlyerTypeSwitchTap: (bool value) async {
          if (value == false){

              _searchModel = _searchModel?.copyWith(
                flyerSearchModel: _searchModel?.flyerSearchModel?.nullifyField(
                  flyerType: true,
                  phid: true,
                ),
              );
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

              await _generateQuery();

          },
       onPickPhidTap: () async {
            final String? _phid = await PhidsPickerScreen.goPickPhid(
              context: context,
              flyerType: _searchModel?.flyerSearchModel?.flyerType,
              event: ViewingEvent.homeView,
              onlyUseZoneChains: true,
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
              await _generateQuery();

            }
          },
       onOnlyShowAuthorSwitchTap: (bool value) async {

            _searchModel = _searchModel?.copyWith(
              flyerSearchModel: _searchModel?.flyerSearchModel?.copyWith(
                onlyShowingAuthors: value,
              ),
            );
            await _generateQuery();

          },
       onOnlyWithPriceSwitchTap: (bool value) async {

            _searchModel = _searchModel?.copyWith(
              flyerSearchModel: _searchModel?.flyerSearchModel?.copyWith(
                onlyWithPrices: value,
              ),
            );
            await _generateQuery();

          },
       onOnlyWithPDFSwitchTap: (bool value) async {

         _searchModel = _searchModel?.copyWith(
           flyerSearchModel: _searchModel?.flyerSearchModel?.copyWith(
             onlyWithPDF: value,
           ),
         );
         await _generateQuery();

         },
       onOnlyAmazonProductsSwitchTap: (bool value) async {

         _searchModel = _searchModel?.copyWith(
           flyerSearchModel: _searchModel?.flyerSearchModel?.copyWith(
             onlyAmazonProducts: value,
             flyerType: value == true ? FlyerType.product : null,
           ),
         );

         await _generateQuery();

         },
       onAuditStateSwitchTap: (bool value) async {
            if (value == false) {

                _searchModel = _searchModel?.copyWith(
                  flyerSearchModel: _searchModel?.flyerSearchModel?.nullifyField(
                    auditState: true,
                  ),
                );

                await _generateQuery();

            }
          },
       onAuditStateTap: (AuditState state) async {

              _searchModel = _searchModel?.copyWith(
                flyerSearchModel: _searchModel?.flyerSearchModel?.copyWith(
                  auditState: state,
                ),
              );
              await _generateQuery();

            },
       onPublishStateSwitchTap: (bool value) async {
         if (value == false) {

           _searchModel = _searchModel?.copyWith(
             flyerSearchModel: _searchModel?.flyerSearchModel?.nullifyField(
               publishState: true,
             ),
           );
           await _generateQuery();

         }
         },
       onPublishStateTap: (PublishState state) async {

         _searchModel = _searchModel?.copyWith(
           flyerSearchModel: _searchModel?.flyerSearchModel?.copyWith(
             publishState: state,
           ),
         );
         await _generateQuery();
         },

     );
    }

    /// BZZ
    else if (_searchType == ModelType.bz){
      return BzSearchFiltersList(
        searchModel: _searchModel,
        onZoneSwitchTap: (bool value) async {
          if (value == true){

              _searchModel = _searchModel?.copyWith(
                zone:  ZoneProvider.proGetCurrentZone(
                  context: context,
                  listen: false,
                ),
              );
              await _generateQuery();

          }
          else {

              _searchModel = _searchModel?.nullifyField(
                zone: true,
              );

              await _generateQuery();

          }
          },
        onZoneTap: () async {

          final ZoneModel? _newZone = await ZoneSelection.goBringAZone(
            context: context,
            depth: ZoneDepth.city,
            settingCurrentZone: false,
            zoneViewingEvent: ViewingEvent.homeView,
            viewerCountryID: UsersProvider.proGetUserZone()?.countryID,
          );

          if (_newZone != null){
            await ZoneSelection.setCurrentZone(
              zone: _newZone,
            );

              _searchModel = _searchModel?.copyWith(
                zone: _newZone,
              );
              await _generateQuery();

          }

          },
        onBzIsVerifiedSwitchTap: (bool value) async {

            _searchModel = _searchModel?.copyWith(
              bzSearchModel: _searchModel?.bzSearchModel?.copyWith(
                onlyVerified: value,
              ),
            );
            await _generateQuery();

          },
        onBzFormSwitchTap: (bool value) async {
          if (value == false){

              _searchModel = _searchModel?.copyWith(
                bzSearchModel: _searchModel?.bzSearchModel?.nullifyField(
                  bzForm: true,
                ),
              );
              await _generateQuery();

          }
          },
        onBzFormTap: (BzForm form) async {

            _searchModel = _searchModel?.copyWith(
              bzSearchModel: _searchModel?.bzSearchModel?.copyWith(
                bzForm: form,
              ),
            );
            await _generateQuery();

          },
        onBzTypeSwitchTap: (bool value) async {
          if (value == false){

              _searchModel = _searchModel?.copyWith(
                bzSearchModel: _searchModel?.bzSearchModel?.nullifyField(
                  bzType: true,
                  scopePhid: true,
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

            await _generateQuery();

          },
        onScopeSwitchTap: (bool value) async {

            if (value == false){

                _searchModel = _searchModel?.copyWith(
                  bzSearchModel: _searchModel?.bzSearchModel?.nullifyField(
                    scopePhid: true,
                  ),
                );
                await _generateQuery();

            }

          },
        onScopeTap: (FlyerType flyerType) async {

            final String? _phid = await PhidsPickerScreen.goPickPhid(
              context: context,
              flyerType: flyerType,
              event: ViewingEvent.homeView,
              onlyUseZoneChains: true,
            );

            if (_phid != null) {

                _searchModel = _searchModel?.copyWith(
                  bzSearchModel: _searchModel?.bzSearchModel?.copyWith(
                    scopePhid: _phid,
                  ),
                );
                await _generateQuery();

            }

          },
        onBzzShowingTeamOnlySwitchTap: (bool value) async {

            _searchModel = _searchModel?.copyWith(
              bzSearchModel: _searchModel?.bzSearchModel?.copyWith(
                onlyShowingTeams: value,
              ),
            );

            await _generateQuery();

          },
        onAccountTypeSwitchTap: (bool value) async {
            if (value == false) {

                _searchModel = _searchModel?.copyWith(
                  bzSearchModel: _searchModel?.bzSearchModel?.nullifyField(
                    bzAccountType: true,
                  ),
                );

                await _generateQuery();

            }
          },
        onAccountTypeTap: (BzAccountType type) async {

              _searchModel = _searchModel?.copyWith(
                bzSearchModel: _searchModel?.bzSearchModel?.copyWith(
                  bzAccountType: type,
                ),
              );

              await _generateQuery();

          },
      );
    }

    /// USERS
    else if (_searchType == ModelType.user){
      return UserSearchFiltersList(
        searchModel: _searchModel,
        userSearchModel: _userSearchModel,
        onZoneSwitchTap: (bool value) async {
          if (value == true){

              _searchModel = _searchModel?.copyWith(
                zone:  ZoneProvider.proGetCurrentZone(
                  context: context,
                  listen: false,
                ),
              );
              await _generateQuery();

          }
          else {

              _searchModel = _searchModel?.nullifyField(
                zone: true,
              );
              await _generateQuery();

          }
          },
        onZoneTap: () async {

          final ZoneModel? _newZone = await ZoneSelection.goBringAZone(
            context: context,
            depth: ZoneDepth.city,
            settingCurrentZone: false,
            zoneViewingEvent: ViewingEvent.homeView,
            viewerCountryID: UsersProvider.proGetUserZone()?.countryID,
          );

          if (_newZone != null){
            await ZoneSelection.setCurrentZone(
              zone: _newZone,
            );

              _searchModel = _searchModel?.copyWith(
                zone: _newZone,
              );
              await _generateQuery();

          }

          },
        onUserSearchTypeSwitchTap: (bool value) async {
          if (value == false){
            _userSearchModel = _userSearchModel?.nullifyField(searchType: true);
            await _generateQuery();
          }
          },
        onUserSearchTypeTap: (UserSearchType type) async {

            _userSearchModel = _userSearchModel?.copyWith(searchType: type);
            await _generateQuery();

          },
        onSignInMethodSwitchTap: (bool value) async {
          if (value == false){

              _userSearchModel = _userSearchModel?.nullifyField(
                signInMethod: true,
              );
              await _generateQuery();

          }
          },
        onSignInMethodTap: (SignInMethod method) async {

            _userSearchModel = _userSearchModel?.copyWith(
              signInMethod: method,
            );
            await _generateQuery();

          },
        onGenderSwitchTap: (bool value) async {
          if (value == false){

              _userSearchModel = _userSearchModel?.nullifyField(gender: true);
              await _generateQuery();

          }
          },
        onGenderTap: (Gender gender) async {

            _userSearchModel = _userSearchModel?.copyWith(gender: gender);
            await _generateQuery();

          },
        onLangSwitchTap: (bool value) async {
          if (value == false){

              _userSearchModel = _userSearchModel?.nullifyField(language: true);
              await _generateQuery();

          }
          },
        onLangTap: (String lang) async {

            _userSearchModel = _userSearchModel?.copyWith(language: lang);
            await _generateQuery();

          },
        onOnlyPublicContactsSwitchTap: (bool value) async {
          _userSearchModel = _userSearchModel?.copyWith(onlyWithPublicContacts: value);
          await _generateQuery();
          },
        onOnlyAuthorsSwitchTap: (bool value) async {

            _userSearchModel = _userSearchModel?.copyWith(onlyBzAuthors: value);
            await _generateQuery();

        },
        onOnlyAdminsSwitchTap: (bool value) async {

            _userSearchModel = _userSearchModel?.copyWith(onlyBldrsAdmins: value);
            await _generateQuery();

          },
        onOnlyVerifiedEmailsSwitchTap: (bool value) async {

            _userSearchModel = _userSearchModel?.copyWith(onlyVerifiedEmails: value);
            await _generateQuery();

          },
      );
    }

    /// OTHERWISE
    else {
      return const SizedBox();
    }

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

    blog('SearchHistoryModels: ${_searchHistoryModels.length} models');
    blog(_searchModel);

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
      loading: _loading,
      appBarType: AppBarType.search,
      skyType: SkyType.black,
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

  Verse getSearchHintVerse(){

    final ZoneModel? _zone = ZoneProvider.proGetCurrentZone(
      context: getMainContext(),
      listen: false,
    );

    final String _countryName = _zone?.countryName ?? '';
    final String _cityName = _zone?.cityName ?? '...';

    final String _hintText =  '${Verse.transBake('phid_search_flyers_in')} '
                              '$_cityName, $_countryName';

    return Verse(
      id: _hintText,
      translate: false,
    );

  }

  const Verse search = Verse(
        id: 'phid_search',
        translate: true,
        casing: Casing.capitalizeFirstChar,
      );
