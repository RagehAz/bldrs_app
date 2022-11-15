import 'dart:async';

import 'package:bldrs/a_models/c_chain/a_chain.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble_header.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubbles_separator.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/c_protocols/chain_protocols/protocols/a_chain_protocols.dart';
import 'package:bldrs/c_protocols/chain_protocols/provider/chains_provider.dart';
import 'package:bldrs/c_protocols/chain_protocols/real/chain_real_ops.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/x_dashboard/chains_editor/b_chain_editor_screen.dart';
import 'package:bldrs/x_dashboard/chains_editor/x_chains_manager_controllers.dart';
import 'package:bldrs/x_dashboard/chains_editor/z_components/picking_mode_bubble.dart';
import 'package:bldrs/x_dashboard/provider_viewer/provider_viewer_screen.dart';
import 'package:bldrs/x_dashboard/zz_widgets/layout/dashboard_layout.dart';
import 'package:bldrs/x_dashboard/zz_widgets/wide_button.dart';
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
  /*
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
   */
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

      // _triggerLoading(setTo: true).then((_) async {
      //
      //
      //   await _triggerLoading(setTo: false);
      // });

      _isInit = false;
    }
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void dispose() {
    // _loading.dispose();
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
            headlineVerse: Verse(
              text: 'Editing mode',
              translate: false,
            ),
          ),
          bubbleColor: Colorz.white20,
          columnChildren: <Widget>[

            WideButton(
              width: Bubble.clearWidth(context),
              icon: Iconz.keywords,
              verse: const Verse(
                text: 'Go to Chains Editor',
                translate: false,
              ),
              color: Colorz.blue80,
              onTap: () async {

                unawaited(WaitDialog.showWaitDialog(context: context,));

                List<Chain> _bldrsChains = await ChainProtocols.fetchBldrsChains();

                _bldrsChains = ChainsProvider.proGetBldrsChains(
                    context: context,
                    onlyUseCityChains: false,
                    listen: false,
                );

                // Chain.blogChains(_bldrsChains);

                await WaitDialog.closeWaitDialog(context);

                if (_bldrsChains == null){
                  blog('Bldrs Chains are null');
                }

                else {
                  await goToChainsEditorScreen(
                    context: context,
                    chains: _bldrsChains, // Phider.createChainsIndexes(Chain.dummyChain().sons)
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
            headlineVerse: Verse(
              text: 'Testers',
              translate: false,
            ),
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

                final List<Chain> _bldrsChains = await ChainRealOps.readBldrsChains();


                // Chain.blogChains(_bldrsChains);

                await WaitDialog.closeWaitDialog(context);

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

                final List<Chain> _bldrsChains = await ChainProtocols.fetchBldrsChains();

                Chain.blogChains(_bldrsChains);

                await WaitDialog.closeWaitDialog(context);

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
