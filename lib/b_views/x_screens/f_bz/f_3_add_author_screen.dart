import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/y_views/f_bz/f_4_bz_add_author_screen_view.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/unfinished_night_sky.dart';
import 'package:bldrs/c_controllers/f_bz_controllers/author_invitations_controller.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';

class AddAuthorScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const AddAuthorScreen({
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  /// --------------------------------------------------------------------------
  @override
  State<AddAuthorScreen> createState() => _AddAuthorScreenState();
/// --------------------------------------------------------------------------
}

class _AddAuthorScreenState extends State<AddAuthorScreen> {
// -----------------------------------------------------------------------------
  final ValueNotifier<List<UserModel>> _foundUsers = ValueNotifier(null);
  final ValueNotifier<bool> _isSearching = ValueNotifier(false);
// -----------------------------------------------------------------------------
  /// --- LOCAL LOADING BLOCK
  final ValueNotifier<bool> _loading = ValueNotifier(false); /// tamam disposed
// -----------------------------------
  Future<void> _triggerLoading() async {
    _loading.value = !_loading.value;
    blogLoading(
      loading: _loading.value,
      callerName: 'AddAuthorScreen',
    );
  }
// -----------------------------------------------------------------------------
  Future<void> _onSearch(String text) async {

    await onSearchUsers(
      context: context,
      text: text,
      loading: _loading,
      foundUsers: _foundUsers,
      isSearching: _isSearching,
      excludeMyself: true,
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
      zoneButtonIsOn: false,
      pageTitle: 'Add new Author',
      searchHint: 'Search Users by name',
      pyramidsAreOn: true,
      // appBarBackButton: true,
      appBarType: AppBarType.search,
      onSearchSubmit: _onSearch,
      onSearchChanged: _onSearch,
      layoutWidget: AddAuthorScreenView(
        bzModel: _bzModel,
        foundUsers: _foundUsers,
        isSearching: _isSearching,
        isLoading: _loading,
      ),

    );
  }
}
