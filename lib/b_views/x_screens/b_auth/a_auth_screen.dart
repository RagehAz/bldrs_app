import 'package:bldrs/b_views/x_screens/b_auth/aa_auth_screen_view.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const AuthScreen({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  _AuthScreenState createState() => _AuthScreenState();
  /// --------------------------------------------------------------------------
}

class _AuthScreenState extends State<AuthScreen> {
// -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false); /// tamam disposed
// -----------
//   Future<void> _triggerLoading({bool setTo}) async {
//     if (mounted == true){
//       if (setTo == null){
//         _loading.value = !_loading.value;
//       }
//       else {
//         _loading.value = setTo;
//       }
//       blogLoading(loading: _loading.value, callerName: 'SearchBzzScreen',);
//     }
//   }
// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      // _triggerLoading().then((_) async {
      //
      //   final List<UserModel> _myUserModels = await UserLDBOps.readMyModels();
      //
      //   await _triggerLoading();
      // });

      _isInit = false;
    }
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    _loading.dispose();
    super.dispose();
  }
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
  }
// -----------------------------------------------------------------------------



  @override
  Widget build(BuildContext context) {

    return const MainLayout(
      pyramidsAreOn: true,
      appBarType: AppBarType.non,
      layoutWidget: AuthScreenView(),
    );

  }
}
