import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble_header.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/x_dashboard/z_widgets/layout/dashboard_layout.dart';
import 'package:bldrs/x_dashboard/z_widgets/wide_button.dart';
import 'package:flutter/material.dart';

class TestingTemplate extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const TestingTemplate({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  _TestingTemplateState createState() => _TestingTemplateState();
  /// --------------------------------------------------------------------------
}

class _TestingTemplateState extends State<TestingTemplate> {
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
      blogLoading(loading: _loading.value, callerName: 'TestingTemplate',);
    }
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
