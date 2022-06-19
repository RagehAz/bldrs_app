import 'package:bldrs/a_models/bz/author_model.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/unfinished_night_sky.dart';
import 'package:flutter/material.dart';

class AuthorRoleEditorScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const AuthorRoleEditorScreen({
    @required this.authorModel,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final AuthorModel authorModel;
  /// --------------------------------------------------------------------------
  @override
  _AuthorRoleEditorScreenState createState() => _AuthorRoleEditorScreenState();
/// --------------------------------------------------------------------------
}

class _AuthorRoleEditorScreenState extends State<AuthorRoleEditorScreen> {
// -----------------------------------------------------------------------------
  /// --- LOCAL LOADING BLOCK
  final ValueNotifier<bool> _loading = ValueNotifier(false); /// tamam disposed
  // Future<void> _triggerLoading() async {
  //   _loading.value = !_loading.value;
  //   blogLoading(
  //     loading: _loading.value,
  //     callerName: 'SearchBzzScreen',
  //   );
  // }
// -----------------------------------
  @override
  void initState() {
    super.initState();


  }
// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      // _triggerLoading().then((_) async {
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
  Widget build(BuildContext context) {

    return MainLayout(
      key: const ValueKey<String>('AuthorRoleEditorScreen'),
      loading: _loading,
      appBarType: AppBarType.basic,
      pyramidsAreOn: true,
      historyButtonIsOn: false,
      zoneButtonIsOn: false,
      sectionButtonIsOn: false,
      skyType: SkyType.black,
      pageTitle: 'Author team role',
      layoutWidget: Container(),
    );

  }
}
