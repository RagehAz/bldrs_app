import 'package:bldrs/a_models/b_bz/author/author_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/b_views/f_bz/d_author_search_screen/aa_author_search_screen_view.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/f_bz/d_author_search_screen/x_author_search_controllers.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:flutter/material.dart';

class AuthorSearchScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const AuthorSearchScreen({
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  State<AuthorSearchScreen> createState() => _AuthorSearchScreenState();
  /// --------------------------------------------------------------------------
}

class _AuthorSearchScreenState extends State<AuthorSearchScreen> {
  // -----------------------------------------------------------------------------
  final ValueNotifier<List<UserModel>> _foundUsers = ValueNotifier(null);
  final ValueNotifier<bool> _isSearching = ValueNotifier(false);
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false); /// tamam disposed
  // --------------------
  /*
  Future<void> _triggerLoading({@required bool setTo}) async {
    setNotifier(
      notifier: _loading,
      mounted: mounted,
      value: setTo,
      addPostFrameCallBack: false,
    );
  }
  */
  // -----------------------------------------------------------------------------
  /// TAMAM
  @override
  void dispose() {
    _foundUsers.dispose();
    _isSearching.dispose();
    _loading.dispose();
    super.dispose();
  }
  // --------------------
  Future<void> _onSearch(String text) async {

    final BzModel _bzModel = BzzProvider.proGetActiveBzModel(
      context: context,
      listen: false,
    );

    final List<String> _bzAuthorsIDs = AuthorModel.getAuthorsIDsFromAuthors(
      authors: _bzModel.authors,
    );

    await onSearchUsers(
      text: text,
      loading: _loading,
      foundUsers: _foundUsers,
      isSearching: _isSearching,
      userIDsToExclude: _bzAuthorsIDs,
    );

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final BzModel _bzModel = BzzProvider.proGetActiveBzModel(
      context: context,
      listen: true,
    );

    return MainLayout(
      skyType: SkyType.black,
      pageTitleVerse: const Verse(
        text: 'phid_add_author_to_the_team',
        translate: true,
      ),
      searchHintVerse: const Verse(
        text: 'phid_search_user_by_name',
        translate: true,
      ),
      pyramidsAreOn: true,
      // appBarBackButton: true,
      appBarType: AppBarType.search,
      onSearchSubmit: _onSearch,
      onSearchChanged: _onSearch,
      loading: _loading,
      layoutWidget: AuthorSearchScreenView(
        bzModel: _bzModel,
        foundUsers: _foundUsers,
        isSearching: _isSearching,
        isLoading: _loading,
      ),

    );

  }
  // -----------------------------------------------------------------------------
}
