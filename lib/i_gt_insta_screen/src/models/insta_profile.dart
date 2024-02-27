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
    required this.category,
    required this.followers,
    required this.posts,
    this.afterCursor,
    this.beforeCursor,
  });
  // --------------------
  final String id;
  final String? name;
  final String? logo;
  final String? biography;
  final String? category;
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
    String? logo,
    String? biography,
    String? category,
    int? followers,
    List<ContactModel>? contacts,
    List<InstaPost>? posts,
  }){
    return InstaProfile(
      id: id ?? this.id,
      name: name ?? this.name,
      logo: logo ?? this.logo,
      contacts: contacts ?? this.contacts,
      biography: biography ?? this.biography,
      category: category ?? this.category,
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

        final String? _website = map['business_discovery']?['website'];
        final ContactType? _linkType = ContactModel.concludeContactTypeByURLDomain(url: _website);

        _output = InstaProfile(
          id: map['business_discovery']?['ig_id']?.toString() ?? 'x',
          name: map['business_discovery']?['name'],
          biography: map['business_discovery']?['biography'],
          followers: map['business_discovery']?['followers_count'],
          category: map['business_discovery']?['category_name'],
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

            if (_website != null && _linkType != null && _linkType != ContactType.instagram)
              ContactModel(
                type: _linkType,
                value: _website,
              ),

          ],
        );

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> _getPostsUrlsFromInstaMap(Map<String, dynamic>? map){
    final List<String> _output = [];

    if (map != null){

      final List<Map<String, dynamic>> _postsMaps = Mapper.getMapsFromDynamics(
          dynamics: map['business_discovery']?['media']?['data'],
      );

      if (Lister.checkCanLoop(_postsMaps) == true){

        for (final Map<String, dynamic> map in _postsMaps){

          final String? mediaURL = map['media_url'];

          if (mediaURL != null){
            _output.add(mediaURL);
          }

        }

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  ///
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
        pro1.logo == pro2.logo &&
        ContactModel.checkContactsListsAreIdentical(contacts1: pro1.contacts, contacts2: pro2.contacts) == true &&
        pro1.biography == pro2.biography &&
        Lister.checkListsAreIdentical(list1: pro1.posts, list2: pro2.posts) == true &&
        pro1.followers == pro2.followers &&
        pro1.category == pro2.category &&
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
          logo: $logo,
          contacts: $contacts,
          biography: $biography,
          followers: $followers,
          postsURLs: $posts,
          category: $category,
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
      logo.hashCode^
      contacts.hashCode^
      biography.hashCode^
      posts.hashCode^
      category.hashCode^
      afterCursor.hashCode^
      beforeCursor.hashCode^
      followers.hashCode;
  // -----------------------------------------------------------------------------
}
