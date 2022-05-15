import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/page_bubble.dart';
import 'package:bldrs/b_views/z_components/layouts/unfinished_night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/e_db/fire/methods/cloud_functions.dart' as CloudFunctionz;
import 'package:bldrs/e_db/fire/methods/firestore.dart' as Fire;
import 'package:bldrs/e_db/fire/methods/paths.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/drafters/scrollers.dart' as Scrollers;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/x_dashboard/a_modules/g_users_manager/users_manager_controller.dart';
import 'package:bldrs/x_dashboard/b_widgets/user_button.dart';
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
  /// --- LOCAL LOADING BLOCK
  final ValueNotifier<bool> _loading = ValueNotifier(false); /// tamam disposed
// -----------------------------------
  Future<void> _triggerLoading() async {
    _loading.value = !_loading.value;
    blogLoading(
      loading: _loading.value,
      callerName: 'HomeScreen',
    );
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
    super.dispose();
    _loading.dispose();
  }
// -----------------------------------------------------------------------------
  final ScrollController _scrollController = ScrollController();
// -----------------------------------------------------------------------------
  final ValueNotifier<QueryDocumentSnapshot<Object>> _lastSnapshot = ValueNotifier(null);
  final ValueNotifier<List<UserModel>> _usersModels = ValueNotifier<List<UserModel>>(<UserModel>[]);
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _screenHeight = Scale.superScreenHeightWithoutSafeArea(context);

    return MainLayout(
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
        children: <Widget>[

          PageBubble(
              screenHeightWithoutSafeArea: _screenHeight,
              appBarType: AppBarType.search,
              child: ValueListenableBuilder(
                valueListenable: _usersModels,
                builder: (_, List<UserModel> users, Widget child){

                  return ListView.builder(
                    controller: _scrollController,
                    physics: const BouncingScrollPhysics(),
                    itemCount: users.length,
                    padding: const EdgeInsets.only(bottom: Ratioz.grandHorizon),
                    itemExtent: 70,
                    itemBuilder: (BuildContext context, int index) {

                      return DashboardUserButton(
                        width: PageBubble.clearWidth(context),
                        userModel: users[index],
                        index: index,
                        onDeleteUser: (UserModel userModel) => onDeleteUser(
                          userID: userModel.id,
                          usersModels: _usersModels,
                        ),
                      );

                    },
                  );

                },
              ),
          ),

          PageBubble(
            appBarType: AppBarType.search,
            screenHeightWithoutSafeArea: _screenHeight,
            child: Container(
              width: 100,
              height: 100,
              color: Colorz.bloodTest,
            ),
          ),
        ],
      ),
    );
  }
}
