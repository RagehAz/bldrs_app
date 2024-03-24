part of fish_tank;
// ignore_for_file: always_put_control_body_on_new_line

class BzzFishTankManager extends StatefulWidget {
  // --------------------------------------------------------------------------
  const BzzFishTankManager({
    this.selectedEmails = const [],
    this.multipleSelection = true,
    this.facebookAccessToken,
    super.key
  });
  // --------------------
  final List<String> selectedEmails;
  final bool multipleSelection;
  final String? facebookAccessToken;
  // --------------------
  @override
  _BzzFishTankManagerState createState() => _BzzFishTankManagerState();
  // --------------------------------------------------------------------------
  static Future<List<String>> pickEmails({
    required List<String> selectedEmails,
  }) async {

    final List<FishModel>? _fishes = await BldrsNav.goToNewScreen(
        screen: BzzFishTankManager(
          selectedEmails: selectedEmails,
        ),
    );

    return FishModel.getEmails(
      fishes: _fishes ?? [],
    );
  }
  // --------------------------------------------------------------------------
  static Future<String?> pickInstagramLink({
    String? facebookAccessToken,
  }) async {
    final FishModel? _fish = await BldrsNav.goToNewScreen(
      screen: BzzFishTankManager(
        multipleSelection: false,
        facebookAccessToken: facebookAccessToken,
      ),
    );
    return ContactModel.getValueFromContacts(
        contacts: _fish?.contacts,
        contactType: ContactType.instagram,
    );
  }
  // --------------------------------------------------------------------------
}

