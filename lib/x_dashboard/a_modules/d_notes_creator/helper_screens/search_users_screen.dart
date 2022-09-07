import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/loading/loading.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/f_bz/d_author_search_screen/x_author_search_controllers.dart';
import 'package:bldrs/e_db/ldb/ops/user_ldb_ops.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/x_dashboard/a_modules/d_notes_creator/components/users_tile_buttons_list.dart';
import 'package:flutter/material.dart';

class SearchUsersScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const SearchUsersScreen({
    @required this.userIDsToExcludeInSearch,
    this.multipleSelection = false,
    this.selectedUsers,
    this.onUserTap,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final bool multipleSelection;
  final List<UserModel> selectedUsers;
  final ValueChanged<UserModel> onUserTap;
  final List<String> userIDsToExcludeInSearch;
  /// --------------------------------------------------------------------------
  @override
  _SearchUsersScreenState createState() => _SearchUsersScreenState();
  /// --------------------------------------------------------------------------
}

class _SearchUsersScreenState extends State<SearchUsersScreen> {
  // -----------------------------------------------------------------------------
  final ValueNotifier<List<UserModel>> _foundUsers = ValueNotifier(null);
  final ValueNotifier<List<UserModel>> _historyUsers = ValueNotifier(<UserModel>[]);
  ValueNotifier<List<UserModel>> _selectedUsers;
  final ValueNotifier<bool> _isSearching = ValueNotifier(false);
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void> _triggerLoading({bool setTo}) async {
    if (mounted == true){
      if (setTo == null){
        _loading.value = !_loading.value;
      }
      else {
        _loading.value = setTo;
      }
      blogLoading(loading: _loading.value, callerName: 'SearchUsersScreen',);
    }
  }
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _selectedUsers = ValueNotifier<List<UserModel>>(widget.selectedUsers);
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      _triggerLoading().then((_) async {

        final List<UserModel> _history = await UserLDBOps.readAll();
        _historyUsers.value = _history;

        await _triggerLoading();
      });

      _isInit = false;
    }
    super.didChangeDependencies();
  }
  // --------------------
  /// TAMAM
  @override
  void dispose() {
    _historyUsers.dispose();
    _loading.dispose();
    _foundUsers.dispose();
    _isSearching.dispose();
    _selectedUsers.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  Future<void> _onSearch(String text) async {

    await onSearchUsers(
      context: context,
      text: text,
      loading: _loading,
      foundUsers: _foundUsers,
      isSearching: _isSearching,
      userIDsToExclude: widget.userIDsToExcludeInSearch,
    );

    final List<UserModel> _history = UserModel.addUniqueUsersToUsers(
      usersToGet: _historyUsers.value,
      usersToAdd: _foundUsers.value,
    );
    _historyUsers.value = _history;

    await UserLDBOps.insertUsers(_history);

  }
  // --------------------
  Future<void> onUserTap(UserModel userModel) async {

    /// WHEN SELECTION FUNCTION IS HANDLED INTERNALLY
    if (widget.onUserTap == null){

      /// CAN SELECT MULTIPLE USERS
      if (widget.multipleSelection == true){
        final List<UserModel> _newList = UserModel.addOrRemoveUserToUsers(
          usersModels: _selectedUsers.value,
          userModel: userModel,
        );
        _selectedUsers.value = _newList;
      }

      /// CAN SELECT ONLY ONE USER
      else {
        final bool _isSelected = UserModel.checkUsersContainUser(
            usersModels: _selectedUsers.value,
            userModel: userModel
        );

        if (_isSelected == true){
          _selectedUsers.value = null;
        }
        else {
          _selectedUsers.value = <UserModel>[userModel];
        }

      }

    }

    /// WHEN FUNCTION IS EXTERNALLY PASSED
    else {
      widget.onUserTap(userModel);
    }

  }
  // --------------------
  void _onBack(){

    Nav.goBack(
      context: context,
      invoker: 'SearchUsersScreen.onBack',
      passedData: _selectedUsers.value,
    );

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return MainLayout(
      skyType: SkyType.black,
      sectionButtonIsOn: false,
      pageTitleVerse:  '##Search Users',
      searchHintVerse:  '##Search Users by name',
      pyramidsAreOn: true,
      appBarType: AppBarType.search,
      onSearchSubmit: _onSearch,
      onSearchChanged: _onSearch,
      loading: _loading,
      onBack: _onBack,
      layoutWidget: ListView(
        physics: const BouncingScrollPhysics(),
        children: <Widget>[

          const Stratosphere(bigAppBar: true),

          ValueListenableBuilder(
            valueListenable: _isSearching,
            builder: (_, bool _isSearching, Widget childA){

              return ValueListenableBuilder(
                valueListenable: _loading,
                builder: (_, bool _isLoading, Widget childB){

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
