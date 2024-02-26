part of fish_tank;

@immutable
class InstaProfile {
  // -----------------------------------------------------------------------------
  const InstaProfile({
    required this.id,
    required this.name,
    required this.logo,
    required this.contacts,
    required this.biography,
    required this.followers,
  });
  // --------------------
  final String id;
  final String? name;
  final String? logo;
  final String? biography;
  final int? followers;
  final List<ContactModel> contacts;
  // -----------------------------------------------------------------------------

  ///  CLONING

  // --------------------
  /// TESTED : WORKS PERFECT
  InstaProfile copyWith({
    String? id,
    String? name,
    String? logo,
    String? biography,
    int? followers,
    List<ContactModel>? contacts,
  }){
    return InstaProfile(
      id: id ?? this.id,
      name: name ?? this.name,
      logo: logo ?? this.logo,
      contacts: contacts ?? this.contacts,
      biography: biography ?? this.biography,
      followers: followers ?? this.followers,
    );
  }
  // -----------------------------------------------------------------------------

  ///  CYPHERS

  // --------------------
  ///
  static InstaProfile? decipherInstaMap({
    required Map<String, dynamic>? map,
    required String? url,
  }){
    InstaProfile? _output;

    if (map != null && TextCheck.isEmpty(url) == false){

      final String? _website = map['business_discovery']?['website'];
      final ContactType? _linkType = ContactModel.concludeContactTypeByURLDomain(url: _website);

      _output = InstaProfile(
        id: map['business_discovery']?['ig_id']?.toString() ?? 'x',
        name: map['business_discovery']?['name'],
        biography: map['business_discovery']?['biography'],
        followers: map['business_discovery']?['followers_count'],
        logo: map['business_discovery']?['profile_picture_url'],
        contacts: <ContactModel>[

          ContactModel(
            type: ContactType.instagram,
            value: url,
          ),

          if (_website != null && _linkType != null && _linkType != ContactType.instagram)
            ContactModel(
              type: _linkType,
              value: _website,
            ),

        ],
      );

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// EQUALITY

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkProfilesAreIdentical({
    required InstaProfile? pro1,
    required InstaProfile? pro2,
  }){
    bool _identical = false;

    if (pro1 == null && pro2 == null){
      _identical = true;
    }

    else if (pro1 != null && pro2 != null){

      if (
        pro1.id == pro2.id &&
        pro1.name == pro2.name &&
        pro1.logo == pro2.logo &&
        ContactModel.checkContactsListsAreIdentical(contacts1: pro1.contacts, contacts2: pro2.contacts) == true &&
        pro1.biography == pro2.biography &&
        pro1.followers == pro2.followers
      ){
        _identical = true;
      }

    }

    return _identical;
  }
  // -----------------------------------------------------------------------------

  /// OVERRIDES

  // --------------------
  @override
  String toString() =>
      '''
       InstaProfile(
          id: $id,
          name: $name,
          logo: $logo,
          contacts: $contacts,
          biography: $biography,
          followers: $followers,
       )  
       ''';
  // --------------------
  @override
  bool operator == (Object other){

    if (identical(this, other)) {
      return true;
    }

    bool _areIdentical = false;
    if (other is InstaProfile){
      _areIdentical = checkProfilesAreIdentical(
        pro1: this,
        pro2: other,
      );
    }

    return _areIdentical;
  }
  // --------------------
  @override
  int get hashCode =>
      id.hashCode^
      name.hashCode^
      logo.hashCode^
      contacts.hashCode^
      biography.hashCode^
      followers.hashCode;
  // -----------------------------------------------------------------------------
}
