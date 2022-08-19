import 'package:bldrs/a_models/chain/chain.dart';
import 'package:bldrs/a_models/chain/chain_path_converter/chain_path_converter.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/d_providers/chains_provider.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/e_db/fire/ops/chain_fire_ops.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/sliders.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/x_dashboard/a_modules/c_chains_editor/chain_manager_pages/chain_editor_page.dart';
import 'package:bldrs/x_dashboard/a_modules/c_chains_editor/chain_manager_pages/chains_viewer_page.dart';
import 'package:bldrs/x_dashboard/a_modules/c_chains_editor/chains_editor_controllers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChainsManagerScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const ChainsManagerScreen({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  _ChainsManagerScreenState createState() => _ChainsManagerScreenState();
/// --------------------------------------------------------------------------
}

class _ChainsManagerScreenState extends State<ChainsManagerScreen> {
// -----------------------------------------------------------------------------
  List<Chain> _originalChains;
  ValueNotifier<List<Chain>> _chainsNotifier;
  // List<String> _allChainsPaths;
  // Chain _testChain;
  final PageController _pageController = PageController();
  TextEditingController _textController;
  TextEditingController _searchController;
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(context, listen: false);
    final Chain _keywordsChain = _chainsProvider.bigChainK;
    final Chain _specsChain = _chainsProvider.bigChainS;

    _textController = TextEditingController(); /// tamam disposed
    _searchController = TextEditingController();/// tamam disposed

    // _testChain = const Chain(
    //   id: 'phid_bldrs',
    //   sons: <Chain>[
    //
    //     Chain(
    //       id: 'phid_design',
    //       sons: <String>[
    //         'phid_contractor',
    //         'phid_trade',
    //       ],
    //     ),
    //
    //     Chain(
    //       id: 'phid_property',
    //       sons: <String>[
    //         'phid_product',
    //         'phid_equipment',
    //       ],
    //     ),
    //
    //     Chain(
    //       id: 'phid_enter',
    //       sons: <Chain>[
    //
    //         Chain(
    //           id: 'xx',
    //           sons: <String>[
    //             'yyy',
    //             'zzz',
    //           ],
    //         ),
    //
    //         Chain(
    //           id: 'qqq',
    //           sons: <String>[
    //             'uuuu',
    //             'eeee',
    //           ],
    //         ),
    //       ],
    //     ),
    //
    //   ],
    // );

    _originalChains = <Chain>[
      _keywordsChain,
      _specsChain,
      // _testChain,
    ];

    _chainsNotifier = ValueNotifier<List<Chain>>(<Chain>[_keywordsChain, _specsChain]);

    // _allChainsPaths = ChainPathConverter.generateChainsPaths(
    //     parentID: '',
    //     chains: _originalChains,
    // );

    // blog('all chains paths : -');
    // ChainPathConverter.blogPaths(_allChainsPaths);

  }
// -----------------------------------------------------------------------------
  /// TAMAM
  @override
  void dispose() {
    _isSearching.dispose();
    _foundChains.dispose();
    _searchValue.dispose();
    _pageController.dispose();
    _textController.dispose();
    _searchController.dispose();
    _chainsNotifier.dispose();
    _selectedPath.dispose();
    super.dispose();
  }
// -----------------------------------------------------------------------------
  Future<void> _onStripTap({
    /// => 'phid_a/phid_b/phid_c/'
    @required String path,
}) async {

    _selectedPath.value = path;
    _textController.text = ChainPathConverter.getLastPathNode(path);

    await Sliders.slideToNext(
        pageController: _pageController,
        numberOfSlides: 2,
        currentSlide: 0
    );

  }
// -----------------------------------------------------------------------------
  final ValueNotifier<bool> _isSearching = ValueNotifier<bool>(false); /// tamam disposed
  final ValueNotifier<List<Chain>> _foundChains = ValueNotifier<List<Chain>>(null); /// tamam disposed
  final ValueNotifier<String> _searchValue = ValueNotifier(null); /// tamam disposed
// ------------------------------------------------
  Future<void> onSearch({
    @required String text,
    @required List<Chain> chains,
  }) async {
    await onSearchChains(
      text: text,
      searchValue: _searchValue,
      isSearching: _isSearching,
      allChains: chains,
      foundChains: _foundChains,
    );
  }
