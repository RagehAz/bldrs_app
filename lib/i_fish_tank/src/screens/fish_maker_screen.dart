part of fish_tank;

class FishMakerScreen extends StatefulWidget {
  // --------------------------------------------------------------------------
  const FishMakerScreen({
    required this.allFishes,
    this.fish,
    this.countryID,
    this.facebookAccessToken,
    super.key
  });
  // --------------------
  final FishModel? fish;
  final List<FishModel> allFishes;
  final String? countryID;
  final String? facebookAccessToken;
  // --------------------
  @override
  _FishMakerScreenState createState() => _FishMakerScreenState();
  // --------------------------------------------------------------------------
  static Future<FishModel?> makeFish({
    required List<FishModel> allFishes,
    String? countryID,
  }) async {

    final FishModel? _fish = await BldrsNav.goToNewScreen(
      screen: FishMakerScreen(
        allFishes: allFishes,
        countryID: countryID,
      ),
    );

    return FishModel.decipher(map: _fish?.toMap());
  }
  // --------------------
  static Future<FishModel?> editFish({
    required FishModel? fishModel,
    required List<FishModel> allFishes,
    String? facebookAccessToken,
  }) async {

    final FishModel? _fish = await BldrsNav.goToNewScreen(
        screen: FishMakerScreen(
          allFishes: allFishes,
          fish: fishModel,
          facebookAccessToken: facebookAccessToken,
          // countryID: ,
        ),
    );

    return _fish;
  }
  // --------------------------------------------------------------------------
}

class _FishMakerScreenState extends State<FishMakerScreen> {
  // -----------------------------------------------------------------------------
  List<String> _allDomains = [];
  // -----------------------------------------------------------------------------
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // -----------------------------------------------------------------------------
  FishModel? _fish;
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _websiteController = TextEditingController();

