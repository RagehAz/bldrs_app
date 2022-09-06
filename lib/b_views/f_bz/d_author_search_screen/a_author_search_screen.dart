import 'package:bldrs/a_models/bz/author_model.dart';
import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
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
  Future<void> _triggerLoading({bool setTo}) async {
    if (mounted == true){
      if (setTo == null){
        _loading.value = !_loading.value;
      }
      else {
        _loading.value = setTo;
      }
      blogLoading(loading: _loading.value, callerName: 'SearchForAuthorScreen',);
    }
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
      context: context,
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
      sectionButtonIsOn: false,
      pageTitleVerse: '##Add new Author',
      searchHintVerse: '##Search Users by name',
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
