import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/z_components/app_bar/progress_bar_swiper_model.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/sliders.dart';
import 'package:bldrs/x_dashboard/e_users_manager/aa_users_page.dart';
import 'package:bldrs/x_dashboard/e_users_manager/aaa_selected_user_page.dart';
import 'package:bldrs/x_dashboard/e_users_manager/x_users_manager_controller.dart';
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
  final ScrollController _scrollController = ScrollController();
  final PageController _pageController = PageController();
  final ValueNotifier<ProgressBarModel> _progressBarModel = ValueNotifier(null);
  // --------------------
  final ValueNotifier<QueryDocumentSnapshot<Object>> _lastSnapshot = ValueNotifier(null);
  final ValueNotifier<List<UserModel>> _usersModels = ValueNotifier<List<UserModel>>(<UserModel>[]);
  final ValueNotifier<UserModel> _selectedUser = ValueNotifier<UserModel>(null);
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
    }
  }
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    _progressBarModel.value = const ProgressBarModel(
      swipeDirection: SwipeDirection.freeze,
      index: 0,
      numberOfStrips: 2,
    );

  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      _triggerLoading(setTo: true).then((_) async {
        /// ---------------------------------------------------------0
        await readMoreUsers(
          context: context,
          usersModels: _usersModels,
          scrollController: _scrollController,
          lastSnapshot: _lastSnapshot,
        );
        /// ---------------------------------------------------------0
        await _triggerLoading(setTo: false);
      });

      _isInit = false;
    }
    super.didChangeDependencies();
  }
  // --------------------
  /// TAMAM
  @override
  void dispose() {
    _loading.dispose();
    _lastSnapshot.dispose();
    _usersModels.dispose();
    _selectedUser.dispose();
    _pageController.dispose();
    _scrollController.dispose();
    _progressBarModel.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _screenHeight = Scale.superScreenHeightWithoutSafeArea(context);
    // final double _clearWidth = PageBubble.clearWidth(context);

    return MainLayout(
      key: const ValueKey<String>('UsersManagerScreen'),
      // loading: _loading,
      pageTitleVerse: Verse.plain('Userss Manager'),
      sectionButtonIsOn: false,
      appBarType: AppBarType.search,
      skyType: SkyType.black,
      progressBarModel: _progressBarModel,
      loading: _loading,
      appBarRowWidgets: <Widget>[

        const Expander(),

        ValueListenableBuilder(
            valueListenable: _usersModels,
            builder: (_, List<UserModel> users, Widget child){

              return DreamBox(
                height: 40,
                verse: Verse.plain('Load More'),
                secondLine: Verse.plain('showing ${users.length} users'),
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
        onPageChanged: (int index) => ProgressBarModel.onSwipe(
          context: context,
          newIndex: index,
          progressBarModel: _progressBarModel,
        ),
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
// -----------------------------------------------------------------------------
}
