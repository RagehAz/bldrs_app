import 'package:bldrs/a_models/chain/a_chain.dart';
import 'package:bldrs/b_views/i_chains/z_components/expander_structure/b_chain_splitter.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/x_dashboard/a_modules/c_chains_editor/chains_manager_controllers.dart';
import 'package:flutter/material.dart';

class ChainsEditorScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const ChainsEditorScreen({
    @required this.chains,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final List<Chain> chains;
  /// --------------------------------------------------------------------------
  @override
  State<ChainsEditorScreen> createState() => _ChainsEditorScreenState();
  /// --------------------------------------------------------------------------
}

class _ChainsEditorScreenState extends State<ChainsEditorScreen> {
  // -----------------------------------------------------------------------------
  ValueNotifier<List<Chain>> _initialChains;
  ValueNotifier<List<Chain>> _tempChains;
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
    _initialChains = ValueNotifier( widget.chains);
    _tempChains = ValueNotifier( widget.chains);
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
  @override
  void dispose() {
    _loading.dispose();
    _tempChains.dispose();
    _initialChains.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return MainLayout(
      pageTitleVerse: 'Bldrs Chains',
      sectionButtonIsOn: false,
      appBarType: AppBarType.basic,
      onBack: () => Dialogs.goBackDialog(
        context: context,
        goBackOnConfirm: true,
      ),
      appBarRowWidgets: <Widget>[

        const Expander(),

        ValueListenableBuilder(
            valueListenable: _initialChains,
            builder: (_, List<Chain> initialChains, Widget child){

              return ValueListenableBuilder(
                valueListenable: _tempChains,
                builder: (_, List<Chain> tempChains, Widget child){

                  final bool _areIdentical = Chain.checkChainsListPathsAreIdentical(
                    chains1: tempChains,
                    chains2: initialChains,
                  );

                  return AppBarButton(
                    verse:  'Sync',
                    isDeactivated: _areIdentical,
                    buttonColor: Colorz.yellow255,
                    verseColor: Colorz.black255,
                    onTap: () => onSyncChain(
                      context: context,
                      initialChains: _initialChains,
                      editedChains: _tempChains.value,
                    ),
                  );

                },
              );

            }),

      ],
      layoutWidget: Container(
        width: Scale.superScreenWidth(context),
        height: Scale.superScreenHeightWithoutSafeArea(context),
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: Stratosphere.stratosphereSandwich,
          child: ValueListenableBuilder(
            valueListenable: _tempChains,
            builder: (_, List<Chain> tempChains, Widget child){

              // chain.blogChain();

              return ChainSplitter(
                initiallyExpanded: false,
                chainOrChainsOrSonOrSons: tempChains,
                onSelectPhid: (String path, String phid) => onPhidTap(
                  context: context,
                  path: path,
                  phid: phid,
                  tempChains: _tempChains,
                ),
                onAddToPath: (String path) => onAddNewPath(
                  context: context,
                  path: path,
                  tempChains: _tempChains,
                ),

              );

            },

          ),
        ),
      ),
    );

  }
  // -----------------------------------------------------------------------------
}
