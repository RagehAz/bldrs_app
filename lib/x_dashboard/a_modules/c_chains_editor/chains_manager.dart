import 'dart:async';

import 'package:bldrs/a_models/chain/a_chain.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/info_button/expanded_info_page_parts/info_page_headline.dart';
import 'package:bldrs/b_views/z_components/layouts/separator_line.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/c_protocols/chain_protocols/a_chain_protocols.dart';
import 'package:bldrs/e_db/real/ops/chain_real_ops.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/x_dashboard/a_modules/c_chains_editor/chain_editor_screen.dart';
import 'package:bldrs/x_dashboard/a_modules/c_chains_editor/z_components/picking_mode_bubble.dart';
import 'package:bldrs/x_dashboard/b_widgets/layout/dashboard_layout.dart';
import 'package:bldrs/x_dashboard/b_widgets/wide_button.dart';
import 'package:flutter/material.dart';

class ChainsManager extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const ChainsManager({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  _ChainsManagerState createState() => _ChainsManagerState();
  /// --------------------------------------------------------------------------
}

class _ChainsManagerState extends State<ChainsManager> {
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
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
  // --------------------
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
  // --------------------
  /// TAMAM
  @override
  void dispose() {
    _loading.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _screenWidth = Scale.superScreenWidth(context);
    return DashBoardLayout(
      pageTitle: 'Chains Manager',
      listWidgets: <Widget>[

        // ---------------------------------------

        const ChainsPickingModeBubble(),

        // ---------------------------------------

        const SeparatorLine(),

        /// VIEWING PRO CHAINS
        InfoPageHeadline(
          pageWidth: _screenWidth - 20,
          headlineVerse:  'Chain Real Ops',
        ),
        /// CREATE BLDRS CHAIN
        WideButton(
          translate: false,
          isActive: false,
          verse:  'CREATE BLDRS CHAIN',
          color: Colorz.blue80,
          onTap: () async {

            // final bool _continue = await CenterDialog.showCenterDialog(
            //   context: context,
            //   titleVerse:  'Create new Chain ?',
            //   bodyVerse:  'This will Create a new chain from pro chain and upload it to real db,, wanna continue ?',
            //   boolDialog: true,
            //   color: Colorz.bloodTest,
            // );
            //
            // if (_continue == true){
            //
            //   final Chain chainK = ChainsProvider.proGetBldrsChains(
            //       context: context,
            //       onlyUseCityChains: false,
            //       listen: false
            //   );
            //
            //   final Chain _chainKUploaded = await ChainProtocols.composeChainK(
            //       context: context,
            //       chainK: chainK
            //   );
            //
            //   if (_chainKUploaded == null){
            //     blog('No ChainK received');
            //   }
            //
            //   else {
            //     await Nav.goToNewScreen(
            //       context: context,
            //       screen: ChainEditorScreen(
            //         chain: _chainKUploaded,
            //       ),
            //     );
            //   }
            //
            // }

          },
        ),
        /// READ BLDRS CHAIN
        WideButton(
          translate: false,
          verse:  'READ Bldrs Chain',
          color: Colorz.blue80,
          onTap: () async {

            unawaited(WaitDialog.showWaitDialog(context: context,));

            final List<Chain> _bldrsChains = await ChainRealOps.readBldrsChains(context);

            blog('o');

            // Chain.blogChains(_bldrsChains);

            WaitDialog.closeWaitDialog(context);

            if (_bldrsChains == null){
              blog('No ChainK found');
            }

            else {
              await Nav.goToNewScreen(
                context: context,
                screen: ChainsEditorScreen(
                  chains: _bldrsChains,
                ),
              );
            }

          },
        ),
        /// FETCH CHAINS
        WideButton(
          translate: false,
          verse:  'FETCH Bldrs Chains',
          color: Colorz.blue80,
          onTap: () async {

            unawaited(WaitDialog.showWaitDialog(context: context,));

            final List<Chain> _bldrsChains = await ChainProtocols.fetchBldrsChains(context);

            Chain.blogChains(_bldrsChains);

            WaitDialog.closeWaitDialog(context);

            if (_bldrsChains == null){
              blog('No ChainK found');
            }

            else {
              await Nav.goToNewScreen(
                context: context,
                screen: ChainsEditorScreen(
                  chains: _bldrsChains,
                ),
              );
            }

          },
        ),

        // ---------------------------------------

        const SeparatorLine(),

        const Horizon(),

      ],
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}
