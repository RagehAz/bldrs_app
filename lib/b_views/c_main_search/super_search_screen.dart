import 'package:bldrs/a_models/a_user/sub/need_model.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/sub/bz_typer.dart';
import 'package:bldrs/a_models/c_chain/d_spec_model.dart';
import 'package:bldrs/a_models/d_zone/a_zoning/zone_model.dart';
import 'package:bldrs/a_models/d_zone/a_zoning/zone_stages.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/flyer_typer.dart';
import 'package:bldrs/a_models/k_statistics/record_model.dart';
import 'package:bldrs/b_views/a_starters/b_home_screen/x_home_screen_controllers.dart';
import 'package:bldrs/b_views/c_main_search/z_components/filter_bool_tile.dart';
import 'package:bldrs/b_views/c_main_search/z_components/filter_multi_button_tile.dart';
import 'package:bldrs/b_views/c_main_search/z_components/search_type_button.dart';
import 'package:bldrs/b_views/f_bz/b_bz_editor_screen/z_components/scope_selector_bubble.dart';
import 'package:bldrs/b_views/g_zoning/x_zone_selection_ops.dart';
import 'package:bldrs/b_views/i_phid_picker/app_bar_pick_phid_button/sections_button.dart';
import 'package:bldrs/b_views/i_phid_picker/phids_picker_screen.dart';
import 'package:bldrs/b_views/z_components/app_bar/bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bldrs_bubble_header_vm.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/pyramids/pyramids.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/fire/bz_search.dart';
import 'package:bldrs/c_protocols/chain_protocols/provider/chains_provider.dart';
import 'package:bldrs/c_protocols/flyer_protocols/fire/flyer_search.dart';
import 'package:bldrs/c_protocols/user_protocols/fire/user_fire_search.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/provider/zone_provider.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:bldrs/super_fire/super_fire.dart';
import 'package:bldrs/b_views/c_main_search/views/bzz_paginator_view.dart';
import 'package:bldrs/b_views/c_main_search/views/flyers_paginator_view.dart';
import 'package:bldrs/b_views/c_main_search/views/users_paginator_view.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:bubbles/bubbles.dart';
import 'package:filers/filers.dart';
import 'package:flutter/material.dart';
import 'package:layouts/layouts.dart';
import 'package:night_sky/night_sky.dart';
import 'package:scale/scale.dart';
import 'package:stringer/stringer.dart';
import 'package:super_box/super_box.dart';

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
  ModelType _searchType = ModelType.flyer;
  ZoneModel _zone;
  String _currencyID;
  // --------------------
  FlyerType _flyerType;
  PublishState _publishState;
  AuditState _auditState;
  bool _onlyFlyersShowingAuthors = false;
  bool _onlyFlyersWithPrices = false;
  bool _onlyFlyersWithPDF = false;
  bool onlyAmazonFlyers = false;
  String _flyerKeywordID;
  // --------------------
  BzType _bzType;
  BzForm _bzForm;
  BzAccountType _bzAccountType;
  String _bzScopePhid;
  bool _onlyBzzShowingTeams = false;
  bool _onlyVerifiedBzz = false;
  // --------------------
  SignInMethod _userSignInMethod;
  NeedType _userNeedType;
  UserSearchType _userSearchType = UserSearchType.byName;
  Gender _userGender;
  String _userLanguage;
  bool _onlyUsersWithPublicContacts = false;
  bool _onlyBzAuthors = false;
  bool _onlyBldrsAdmins = false;
  String _userDevicePlatform;
  bool _onlyUsersWithVerifiedEmails = false;
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

    _zone = ZoneProvider.proGetCurrentZone(context: context, listen: false);

    _flyersController = PaginationController.initialize(
      addExtraMapsAtEnd: false,
    );

    _bzzController = PaginationController.initialize(
      addExtraMapsAtEnd: false,
    );

    _usersController = PaginationController.initialize(
      addExtraMapsAtEnd: false,
    );

    _generateQuery();

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
  /// SEARCH TYPE
  // --------------------
  void selectSearchType(ModelType modelType){
    setState(() {
      _searchType = modelType;
      _generateQuery();
    });
  }
  // -----------------------------------------------------------------------------
  /// QUERY GENERATION
  // --------------------
  void _generateQuery(){

    if (_searchType == ModelType.flyer){
     _generateFlyerQuery();
    }
    else if (_searchType == ModelType.bz){
      _generateBzQuery();
    }
    else if (_searchType == ModelType.user){
     _generateUserQuery();
    }

  }
  // --------------------
  void _generateFlyerQuery(){
    _flyersQuery = FlyerSearch.createQuery(
      countryID: _zone?.countryID,
      cityID: _zone?.cityID,
      flyerType: _flyerType,
      keywordID: _flyerKeywordID,
      title: _getSearchText(),
      // orderBy: ,
      // descending:,
      // limit: 4,
      publishState: _publishState,
      auditState: _auditState,
      showsAuthor: _onlyFlyersShowingAuthors,
      hasPrice: _onlyFlyersWithPrices,
      currencyID: _currencyID,
      hasAffiliateLink: onlyAmazonFlyers,
      gtaLink: _getSearchURL(),
      hasPDF: _onlyFlyersWithPDF,
    );
  }
  // --------------------
  void _generateBzQuery(){
    _bzzQuery = BzSearch.createQuery(
      countryID: _zone?.countryID,
      cityID: _zone?.cityID,
      bzType: _bzType,
      bzScopePhid: _bzScopePhid,
      bzName: _getSearchText(),
      // orderBy: ,
      // descending:,
      // limit: 4,
      bzForm: _bzForm,
      bzAccountType: _bzAccountType,
      onlyBzzShowingTeams: _onlyBzzShowingTeams,
      onlyVerifiedBzz: _onlyVerifiedBzz,
    );
  }
  // --------------------
  void _generateUserQuery(){

    _usersQuery = UserSearch.createQuery(
      countryID: _zone?.countryID,
      cityID: _zone?.cityID,
      searchText: _getSearchText(),
      searchType: _userSearchType,
      // orderBy: ,
      // descending:,
      // limit: 4,
      signInMethod: _userSignInMethod,
      devicePlatform: _userDevicePlatform,
      gender: _userGender,
      userLanguage: _userLanguage,
      onlyBzAuthors: _onlyBzAuthors,
      onlyBldrsAdmins: _onlyBldrsAdmins,
      onlyUsersWithPublicContacts: _onlyUsersWithPublicContacts,
      onlyUsersWithVerifiedEmails: _onlyUsersWithVerifiedEmails,
      needType: _userNeedType,
    );

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
  List<Widget> _getFilters(){

    if (_searchType == ModelType.flyer){
     return _flyerFilters();
    }
    else if (_searchType == ModelType.bz){
      return _bzFilters();
    }
    else if (_searchType == ModelType.user){
      return _userFilters();
    }
    else {
      return [];
    }

  }
  // --------------------
  List<Widget> _flyerFilters(){

    final double _tileWidth = SuperSearchScreen.getFilterTileWidth(context);

    final String _keywordIcon = ChainsProvider.proGetPhidIcon(
        context: context,
        son: _flyerKeywordID,
    );

    // List<SpecModel> specs;

    return <Widget>[

      /// ZONE
      TileBubble(
          bubbleWidth: _tileWidth,
          bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
            context: context,
            leadingIcon: _zone?.icon ?? Iconz.contAfrica,
            headerWidth: _tileWidth,
            headlineVerse: ZoneModel.generateInZoneVerse(
                  context: context,
                  zoneModel: _zone,
                ),
          ),
        onTileTap: () async {

            final ZoneModel _newZone = await ZoneSelection.goBringAZone(
                context: context,
                depth: ZoneDepth.city,
                settingCurrentZone: false,
                zoneViewingEvent: ViewingEvent.homeView,
            );

            if (_newZone != null){

              await ZoneSelection.setCurrentZone(
                  context: context,
                  zone: _newZone,
              );

              setState(() {
                _zone = _newZone;
                _generateQuery();
              });
            }

        },
        ),

      /// FLYER TYPE
      FilterMultiButtonTile (
        icon: Iconz.flyer,
        verse: Verse.plain('Flyer type'),
        switchValue: _flyerType != null,
        onSwitchTap: (bool value){
          if (value == false){
            setState(() {
              _flyerType = null;
              _flyerKeywordID = null;
              _generateQuery();
            });
          }
          },
        items: FlyerTyper.flyerTypesList,
        selectedItem: _flyerType,
        itemVerse: (dynamic flyerType) => Verse(
          id: FlyerTyper.getFlyerTypePhid(flyerType: flyerType,),
          translate: true,
        ),
        itemIcon: (dynamic flyerType) => FlyerTyper.flyerTypeIcon(flyerType: flyerType, isOn: false),
        onItemTap: (dynamic item) {
          setState(() {
            _flyerType = item;
            if (_flyerType != FlyerType.product && _flyerType != FlyerType.equipment) {
              onlyAmazonFlyers = null;
            }
            _generateQuery();
          });
          },
      ),

      /// KEYWORD
      Disabler(
        isDisabled: _flyerType == null,
        child: TileBubble(
          bubbleWidth: _tileWidth,
          bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
            context: context,
            leadingIcon: _flyerKeywordID == null ? Iconz.keyword
                :
            _keywordIcon == '' ||  _keywordIcon == null ? Iconz.dvBlankSVG
                 :
            _keywordIcon,
            headerWidth: _tileWidth,
            headlineVerse: _flyerKeywordID == null ?
            Verse.plain('Select keyword')
                :
            SectionsButton.getBody(
              context: context,
              currentKeywordID: _flyerKeywordID,
              currentSection: _flyerType,
            ),
          ),
          onTileTap: () async {
            final String _phid = await PhidsPickerScreen.goPickPhid(
              context: context,
              flyerType: _flyerType,
              event: ViewingEvent.homeView,
              onlyUseCityChains: true,
            );

            if (_phid != null) {
              await setActivePhidK(
                context: context,
                phidK: _phid,
                flyerType: _flyerType,
              );

              setState(() {
                _flyerKeywordID = _phid;
              });
            }
          },
        ),
      ),

      /// SHOWS AUTHOR
      FilterBoolTile(
        icon: Iconz.bz,
        switchValue: _onlyFlyersShowingAuthors,
        verse: Verse.plain('Flyers showing authors only'),
        onSwitchTap: (bool value){
          setState(() {
            _onlyFlyersShowingAuthors = value;
            _generateQuery();
          });
          },
      ),

      /// HAS PRICE
      FilterBoolTile(
        icon: Iconz.dollar,
        verse: Verse.plain('Flyers with prices only'),
        switchValue: _onlyFlyersWithPrices,
        onSwitchTap: (bool value){
          setState(() {
            _onlyFlyersWithPrices = value;
            _generateQuery();
          });
          },
      ),

      /// HAS PDF
      FilterBoolTile(
        icon: Iconz.pfd,
        verse: Verse.plain('Flyers with PDF attachments only'),
        switchValue: _onlyFlyersWithPDF,
        onSwitchTap: (bool value){
              setState(() {
                _onlyFlyersWithPDF = value;
                _generateQuery();
              });
            },
      ),

      /// IS AMAZON PRODUCT
      FilterBoolTile(
        icon: Iconz.amazon,
        verse: Verse.plain('Amazon Products only'),
        switchValue: onlyAmazonFlyers != null,
        onSwitchTap: (bool value){
              setState(() {
                onlyAmazonFlyers = value == true ? true : null;

                if (value == true){
                  _flyerType = FlyerType.product;
                }

                _generateQuery();
              });
            },
      ),

      /// SEPARATOR
      if (UsersProvider.userIsAdmin(context) == true)
      const DotSeparator(),

      /// AUDIT STATE
      if (UsersProvider.userIsAdmin(context) == true)
        FilterMultiButtonTile(
          bubbleColor: Colorz.yellow50,
          icon: Iconz.verifyFlyer,
          verse: Verse.plain('Audit State'),
          switchValue: _auditState != null,
          onSwitchTap: (bool value) {
            if (value == false) {
              setState(() {
                _auditState = null;
                _generateQuery();
              });
            }
          },
          items: FlyerModel.auditStates,
          selectedItem: _auditState,
          itemVerse: (dynamic state) => Verse(id: FlyerModel.getAuditStatePhid(state), translate: true,),
          onItemTap: (dynamic item){
            setState(() {
              _auditState = item;
              _generateQuery();
            });
            },
        ),

      /// PUBLISH STATE
      if (UsersProvider.userIsAdmin(context) == true)
        FilterMultiButtonTile(
          bubbleColor: Colorz.yellow50,
          icon: Iconz.verifyFlyer,
          verse: Verse.plain('Publish State'),
          switchValue: _publishState != null,
          onSwitchTap: (bool value) {
              if (value == false) {
                setState(() {
                  _publishState = null;
                  _generateQuery();
                });
              }
            },
          items: FlyerModel.publishStates,
          selectedItem: _publishState,
          itemVerse: (dynamic state) => Verse(id: FlyerModel.getPublishStatePhid(state), translate: true,),
          onItemTap: (dynamic item){
            setState(() {
              _publishState = item;
              _generateQuery();
            });
            },
        ),

    ];
  }
  // --------------------
  List<Widget> _bzFilters(){

    final double _tileWidth = SuperSearchScreen.getFilterTileWidth(context);

    // final List<ContactModel> contacts;
    // final BzState bzState;

    return <Widget>[

      /// ZONE
      TileBubble(
          bubbleWidth: _tileWidth,
          bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
            context: context,
            leadingIcon: _zone?.icon ?? Iconz.contAfrica,
            headerWidth: _tileWidth,
            headlineVerse: ZoneModel.generateInZoneVerse(
                  context: context,
                  zoneModel: _zone,
                ),
          ),
        onTileTap: () async {

            final ZoneModel _newZone = await ZoneSelection.goBringAZone(
                context: context,
                depth: ZoneDepth.city,
                settingCurrentZone: false,
                zoneViewingEvent: ViewingEvent.homeView,
            );

            if (_newZone != null){

              await ZoneSelection.setCurrentZone(
                  context: context,
                  zone: _newZone,
              );

              setState(() {
                _zone = _newZone;
                _generateQuery();
              });
            }

        },
        ),

      /// BZ IS VERIFIED
      FilterBoolTile(
        icon: Iconz.bzBadgeWhite,
        verse: Verse.plain('Verified Businesses only'),
        switchValue: _onlyVerifiedBzz,
        iconIsBig: false,
        onSwitchTap: (bool value){
          setState(() {
            _onlyVerifiedBzz = value;
            _generateQuery();
          });
          },
      ),

      /// BZ FORM
      FilterMultiButtonTile (
        icon: Iconz.bz,
        verse: Verse.plain('Business Account form'),
        switchValue: _bzForm != null,
        onSwitchTap: (bool value){

              if (value == false){
                setState(() {
                  _bzForm = null;
                  _generateQuery();
                });
              }
            },
        items: BzTyper.bzFormsList,
        selectedItem: _bzForm,
        itemVerse: (dynamic form) => Verse(id: BzTyper.getBzFormPhid(form), translate: true),
        onItemTap: (dynamic form) {
          setState(() {
            _bzForm = form;
            _generateQuery();
          });
          },
      ),

      /// BZ TYPE
      FilterMultiButtonTile (
        icon: Iconz.bz,
        verse: Verse.plain('Business Account type'),
        switchValue: _bzType != null,
        onSwitchTap: (bool value){

              if (value == false){
                setState(() {
                  _bzType = null;
                  _bzScopePhid = null;
                  _generateQuery();
                });
              }
            },
        items: BzTyper.bzTypesList,
        selectedItem: _bzType,
        itemVerse: (dynamic type) => Verse(
          id: BzTyper.getBzTypePhid(bzType: type, pluralTranslation: false,),
          translate: true,
        ),
        itemIcon: (dynamic type) => BzTyper.getBzTypeIconOff(type),
        onItemTap: (dynamic type) {
          setState(() {
            _bzType = type;
            _bzScopePhid = null;
            _generateQuery();
          });
          },
      ),

      /// SCOPE
      Disabler(
        isDisabled: _bzType == null,
        child: ScopeSelectorBubble(
          bubbleWidth: _tileWidth,
          headlineVerse: const Verse(
            id: 'phid_scopeOfServices',
            translate: true,
          ),
          flyerTypes: FlyerTyper.concludePossibleFlyerTypesByBzType(bzType: _bzType),
          selectedSpecs: SpecModel.generateSpecsByPhids(
            context: context,
            phids: _bzScopePhid == null ? [] : [_bzScopePhid],
          ),
          onFlyerTypeBubbleTap: (FlyerType flyerType) async {

            final String _phid = await PhidsPickerScreen.goPickPhid(
              context: context,
              flyerType: flyerType,
              event: ViewingEvent.homeView,
              onlyUseCityChains: true,
            );

            if (_phid != null) {
              setState(() {
                _bzScopePhid = _phid;
              });
            }

          },
          onPhidTap: (FlyerType flyerType, String phid) async {

            final String _phid = await PhidsPickerScreen.goPickPhid(
              context: context,
              flyerType: flyerType,
              event: ViewingEvent.homeView,
              onlyUseCityChains: true,
            );

            if (_phid != null) {
              setState(() {
                _bzScopePhid = _phid;
              });
            }


          },
          switchValue: _bzScopePhid != null && _bzType != null,
          onSwitchTap: (bool value){

            if (value == false){
              setState(() {
                _bzScopePhid = null;
                _generateQuery();
              });
            }
          },
        ),
      ),

      /// BZZ SHOWING TEAMS
      FilterBoolTile(
        icon: Iconz.users,
        verse: Verse.plain('Businesses showing their team members only'),
        iconIsBig: false,
        switchValue: _onlyBzzShowingTeams,
        onSwitchTap: (bool value){
              setState(() {
                _onlyBzzShowingTeams = value;
                _generateQuery();
              });
            },
      ),

      /// SEPARATOR
      if (UsersProvider.userIsAdmin(context) == true)
      const DotSeparator(),

      /// ACCOUNT TYPE
      if (UsersProvider.userIsAdmin(context) == true)
        FilterMultiButtonTile(
          bubbleColor: Colorz.yellow50,
          icon: Iconz.star,
          verse: Verse.plain('Subscription type'),
          switchValue: _bzAccountType != null,
          onSwitchTap: (bool value) {
            if (value == false) {
              setState(() {
                _bzAccountType = null;
                _generateQuery();
              });
            }
          },
          items: BzTyper.bzAccountTypesList,
          selectedItem: _bzAccountType,
          itemVerse: (dynamic type) => Verse(
            id: type.toString(),
            translate: false,
          ),
          onItemTap: (dynamic type) {
            setState(() {
              _bzAccountType = type;
              _generateQuery();
            });
          },
        ),

    ];

  }
  // --------------------
  List<Widget> _userFilters(){

    final double _tileWidth = SuperSearchScreen.getFilterTileWidth(context);

    // NeedType _userNeedType;
    // String _userDevicePlatform;

    return <Widget>[

      /// ZONE
      TileBubble(
          bubbleWidth: _tileWidth,
          bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
            context: context,
            leadingIcon: _zone?.icon ?? Iconz.contAfrica,
            headerWidth: _tileWidth,
            headlineVerse: ZoneModel.generateInZoneVerse(
                  context: context,
                  zoneModel: _zone,
                ),
          ),
        onTileTap: () async {

            final ZoneModel _newZone = await ZoneSelection.goBringAZone(
                context: context,
                depth: ZoneDepth.city,
                settingCurrentZone: false,
                zoneViewingEvent: ViewingEvent.homeView,
            );

            if (_newZone != null){

              await ZoneSelection.setCurrentZone(
                  context: context,
                  zone: _newZone,
              );

              setState(() {
                _zone = _newZone;
                _generateQuery();
              });
            }

        },
        ),

      /// USER SEARCH TYPE
      FilterMultiButtonTile(
        icon: Iconz.search,
        verse: Verse.plain('User Search type'),
        switchValue: _userSearchType != null,
        onSwitchTap: (bool value){

              if (value == false){
                setState(() {
                  _userSearchType = null;
                  _generateQuery();
                });
              }
            },
        items: UserSearch.userSearchTypes,
        selectedItem: _userSearchType,
        itemVerse: (dynamic type) => Verse.plain(TextMod.removeTextBeforeFirstSpecialCharacter(type.toString(), '.')),
        onItemTap: (dynamic type) {
          setState(() {
            _userSearchType = type;
            _generateQuery();
          });
          },
      ),

      /// SIGN IN METHOD
      FilterMultiButtonTile(
        icon: Iconz.comGooglePlay,
        verse: Verse.plain('Sign in method'),
        switchValue: _userSignInMethod != null,
        onSwitchTap: (bool value){

              if (value == false){
                setState(() {
                  _userSignInMethod = null;
                  _generateQuery();
                });
              }
            },
        items: AuthModel.signInMethodsList,
        selectedItem: _userSignInMethod,
        itemVerse: (dynamic method) => Verse.plain(AuthModel.cipherSignInMethod(method)),
        onItemTap: (dynamic method) {
          setState(() {
            _userSignInMethod = method;
            _generateQuery();
          });
          },
      ),

      /// GENDER
      FilterMultiButtonTile(
        icon: Iconz.female,
        verse: const Verse(id: 'phid_gender', translate: true,),
        switchValue: _userGender != null,
        onSwitchTap: (bool value){

              if (value == false){
                setState(() {
                  _userGender = null;
                  _generateQuery();
                });
              }
            },
        items: UserModel.gendersList,
        selectedItem: _userGender,
        itemVerse: (dynamic gender) => Verse(id: UserModel.getGenderPhid(gender), translate: true),
        onItemTap: (dynamic gender) {
          setState(() {
            _userGender = gender;
            _generateQuery();
          });
          },
      ),

      /// LANGUAGE
      FilterMultiButtonTile(
        icon: Iconz.language,
        verse: const Verse(id: 'phid_language', translate: true,),
        switchValue: _userLanguage != null,
        onSwitchTap: (bool value){
          if (value == false){
            setState(() {
              _userLanguage = null;
              _generateQuery();
            });
          }
          },
        items: Localizer.supportedLangCodes,
        selectedItem: _userLanguage,
        itemVerse: (dynamic lang) => Verse(id: lang, translate: false),
        onItemTap: (dynamic lang) {
          setState(() {
            _userLanguage = lang;
            _generateQuery();
          });
          },
      ),

      /// ONLY USERS WITH PUBLIC CONTACTS
      FilterBoolTile(
        icon: Iconz.comWebsite,
        verse: Verse.plain('Only users with public contacts'),
        iconIsBig: false,
        switchValue: _onlyUsersWithPublicContacts,
        onSwitchTap: (bool value){
              setState(() {
                _onlyUsersWithPublicContacts = value;
                _generateQuery();
              });
            },
      ),

      /// ONLY BZ AUTHORS
      FilterBoolTile(
        icon: Iconz.bz,
        verse: Verse.plain('Only Business Authors'),
        iconIsBig: false,
        switchValue: _onlyBzAuthors,
        onSwitchTap: (bool value){
              setState(() {
                _onlyBzAuthors = value;
                _generateQuery();
              });
            },
      ),

      /// ONLY BLDRS ADMIN
      FilterBoolTile(
        icon: Iconz.viewsIcon,
        verse: Verse.plain('Only Bldrs Admins'),
        iconIsBig: false,
        switchValue: _onlyBldrsAdmins,
        onSwitchTap: (bool value){
              setState(() {
                _onlyBldrsAdmins = value;
                _generateQuery();
              });
            },
      ),

      /// ONLY USERS WITH VERIFIED EMAILS
      FilterBoolTile(
        icon: Iconz.check,
        verse: Verse.plain('Only Users with verified emails'),
        iconIsBig: false,
        switchValue: _onlyUsersWithVerifiedEmails,
        onSwitchTap: (bool value){
          setState(() {
            _onlyUsersWithVerifiedEmails = value;
            _generateQuery();
          });
          },
      ),

    ];

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    const AppBarType _appBarType = AppBarType.search;
    // --------------------
    return MainLayout(
      loading: _loading,
      appBarType: _appBarType,
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
      filtersChildren: _getFilters(),

      appBarRowWidgets: <Widget>[

        const Expander(),

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
        if (UsersProvider.userIsAdmin(context) == true)
        SearchTypeButton(
          currentModel: _searchType,
          modelType: ModelType.user,
          onTap: () => selectSearchType(ModelType.user),
        ),

      ],
      child:

      /// FLYERS PAGINATION
      _searchType == ModelType.flyer ?
      FlyersPaginatorView(
        fireQueryModel: _flyersQuery,
        paginationController: _flyersController,
      )
          :
      /// BZZ PAGINATION
      _searchType == ModelType.bz ?
      BzzPaginatorView(
        fireQueryModel: _bzzQuery,
        paginationController: _bzzController,
      )
          :
      /// USERS PAGINATION
      _searchType == ModelType.user ?
      UsersPaginatorView(
        fireQueryModel: _usersQuery,
        paginationController: _bzzController,
      )
          :

      const SizedBox.shrink(),

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

    final String _hintText =  '${Verse.transBake(context, 'phid_search_flyers_in')} '
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
