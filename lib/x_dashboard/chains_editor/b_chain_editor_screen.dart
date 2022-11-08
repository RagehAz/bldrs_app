import 'package:bldrs/a_models/c_chain/a_chain.dart';
import 'package:bldrs/a_models/c_chain/aa_chain_path_converter.dart';
import 'package:bldrs/a_models/c_chain/aaa_phider.dart';
import 'package:bldrs/b_views/i_chains/z_components/chain_builders/a_chain_splitter.dart';
import 'package:bldrs/b_views/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/x_dashboard/chains_editor/x_chains_manager_controllers.dart';
import 'package:bldrs/x_dashboard/chains_editor/z_components/editing_chain_builders/a_editing_chain_splitter.dart';
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
  final ValueNotifier<bool> _isSearching = ValueNotifier<bool>(false);
  final ValueNotifier<List<Chain>> _foundChains = ValueNotifier<List<Chain>>(null);
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  /*
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
    _initialChains.dispose();
    _tempChains.dispose();

    _searchController.dispose();
    _isSearching.dispose();
    _foundChains.dispose();

    _loading.dispose();
    super.dispose();
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void _onSearch(String text){

    onSearchChainsByIDs(
        text: text,
        searchValue: ValueNotifier<String>(null),
        isSearching: _isSearching,
        tempChains: _tempChains.value,
        foundChains: _foundChains,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onPhidTap(String path, String phid) async {
    await onChainsEditorPhidTap(
      context: context,
      path: path,
      phid: phid,
      tempChains: _tempChains,
      textController: _searchController,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onPhidDoubleTap(String path) async {
    final String _lastNode = ChainPathConverter.getLastPathNode(path);
    await Keyboard.copyToClipboard(context: context, copy: _lastNode);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onAddToPath(String path) async {
    await onAddNewPath(
      context: context,
      path: path,
      tempChains: _tempChains,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onReorder({
    int oldIndex,
    int newIndex,
    List<dynamic> sons,
    String previousPath,
    int level,
  }) async {

    if (_isSearching.value == true){

      await TopDialog.showTopDialog(
        context: context,
        firstVerse: const Verse(
          text: "Can't re-order search result",
          translate: false,
        ),
      );

    }

    else {

      onReorderSon(
        sons: sons,
        oldIndex: oldIndex,
        tempChains: _tempChains,
        newIndex: newIndex,
        previousPath: previousPath,
        level: level,
      );

    }

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return MainLayout(
      key: const ValueKey<String>('ChainsEditorScreen'),
      pageTitleVerse: const Verse(text: 'Chains',translate: false),
      appBarType: AppBarType.search,
      searchController: _searchController,
      searchHintVerse: const Verse(
        text: 'Search Chains',
        translate: false,
      ),
      loading: _loading,
      onSearchSubmit: _onSearch,
      onSearchChanged: _onSearch,
      onSearchCancelled: () => MainLayout.onCancelSearch(
        context: context,
        controller: _searchController,
        foundResultNotifier: _foundChains,
        isSearching: _isSearching,
      ),
      onBack: () => onChainsEditorScreenGoBack(
        context: context,
        tempChains: _tempChains,
        initialChains: _initialChains,
      ),
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
                          onTap: () => onResetTempChains(
                            context: context,
                            initialChains: _initialChains,
                            tempChains: _tempChains,
                          ),
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
        key: const ValueKey<String>('ChainsEditorScreenViews'),
        width: Scale.screenWidth(context),
        height: Scale.superScreenHeightWithoutSafeArea(context),
        alignment: Alignment.topCenter,
        child: ValueListenableBuilder(
          valueListenable: _isSearching,
          builder: (_, bool isSearching, Widget browsingView){

            /// SEARCHING
            if (isSearching == true){
              return ValueListenableBuilder(
                  valueListenable: _foundChains,
                  builder: (_, List<Chain> foundChains, Widget child,){

                    return EditingChainSplitter(
                      width: Scale.screenWidth(context),
                      initiallyExpanded: false,
                      chainOrChainsOrSonOrSons: foundChains,
                      searchText: _searchController,
                      onPhidTap: _onPhidTap,
                      onAddToPath: _onAddToPath,
                      secondLinesType: ChainSecondLinesType.indexAndID,
                      onPhidDoubleTap: _onPhidDoubleTap,
                      onReorder: _onReorder,
                    );

                  },
              );
            }

            /// BROWSING
            else {
              return browsingView;
            }

          },
          /// BROWSING VIEW
          child: ValueListenableBuilder(
            valueListenable: _tempChains,
            builder: (_, List<Chain> tempChains, Widget child){

              return EditingChainSplitter(
                width: Scale.screenWidth(context),
                initiallyExpanded: false,
                chainOrChainsOrSonOrSons: tempChains,
                onPhidTap: _onPhidTap,
                onAddToPath: _onAddToPath,
                secondLinesType: ChainSecondLinesType.indexAndID,
                onPhidDoubleTap: _onPhidDoubleTap,
                onReorder: _onReorder,
              );

            },

          ),
        ),
      ),
    );

  }
  // -----------------------------------------------------------------------------
}