// -----------------------------------------------------------------------------
  final ValueNotifier<String> _selectedPath = ValueNotifier(null);
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _screenHeight = Scale.superScreenHeightWithoutSafeArea(context);

    return ValueListenableBuilder(
        valueListenable: _chainsNotifier,
        builder: (_, List<Chain> chains, Widget child){

          final bool _inSync = Chain.checkChainsListPathsAreIdentical(
            chains1: chains,
            chains2: _originalChains,
          );

          return MainLayout(
            key: const ValueKey<String>('ChainsManagerScreen'),
            pageTitle: 'All Keywords',
            appBarType: AppBarType.search,
            pyramidsAreOn: true,
            sectionButtonIsOn: false,
            skyType: SkyType.black,
            onBack: () async {
              final bool _result = await CenterDialog.showCenterDialog(
                context: context,
                boolDialog: true,
                title: 'Go Back ?',
              );
              if (_result == true){
                Nav.goBack(
                  context: context,
                  invoker: 'ChainsManagerScreen.onBack',
                );
              }
            },
            onSearchSubmit: (String text) => onSearch(
              text: text,
              chains: chains,
            ),
            onSearchChanged: (String text) => onSearch(
              text: text,
              chains: chains,
            ),
            searchController: _searchController,
            appBarRowWidgets: <Widget>[

              const Expander(),

              /// SYNCED BUTTON
              DreamBox(
                height: 40,
                verse: _inSync ? 'Synced' : 'Not\nSynced',
                verseScaleFactor: 0.5,
                verseMaxLines: 2,
                color: _inSync ? Colorz.green255 : Colorz.red255,
                onTap: () => onSync(
                  context: context,
                  originalChains: _originalChains,
                  updatedChains: chains,
                ),
              ),

              /// BACKUP CHAIN
              DreamBox(
                height: 40,
                verse: 'Backups',
                iconSizeFactor: 0.6,
                margins: const EdgeInsets.symmetric(horizontal: 5),
                onTap: () async {

                  await BottomDialog.showButtonsBottomDialog(
                      context: context,
                      draggable: true,
                      buttonHeight: 40,
                      numberOfWidgets: 3,
                      title: 'Back The fuck Up',
                      builder: (BuildContext context, PhraseProvider phraseProvider){

                        return <Widget>[

                          /// BACK UP
                          BottomDialog.wideButton(
                            context: context,
                            verse: 'Back up current Chain',
                            onTap: () => onBackupAllChains(context),
                          ),

                          /// DOWNLOAD LAST BACKUP
                          BottomDialog.wideButton(
                            context: context,
                            verse: 'Download and set last Backup',
                            onTap: () async {

                              final List<Chain> _backups = await ChainFireOpsOLD.readKeywordsAndSpecsBackups(context);

                              Nav.goBack(
                                context: context,
                                invoker: 'ChainsManagerScreen.Download',
                              );

                              _chainsNotifier.value = _backups;
                            },
                          ),

                          /// RELOAD CHAINS
                          BottomDialog.wideButton(
                            context: context,
                            verse: 'Reload chains',
                            onTap: () async {
                              final List<Chain> _chains = await ChainFireOpsOLD.reloadKeywordsAndSpecsChains(context);
                              Nav.goBack(
                                context: context,
                                invoker: 'ChainsManagerScreen.Reload',
                              );
                              _chainsNotifier.value = _chains;
                            },
                          ),

                        ];

                      }
                  );

                },
              ),

            ],

            layoutWidget: PageView(
              physics: const BouncingScrollPhysics(),
              controller: _pageController,
              children: <Widget>[

                ChainViewerPage(
                  screenHeight: _screenHeight,
                  isSearching: _isSearching,
                  foundChains: _foundChains,
                  searchValue: _searchValue,
                  allChains: chains,
                  onStripTap: (String path) => _onStripTap(
                    path: path,
                  ),
                ),

                ChainEditorPage(
                  screenHeight: _screenHeight,
                  textController: _textController,
                  path: _selectedPath,
                  allChains: chains,
                  onUpdateNode: () => onUpdateNode(
                    context: context,
                    newPhid: _textController.text,
                    chains: chains,
                    chainsNotifier: _chainsNotifier,
                    path: _selectedPath.value,
                    // oldChains: chains,
                    pageController: _pageController,
                    searchValue: _searchValue,
                    isSearching: _isSearching,
                    searchController: _searchController,
                    foundChains: _foundChains,
                  ),
                ),

              ],
            ),

          );

        }
    );

  }
}
