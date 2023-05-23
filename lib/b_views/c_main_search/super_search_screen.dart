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
import 'package:bldrs/b_views/z_components/layouts/main_layout/app_bar/bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/pyramids/pyramids.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/fire/bz_search.dart';
import 'package:bldrs/c_protocols/flyer_protocols/fire/flyer_search.dart';
import 'package:bldrs/c_protocols/user_protocols/fire/user_fire_search.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/provider/zone_provider.dart';
import 'package:bldrs/super_fire/super_fire.dart';
import 'package:filers/filers.dart';
import 'package:flutter/material.dart';
import 'package:night_sky/night_sky.dart';
import 'package:stringer/stringer.dart';

class SuperSearchScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const SuperSearchScreen({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  _SuperSearchScreenState createState() => _SuperSearchScreenState();
  // --------------------------------------------------------------------------
    static double getFilterTileWidth(BuildContext context){
    final double _appBarWidth = BldrsAppBar.width(context);
    return _appBarWidth - 20;
  }
  // --------------------------------------------------------------------------
}

class _SuperSearchScreenState extends State<SuperSearchScreen> {
  // -----------------------------------------------------------------------------
  PaginationController _flyersController;
  FireQueryModel _flyersQuery;
  // --------------------
  PaginationController _bzzController;
  FireQueryModel _bzzQuery;
  // --------------------
  PaginationController _usersController;
  FireQueryModel _usersQuery;
  // --------------------
  final TextEditingController _searchController = TextEditingController();
  final ValueNotifier<bool> _filtersAreOn = ValueNotifier(false);
  // --------------------
  ModelType _searchType = ModelType.flyer;
  SearchModel _searchModel;
  UserSearchModel _userSearchModel;
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void> _triggerLoading({@required bool setTo}) async {
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

    _userSearchModel = UserSearchModel.initialModel;
    _searchModel = SearchModel.createInitialModel(
      context: context,
    );

    _flyersController = PaginationController.initialize(
      addExtraMapsAtEnd: true,
    );

    _bzzController = PaginationController.initialize(
      addExtraMapsAtEnd: true,
    );

    _usersController = PaginationController.initialize(
      addExtraMapsAtEnd: true,
    );

    _generateQuery();

    _listenToPaginationLoading();

  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      _triggerLoading(setTo: true).then((_) async {

        /// FUCK

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
    setState(() {
      _searchType = modelType;
      _searchModel = SearchModel.createInitialModel(context: context);
      _generateQuery();
    });
    }
  }
  // -----------------------------------------------------------------------------
  /// QUERY GENERATION
  // --------------------
  void _generateQuery(){

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

  }
  // -----------------------------------------------------------------------------
  /// TEXT SEARCH
  // --------------------
  Future<void> _onSearch(String text) async {
    setState(() {
      _generateQuery();
    });
  }
  // --------------------
  Future<void> _onSearchCancelled() async {
    setState(() {
      _searchController.clear();
      _generateQuery();
    });
  }
  // --------------------
  String _getSearchText(){
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
  String _getSearchURL(){
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
       onZoneSwitchTap: (bool value){
          if (value == true){
            setState(() {
              _searchModel = _searchModel.copyWith(
                zone:  ZoneProvider.proGetCurrentZone(context: context, listen: false),
              );
              _generateQuery();
            });
          }
          else {
            setState(() {
              _searchModel = _searchModel.nullifyField(
                zone: true,
              );
              _generateQuery();
            });
          }
          },
       onZoneTap: () async {

          final ZoneModel _newZone = await ZoneSelection.goBringAZone(
            context: context,
            depth: ZoneDepth.city,
            settingCurrentZone: false,
            zoneViewingEvent: ViewingEvent.homeView,
            viewerCountryID: UsersProvider.proGetUserZone()?.countryID,
          );

          if (_newZone != null){
            await ZoneSelection.setCurrentZone(
              context: context,
              zone: _newZone,
            );
            setState(() {
              _searchModel = _searchModel.copyWith(
                zone: _newZone,
              );
              _generateQuery();
            });
          }

          },
       onFlyerTypeSwitchTap: (bool value){
          if (value == false){
            setState(() {
              _searchModel = _searchModel.copyWith(
                flyerSearchModel: _searchModel.flyerSearchModel.nullifyField(
                  flyerType: true,
                  phid: true,
                ),
              );
              _generateQuery();
            });
          }
          },
       onFlyerTypeTap: (FlyerType flyerType) {
          setState(() {

            _searchModel = _searchModel.copyWith(
              flyerSearchModel: _searchModel.flyerSearchModel?.copyWith(
                flyerType: flyerType,
              ),
            );

            if (
                _searchModel.flyerSearchModel?.flyerType != FlyerType.product
                &&
                _searchModel.flyerSearchModel?.flyerType != FlyerType.equipment
            ) {
              _searchModel = _searchModel.copyWith(
                flyerSearchModel: _searchModel.flyerSearchModel.copyWith(
                  onlyAmazonProducts: false,
                ),
              );
            }

            _generateQuery();
          });
          },
       onPickPhidTap: () async {
            final String _phid = await PhidsPickerScreen.goPickPhid(
              context: context,
              flyerType: _searchModel.flyerSearchModel?.flyerType,
              event: ViewingEvent.homeView,
              onlyUseZoneChains: true,
            );

            if (_phid != null) {
              await setActivePhidK(
                context: context,
                phidK: _phid,
                flyerType: _searchModel.flyerSearchModel?.flyerType,
              );

              setState(() {
                _searchModel = _searchModel.copyWith(
                  flyerSearchModel: _searchModel.flyerSearchModel.copyWith(
                    phid: _phid,
                  ),
                );
                _generateQuery();
              });
            }
          },
       onOnlyShowAuthorSwitchTap: (bool value){
          setState(() {
            _searchModel = _searchModel.copyWith(
              flyerSearchModel: _searchModel.flyerSearchModel?.copyWith(
                onlyShowingAuthors: value,
              ),
            );
            _generateQuery();
          });
          },
       onOnlyWithPriceSwitchTap: (bool value){
          setState(() {
            _searchModel = _searchModel.copyWith(
              flyerSearchModel: _searchModel.flyerSearchModel?.copyWith(
                onlyWithPrices: value,
              ),
            );
            _generateQuery();
          });
          },
       onOnlyWithPDFSwitchTap: (bool value){
              setState(() {
                _searchModel = _searchModel.copyWith(
                  flyerSearchModel: _searchModel?.flyerSearchModel?.copyWith(
                    onlyWithPDF: value,
                  ),
                );
                _generateQuery();
              });
            },
       onOnlyAmazonProductsSwitchTap: (bool value){
          setState(() {

            _searchModel = _searchModel.copyWith(
              flyerSearchModel: _searchModel.flyerSearchModel?.copyWith(
                onlyAmazonProducts: value,
                flyerType: value == true ? FlyerType.product : null,
              ),
            );
            _generateQuery();
          });
          },
       onAuditStateSwitchTap: (bool value) {
            if (value == false) {
              setState(() {
                _searchModel = _searchModel.copyWith(
                  flyerSearchModel: _searchModel.flyerSearchModel.nullifyField(
                    auditState: true,
                  ),
                );

                _generateQuery();
              });
            }
          },
       onAuditStateTap: (AuditState state){
            setState(() {
              _searchModel = _searchModel.copyWith(
                flyerSearchModel: _searchModel.flyerSearchModel?.copyWith(
                  auditState: state,
                ),
              );
              _generateQuery();
            });
            },
       onPublishStateSwitchTap: (bool value) {
              if (value == false) {
                setState(() {
                  _searchModel = _searchModel.copyWith(
                    flyerSearchModel: _searchModel?.flyerSearchModel?.nullifyField(
                      publishState: true,
                    ),
                  );
                  _generateQuery();
                });
              }
            },
       onPublishStateTap: (PublishState state){
            setState(() {
              _searchModel = _searchModel.copyWith(
                flyerSearchModel: _searchModel?.flyerSearchModel?.copyWith(
                  publishState: state,
                ),
              );
              _generateQuery();
            });
            },
     );
    }

    /// BZZ
    else if (_searchType == ModelType.bz){
      return BzSearchFiltersList(
        searchModel: _searchModel,
        onZoneSwitchTap: (bool value){
          if (value == true){
            setState(() {
              _searchModel = _searchModel.copyWith(
                zone:  ZoneProvider.proGetCurrentZone(context: context, listen: false),
              );
              _generateQuery();
            });
          }
          else {
            setState(() {
              _searchModel = _searchModel.nullifyField(
                zone: true,
              );
              _generateQuery();
            });
          }
          },
        onZoneTap: () async {

          final ZoneModel _newZone = await ZoneSelection.goBringAZone(
            context: context,
            depth: ZoneDepth.city,
            settingCurrentZone: false,
            zoneViewingEvent: ViewingEvent.homeView,
            viewerCountryID: UsersProvider.proGetUserZone()?.countryID,
          );

          if (_newZone != null){
            await ZoneSelection.setCurrentZone(
              context: context,
              zone: _newZone,
            );
            setState(() {
              _searchModel = _searchModel.copyWith(
                zone: _newZone,
              );
              _generateQuery();
            });
          }

          },
        onBzIsVerifiedSwitchTap: (bool value){
          setState(() {
            _searchModel = _searchModel?.copyWith(
              bzSearchModel: _searchModel?.bzSearchModel?.copyWith(
                onlyVerified: value,
              ),
            );
            _generateQuery();
          });
          },
        onBzFormSwitchTap: (bool value){
          if (value == false){
            setState(() {
              _searchModel = _searchModel.copyWith(
                bzSearchModel: _searchModel.bzSearchModel?.nullifyField(
                  bzForm: true,
                ),
              );
              _generateQuery();
            });
          }
          },
        onBzFormTap: (BzForm form) {
          setState(() {
            _searchModel = _searchModel.copyWith(
              bzSearchModel: _searchModel.bzSearchModel.copyWith(
                bzForm: form,
              ),
            );
            _generateQuery();
          });
          },
        onBzTypeSwitchTap: (bool value){
          if (value == false){
            setState(() {

              _searchModel = _searchModel.copyWith(
                bzSearchModel: _searchModel.bzSearchModel.nullifyField(
                  bzType: true,
                  scopePhid: true,
                ),
              );

              _generateQuery();
            });
          }
          },
        onBzTypeTap: (BzType type) {
          setState(() {

            _searchModel = _searchModel.copyWith(
              bzSearchModel: _searchModel.bzSearchModel.copyWith(
                bzType: type,
              ),
            );

            _searchModel = _searchModel.copyWith(
              bzSearchModel: _searchModel.bzSearchModel.nullifyField(
                scopePhid: true,
              ),
            );

            _generateQuery();
          });
          },
        onScopeSwitchTap: (bool value){

            if (value == false){
              setState(() {
                _searchModel = _searchModel.copyWith(
                  bzSearchModel: _searchModel.bzSearchModel?.nullifyField(
                    scopePhid: true,
                  ),
                );
                _generateQuery();
              });
            }

          },
        onScopeTap: (FlyerType flyerType) async {

            final String _phid = await PhidsPickerScreen.goPickPhid(
              context: context,
              flyerType: flyerType,
              event: ViewingEvent.homeView,
              onlyUseZoneChains: true,
            );

            if (_phid != null) {
              setState(() {
                _searchModel = _searchModel.copyWith(
                  bzSearchModel: _searchModel.bzSearchModel?.copyWith(
                    scopePhid: _phid,
                  ),
                );
                _generateQuery();
              });
            }

          },
        onBzzShowingTeamOnlySwitchTap: (bool value){
          setState(() {

            _searchModel = _searchModel.copyWith(
              bzSearchModel: _searchModel.bzSearchModel.copyWith(
                onlyShowingTeams: value,
              ),
            );

            _generateQuery();
          });
          },
        onAccountTypeSwitchTap: (bool value) {
            if (value == false) {
              setState(() {

                _searchModel = _searchModel.copyWith(
                  bzSearchModel: _searchModel.bzSearchModel.nullifyField(
                    bzAccountType: true,
                  ),
                );

                _generateQuery();
              });
            }
          },
        onAccountTypeTap: (BzAccountType type) {
            setState(() {

              _searchModel = _searchModel.copyWith(
                bzSearchModel: _searchModel.bzSearchModel.copyWith(
                  bzAccountType: type,
                ),
              );

              _generateQuery();
            });
          },
      );
    }

    /// USERS
    else if (_searchType == ModelType.user){
      return UserSearchFiltersList(
        searchModel: _searchModel,
        userSearchModel: _userSearchModel,
        onZoneSwitchTap: (bool value){
          if (value == true){
            setState(() {
              _searchModel = _searchModel.copyWith(
                zone:  ZoneProvider.proGetCurrentZone(context: context, listen: false),
              );
              _generateQuery();
            });
          }
          else {
            setState(() {
              _searchModel = _searchModel.nullifyField(
                zone: true,
              );
              _generateQuery();
            });
          }
          },
        onZoneTap: () async {

          final ZoneModel _newZone = await ZoneSelection.goBringAZone(
            context: context,
            depth: ZoneDepth.city,
            settingCurrentZone: false,
            zoneViewingEvent: ViewingEvent.homeView,
            viewerCountryID: UsersProvider.proGetUserZone()?.countryID,
          );

          if (_newZone != null){
            await ZoneSelection.setCurrentZone(
              context: context,
              zone: _newZone,
            );
            setState(() {
              _searchModel = _searchModel.copyWith(
                zone: _newZone,
              );
              _generateQuery();
            });
          }

          },
        onUserSearchTypeSwitchTap: (bool value){
              if (value == false){
                setState(() {
                  _userSearchModel = _userSearchModel?.nullifyField(searchType: true);
                  _generateQuery();
                });
              }
            },
        onUserSearchTypeTap: (UserSearchType type) {
          setState(() {
            _userSearchModel = _userSearchModel?.copyWith(searchType: type);
            _generateQuery();
          });
          },
        onSignInMethodSwitchTap: (bool value){
          if (value == false){
            setState(() {
              _userSearchModel = _userSearchModel?.nullifyField(
                signInMethod: true,
              );
              _generateQuery();
            });
          }
          },
        onSignInMethodTap: (SignInMethod method) {
          setState(() {
            _userSearchModel = _userSearchModel?.copyWith(
              signInMethod: method,
            );
            _generateQuery();
          });
          },
        onGenderSwitchTap: (bool value){
          if (value == false){
            setState(() {
              _userSearchModel = _userSearchModel?.nullifyField(gender: true);
              _generateQuery();
            });
          }
          },
        onGenderTap: (Gender gender) {
          setState(() {
            _userSearchModel = _userSearchModel?.copyWith(gender: gender);
            _generateQuery();
          });
          },
        onLangSwitchTap: (bool value){
          if (value == false){
            setState(() {
              _userSearchModel = _userSearchModel?.nullifyField(language: true);
              _generateQuery();
            });
          }
          },
        onLangTap: (String lang) {
          setState(() {
            _userSearchModel = _userSearchModel?.copyWith(language: lang);
            _generateQuery();
          });
          },
        onOnlyPublicContactsSwitchTap: (bool value){
              setState(() {
                _userSearchModel = _userSearchModel?.copyWith(onlyWithPublicContacts: value);
                _generateQuery();
              });
            },
        onOnlyAuthorsSwitchTap: (bool value) {
          setState(() {
            _userSearchModel = _userSearchModel?.copyWith(onlyBzAuthors: value);
            _generateQuery();
          });
        },
        onOnlyAdminsSwitchTap: (bool value){
          setState(() {
            _userSearchModel = _userSearchModel?.copyWith(onlyBldrsAdmins: value);
            _generateQuery();
          });
          },
        onOnlyVerifiedEmailsSwitchTap: (bool value){
          setState(() {
            _userSearchModel = _userSearchModel?.copyWith(onlyVerifiedEmails: value);
            _generateQuery();
          });
          },
      );
    }

    /// OTHERWISE
    else {
      return const SizedBox();
    }

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
      onSearchChanged: _onSearch,
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
      ),

    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}

  Verse getSearchHintVerse(BuildContext context){

    final ZoneModel _zone = ZoneProvider.proGetCurrentZone(
        context: context,
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