  // -----------------------------------------------------------------------------
  /// --- LOADING
  bool _loading = false;
  // -----------------------------------------------------------------------------
  @override
  void initState() {

    _fish = widget.fish ?? FishModel(
      id: '',
      bio: '',
      countryID: widget.countryID,
      contacts: ContactModel.prepareContactsForEditing(
        countryID: widget.countryID,
        contacts: [],
      ),
      type: null,
      name: '',
    );

    _fish = _fish!.copyWith(
      contacts: ContactModel.prepareContactsForEditing(
        countryID: _fish?.countryID,
        contacts: _fish?.contacts ?? [],
      ),
    );

    _idController.text = _fish?.id ?? '';
    _nameController.text = _fish?.name ?? '';
    _bioController.text = _fish?.bio ?? '';

    _definePhoneEmailWebsite();

    _allDomains = FishModel.getAllDomains(fishes: widget.allFishes);

    super.initState();
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {

    if (_isInit && mounted) {
      _isInit = false; // good

      asyncInSync(() async {


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
    _idController.dispose();
    _nameController.dispose();
    _bioController.dispose();

    _phoneController.dispose();
    _emailController.dispose();
    _websiteController.dispose();

    super.dispose();
  }
  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  void onChangeBzContact({
    required ContactType contactType,
    required String? value,
  }){

    final List<ContactModel> _contacts = ContactModel.insertOrReplaceContact(
      contacts: _fish?.contacts,
      contactToReplace: ContactModel(
        value: value,
        type: contactType,
      ),
    );

    setState(() {
      _fish = _fish?.copyWith(
        contacts: _contacts,
      );
    });

  }
  // --------------------
  void _definePhoneEmailWebsite(){

    final String? _phone = ContactModel.getInitialContactValue(
      type: ContactType.phone,
      countryID: _fish?.countryID,
      existingContacts: _fish?.contacts,
    );

    final String? _email = ContactModel.getInitialContactValue(
      type: ContactType.email,
      countryID: _fish?.countryID,
      existingContacts: _fish?.contacts,
    );

    final String? _website = ContactModel.getInitialContactValue(
      type: ContactType.website,
      countryID: _fish?.countryID,
      existingContacts: _fish?.contacts,
    );

    _phoneController.text = _phone ?? '';
    _emailController.text = _email ?? '';
    _websiteController.text = _website ?? 'https://';

  }
  // --------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final List<String> _allBzTypesButtons = BzTyper.getBzTypesPhids(
      context: context,
      bzTypes: BzTyper.bzTypesList,
      pluralTranslation: false,
    );
    // --------------------
    final List<String> _selectedBzTypesPhids = BzTyper.getBzTypesPhids(
      context: context,
      bzTypes: _fish?.type == null ? [] : [_fish!.type!],
      pluralTranslation: false,
    );
    // --------------------
    final String? _instagramLink = _fish?.getInstagramLink();
    // --------------------
    return MainLayout(
      canSwipeBack: true,
      confirmButton: ConfirmButton(
        enAlignment: Alignment.bottomRight,
        confirmButtonModel: ConfirmButtonModel(
          firstLine: Verse.plain('Done'),
          onTap: () async {

            await Nav.goBack(
              context: context,
              passedData: _fish?.copyWith(
                contacts: ContactModel.bakeContactsAfterEditing(contacts: _fish?.contacts, countryID: _fish?.countryID),
              ),
            );

          }
        ),
      ),
      appBarRowWidgets: <Widget>[

        AppBarButton(
          icon: Iconz.gtInsta,
          isDisabled: _instagramLink == null,
          onTap: () async {

            blog('aaa');

            final bool _go = await Dialogs.confirmProceed(
              titleVerse: Verse.plain('Scrap Instagram profile ?'),
            );

            if (_go == true){

              final bool _urlIsValid = Formers.socialLinkValidator(
                url: _instagramLink,
                contactType: ContactType.instagram,
                isMandatory: true,
              ) == null;

              if (_urlIsValid == false){
                await Dialogs.topNotice(verse: Verse.plain('Not an Instagram Link'), color: Colorz.red255);
              }

              else if (_loading == false){

                if (mounted){
                  setState(() {
                    _loading = true;
                  });
                }
                blog('show dialog : ${widget.facebookAccessToken}');
                blog('_instagramLink : $_instagramLink');
                WaitDialog.showUnawaitedWaitDialog();

                final Map<String, dynamic>? _map = await GtInstaOps.scrapProfileByURL(
                  url: _instagramLink,
                  facebookAccessToken: widget.facebookAccessToken,
                  limit: 9,
                  // startAfterCursor: startAfterCursor,
                  // startBeforeCursor: startBeforeCursor,
                );

                if (_map?['error'] != null){
                  await Dialogs.topNotice(
                      verse: Verse.plain('Failed to get profile\n${GtInstaOps.extractProfileName(urlOrName: _instagramLink)}'),
                      color: Colorz.red255
                  );
                }

                if (TextCheck.stringContainsSubString(string: _map?['error']?['message'], subString: 'Application request limit reached')){
                  await Dialogs.centerNotice(
                    verse: Verse.plain('Max API calls limit Reached'),
                    color: Colorz.red255,
                  );
                }

                if (mounted){
                  setState(() {

                    final InstaProfile? _profile = InstaProfile.decipherInstaMap(
                        map: _map,
                        url: _instagramLink
                    );
                    _loading = false;

                    blog(_profile);


                    List<ContactModel> _contacts = ContactModel.bakeContactsAfterEditing(
                      contacts: _fish?.contacts,
                      countryID: _fish?.countryID,
                    );
                    _contacts = ContactModel.insertOrReplaceContacts(
                      contacts: _contacts,
                      contactsToReplace: _profile?.contacts,
                    );
                    blog('contacts after : $_contacts');


                    _idController.text = TextMod.idifyString(_profile?.profileName) ?? _fish?.id ?? '';
                    _nameController.text = _profile?.name ?? _fish?.name ?? '';
                    _bioController.text = _profile?.biography ?? _fish?.bio ?? '';
                    _fish = _fish?.copyWith(
                      id: _idController.text,
                      name: _nameController.text,
                      imageURL: _profile?.logo ?? _fish?.imageURL,
                      bio: _bioController.text,
                      contacts: ContactModel.prepareContactsForEditing(
                        countryID: _fish?.countryID,
                        contacts: _contacts,
                      ),
                    );

                    _definePhoneEmailWebsite();

                  });



                }

                await WaitDialog.closeWaitDialog();
              }

              else {
                blog('is loading');
              }

            }

          },
        ),

        AppBarButton(
          icon: Icons.print,
          onTap: (){

            blog(_fish);

          },
        ),

      ],
      child: Form(
        key: _formKey,
        child: FloatingList(
          padding: Stratosphere.stratosphereSandwich,
          columnChildren: <Widget>[

            /// ID
            BldrsTextFieldBubble(
              appBarType: AppBarType.non,
              textController: _idController,
              bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
                context: context,
                headlineVerse: Verse.plain('id'),
              ),
              initialText: _fish?.id,
              pasteFunction: (String? text) async {
                if (text != null){

                  final String _text = TextMod.idifyString(text)!;

                  setState(() {
                    _fish = _fish?.copyWith(
                      id: _text,
                    );
                  });
                  _idController.text = _text;
                }
              },
              onTextChanged: (String? text){

                setState(() {
                  _fish = _fish?.copyWith(
                    id: text,
                  );
                });

              },
              validator: (String? text){

                final FishModel? _fish = FishModel.getFishByID(
                  fishes: widget.allFishes,
                  id: text,
                );

                if (_fish != null){
                  return 'ID is used before';
                }

                else if (TextCheck.isEmpty(text) == true){
                  return "ID Can't be Empty";
                }
                else {
                  return null;
                }

              },
            ),

            /// NAME
            BldrsTextFieldBubble(
              appBarType: AppBarType.non,
              textController: _nameController,
              bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
                context: context,
                headlineVerse: Verse.plain('Name'),
              ),
              initialText: _fish?.name,
              pasteFunction: (String? text) async {
                if (text != null){
                  setState(() {
                    _fish = _fish?.copyWith(
                      name: text,
                    );
                  });
                  _nameController.text = text;
                }
              },
              onTextChanged: (String? text){

                setState(() {
                  _fish = _fish?.copyWith(
                    name: text,
                  );
                });

              },
              validator: (String? text){

                final FishModel? _fish = FishModel.getFishByName(
                  fishes: widget.allFishes,
                  name: text,
                );

                if (_fish != null){
                  return 'Name is used before';
                }
                else {
                  return null;
                }

              },
            ),

            /// BZ TYPE
            MultipleChoiceBubble(
              titleVerse: const Verse(
                id: 'phid_bz_entity_type',
                translate: true,
              ),
              buttonsVerses: Verse.createVerses(strings: _allBzTypesButtons, translate: true),
              selectedButtonsPhids: _selectedBzTypesPhids,
              inactiveButtons: const [],
              onButtonTap: (int index) {

                final BzType _selectedBzType = BzTyper.bzTypesList[index];

                setState(() {
                  _fish = _fish?.copyWith(
                    type: _selectedBzType,
                  );
                });

              },
            ),

            /// BZ ZONE
            ZoneSelectionBubble(
                zoneViewingEvent: ViewingEvent.admin,
                titleVerse: const Verse(
                  id: 'phid_hqCity',
                  translate: true,
                ),
                currentZone: _fish?.countryID == null ? null : ZoneModel(
                  countryID: _fish!.countryID!,
                  icon: Flag.getCountryIcon(_fish!.countryID!),
                  countryName: CountryModel.translateCountry(countryID: _fish!.countryID!, langCode: 'en'),
                ),
                depth: ZoneDepth.country,
                viewerZone: null,
                ignoreCensusAndStaging: true,
                onZoneChanged: (ZoneModel? zone) {

                  setState(() {
                    _fish = _fish?.copyWith(
                      countryID: zone?.countryID,
                    );
                  });

                }),

            /// PHONE
            Builder(
              builder: (context) {

                return ContactFieldEditorBubble(
                  textController: _phoneController,
                  formKey: null,
                  appBarType: AppBarType.non,
                  isFormField: true,
                  headerViewModel: BldrsBubbleHeaderVM.bake(
                    context: context,
                    headlineVerse: const Verse(
                      id: 'phid_phone',
                      translate: true,
                    ),
                  ),
                  keyboardTextInputType: TextInputType.phone,
                  keyboardTextInputAction: TextInputAction.next,
                  contactsArePublic: true,
                  validator: (String? text){

                    final String? _error = Formers.phoneValidator(
                      phone: text,
                      zoneModel: _fish?.countryID == null ? null : ZoneModel(
                        countryID: _fish!.countryID!,
                      ),
                      canValidate: true, //draft?.canValidate,
                      isMandatory: false,
                    );

                    if (_error != null){
                      return _error;
                    }

                    else {

                      final FishModel? _fish = FishModel.getFishByContactType(
                        fishes: widget.allFishes,
                        value: text,
                        contactType: ContactType.phone,
                      );

                      if (_fish != null){
                        return 'Phone is used before by ${_fish.name}';
                      }
                      else {
                        return null;
                      }

                    }

                  },
                  hintVerse: Verse.plain('${Flag.getCountryPhoneCode(_fish?.countryID) ?? '00'} 000 00 ...'),
                  contactType: ContactType.phone,
                  textOnChanged: (String? text) => onChangeBzContact(
                    contactType: ContactType.phone,
                    value: text,
                  ),
                );
              }
            ),

            /// EMAIL
            Builder(
              builder: (context) {

                return ContactFieldEditorBubble(
                  textController: _emailController,
                  formKey: null,
                  appBarType: AppBarType.basic,
                  isFormField: true,
                  headerViewModel: BldrsBubbleHeaderVM.bake(
                    context: context,
                    headlineVerse: const Verse(
                      id: 'phid_emailAddress',
                      translate: true,
                    ),
                    redDot: true,
                  ),
                  keyboardTextInputType: TextInputType.emailAddress,
                  keyboardTextInputAction: TextInputAction.next,
                  contactsArePublic: true,
                  validator: (String? text){

                    final String? _error = Formers.emailValidator(
                      email: text,
                      canValidate: true, //draft?.canValidate,
                    );

                    if (_error != null){
                      return _error;
                    }

                    else {

                      final FishModel? _fish = FishModel.getFishByContactType(
                        fishes: widget.allFishes,
                        value: text,
                        contactType: ContactType.email,
                      );

                      final bool _domainIsUsed = TextCheck.checkStringContainAnyOfSubStrings(
                        string: text,
                        subStrings: _allDomains,
                      );

                      if (_fish != null){
                        return 'Email is used before by ${_fish.name}';
                      }
                      else if (_domainIsUsed == true){
                        return 'Domain is previously used';
                      }
                      else {
                        return null;
                      }

                    }

                  },
                  textOnChanged: (String? text) => onChangeBzContact(
                    contactType: ContactType.email,
                    value: text,
                  ),
                  hintVerse: Verse.plain('bldr@bldrs.net'),
                );
              }
            ),

            /// WEBSITE
            Builder(
              builder: (context) {


                return ContactFieldEditorBubble(
                  textController: _websiteController,
                  headerViewModel: BldrsBubbleHeaderVM.bake(
                    context: context,
                    headlineVerse: const Verse(
                      id: 'phid_website',
                      translate: true,
                    ),
                  ),
                  formKey: null,
                  appBarType: AppBarType.basic,
                  isFormField: true,
                  contactsArePublic: true,
                  // keyboardTextInputType: TextInputType.url,
                  keyboardTextInputAction: TextInputAction.done,
                  bulletPoints: const <Verse>[
                    Verse(id: 'phid_optional_field', translate: true),
                  ],
                  // canPaste: true,
                  // autoValidate: true,
                  validator: (String? text){

                    final String? _error = Formers.webSiteValidator(
                      website: text,
                      isMandatory: Standards.bzWebsiteIsMandatory,
                      excludedDomains: <String>[
                        'facebook.com',
                        'linkedin.com',
                        'youtube.com',
                        'instagram.com',
                        'pinterest.com',
                        'pinterest.it',
                        'tiktok.com',
                        'twitter.com',
                      ],
                    );

                    if (_error != null){
                      return _error;
                    }
                    else {

                      final FishModel? _fish = FishModel.getFishByContactType(
                        fishes: widget.allFishes,
                        value: text,
                        contactType: ContactType.website,
                      );

                      final bool _domainIsUsed = TextCheck.checkStringContainAnyOfSubStrings(
                        string: text,
                        subStrings: _allDomains,
                      );

                      if (_fish != null){
                        return 'Website is used before by ${_fish.name}';
                      }
                      else if (_domainIsUsed == true){
                        return 'Domain is used before';
                      }
                      else {
                        return null;
                      }

                    }

                  },
                  textOnChanged: (String? text) => onChangeBzContact(
                    contactType: ContactType.website,
                    value: text,
                  ),
                );
              }
            ),

            /// FACEBOOK - INSTAGRAM - TWITTER - LINKEDIN - YOUTUBE - TIKTOK - SNAPCHAT
            SocialFieldEditorBubble(
              contacts: _fish?.contacts,
              onContactChanged: (ContactModel contact) => onChangeBzContact(
                contactType: contact.type!,
                value: contact.value,
              ),
              forbiddenLinks: FishModel.getAllSocialLinksFromFishes(
                fishes: widget.allFishes,
              ),
            ),

            /// BIO
            BldrsTextFieldBubble(
              appBarType: AppBarType.non,
              textController: _bioController,
              bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
                context: context,
                headlineVerse: Verse.plain('Bio'),
              ),
              initialText: _fish?.name,
              maxLines: 5,
              minLines: 3,
              pasteFunction: (String? text) async {
                if (text != null){
                  setState(() {
                    _fish = _fish?.copyWith(
                      bio: text,
                    );
                  });
                  _bioController.text = text;
                }
              },
              onTextChanged: (String? text){

                setState(() {
                  _fish = _fish?.copyWith(
                    bio: text,
                  );
                });

              },
            ),

            /// IMAGE URL
            Builder(
              builder: (context) {

                final bool _urlIsValid = Formers.webSiteValidator(website: _fish?.imageURL, isMandatory: false) == null;

                return BldrsBox(
                  height: 50,
                  width: Bubble.bubbleWidth(context: context),
                  icon: _fish?.imageURL ?? Iconz.dvBlankSVG,
                  verse: Verse.plain(_fish?.imageURL ?? 'paste url ...'),
                  verseCentered: false,
                  verseScaleFactor: 0.5,
                  verseWeight: VerseWeight.thin,
                  verseItalic: true,
                  verseMaxLines: 3,
                  color: _urlIsValid == true ? Colorz.white10 : Colorz.bloodTest,
                  bubble: false,
                  onTap: () async {

                    final String? _pasted = await TextClipBoard.paste();

                    if (TextCheck.isEmpty(_pasted) == true){
                      await Dialogs.topNotice(verse: Verse.plain('No URL is copied'), color: Colorz.red255);
                    }
                    else if (Formers.webSiteValidator(website: _pasted, isMandatory: true) != null){
                      await Dialogs.topNotice(verse: Verse.plain('Not a web link'), color: Colorz.red255);
                    }
                    else {

                      setState(() {
                        _fish = _fish?.copyWith(
                          imageURL: _pasted,
                        );
                      });

                    }

                  },
                );
              }
            ),

          ],
        ),
      ),
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
