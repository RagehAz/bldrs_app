import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/b_views/f_bz/d_author_search_screen/x_author_search_controllers.dart';
import 'package:bldrs/b_views/z_components/buttons/user_buttons/users_tile_buttons_list.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:basics/bldrs_theme/night_sky/night_sky.dart';
import 'package:bldrs/b_views/z_components/loading/loading.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/c_protocols/user_protocols/ldb/user_ldb_ops.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:basics/layouts/nav/nav.dart';
import 'package:bldrs/f_helpers/router/d_bldrs_nav.dart';
import 'package:flutter/material.dart';

class SearchUsersScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const SearchUsersScreen({
    required this.userIDsToExcludeInSearch,
    this.multipleSelection = false,
    this.selectedUsers,
    this.onUserTap,
    super.key
  });
  /// --------------------------------------------------------------------------
  final bool multipleSelection;
  final List<UserModel>? selectedUsers;
  final ValueChanged<UserModel>? onUserTap;
  final List<String> userIDsToExcludeInSearch;
  /// --------------------------------------------------------------------------
  @override
  _SearchUsersScreenState createState() => _SearchUsersScreenState();
  /// --------------------------------------------------------------------------
  static Future<UserModel?> selectUser() async {

    final List<UserModel>? _users = await BldrsNav.goToNewScreen(
        screen: const SearchUsersScreen(
          userIDsToExcludeInSearch: [],
          // multipleSelection: false,
        ),
    );

    if (Mapper.checkCanLoopList(_users) == true){
      return _users!.first;
    }
    else {
      return null;
    }

  }
  /// --------------------------------------------------------------------------
}

class _SearchUsersScreenState extends State<SearchUsersScreen> {
  // -----------------------------------------------------------------------------
  final ValueNotifier<List<UserModel>?> _foundUsers = ValueNotifier(null);
  final ValueNotifier<List<UserModel>> _historyUsers = ValueNotifier(<UserModel>[]);
  ValueNotifier<List<UserModel>?>? _selectedUsers;
  final ValueNotifier<bool> _isSearching = ValueNotifier(false);
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
  @override
  void initState() {
    super.initState();
    _selectedUsers = ValueNotifier<List<UserModel>?>(widget.selectedUsers);

    blog('users : ${_selectedUsers?.value?.length}');

  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {

    if (_isInit && mounted) {
      _isInit = false; // good

      _triggerLoading(setTo: true).then((_) async {

        final List<UserModel> _history = await UserLDBOps.readAll();

        blog('history : ${_history.length}');

        setNotifier(
            notifier: _historyUsers,
            mounted: mounted,
            value: _history,
        );

        await _triggerLoading(setTo: false);
      });

    }
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void dispose() {
    _historyUsers.dispose();
    _loading.dispose();
    _foundUsers.dispose();
    _isSearching.dispose();
    _selectedUsers?.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  Future<void> _onSearch(String? text) async {

    await onSearchUsers(
      text: text,
      loading: _loading,
      foundUsers: _foundUsers,
      isSearching: _isSearching,
      userIDsToExclude: widget.userIDsToExcludeInSearch,
      mounted: mounted,
    );

    final List<UserModel> _history = UserModel.addUniqueUsersToUsers(
      usersToGet: _historyUsers.value,
      usersToAdd: _foundUsers.value,
    );

    setNotifier(
        notifier: _historyUsers,
        mounted: mounted,
        value: _history,
    );

    await UserLDBOps.insertUsers(_history);

  }
  // --------------------
  Future<void> onUserTap(UserModel userModel) async {

    /// WHEN SELECTION FUNCTION IS HANDLED INTERNALLY
    if (widget.onUserTap == null){

      /// CAN SELECT MULTIPLE USERS
      if (widget.multipleSelection == true){

        final List<UserModel> _newList = UserModel.addOrRemoveUserToUsers(
          usersModels: _selectedUsers?.value,
          userModel: userModel,
        );

        setNotifier(notifier: _selectedUsers, mounted: mounted, value: _newList);

      }

      /// CAN SELECT ONLY ONE USER
      else {

        final bool _isSelected = UserModel.checkUsersContainUser(
            usersModels: _selectedUsers?.value,
            userModel: userModel
        );

        if (_isSelected == true){

          setNotifier(
              notifier: _selectedUsers,
              mounted: mounted,
              value: null,
          );

        }

        else {

          setNotifier(
              notifier: _selectedUsers,
              mounted: mounted,
              value:  <UserModel>[userModel],
          );

        }

      }

    }

    /// WHEN FUNCTION IS EXTERNALLY PASSED
    else {
      widget.onUserTap?.call(userModel);
    }

  }
  // --------------------
  Future<void> _onBack() async {

    await Nav.goBack(
      context: context,
      invoker: 'SearchUsersScreen.onBack',
      passedData: _selectedUsers?.value,
    );

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return MainLayout(
      canSwipeBack: true,
      skyType: SkyType.grey,
      title: const Verse(id: 'phid_search_users', translate: true),
      searchHintVerse: const Verse(id: 'phid_search_users_hint', translate: true),
      pyramidsAreOn: true,
      appBarType: AppBarType.search,
      onSearchSubmit: _onSearch,
      onSearchChanged: _onSearch,
      loading: _loading,
      onBack: _onBack,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: <Widget>[

          const Stratosphere(bigAppBar: true),

          ValueListenableBuilder(
            valueListenable: _isSearching,
            builder: (_, bool _isSearching, Widget? childA){

              return ValueListenableBuilder(
                valueListenable: _loading,
                builder: (_, bool _isLoading, Widget? childB){

                  /// SEARCHING
                  if (_isSearching == true){

                    /// LOADING
                    if (_isLoading == true){
                      return const Center(
                        child: Loading(loading: true),
                      );
                    }

                    /// NOT LOADING
                    else {

                      return UserTileButtonsList(
                          usersModels: _foundUsers,
                          selectedUsers: _selectedUsers,
                          onUserTap: onUserTap
                      );

                    }

                  }

                  /// NOT SEARCHING
                  else {
                    return UserTileButtonsList(
                        usersModels: _historyUsers,
                        selectedUsers: _selectedUsers,
                        onUserTap: onUserTap
                    );
                  }

                },
              );


            },
          ),

        ],
      ),

    );

  }
  // -----------------------------------------------------------------------------
}
