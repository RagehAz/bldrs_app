part of fish_tank;

@immutable
class InstaProfile {
  // -----------------------------------------------------------------------------
  const InstaProfile({
    required this.id,
    required this.name,
    required this.profileName,
    required this.logo,
    required this.contacts,
    required this.biography,
    required this.followers,
    required this.posts,
    this.afterCursor,
    this.beforeCursor,
  });
  // --------------------
  final String id;
  final String? name;
  final String? profileName;
  final String? logo;
  final String? biography;
  final int? followers;
  final List<ContactModel> contacts;
  final List<InstaPost> posts;
  final String? afterCursor;
  final String? beforeCursor;
  // -----------------------------------------------------------------------------

  ///  CLONING

  // --------------------
  /// TESTED : WORKS PERFECT
  InstaProfile copyWith({
    String? id,
    String? name,
    String? profileName,
    String? logo,
    String? biography,
    int? followers,
    List<ContactModel>? contacts,
    List<InstaPost>? posts,
  }){
    return InstaProfile(
      id: id ?? this.id,
      name: name ?? this.name,
      profileName: profileName ?? this.profileName,
      logo: logo ?? this.logo,
      contacts: contacts ?? this.contacts,
      biography: biography ?? this.biography,
      followers: followers ?? this.followers,
      posts: posts ?? this.posts,
    );
  }
  // -----------------------------------------------------------------------------

  ///  CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static InstaProfile? decipherInstaMap({
    required Map<String, dynamic>? map,
    required String? url,
  }){
    InstaProfile? _output;

    if (map != null && TextCheck.isEmpty(url) == false){

      final String? _name = map['business_discovery']?['name'];

      if (_name != null){

        final String? contact = map['business_discovery']?['website'];
        final ContactType? _linkType = ContactModel.concludeContactTypeByURLDomain(url: contact);

        _output = InstaProfile(
          id: map['business_discovery']?['ig_id']?.toString() ?? 'x',
          name: map['business_discovery']?['name'],
          profileName: map['profileName'],
          biography: map['business_discovery']?['biography'],
          followers: map['business_discovery']?['followers_count'],
          logo: map['business_discovery']?['profile_picture_url'],
          posts: InstaPost.decipherPosts(
            mediaMap: map['business_discovery']?['media'],
          ),
          afterCursor: map['business_discovery']?['media']?['paging']?['cursors']?['after'],
          beforeCursor: map['business_discovery']?['media']?['paging']?['cursors']?['before'],
          contacts: <ContactModel>[

            ContactModel(
              type: ContactType.instagram,
              value: url,
            ),

            if (
                contact != null &&
                _linkType != null &&
                _linkType != ContactType.instagram &&
                _linkType != ContactType.phone
            )
              ContactModel(
                type: _linkType,
                value: contact,
              ),

            if (
                contact != null &&
                _linkType != null &&
                _linkType == ContactType.phone &&
                TextCheck.stringContainsSubString(string: contact, subString: 'wa.me')
            )
              ContactModel(
                type: _linkType,
                value: TextMod.removeTextBeforeFirstSpecialCharacter(
                    specialCharacter: '/',
                    text: TextMod.removeTextBeforeFirstSpecialCharacter(
                      specialCharacter: 'wa.me',
                      text: contact,
                    ),
                ),
              ),


          ],
        );

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  String? getInstagramURL(){
    return ContactModel.getValueFromContacts(
      contacts: contacts,
      contactType: ContactType.instagram,
    );
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
        pro1.profileName == pro2.profileName &&
        pro1.logo == pro2.logo &&
        ContactModel.checkContactsListsAreIdentical(contacts1: pro1.contacts, contacts2: pro2.contacts) == true &&
        pro1.biography == pro2.biography &&
        Lister.checkListsAreIdentical(list1: pro1.posts, list2: pro2.posts) == true &&
        pro1.followers == pro2.followers &&
        pro1.afterCursor == pro2.afterCursor &&
        pro1.beforeCursor == pro2.beforeCursor
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
          profileName: $profileName,
          logo: $logo,
          contacts: $contacts,
          biography: $biography,
          followers: $followers,
          postsURLs: $posts,
          afterCursor: $afterCursor,
          beforeCursor: $beforeCursor,
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
      profileName.hashCode^
      logo.hashCode^
      contacts.hashCode^
      biography.hashCode^
      posts.hashCode^
      afterCursor.hashCode^
      beforeCursor.hashCode^
      followers.hashCode;
  // -----------------------------------------------------------------------------
}
