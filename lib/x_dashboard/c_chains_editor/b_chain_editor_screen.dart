import 'package:bldrs/a_models/chain/a_chain.dart';
import 'package:bldrs/a_models/chain/aaa_phider.dart';
import 'package:bldrs/b_views/i_chains/z_components/chain_builders/a_chain_splitter.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/x_dashboard/c_chains_editor/x_chains_manager_controllers.dart';
import 'package:bldrs/x_dashboard/c_chains_editor/z_components/editing_chain_builders/a_editing_chain_splitter.dart';
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
  // --------------------
  final TextEditingController _searchController = TextEditingController();
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  /*
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
   */
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _initialChains.value = Phider.sortChainsByIndexes(widget.chains);
    _tempChains.value = _initialChains.value;
  }
  // --------------------
  /*
  final bool _isInit = true;
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
   */
  // --------------------
  @override
  void dispose() {
    _loading.dispose();
    _tempChains.dispose();
    _initialChains.dispose();
    _searchController.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  void _onSearch(String text){
    blog('text is : $text');

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return MainLayout(
      pageTitleVerse: const Verse(text: 'Chains',translate: false),
      sectionButtonIsOn: false,
      appBarType: AppBarType.search,
      searchController: _searchController,
      searchHintVerse: const Verse(
        text: 'Search Chains',
        translate: false,
      ),
      onSearchSubmit: _onSearch,
      onSearchChanged: _onSearch,
      onBack: (){

        final bool _identicalPaths = Chain.checkChainsListPathsAreIdentical(
          chains1: _tempChains.value,
          chains2: _initialChains.value,
          blogDifferences: false,
        );

        if (_identicalPaths == true){
          Nav.goBack(context: context, invoker: 'ChainsEditorScreen');
        }

        else {
          Dialogs.goBackDialog(
            context: context,
            bodyVerse: const Verse(
              text: 'UnSynced Changes\nWill be lost\nFor Fucking ever',
              translate: false,
            ),
            goBackOnConfirm: true,
          );
        }

      },
      pyramidsAreOn: true,
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
                  );

                  return Row(
                    children: <Widget>[

                      /// RESET
                      AppBarButton(
                          icon: Iconz.reload,
                          isDeactivated: _identicalPaths,
                          buttonColor: Colorz.bloodTest,
                          onTap: () async {

                            final bool _result = await Dialogs.bottomBoolDialog(
                                context: context,
                                titleVerse: const Verse(
                                  text: 'Reset Chains ?',
                                  translate: false,
                                ),
                            );

                            if (_result == true){
                              _tempChains.value = widget.chains;
                            }

                          }
                      ),

                      /// BLOG CURRENT CHAIN PATHS
                      AppBarButton(
                          verse: const Verse(
                            text: 'Blog\nPaths',
                            translate: false,
                          ),
                          buttonColor: _identicalPaths == true ? Colorz.white20 : Colorz.bloodTest,
                          onTap: () async {

                            Chain.blogChainsPaths(tempChains);

                            Chain.blogChainsPathsDifferences(
                                chains1: tempChains,
                                chains2: initialChains,
                            );

                          }
                      ),

                      /// BLOG CURRENT CHAIN
                      AppBarButton(
                        verse: const Verse(
                          text: 'Blog\nChains',
                          translate: false,
                        ),
                        buttonColor: _identicalChains == true ? Colorz.white20 : Colorz.bloodTest,
                        onTap: (){
                          Chain.blogChains(tempChains);
                        }
                      ),

                      /// SYNC BUTTON
                      AppBarButton(
                        verse: const Verse(
                          text: 'Sync',
                          translate: false
                        ),
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
        child: ValueListenableBuilder(
          valueListenable: _tempChains,
          builder: (_, List<Chain> tempChains, Widget child){

            return EditingChainSplitter(
              width: Scale.superScreenWidth(context),
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
              secondLinesType: ChainSecondLinesType.indexAndID,
              onDoubleTap: (String path) => onPhidTap(
                context: context,
                path: path,
                phid: null,
                tempChains: _tempChains,
              ),
              onReorder: ({
                int oldIndex,
                int newIndex,
                List<dynamic> sons,
                String previousPath,
                int level,
              }) => onReorderSon(
                sons: sons,
                oldIndex: oldIndex,
                tempChains: _tempChains,
                newIndex: newIndex,
                previousPath: previousPath,
                level: level,
              ),
            );

          },

        ),
      ),
    );

  }
  // -----------------------------------------------------------------------------
}
