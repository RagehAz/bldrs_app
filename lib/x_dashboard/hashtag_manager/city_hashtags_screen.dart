import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/x_dashboard/zz_widgets/layout/dashboard_layout.dart';
import 'package:bldrs/x_dashboard/zz_widgets/wide_button.dart';
import 'package:flutter/material.dart';

class CityHashtagsScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const CityHashtagsScreen({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  _CityHashtagsScreenState createState() => _CityHashtagsScreenState();
/// --------------------------------------------------------------------------
}

class _CityHashtagsScreenState extends State<CityHashtagsScreen> {
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void> _triggerLoading({@required bool setTo}) async {
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
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      _triggerLoading(setTo: true).then((_) async {

        /// FUCK

        await _triggerLoading(setTo: false);
      });

      _isInit = false;
    }
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void dispose() {
    _loading.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return DashBoardLayout(
      loading: _loading,
      listWidgets: <Widget>[

        WideButton(
          verse: Verse.plain('~~~~~~~~~test~~~~~~~~~~'),
          onTap: () async {

            blog('~~~~~~~~~test~~~~~~~~~~ onTap');

          },
        ),

      ],
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}
