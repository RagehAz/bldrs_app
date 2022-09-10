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
  final ValueNotifier<List<Chain>> _initialChains = ValueNotifier([]);
  final ValueNotifier<List<Chain>> _tempChains = ValueNotifier([]);
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
      blogLoading(loading: _loading.value, callerName: 'ChainsEditorScreen',);
    }
  }
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _initialChains.value = widget.chains;
    _tempChains.value = widget.chains;

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
      translatePageTitle: false,
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

                  final bool _identicalPaths = Chain.checkChainsListPathsAreIdentical(
                    chains1: tempChains,
                    chains2: initialChains,
                    blogDifferences: false,
                  );

                  final bool _identicalChains = Chain.checkChainsListsAreIdentical(
                    chains1: tempChains,
                    chains2: initialChains,
                    blogDifferences: false,
                  );

                  return Row(
                    children: <Widget>[

                      /// BLOG CURRENT CHAIN PATHS
                      AppBarButton(
                          verse:  'B.Paths',
                          translate: false,
                          buttonColor: _identicalPaths == true ? Colorz.white20 : Colorz.bloodTest,
                          onTap: (){
                            Chain.blogChainsPaths(tempChains);
                          }
                      ),

                      /// BLOG CURRENT CHAIN
                      AppBarButton(
                        verse:  'B.Chain',
                        translate: false,
                        buttonColor: _identicalChains == true ? Colorz.white20 : Colorz.bloodTest,
                        onTap: (){
                          Chain.blogChains(tempChains);
                        }
                      ),

                      /// SYNC BUTTON
                      AppBarButton(
                        verse:  'Sync',
                        translate: false,
                        isDeactivated: _identicalPaths,
                        buttonColor: Colorz.yellow255,
                        verseColor: Colorz.black255,
                        onDeactivatedTap: (){

                          final bool _areIdentical = Chain.checkChainsListPathsAreIdentical(
                            chains1: tempChains,
                            chains2: initialChains,
                          );

                          blog('_identicalPaths : $_areIdentical');

                          // Chain.blogChainsPaths(tempChains);

                        },
                        onTap: () => onSyncChain(
                          context: context,
                          initialChains: _initialChains,
                          editedChains: _tempChains.value,
                        ),
                      ),

                    ],
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
                editMode: true,
                secondLinesType: ChainSecondLinesType.indexAndID,
              );

            },

          ),
        ),
      ),
    );

  }
  // -----------------------------------------------------------------------------
}
