import 'dart:async';

import 'package:bldrs/a_models/chain/raw_data/specs/specs_pickers.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/info_button/expanded_info_page_parts/info_page_headline.dart';
import 'package:bldrs/b_views/z_components/layouts/separator_line.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/x_dashboard/a_modules/c_spec_pickers_editor/spec_pickers_editor_screen.dart';
import 'package:bldrs/x_dashboard/b_widgets/layout/dashboard_layout.dart';
import 'package:bldrs/x_dashboard/b_widgets/wide_button.dart';
import 'package:flutter/material.dart';

class SpecPickerManager extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const SpecPickerManager({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  _SpecPickerManagerState createState() => _SpecPickerManagerState();
/// --------------------------------------------------------------------------
}

class _SpecPickerManagerState extends State<SpecPickerManager> {
// -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
// -----------
  Future<void> _triggerLoading({
    bool setTo,
  }) async {
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
// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      _triggerLoading().then((_) async {

        /// FUCK

        await _triggerLoading();
      });

      _isInit = false;
    }
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------
  /// TAMAM
  @override
  void dispose() {
    _loading.dispose();
    super.dispose();
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _screenWidth = Scale.superScreenWidth(context);

    return DashBoardLayout(
      // pageTitle: _flyerType?.toString(),
      appBarWidgets: <Widget>[

        AppBarButton(
          icon: Iconz.star,
          verse: 'thing',
          // buttonColor:
          // verseColor: Colorz.white255,
          onTap: (){


          },
        ),

      ],
      listWidgets: <Widget>[

        // ---------------------------------------

        /// VIEWING SPEC PICKERS
        InfoPageHeadline(
          pageWidth: _screenWidth - 20,
          headline: 'Viewing Spec Pickers',
        ),

        /// PROPERTIES SPEC PICKER
        WideButton(
          verse: 'BLOG propertySpecsPickers',
          onTap: () async {

            // SpecPicker.blogSpecsPickers(propertySpecsPickers);

            await Nav.goToNewScreen(
                context: context,
                screen: SpecPickerEditorScreen(
                    specPickers: propertySpecsPickers,
                ),
            );

          },
        ),

        // ---------------------------------------

        const SeparatorLine(),

        const Horizon(),

      ],
    );
  }
// -----------------------------------------------------------------------------
}
