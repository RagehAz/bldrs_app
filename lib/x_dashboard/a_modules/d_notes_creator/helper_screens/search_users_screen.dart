import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/z_components/app_bar/bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/unfinished_night_sky.dart';
import 'package:bldrs/b_views/z_components/loading/loading.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/b_views/z_components/user_profile/user_button.dart';
import 'package:bldrs/c_controllers/f_bz_controllers/authors_pages_controller.dart';
import 'package:bldrs/e_db/fire/ops/auth_ops.dart' as AuthFireOps;
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;

class SearchUsersScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const SearchUsersScreen({
    @required this.excludeMyself,
    this.multipleSelection = false,
    this.selectedUsers,
    this.onUserTap,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final bool multipleSelection;
  final List<UserModel> selectedUsers;
  final ValueChanged<UserModel> onUserTap;
  final bool excludeMyself;
  /// --------------------------------------------------------------------------
  @override
  _SearchUsersScreenState createState() => _SearchUsersScreenState();
/// --------------------------------------------------------------------------
}

class _SearchUsersScreenState extends State<SearchUsersScreen> {
  // -----------------------------------------------------------------------------
  final ValueNotifier<List<UserModel>> _foundUsers = ValueNotifier(null);
  ValueNotifier<List<UserModel>> _selectedUsers;
  final ValueNotifier<bool> _isSearching = ValueNotifier(false);
// -----------------------------------------------------------------------------
  /// --- LOCAL LOADING BLOCK
  final ValueNotifier<bool> _loading = ValueNotifier(false); /// tamam disposed
// -----------------------------------
  @override
  void initState() {
    super.initState();
    _selectedUsers = ValueNotifier<List<UserModel>>(widget.selectedUsers);
  }
// -----------------------------------------------------------------------------
  /*
  Future<void> _triggerLoading() async {
    _loading.value = !_loading.value;
    blogLoading(
      loading: _loading.value,
      callerName: 'AddAuthorScreen',
    );
  }
   */
// -----------------------------------------------------------------------------
  Future<void> _onSearch(String text) async {

    await onSearchUsers(
      context: context,
      text: text,
      loading: _loading,
      foundUsers: _foundUsers,
      isSearching: _isSearching,
      excludeMyself: widget.excludeMyself,
    );

  }
// -----------------------------------------------------------------------------
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
        final bool _isSelected = UserModel.checkUsersContainThisUser(
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
// -----------------------------------------------------------------------------
  void _onBack(){

    Nav.goBack(context, passedData: _selectedUsers.value);

  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return MainLayout(
      skyType: SkyType.black,
      sectionButtonIsOn: false,
      zoneButtonIsOn: false,
      pageTitle: 'Search Users',
      searchHint: 'Search Users by name',
      pyramidsAreOn: true,
      appBarType: AppBarType.search,
      onSearchSubmit: _onSearch,
      onSearchChanged: _onSearch,
      loading: _loading,
      onBack: _onBack,
      layoutWidget: ListView(
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
                      return ValueListenableBuilder(
                          valueListenable: _foundUsers,
                          builder: (_, List<UserModel> foundUsers, Widget child){

                            /// FOUND USERS
                            if (Mapper.canLoopList(foundUsers) == true){

                              return ValueListenableBuilder(
                                valueListenable: _selectedUsers,
                                builder: (_, List<UserModel> selectedUsers, Widget child){

                                  return SizedBox(
                                    width: Scale.superScreenWidth(context),
                                    height: Scale.superScreenHeight(context),
                                    child: ListView.builder(
                                      itemCount: foundUsers.length,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemBuilder: (_, index){

                                        final UserModel _user = foundUsers[index];
                                        final bool _isSelected = UserModel.checkUsersContainThisUser(
                                          usersModels: selectedUsers,
                                          userModel: _user,
                                        );
                                        final bool _isMe = _user.id == AuthFireOps.superUserID();

                                        return UserTileButton(
                                          boxWidth: BldrsAppBar.width(context),
                                          userModel: _user,
                                          color: _isSelected == true ? Colorz.green255
                                              :
                                          _isMe == true ? Colorz.black255
                                              :
                                          null,
                                          onUserTap: () => onUserTap(_user),
                                        );

                                      },
                                    ),
                                  );

                                },
                              );

                            }

                            /// NO USERS FOUND
                            else {
                              return const SuperVerse(
                                verse: 'No users found with this name',
                              );
                            }

                          }
                      );
                    }

                  }

                  /// NOT SEARCHING
                  else {
                    return const SizedBox();
                  }

                },
              );


            },
          ),

        ],
      ),

    );

  }

}
