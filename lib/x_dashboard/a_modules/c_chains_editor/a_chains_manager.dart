import 'dart:async';

import 'package:bldrs/a_models/chain/a_chain.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble_header.dart';
import 'package:bldrs/b_views/z_components/bubble/bubbles_separator.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/c_protocols/chain_protocols/a_chain_protocols.dart';
import 'package:bldrs/e_db/real/ops/chain_real_ops.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/x_dashboard/a_modules/c_chains_editor/b_chain_editor_screen.dart';
import 'package:bldrs/x_dashboard/a_modules/c_chains_editor/chains_manager_controllers.dart';
import 'package:bldrs/x_dashboard/a_modules/c_chains_editor/z_components/picking_mode_bubble.dart';
import 'package:bldrs/x_dashboard/a_modules/l_provider_viewer/provider_viewer_screen.dart';
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

    return DashBoardLayout(
      pageTitle: 'Chains Manager',
      listWidgets: <Widget>[

        /// GO TO CHAINS EDITOR SCREEN
        Bubble(
          headerViewModel: const BubbleHeaderVM(
            headlineVerse: 'Editing mode',
            translateHeadline: false,
          ),
          bubbleColor: Colorz.white20,
          columnChildren: <Widget>[

            WideButton(
              width: Bubble.clearWidth(context),
              icon: Iconz.keywords,
              translate: false,
              verse:  'Go to Chains Editor',
              color: Colorz.blue80,
              onTap: () async {

                unawaited(WaitDialog.showWaitDialog(context: context,));

                final List<Chain> _bldrsChains = await ChainProtocols.fetchBldrsChains(context);

                // Chain.blogChains(_bldrsChains);

                WaitDialog.closeWaitDialog(context);

                if (_bldrsChains == null){
                  blog('Bldrs Chains are null');
                }

                else {
                  await goToChainsEditorScreen(
                    context: context,
                    chains: _bldrsChains,
                  );
                }

              },
            ),

          ],
        ),

        /// SEPARATOR
        const DotSeparator(),

        /// GO TO CHAINS PICKING SCREEN
        const ChainsPickingModeBubble(),

        /// SEPARATOR
        const DotSeparator(),

        /// TESTING METHODS
        Bubble(
          headerViewModel: const BubbleHeaderVM(
            headlineVerse: 'Testers',
            translateHeadline: false,
          ),
          bubbleColor: Colorz.white20,
          columnChildren: <Widget>[

            /// CREATE BLDRS CHAIN
            ProviderTestButton(
              width: Bubble.clearWidth(context),
              value: null,
              // icon: Iconz.keywords,
              // translate: false,
              // verse:  'Go to Chains Editor',
              // color: Colorz.blue80,
              title: 'CREATE BLDRS CHAIN',
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
            ProviderTestButton(
              width: Bubble.clearWidth(context),
              value: false,
              title:  'READ Bldrs Chain',
              onTap: () async {

                unawaited(WaitDialog.showWaitDialog(context: context,));

                final List<Chain> _bldrsChains = await ChainRealOps.readBldrsChains(context);


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
            ProviderTestButton(
              width: Bubble.clearWidth(context),
              value: false,
              title:  'FETCH Bldrs Chains',
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

          ],
        ),

        /// SEPARATOR
        const DotSeparator(),

        const Horizon(),

      ],
    );

  }
// -----------------------------------------------------------------------------
}
