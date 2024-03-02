part of fish_tank;

/// => TAMAM
@immutable
class FishModel {
  // -----------------------------------------------------------------------------
  const FishModel({
    required this.id,
    required this.name,
    required this.bio,
    required this.contacts,
    required this.type,
    required this.countryID,
    this.imageURL,
    this.emailIsFailing = false,
  });
  // --------------------
  final String? id;
  final String? name;
  final String? bio;
  final List<ContactModel> contacts;
  final BzType? type;
  final String? countryID;
  final String? imageURL;
  final bool emailIsFailing;
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  /// TESTED : WORKS PERFECT
  FishModel copyWith({
    String? id,
    String? name,
    String? bio,
    List<ContactModel>? contacts,
    BzType? type,
    String? countryID,
    String? imageURL,
    bool? emailIsFailing,
  }){
    return FishModel(
      id: id ?? this.id,
      name: name ?? this.name,
      bio: bio ?? this.bio,
      contacts: contacts ?? this.contacts,
      type: type ?? this.type,
      countryID: countryID ?? this.countryID,
      imageURL: imageURL ?? this.imageURL,
      emailIsFailing: emailIsFailing ?? this.emailIsFailing,
    );
  }
  // -----------------------------------------------------------------------------

  /// CIPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  Map<String, dynamic> toMap(){

    final List<ContactModel> _contacts = ContactModel.bakeContactsAfterEditing(
        contacts: contacts,
        countryID: countryID,
    );

