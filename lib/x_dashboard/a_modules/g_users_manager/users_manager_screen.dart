import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/unfinished_night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/x_dashboard/a_modules/g_users_manager/selected_user_page.dart';
import 'package:bldrs/x_dashboard/a_modules/g_users_manager/users_manager_controller.dart';
import 'package:bldrs/x_dashboard/a_modules/g_users_manager/users_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UsersManagerScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const UsersManagerScreen({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  _UsersManagerScreenState createState() => _UsersManagerScreenState();
/// --------------------------------------------------------------------------
}

class _UsersManagerScreenState extends State<UsersManagerScreen> {
// -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false); /// tamam disposed
// -----------
  Future<void> _triggerLoading({bool setTo}) async {
    if (mounted == true){
      if (setTo == null){
        _loading.value = !_loading.value;
      }
      else {
        _loading.value = setTo;
      }
      blogLoading(loading: _loading.value, callerName: 'xxxxx',);
    }
  }
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
  }
  // -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      _triggerLoading().then((_) async {

        await readMoreUsers(
          context: context,
          usersModels: _usersModels,
          scrollController: _scrollController,
          lastSnapshot: _lastSnapshot,
        );

      });

      _isInit = false;
    }
    super.didChangeDependencies();
  }
  // -----------------------------------------------------------------------------
  @override
  void dispose() {
    _loading.dispose();
    _lastSnapshot.dispose();
    _usersModels.dispose();
    _selectedUser.dispose();
    _pageController.dispose();
    _scrollController.dispose();
    super.dispose(); /// tamam
  }
// -----------------------------------------------------------------------------
  final ScrollController _scrollController = ScrollController(); /// tamam disposed
  final PageController _pageController = PageController(); /// tamam disposed
// -----------------------------------------------------------------------------
  final ValueNotifier<QueryDocumentSnapshot<Object>> _lastSnapshot = ValueNotifier(null); /// tamam disposed
  final ValueNotifier<List<UserModel>> _usersModels = ValueNotifier<List<UserModel>>(<UserModel>[]); /// tamam disposed
  final ValueNotifier<UserModel> _selectedUser = ValueNotifier<UserModel>(null); /// tamam disposed
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _screenHeight = Scale.superScreenHeightWithoutSafeArea(context);
    // final double _clearWidth = PageBubble.clearWidth(context);

    return MainLayout(
      key: const ValueKey<String>('UsersManagerScreen'),
      // loading: _loading,
      pageTitle: 'Users Manager',
      sectionButtonIsOn: false,
      appBarType: AppBarType.search,
      zoneButtonIsOn: false,
      skyType: SkyType.black,
      appBarRowWidgets: <Widget>[

        const Expander(),

        ValueListenableBuilder(
            valueListenable: _usersModels,
            builder: (_, List<UserModel> users, Widget child){

              return DreamBox(
                height: 40,
                verse: 'Load More',
                secondLine: 'showing ${users.length} users',
                verseScaleFactor: 0.7,
                secondLineScaleFactor: 0.9,
                margins: const EdgeInsets.symmetric(horizontal: 5),
                onTap: () => readMoreUsers(
                  context: context,
                  usersModels: _usersModels,
                  lastSnapshot: _lastSnapshot,
                  scrollController: _scrollController,
                ),
              );

            }
            ),

      ],

      layoutWidget: PageView(
        physics: const BouncingScrollPhysics(),
        controller: _pageController,
        children: <Widget>[

          /// USERS PAGE
          UsersPage(
            screenHeight: _screenHeight,
            selectedUser: _selectedUser,
            scrollController: _scrollController,
            pageController: _pageController,
            usersModels: _usersModels,
          ),

          /// SELECTED USER PAGE
          SelectedUserPage(
            screenHeight: _screenHeight,
            selectedUser: _selectedUser,
            usersModels: _usersModels,
            pageController: _pageController,
          ),

        ],
      ),
    );
  }
}