class _BzzFishTankManagerState extends State<BzzFishTankManager> {
  // -----------------------------------------------------------------------------
  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<bool> _filtersAreOn = ValueNotifier<bool>(false);
  // -----------------------------------------------------------------------------
  List<FishModel> _selectedFishes = [];
  List<FishModel> _fishes = [];
  List<FishModel> _originalFishes = [];
  final TextEditingController _searchController = TextEditingController();
  final ValueNotifier<bool> _isSearching = ValueNotifier(false);
  List<FishModel> _foundFishes = [];
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
  /*
  @override
  void initState() {
    super.initState();
  }
   */
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {

    if (_isInit && mounted) {
      _isInit = false; // good

      asyncInSync(() async {

        await _triggerLoading(setTo: true);

        final List<FishModel> _all = await FishProtocols.fetchAll();

        if (mounted == true){
          setState(() {
            _fishes = _all;
            _originalFishes = _all;
          });
        }

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
    _isSearching.dispose();
    _scrollController.dispose();
    _filtersAreOn.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------

  /// EDITING FISHES

  // --------------------
  Future<void> onAddNewFishTap({
    FishModel? newFish,
  }) async {

    final FishModel? _fish = newFish ?? await FishMakerScreen.makeFish(
      allFishes: _fishes,
      countryID: _fishes.last.countryID,
    );

    if (_fish != null){

      blog('composing Fish :-');
      blog(_fish);

      WaitDialog.showUnawaitedWaitDialog();
      final FishModel? _uploaded = await FishProtocols.compose(fish: _fish);
      await WaitDialog.closeWaitDialog();

      if (_uploaded == null){
        await Dialogs.topNotice(verse: Verse.plain('Fish was not composed'), color: Colorz.red255);
      }
      else {

        setState(() {
          _fishes = FishModel.insertFishToFishes(fishes: _fishes, fish: _uploaded);
          _foundFishes = [];
        });

        setNotifier(notifier: _isSearching, mounted: mounted, value: false);
        _searchController.text = '';

        // await Future.delayed(const Duration(milliseconds: 500));
        // await Sliders.scrollToEnd(controller: _scrollController, duration: const Duration(milliseconds: 800));

      }

    }

  }
  // --------------------
  Future<void> onEditFish(FishModel fish) async {

    await BottomDialog.showButtonsBottomDialog(
        context: context,
        draggable: true,
        numberOfWidgets: 3,
        builder: (_, __){

          return [

            /// EDIT
            BottomDialog.wideButton(
              context: context,
              text: 'Edit',
              onTap: () async {

                await Nav.goBack(context: context);
                await _editFish(fish);

              },
            ),

            /// DELETE
            BottomDialog.wideButton(
              context: context,
              text: 'Delete',
              onTap: () async {

                await Nav.goBack(context: context);
                await _deleteFish(fish);

              },
            ),

          ];

        }
    );

  }
  // --------------------
  Future<void> _editFish(FishModel fish) async {

    final FishModel? _updated = await FishMakerScreen.editFish(
      fishModel: fish,
      allFishes: _fishes,
      facebookAccessToken: widget.facebookAccessToken,
    );

    if (_updated != null){

      WaitDialog.showUnawaitedWaitDialog();

      await FishProtocols.renovate(newFish: _updated);
      setState(() {
        _fishes = FishModel.insertFishToFishes(
          fishes: _fishes,
          fish: _updated,
        );
        if (FishModel.checkFishesContainFish(fishes: _foundFishes, fish: _updated) == true){
          _foundFishes = FishModel.insertFishToFishes(
            fishes: _foundFishes,
            fish: _updated,
          );
        }
      });
      await WaitDialog.closeWaitDialog();

    }

  }
  // --------------------
  Future<void> _deleteFish(FishModel fish) async {

    final bool _go = await Dialogs.confirmProceed(
      titleVerse: Verse.plain('Delete fish ?'),
      bodyVerse: Verse.plain(fish.id),
    );

    if (_go == true){

      await FishProtocols.wipe(id: fish.id);

      setState(() {
        _fishes = FishModel.removeFish(fishes: _fishes, fish: fish);
        _selectedFishes = FishModel.removeFish(fishes: _selectedFishes, fish: fish);
      });

    }

  }
  // --------------------
  Future<void> _checkInstagramLinkExists() async {

    if (_isSearching.value == true){
      _foundFishes = const [];
      _searchController.text = '';
      setNotifier(notifier: _isSearching, mounted: mounted, value: false);
      // await Future.delayed(const Duration(milliseconds: 200));
      // await Sliders.scrollToEnd(controller: _scrollController,duration: Duration.zero);
    }

    else {

      final String? url = await TextClipBoard.paste();

      String? _error;
      if (TextCheck.isEmpty(url) == true){
        _error = 'Copy The instagram link first';
      }
      else if (Formers.socialLinkValidator(url: url, contactType: ContactType.instagram, isMandatory: true) != null){
        _error = 'This is not an instagram Link';
      }

      /// LINK IS NOT GOOD
      if (_error != null){
        await Dialogs.topNotice(verse: Verse.plain(_error));
      }

      /// SEARCH FOR THE LINK
      else {

        final FishModel? _fish = FishModel.getFishByContactType(
          fishes: _fishes,
          value: Linker.cleanURL(url),
          contactType: ContactType.instagram,
        );

        if (_fish == null){

          await Dialogs.topNotice(
            verse: Verse.plain('Not Used'),
            color: Colorz.green255,
          );

          await _editFish(
              FishModel(
                id: '',
                countryID: _fishes.last.countryID,
                bio: '',
                contacts: ContactModel.prepareContactsForEditing(
                  countryID: null,
                  contacts: [
                    ContactModel(value: url, type: ContactType.instagram),
                  ],
                ),
                type: null,
                name: '',
              )
          );

        }
        else {

          _foundFishes = [_fish];
          setNotifier(notifier: _isSearching, mounted: mounted, value: true);

        }

      }

    }

  }
  // -----------------------------------------------------------------------------

  /// FISH SELECTION

  // --------------------
  Future<void> _onFishTap(FishModel _fish) async {

    if (widget.multipleSelection == true){

      final bool _isSelected = FishModel.checkFishesContainFish(fishes: _selectedFishes, fish: _fish);

      if (_isSelected == true){
        final List<FishModel> _newSelectedFishes = FishModel.removeFish(
          fishes: _selectedFishes,
          fish: _fish,
        );
        setState(() {
          _selectedFishes = _newSelectedFishes;
        });
      }

      else {

        final List<FishModel> _newSelectedFishes = FishModel.insertFishToFishes(
          fishes: _selectedFishes,
          fish: _fish,
        );
        setState(() {
          _selectedFishes = _newSelectedFishes;
        });

      }

    }

    else {
      await Nav.goBack(
        context: context,
        passedData: _fish,
      );
    }

  }
  // --------------------
  Future<void> _onConfirmSelected() async {

    await Nav.goBack(
      context: context,
      passedData: _selectedFishes,
    );

  }
  // -----------------------------------------------------------------------------

  /// COPYING

  // --------------------
  Future<void> _batchCopy(List<FishModel> fishes) async {

    final List<String> _emails = FishModel.getEmails(fishes: fishes);

    if (Lister.checkCanLoop(_emails) == true){

      final int _numberOfEmails = _emails.length;
      const int _batchSize = 50;
      final int _numberOfTurns = (_numberOfEmails / _batchSize).ceil();

      await Dialogs.centerNotice(
        verse: Verse.plain('${_emails.length} emails'),
        body: Verse.plain('will be divided on batches of $_batchSize on $_numberOfTurns turns'),
      );

      for (int i = 0; i < _numberOfTurns; i++){

        final int start = i * _batchSize;
        int end = (i + 1) * _batchSize;
        end = end > _numberOfEmails ? _numberOfEmails : end;

        final List<String> batch = _emails.sublist(start, end);

        String _copy = '';
        for (final String _email in batch){
          _copy = '$_copy$_email; ';
        }
        await Keyboard.copyToClipboardAndNotify(copy: _copy);

        if (i+1 != _numberOfTurns){
          await Dialogs.centerNotice(
            verse: Verse.plain('go round ${i+2}/$_numberOfTurns ?'),
          );
        }

      }

    }

  }
  // -----------------------------------------------------------------------------

  /// EDITING FISHES

  // --------------------
  Future<void> _onSearch(String? text) async {

    Searching.triggerIsSearchingNotifier(
      text: text?.toLowerCase(),
      isSearching: _isSearching,
      mounted: mounted,
      minCharLimit: 2,
    );

    if (_isSearching.value == true){

      final List<FishModel> _found = searchAllFishes(text);

      blog('text : $text : _found : $_found');

      setState(() {
        _foundFishes = _found;
      });

    }

  }
  // --------------------
  List<FishModel> searchAllFishes(String? text){
    List<FishModel> _found = [];

    if (TextCheck.isEmpty(text) == false){

      /// BY ID
      final FishModel? _byID = FishModel.getFishByID(fishes: _fishes, id: text);
      _found = FishModel.insertFishToFishes(fishes: _found, fish: _byID);
      if(_byID != null){blog('searchAllFishes : found by ID : ${_byID.id}');}

      /// BY NAME
      final FishModel? _byName = FishModel.getFishByName(fishes: _fishes, name: text);
      _found = FishModel.insertFishToFishes(fishes: _found, fish: _byName);
      if(_byName != null){blog('searchAllFishes : found by name : ${_byName.name}');}

      /// BY PART OF NAME
      final List<FishModel> _byPartName = FishModel.getFishesByPartName(fishes: _fishes, part: text);
      _found = FishModel.insertFishesToFishes(listToTake: _found, listToAdd: _byPartName);
      if(_byPartName.isNotEmpty){blog('searchAllFishes : found by _byPartName : ${_byPartName.first.name} : ${_byPartName.length} fishes');}

      /// BY FACEBOOK
      final FishModel? _byFacebook = FishModel.getFishByContactType(fishes: _fishes, value: text, contactType: ContactType.facebook);
      _found = FishModel.insertFishToFishes(fishes: _found, fish: _byFacebook);
      if(_byFacebook != null){blog('searchAllFishes : found by facebook : ${_byFacebook.id}');}

      /// BY INSTAGRAM
      final FishModel? _byInstagram = FishModel.getFishByContactType(fishes: _fishes, value: text, contactType: ContactType.instagram);
      _found = FishModel.insertFishToFishes(fishes: _found, fish: _byInstagram);
      if(_byInstagram != null){blog('searchAllFishes : found by instagram : ${_byInstagram.id}');}

      /// BY PHONE
      final FishModel? _byPhone = FishModel.getFishByContactType(fishes: _fishes, value: text, contactType: ContactType.phone);
      _found = FishModel.insertFishToFishes(fishes: _found, fish: _byPhone);
      if(_byPhone != null){blog('searchAllFishes : found by phone : ${_byPhone.id}');}

      /// BY EMAIL
      final FishModel? _byEmail = FishModel.getFishByContactType(fishes: _fishes, value: text, contactType: ContactType.email);
      _found = FishModel.insertFishToFishes(fishes: _found, fish: _byEmail);
      if(_byEmail != null){blog('searchAllFishes : found by email : ${_byEmail.id}');}

      /// BY WEBSITE
      final FishModel? _byWebsite = FishModel.getFishByContactType(fishes: _fishes, value: text, contactType: ContactType.website);
      _found = FishModel.insertFishToFishes(fishes: _found, fish: _byWebsite);
      if(_byWebsite != null){blog('searchAllFishes : found by website : ${_byWebsite.id}');}

      /// BY DOMAIN
      final FishModel? _byDomain = FishModel.getFishByWebsiteDomain(fishes: _fishes, domain: text);
      _found = FishModel.insertFishToFishes(fishes: _found, fish: _byDomain);
      if(_byDomain != null){blog('searchAllFishes : found by domain : ${_byDomain.id}');}

    }

    return _found;
  }
  // --------------------
  Future<void> _onSearchCancelled() async {

    blog('search ended');

    setNotifier(notifier: _isSearching, mounted: mounted, value: false);
    _searchController.text = '';
    setState(() {
      _foundFishes = [];
    });

    // await Future.delayed(const Duration(milliseconds: 500));
    // await Sliders.scrollToEnd(controller: _scrollController, duration: const Duration(milliseconds: 800));

  }
  // -----------------------------------------------------------------------------
  List<String> _filterCountriesIDs = [];
  BzType? _filterBzType;
  bool _filterOnlyEmail = false;
  bool _filterOnlyWebsite = false;
  bool _filterOnlyPhone = false;
  bool _filterOnlyFacebook = false;
  bool _filterOnlyInstagram = false;
  bool _filterOnlyLinkedIn = false;
  bool _filterOnlyTiktok = false;
  bool _filterOnlyTwitter = false;
  bool _filterOnlyYoutube = false;
  // --------------------
  Widget _getFilters(){

    return SearchFilterBox(
      children: <Widget>[

        /// ZONE
        CountriesFilterTile(
          countries: _filterCountriesIDs,
          onSelectedCountryTap: (String countryID){

            _filterCountriesIDs = Stringer.removeStringsFromStrings(
                removeFrom: _filterCountriesIDs,
                removeThis: [countryID],
            );
            _doTheFilters();

          },
          onSwitchTap: (bool value){

            if (value == false){
              _filterCountriesIDs = [];
              _doTheFilters();
            }
            else {
              _goBringCountryFilter();
            }

          },
          onTileTap: _goBringCountryFilter,
        ),

        /// ONLY ARABIC COUNTRIES
        FilterBoolTile(
          icon: 'ض',
          verse: Verse.plain('Only Arabic Countries'),
          switchValue: Lister.checkListsAreIdentical(list1: _filterCountriesIDs, list2: arabCountries),
          iconIsBig: false,
          onSwitchTap: (bool value){
            _filterCountriesIDs = value == true ? arabCountries : [];
            _doTheFilters();
          },
        ),

        /// ONLY US STATES
        FilterBoolTile(
          icon: Flag.getCountryIcon('usa')!,
          verse: Verse.plain('Only US States'),
          switchValue: Lister.checkListsAreIdentical(list1: _filterCountriesIDs, list2: America.getStatesIDs()),
          iconIsBig: false,
          onSwitchTap: (bool value){
            _filterCountriesIDs = value == true ? America.getStatesIDs() : [];
            _doTheFilters();
          },
        ),

        /// BZ TYPE
        FilterMultiButtonTile(
          icon: Iconz.bz,
          verse: const Verse(
            id: 'phid_bz_entity_type',
            translate: true,
          ),
          items: BzTyper.bzTypesList,
          switchValue: _filterBzType != null,

          selectedItem: _filterBzType,
          itemVerse: (dynamic type) => Verse(
            id: BzTyper.getBzTypePhid(
              bzType: type,
              pluralTranslation: false,
            ),
            translate: true,
          ),
          itemIcon: (dynamic type) => BzTyper.getBzTypeIcon(type),
          iconIsBig: false,
          onSwitchTap: (bool value){

            if (value == false){
              _filterBzType = null;
              _doTheFilters();
            }

          },
          onItemTap: (dynamic type) {
            _filterBzType = type;
            _doTheFilters();
          },
        ),

        /// ONLY WITH EMAIL
        FilterBoolTile(
          icon: Iconz.comEmail,
          verse: Verse.plain('Only with Emails'),
          switchValue: _filterOnlyEmail,
          iconIsBig: false,
          onSwitchTap: (bool value){
            _filterOnlyEmail = value;
            _doTheFilters();
          },
        ),

        /// ONLY WITH WEBSITE
        FilterBoolTile(
          icon: Iconz.comWebsite,
          verse: Verse.plain('Only with Website'),
          switchValue: _filterOnlyWebsite,
          iconIsBig: false,
          onSwitchTap: (bool value){
            _filterOnlyWebsite = value;
            _doTheFilters();
          },
        ),

        /// ONLY WITH PHONE
        FilterBoolTile(
          icon: Iconz.comPhone,
          verse: Verse.plain('Only with Phone'),
          switchValue: _filterOnlyPhone,
          iconIsBig: false,
          onSwitchTap: (bool value){
            _filterOnlyPhone = value;
            _doTheFilters();
          },
        ),

        /// ONLY WITH FACEBOOK
        FilterBoolTile(
          icon: Iconz.comFacebook,
          verse: Verse.plain('Only with Facebook'),
          switchValue: _filterOnlyFacebook,
          iconIsBig: false,
          onSwitchTap: (bool value){
            _filterOnlyFacebook = value;
            _doTheFilters();
          },
        ),

        /// ONLY WITH INSTAGRAM
        FilterBoolTile(
          icon: Iconz.comInstagram,
          verse: Verse.plain('Only with Instagram'),
          switchValue: _filterOnlyInstagram,
          iconIsBig: false,
          onSwitchTap: (bool value){
            _filterOnlyInstagram = value;
            _doTheFilters();
          },
        ),

        /// ONLY WITH LINKEDIN
        FilterBoolTile(
          icon: Iconz.comLinkedin,
          verse: Verse.plain('Only with LinkedIn'),
          switchValue: _filterOnlyLinkedIn,
          iconIsBig: false,
          onSwitchTap: (bool value){
            _filterOnlyLinkedIn = value;
            _doTheFilters();
          },
        ),

        /// ONLY WITH TIKTOK
        FilterBoolTile(
          icon: Iconz.comTikTok,
          verse: Verse.plain('Only with Tiktok'),
          switchValue: _filterOnlyTiktok,
          iconIsBig: false,
          onSwitchTap: (bool value){
            _filterOnlyTiktok = value;
            _doTheFilters();
          },
        ),

        /// ONLY WITH YOUTUBE
        FilterBoolTile(
          icon: Iconz.comYoutube,
          verse: Verse.plain('Only with Youtube'),
          switchValue: _filterOnlyYoutube,
          iconIsBig: false,
          onSwitchTap: (bool value){
            _filterOnlyYoutube = value;
            _doTheFilters();
          },
        ),

        /// ONLY WITH TWITTER
        FilterBoolTile(
          icon: Iconz.comTwitter,
          verse: Verse.plain('Only with X'),
          switchValue: _filterOnlyTwitter,
          iconIsBig: false,
          onSwitchTap: (bool value){
            _filterOnlyTwitter = value;
            _doTheFilters();
          },
        ),

      ],
    );

  }
  // --------------------
  Future<void> _goBringCountryFilter() async {

    _filterCountriesIDs = await ZoneSelection.goBringCountries(
      depth: ZoneDepth.country,
      zoneViewingEvent: ViewingEvent.admin,
      viewerZone: null,
      selectedCountries: _filterCountriesIDs,
      ignoreCensusAndStaging: true,
    );

    _doTheFilters();

  }
  // --------------------
  void _doTheFilters(){

    /// COUNTRY
    List<FishModel> _filtered = FishModel.filterByCountries(
      fishes: _originalFishes,
      countriesIDs: _filterCountriesIDs,
    );

    /// BZ TYPE
    _filtered = FishModel.filterByBzType(
      fishes: _filtered,
      bzType: _filterBzType,
    );

    /// ONLY WITH EMAIL
    _filtered = FishModel.filterByContactType(
      fishes: _filtered,
      contactType: _filterOnlyEmail == true ? ContactType.email : null,
    );

    /// ONLY WITH WEBSITE
    _filtered = FishModel.filterByContactType(
      fishes: _filtered,
      contactType: _filterOnlyWebsite == true ? ContactType.website : null,
    );

    /// ONLY WITH PHONE
    _filtered = FishModel.filterByContactType(
      fishes: _filtered,
      contactType: _filterOnlyPhone == true ? ContactType.phone : null,
    );

    /// ONLY WITH FACEBOOK
    _filtered = FishModel.filterByContactType(
      fishes: _filtered,
      contactType: _filterOnlyFacebook == true ? ContactType.facebook : null,
    );

    /// ONLY WITH INSTAGRAM
    _filtered = FishModel.filterByContactType(
      fishes: _filtered,
      contactType: _filterOnlyInstagram == true ?  ContactType.instagram : null,
    );

    /// LINKED IN
    _filtered = FishModel.filterByContactType(
      fishes: _filtered,
      contactType: _filterOnlyLinkedIn == true ?  ContactType.linkedIn : null,
    );

    /// ONLY WITH TIKTOK
    _filtered = FishModel.filterByContactType(
      fishes: _filtered,
      contactType: _filterOnlyTiktok== true ? ContactType.tiktok : null,
    );

    /// ONLY WITH YOUTUBE
    _filtered = FishModel.filterByContactType(
      fishes: _filtered,
      contactType: _filterOnlyYoutube == true ? ContactType.youtube : null,
    );

    /// ONLY WITH TWITTER
    _filtered = FishModel.filterByContactType(
      fishes: _filtered,
      contactType: _filterOnlyTwitter == true ? ContactType.twitter : null,
    );

    setState(() {
      _fishes = _filtered;
    });

  }
  // -----------------------------------------------------------------------------

  /// MORE

  // --------------------
  Future<void> _onMoreTap() async {

    await BottomDialog.showButtonsBottomDialog(
        context: context,
        draggable: true,
        numberOfWidgets: 11,
        builder: (_, __){

          return [

            /// ADD NEW FISH
            BottomDialog.wideButton(
              context: context,
              text: 'Add new Fish',
              onTap: onAddNewFishTap,
            ),

            /// SELECT ALL
            BottomDialog.wideButton(
              context: context,
              text: 'Select All',
              onTap: () async {

                setState(() {
                  _selectedFishes = _fishes;
                });

                await Nav.goBack(context: context);

              },
            ),

            /// DESELECT ALL
            BottomDialog.wideButton(
              context: context,
              text: 'Deselect All',
              onTap: () async {

                setState(() {
                  _selectedFishes = [];
                });

                await Nav.goBack(context: context);

              },
            ),

            /// COPY ALL
            BottomDialog.wideButton(
              context: context,
              text: 'Copy all emails',
              onTap: () async {

                await Nav.goBack(context: context);

                final List<String> _emails = FishModel.getEmails(fishes: _fishes);

                if (Lister.checkCanLoop(_emails) == true){

                  String _copy = '';
                  for (final String _email in _emails){
                    _copy = '$_copy$_email; ';
                  }
                  await Keyboard.copyToClipboardAndNotify(copy: _copy);

                }

              },
            ),

            /// BATCH COPY
            BottomDialog.wideButton(
              context: context,
              text: 'Copy Emails on batches of 50s',
              onTap: () async {

                await Nav.goBack(context: context);

                await _batchCopy(_fishes);


              },
            ),

            /// BATCH COPY SELECTED
            BottomDialog.wideButton(
              context: context,
              text: 'Copy Selected in Batches',
              onTap: () async {

                await Nav.goBack(context: context);

                await _batchCopy(_selectedFishes);


              },
            ),

            /// REFETCH
            BottomDialog.wideButton(
              context: context,
              text: 'Refetch',
              onTap: () async {

                await Nav.goBack(context: context);

                WaitDialog.showUnawaitedWaitDialog();

                final List<FishModel> _allFishes = await FishProtocols.refetchAll();

                setState(() {
                  _fishes = _allFishes;
                });

                await WaitDialog.closeWaitDialog();

              },
            ),

            const DotSeparator(),

            // /// SCRAP_EYE_OF_RIYADH
            // BottomDialog.wideButton(
            //   context: context,
            //   text: 'Scrap Eye of Riyadh',
            //   onTap: () async {
            //
            //     blog('start scrapping');
            //
            //     final Map<String, dynamic>? _map = await EyeOfRiyadhScrapper.scrap(
            //         url: 'https://www.eyeofriyadh.com/directory/details/1560_al-rajhi-steel',
            //     );
            //
            //     Mapper.blogMap(_map, invoker: 'Maw');
            //
            //   },
            // ),

            const DotSeparator(),

            /// CLEAN WEBSITES
            BottomDialog.wideButton(
              context: context,
              text: 'Clean websites',
              onTap: () async {

                for (final FishModel fish in _fishes){

                  final String? _website = ContactModel.getValueFromContacts(
                      contacts: fish.contacts,
                      contactType: ContactType.website,
                  );

                  final ContactType? _type = ContactModel.concludeContactTypeByURLDomain(url: _website);

                  if (_type != null && _type != ContactType.website){
                    blog('fish ${fish.id} : website is : $_website');
                  }

                }

              },
            ),

            /// BACK UP
            BottomDialog.wideButton(
              context: context,
              text: 'BACK UP FISHES',
              onTap: () async {

                WaitDialog.showUnawaitedWaitDialog(verse: Verse.plain('Backing up fishes'));

                final List<FishModel> _fishes = await FishFireOps.readAll();

                int i = 0;
                for (final FishModel fish in _fishes){
                  UiProvider.proSetLoadingVerse(verse: Verse.plain('$i :storing :${fish.name}'));
                  await Real.createDocInPath(
                      pathWithoutDocName: 'app/fishes_backup',
                      doc: fish.id,
                      map: fish.toMap()
                  );
                  i++;
                }

                await WaitDialog.closeWaitDialog();

              },
            ),

            /// STEAL URL IMAGES
            BottomDialog.wideButton(
              context: context,
              text: 'STEAL URL IMAGES',
              icon: Iconz.gallery,
              onTap: () async {

                WaitDialog.showUnawaitedWaitDialog();

                for (int i = 0; i < _fishes.length; i++){

                  final FishModel fish = _fishes[i];
                  final String _count = Numeric.formatIndexDigits(index: i+1, listLength: _fishes.length)!;
                  final String _num = '$_count/${_fishes.length}';
                  blog('$_num : ${fish.id}');

                  final String? _image = fish.imageURL;

                  if (TextCheck.isEmpty(_image) == false && fish.id != null){

                    final bool _isStoragePath = ObjectCheck.objectIsFireStoragePicPath(_image);
                    final bool _isURL = ObjectCheck.isAbsoluteURL(_image);

                    if (_isStoragePath == false && _isURL == true){

                      final MediaModel? _picModel = await MediaProtocols.stealInternetPic(
                        url: _image,
                        ownersIDs: [BldrsKeys.ragehID],
                        uploadPath: 'storage/fishes/${fish.id}',
                      );

                      if (_picModel != null){

                        final FishModel _fish = fish.copyWith(
                          imageURL: 'storage/fishes/${fish.id}',
                        );

                        await FishProtocols.renovate(newFish: _fish);

                        setState(() {
                          _fishes = FishModel.insertFishToFishes(fishes: _fishes, fish: fish);
                        });

                      }

                    }

                  }

                }

                await WaitDialog.closeWaitDialog();

              },
            ),

            const DotSeparator(),

            /// BLOG INSTAGRAM LINKS
            BottomDialog.wideButton(
              context: context,
              text: 'Blog instagram links',
              icon: Iconz.comInstagramPlain,
              onTap: () async {

                List<String> _links = [];

                for (final FishModel fish in _fishes){

                  final String? _insta = ContactModel.getValueFromContacts(
                      contacts: fish.contacts,
                      contactType: ContactType.instagram,
                  );

                  _links = Stringer.addStringToListIfDoesNotContainIt(
                      strings: _links,
                      stringToAdd: _insta,
                  );

                }

                Stringer.blogStrings(strings: _links, invoker: 'All Instagram links');

              },
            ),

            const DotSeparator(),

            /// MARK EMAIL AS FAILURE
            BottomDialog.wideButton(
              context: context,
              text: 'Mark Email isFailing',
              icon: Iconz.comEmail,
              onTap: () async {

                String? _text = await TextClipBoard.paste();
                _text = _text?.trim();
                final bool _isValidEmail = Formers.emailValidator(email: _text, canValidate: true) == null;

                if (_isValidEmail == true){

                  FishModel? _fish = FishModel.getFishByContactType(
                      fishes: _fishes,
                      value: _text,
                      contactType: ContactType.email,
                  );

                  if (_fish == null){
                    await Dialogs.topNotice(verse: Verse.plain('Could not find fish'), color: Colorz.red255);
                  }
                  else if (_fish.emailIsFailing == true){
                    await Dialogs.topNotice(verse: Verse.plain('Is Marked Already'), color: Colorz.red255);
                  }
                  else {

                    _fish = _fish.copyWith(
                      emailIsFailing: true,
                    );

                    WaitDialog.showUnawaitedWaitDialog();

                    await FishProtocols.renovate(newFish: _fish);
                    setState(() {
                      _fishes = FishModel.insertFishToFishes(
                        fishes: _fishes,
                        fish: _fish,
                      );
                      if (FishModel.checkFishesContainFish(fishes: _foundFishes, fish: _fish!) == true){
                        _foundFishes = FishModel.insertFishToFishes(
                          fishes: _foundFishes,
                          fish: _fish,
                        );
                      }
                    });
                    await WaitDialog.closeWaitDialog();

                    final String _name = _fish.name ?? _fish.id ?? _text!;
                    await Dialogs.topNotice(verse: Verse.plain("Fish ($_name)'s email is marked isFailing"), color: Colorz.green255);

                  }

                }
                else {
                  await Dialogs.topNotice(verse: Verse.plain('Not a valid Email'), color: Colorz.red255);
                }

              },
            ),


          ];

        }
    );

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return MainLayout(
      canSwipeBack: true,
      appBarType: AppBarType.search,
      title: Verse(
        id: '${_fishes.length} Bzz fish tank',
        translate: false,
      ),
      loading: _loading,
      onSearchChanged: _onSearch,
      onSearchSubmit: _onSearch,
      onSearchCancelled: _onSearchCancelled,
      searchController: _searchController,
      confirmButton: widget.multipleSelection == false ? null : ConfirmButton(
        enAlignment: Alignment.bottomRight,
        confirmButtonModel: Lister.checkCanLoop(_selectedFishes) == true ?
        ConfirmButtonModel(
          firstLine: Verse.plain('Confirm ${_selectedFishes.length} selected'),
          onTap: _onConfirmSelected,
        )
            :
        ConfirmButtonModel(
          firstLine: Verse.plain('Add Fish'),
          isWide: true,
          onTap: onAddNewFishTap,

        ),
      ),
      appBarRowWidgets: <Widget>[

        // AppBarButton(
        //   verse: Verse.plain('read excels'),
        //   onTap: () async {
        //
        //     // final List<List<String>> _sheet = await GoogleSheets.readAllRows(
        //     //   sheetTitle: 'fishes',
        //     //   fileURL: 'https://docs.google.com/spreadsheets/d/1hDSxuFSFaSfqgErSzbMONiTZdLWIES9KYgra1kt09As/edit#gid=1077805363',
        //     //
        //     // );
        //
        //     final List<List<String>> _rows = await GoogleSheets.readAllRows(
        //       sheetTitle: 'fishes',
        //       fileURL: 'https://docs.google.com/spreadsheets/d/1hDSxuFSFaSfqgErSzbMONiTZdLWIES9KYgra1kt09As/edit#gid=1077805363',
        //       onGetSheetError: (String? error) async {
        //         await GoogleSheets.onGSheetErrorDialog(error);
        //       },
        //       onReadError: (String? error) async {
        //         await GoogleSheets.onGSheetErrorDialog(error);
        //
        //       },
        //     );
        //
        //     blog('the rows : $_rows');
        //
        //       if (Lister.checkCanLoop(_rows) == true){
        //
        //         List<FishModel> _samak = [];
        //
        //         for (final List<String> row in _rows){
        //
        //           if (Lister.checkCanLoop(row) == true){
        //
        //             final String _link = row.first;
        //             final String _email = row.last;
        //             String? _domain = Linker.extractEmailDomain(email: _email);
        //             _domain = TextMod.removeTextAfterLastSpecialCharacter(text: _domain, specialCharacter: '.');
        //             final ContactType? _type = ContactModel.concludeContactTypeByURLDomain(url: _link);
        //
        //             final FishModel _fish = FishModel(
        //               id: TextMod.idifyString(_email),
        //               name: _domain,
        //               contacts: [
        //                 ContactModel(type: _type, value: _link),
        //                 ContactModel(type: ContactType.email, value: _email),
        //               ],
        //               type: null,
        //               countryID: null,
        //             );
        //
        //             if (_email != 'email'){
        //
        //               final FishModel? _uploaded = await FishProtocols.compose(fish: _fish);
        //
        //               _samak = FishModel.insertFishToFishes(
        //                 fishes: _samak,
        //                 fish: _uploaded,
        //               );
        //             }
        //
        //           }
        //
        //         }
        //
        //         setState(() {
        //           _fishes = FishModel.insertFishesToFishes(listToTake: _fishes, listToAdd: _samak);
        //         });
        //
        //         // blog('fishes : $_samak');
        //
        //       }
        //
        //
        //   },
        // ),
        //
        // /// COMPOSE
        // AppBarButton(
        //   verse: Verse.plain('compose all'),
        //   onTap: () async {
        //
        //     WaitDialog.showUnawaitedWaitDialog();
        //
        //     final List<Map<String, dynamic>> _all = await Fire.readAllColl(coll: FireColl.fishes);
        //     final List<FishModel> _theFishes = FishModel.decipherFishes(maps: _all);
        //
        //     for (final FishModel fish in _theFishes){
        //
        //       UiProvider.proSetLoadingVerse(verse: Verse.plain(fish.name));
        //       await FishProtocols.compose(fish: fish);
        //
        //       await Real.createDoc(
        //           coll: 'fishes',
        //           map: fish.toMap(),
        //       );
        //
        //     }
        //
        //     await WaitDialog.closeWaitDialog();
        //
        //   },
        // ),

        /// SCRAP_EYE_OF_RIYADH
        // if (DeviceChecker.deviceIsWindows() == true)
        // AppBarButton(
        //   verse: Verse.plain('Scrap Riyadh'),
        //   icon: Flag.getCountryIcon('sau'),
        //   onTap: () async {
        //
        //     blog('yalla');
        //
        //     final String? _pasted = await TextClipBoard.paste();
        //
        //     if (TextCheck.isEmpty(_pasted) == true){
        //       await Dialogs.topNotice(verse: Verse.plain('No URL is copied'), color: Colorz.red255);
        //     }
        //     else if (Formers.webSiteValidator(website: _pasted, isMandatory: true) != null){
        //       await Dialogs.topNotice(verse: Verse.plain('Not a website'), color: Colorz.red255);
        //     }
        //     else if (TextCheck.stringContainsSubString(string: _pasted, subString: 'eyeofriyadh') == false){
        //       await Dialogs.topNotice(verse: Verse.plain('This is not eye of riyadh website'), color: Colorz.red255);
        //     }
        //     else {
        //
        //       WaitDialog.showUnawaitedWaitDialog();
        //
        //       final Map<String, dynamic>? _map = await EyeOfRiyadhScrapper.scrap(url: _pasted);
        //       await WaitDialog.closeWaitDialog();
        //
        //       Mapper.blogMap(_map);
        //
        //       if (_map == null){
        //         await Dialogs.topNotice(verse: Verse.plain('Could not scrap'), color: Colorz.red255);
        //       }
        //       else {
        //
        //         BzType? _type;
        //
        //         await BottomDialog.showButtonsBottomDialog(
        //             context: context,
        //             draggable: true,
        //             numberOfWidgets: BzTyper.bzTypesList.length,
        //             builder: (_, __){
        //               return [
        //                 ...List.generate(BzTyper.bzTypesList.length, (index){
        //                   final BzType _bzType = BzTyper.bzTypesList[index];
        //                   return BottomDialog.wideButton(
        //                     context: context,
        //                     icon: BzTyper.getBzTypeIcon(_bzType),
        //                     text: getWord(BzTyper.getBzTypePhid(bzType: _bzType)),
        //                     onTap: () async {
        //                       _type = _bzType;
        //                       await Nav.goBack(context: context);
        //                     }
        //                   );
        //
        //                 }),
        //               ];
        //             }
        //         );
        //
        //         if (_type == null){
        //           await Dialogs.topNotice(verse: Verse.plain('Select a Bz Type'), color: Colorz.red255);
        //         }
        //         else {
        //
        //           final FishModel? _fish = EyeOfRiyadhScrapper.cipherScrappedToFish(
        //             map: _map,
        //             bzType: _type!,
        //           );
        //
        //           if (_fish == null){
        //             await Dialogs.topNotice(verse: Verse.plain('Could not create fish'), color: Colorz.red255);
        //           }
        //           else {
        //
        //             final FishModel? _byID = FishModel.getFishByID(fishes: _fishes, id: _fish.id);
        //             if (_byID != null){
        //               setState(() {
        //                 _foundFishes = [_fish];
        //               });
        //               setNotifier(notifier: _isSearching, mounted: mounted, value: true);
        //             }
        //             else {
        //
        //               final String? _email = ContactModel.getValueFromContacts(contacts: _fish.contacts, contactType: ContactType.email);
        //               final String? _webSite = ContactModel.getValueFromContacts(contacts: _fish.contacts, contactType: ContactType.website);
        //               final List<FishModel> _found3 = searchAllFishes(_email);
        //               final List<FishModel> _found2 = searchAllFishes(_webSite);
        //
        //               if (Lister.checkCanLoop([..._found2,..._found3]) == true){
        //                 await _onSearch(_email);
        //                 if (_foundFishes.isEmpty){await _onSearch(_webSite);}
        //                 if (_foundFishes.isEmpty){await _onSearch(_fish.id);}
        //                 await Dialogs.topNotice(verse: Verse.plain('Is already fished out'), color: Colorz.red255);
        //               }
        //               else {
        //                 await onAddNewFishTap(
        //                   newFish: _fish,
        //                 );
        //               }
        //
        //             }
        //
        //           }
        //
        //         }
        //
        //       }
        //
        //     }
        //
        //   },
        // ),

        /// INSTAGRAM LINK CHECKER
        ValueListenableBuilder(
            valueListenable: _isSearching,
            builder: (_, bool isSearching, Widget? child) {

              return AppBarButton(
                icon: isSearching ? Iconz.xSmall : Iconz.comInstagram,
                verse: Verse.plain(isSearching ? 'Cancel\nSearch' : 'Check'),
                onTap: _checkInstagramLinkExists,
              );

            }
            ),

        /// MORE
        AppBarButton(
          icon: Iconz.more,
          onTap: _onMoreTap,
        ),

      ],
      filtersAreOn: _filtersAreOn,
      filters: _getFilters(),
      onPaste: _onSearch,
      child: ValueListenableBuilder(
        valueListenable: _isSearching,
        builder: (_, bool isSearching, Widget? child) {

          final List<FishModel> _theFishes = isSearching == true ? _foundFishes : _fishes;

          if (Lister.checkCanLoop(_theFishes) == false){
            return const Center(child: NoResultFound());
          }

          else {
            return Scroller(
              controller: _scrollController,
              child: ListView.builder(
                controller: _scrollController,
                itemCount: _theFishes.length,
                padding: Stratosphere.getStratosphereSandwich(context: context, appBarType: AppBarType.search),
                physics: const BouncingScrollPhysics(),
                itemBuilder: (_, int index){

                  final FishModel _fish = _theFishes.reversed.toList()[index];
                  final String? _index = Numeric.formatIndexDigits(
                    index: index+1,
                    listLength: _theFishes.length,
                  );
                  final bool _isSelected = FishModel.checkFishesContainFish(
                    fishes: _selectedFishes,
                    fish: _fish,
                  );

                  return FishTile(
                      index: _index,
                      fishModel: _fish,
                      isSelected: _isSelected,
                      onTileTap: () => _onFishTap(_fish),
                      onEditTap: () => onEditFish(_fish),
                      );

                  },
              ),
            );

          }

        }
      ),
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