    return {
      'id': id,
      'name': name,
      'bio': bio,
      'contacts': ContactModel.cipherContacts(_contacts),
      'type': BzTyper.cipherBzType(type),
      'countryID': countryID,
      'imageURL': imageURL,
      'emailIsFailing': emailIsFailing,
    };

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Map<String, dynamic>> cipherFishes({
    required List<FishModel> fishes,
  }){
    final List<Map<String, dynamic>> _output = [];

    if (Lister.checkCanLoop(fishes) == true){

      for (final FishModel fish in fishes){

        final Map<String, dynamic> _map = fish.toMap();

        _output.add(_map);

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static FishModel? decipher({
    required Map<String, dynamic>? map,
  }){

    if (map == null){
      return null;
    }

    else {

      return FishModel(
        id: map['id'],
        name: map['name'],
        bio: map['bio'],
        contacts: ContactModel.decipherContacts(map['contacts']),
        type: BzTyper.decipherBzType(map['type']),
        countryID: map['countryID'],
        imageURL: map['imageURL'],
        emailIsFailing: map['emailIsFailing'] ?? false,
      );

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<FishModel> decipherFishes({
    required List<Map<String, dynamic>> maps,
  }){
    final List<FishModel> _output = [];

    if (Lister.checkCanLoop(maps) == true){

      for (final Map<String, dynamic> map in maps){

        final Map<String, dynamic>? _cleaned = Mapper.cleanNullPairs(
          map: map,
        );
        final FishModel? _fish = decipher(map: _cleaned);

        if (_fish != null){
          _output.add(_fish);
        }

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  String? getInstagramLink(){
    return ContactModel.getValueFromContacts(
      contacts: contacts,
      contactType: ContactType.instagram,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static FishModel? getFishFromFishes({
    required List<FishModel> fishes,
    required String? id,
  }){
    FishModel? _output;

    if (id != null && Lister.checkCanLoop(fishes) == true){

      _output = fishes.firstWhereOrNull((FishModel fish) => fish.id == id);

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> getEmails({
    required List<FishModel> fishes,
  }){
    List<String> _output = [];

    if (Lister.checkCanLoop(fishes) == true){

      for (final FishModel fish in fishes){

        final List<String> _emails = ContactModel.getValuesByType(
          contacts: fish.contacts,
          contactType: ContactType.email,
        );

        _output = Stringer.addStringsToStringsIfDoNotContainThem(
            listToTake: _output,
            listToAdd: _emails,
        );

      }

    }

     return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> getContactsByType({
    required List<FishModel> fishes,
    required ContactType contactType,
  }){
    List<String> _output = [];

    if (Lister.checkCanLoop(fishes) == true){

      for (final FishModel fish in fishes){

        final List<String> _values = ContactModel.getValuesByType(
          contacts: fish.contacts,
          contactType: contactType,
        );

        _output = Stringer.addStringsToStringsIfDoNotContainThem(
          listToTake: _output,
          listToAdd: _values,
        );

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> getAllDomains({
    required List<FishModel> fishes,
  }){

    final List<String> _websites = getContactsByType(
      fishes: fishes,
      contactType: ContactType.website,
    );

    return Linker.extractWebsitesDomains(
      links: _websites,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<FishModel> getFishesByEmails({
    required List<FishModel> allFishes,
    required List<String> emails,
  }){
    final List<FishModel> _output = [];

    if (Lister.checkCanLoop(allFishes) == true && Lister.checkCanLoop(emails) == true){

      for (final String email in emails){

        final FishModel? _fish = getFishByContactType(
          fishes: allFishes,
          value: email,
          contactType: ContactType.email,
        );

        if (_fish != null){
          _output.add(_fish);
        }

      }


    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static FishModel? getFishByContactType({
    required List<FishModel> fishes,
    required String? value,
    required ContactType contactType,
  }){
    FishModel? _output;

    if (TextCheck.isEmpty(value) == false){

      for (final FishModel fish in fishes){

        String? _value = ContactModel.getValueFromContacts(
          contacts: fish.contacts,
          contactType: contactType,
        );

        final bool _isSocial = ContactModel.checkContactIsSocialMedia(contactType);
        if (_isSocial == true){
          _value = Linker.cleanURL(_value);
        }

        if (_value == value){
          _output = fish;
          break;
        }

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static FishModel? getFishByID({
    required List<FishModel> fishes,
    required String? id,
  }){
    FishModel? _output;

    if (TextCheck.isEmpty(id) == false){

      for (final FishModel fish in fishes){

        if (fish.id == id){
          _output = fish;
          break;
        }

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static FishModel? getFishByName({
    required List<FishModel> fishes,
    required String? name,
  }){
    FishModel? _output;

    if (TextCheck.isEmpty(name) == false){

      for (final FishModel fish in fishes){

        if (fish.name == name){
          _output = fish;
          break;
        }

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<FishModel> getFishesByPartName({
    required List<FishModel> fishes,
    required String? part,
  }){
    List<FishModel> _output = [];

    if (TextCheck.isEmpty(part) == false){

      for (final FishModel fish in fishes){

        final bool _is = TextCheck.stringContainsSubString(
            string: fish.name,
            subString: part
        );

        if (_is == true){
          _output = insertFishToFishes(
              fishes: _output,
              fish: fish
          );
        }

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> getAllSocialLinksFromFishes({
    required List<FishModel> fishes,
  }){
    List<String> _output = [];

    if (Lister.checkCanLoop(fishes) == false){

      for (final FishModel fish in fishes){

        final List<ContactModel> _socialContacts = ContactModel.filterSocialMediaContacts(fish.contacts);
        final List<String> _values = ContactModel.getAllValues(_socialContacts);
        _output = Stringer.addStringsToStringsIfDoNotContainThem(
            listToTake: _output,
            listToAdd: _values,
        );
      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static FishModel? getFishByWebsiteDomain({
    required List<FishModel> fishes,
    required String? domain,
  }){
    FishModel? _output;

    if (Lister.checkCanLoop(fishes) == true && TextCheck.isEmpty(domain) == false){

      for (final FishModel fish in fishes){

        final String? _fishWebsite = ContactModel.getValueFromContacts(
          contacts: fish.contacts,
          contactType: ContactType.website,
        );
        final String? _fishDomain = Linker.extractWebsiteDomain(link: _fishWebsite);

        final String? _thisDomain = Linker.extractWebsiteDomain(link: domain);

        final bool _isIt = TextCheck.stringContainsSubString(
            string: _fishDomain,
            subString: _thisDomain,
        );

        if (_isIt == true){
          _output = fish;
          break;
        }

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// FILTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<FishModel> filterByCountry({
    required List<FishModel> fishes,
    required String? countryID,
  }){
    List<FishModel> _output = [...fishes];

    if (countryID != null){

      _output = [];

      for (final FishModel fish in fishes){

        if (fish.countryID == countryID){

          _output.add(fish);

        }

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<FishModel> filterByCountries({
    required List<FishModel> fishes,
    required List<String> countriesIDs,
  }){
    List<FishModel> _output = [...fishes];

    if (Lister.checkCanLoop(countriesIDs) == true){

      _output = [];

      for (final FishModel fish in fishes){

        final bool _withUs = Stringer.checkStringsContainString(
            strings: countriesIDs,
            string: fish.countryID
        );

        if (_withUs == true){
          _output.add(fish);
        }

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<FishModel> filterByBzType({
    required List<FishModel> fishes,
    required BzType? bzType,
  }){
    List<FishModel> _output = [...fishes];

    if (bzType != null){

      _output = [];

      for (final FishModel fish in fishes){

        if (fish.type == bzType){

          _output.add(fish);

        }

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<FishModel> filterByContactType({
    required List<FishModel> fishes,
    required ContactType? contactType,
  }){
    List<FishModel> _output = [...fishes];

    if (contactType != null){

      _output = [];

      for (final FishModel fish in fishes){

        final ContactModel? _contact = ContactModel.getContactFromContacts(
            contacts: fish.contacts,
            type: contactType,
        );

        if (_contact != null){
          _output.add(fish);
        }

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// LIST MODIFIERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<FishModel> insertFishToFishes({
    required List<FishModel> fishes,
    required FishModel? fish,
  }){
    final List<FishModel> _output = [...fishes];

    if (fish != null){

      final FishModel? _found = getFishFromFishes(
          fishes: fishes,
          id: fish.id,
      );

      if (_found == null){
        _output.add(fish);
      }
      else {
        final int _index = _output.indexWhere((element) => element.id == fish.id);
        _output.removeAt(_index);
        _output.insert(_index, fish);
      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<FishModel> insertFishesToFishes({
    required List<FishModel> listToTake,
    required List<FishModel> listToAdd,
  }){
    List<FishModel> _output = [...listToTake];

    if (Lister.checkCanLoop(listToAdd) == true){

      for (final FishModel fish in listToAdd){

        _output = insertFishToFishes(
          fishes: _output,
          fish: fish,
        );

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<FishModel> removeFish({
    required List<FishModel> fishes,
    required FishModel? fish,
  }){

    final List<FishModel> _output = [...fishes];

    if (fish != null && Lister.checkCanLoop(fishes) == true){

      final FishModel? _found = getFishFromFishes(
        fishes: fishes,
        id: fish.id,
      );

      if (_found != null){
        final int _index = _output.indexWhere((element) => element.id == fish.id);
        _output.removeAt(_index);
      }

    }

    return _output;

  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkFishesContainFish({
    required List<FishModel> fishes,
    required FishModel fish,
  }){
    bool _output = false;
    for (final FishModel f in fishes){

      if (f.id == fish.id){
        _output = true;
        break;
      }

    }
    return _output;
  }
  // -----------------------------------------------------------------------------

  /// EQUALITY

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkFishesAreIdentical({
    required FishModel? fish1,
    required FishModel? fish2,
  }){

    return Mapper.checkMapsAreIdentical(
        map1: fish1?.toMap(),
        map2: fish2?.toMap(),
    );

  }
  // -----------------------------------------------------------------------------

  /// OVERRIDES

  // --------------------
  @override
  String toString(){

    final String _text =
    '''
    FishModel(
      id: $id,
      name: $name,
      bio: $bio,
      contacts: $contacts,
      type: $type,
      countryID: $countryID,
      imageURL: $imageURL,
      emailIsFailing: $emailIsFailing,
    );
    ''';

    return _text;
  }
  // --------------------
  @override
  bool operator == (Object other){

    if (identical(this, other)) {
      return true;
    }

    bool _areIdentical = false;
    if (other is FishModel){
      _areIdentical = checkFishesAreIdentical(
        fish1: this,
        fish2: other,
      );
    }

    return _areIdentical;
  }
  // --------------------
  @override
  int get hashCode =>
      id.hashCode^
      name.hashCode^
      bio.hashCode^
      contacts.hashCode^
      type.hashCode^
      imageURL.hashCode^
      emailIsFailing.hashCode^
      countryID.hashCode;
// -----------------------------------------------------------------------------
}
