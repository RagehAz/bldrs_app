import 'package:bldrs/a_models/chain/chain.dart';
import 'package:bldrs/a_models/chain/chain_path_converter/chain_path_converter.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/page_bubble.dart';
import 'package:bldrs/b_views/z_components/layouts/unfinished_night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/texting/data_strip.dart';
import 'package:bldrs/b_views/z_components/texting/data_strip_with_headline.dart';
import 'package:bldrs/d_providers/chains_provider.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/text_mod.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/x_dashboard/a_modules/c_chains_editor/chains_controller.dart';
import 'package:bldrs/x_dashboard/a_modules/c_chains_editor/widgets/chain_tree_viewer.dart';
import 'package:bldrs/x_dashboard/a_modules/c_chains_editor/widgets/chains_data_tree_starter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;

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
  List<Chain> _allChains;
  List<String> _allChainsPaths;
  Chain _testChain;
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(context, listen: false);
    final Chain _keywordsChain = _chainsProvider.keywordsChain;
    final Chain _specsChain = _chainsProvider.specsChain;

    _testChain = const Chain(
      id: 'phid_bldrs',
      sons: <Chain>[

        Chain(
          id: 'phid_design',
          sons: <String>[
            'phid_contractor',
            'phid_craft',
          ],
        ),

        Chain(
          id: 'phid_property',
          sons: <String>[
            'phid_product',
            'phid_equipment',
          ],
        ),

        Chain(
          id: 'phid_enter',
          sons: <Chain>[

            Chain(
              id: 'xx',
              sons: <String>[
                'yyy',
                'zzz',
              ],
            ),

            Chain(
              id: 'qqq',
              sons: <String>[
                'uuuu',
                'eeee',
              ],
            ),
          ],
        ),

      ],
    );

    _allChains = <Chain>[
      _keywordsChain,
      _specsChain,
      _testChain,
    ];

    _allChainsPaths = ChainPathConverter.generateChainsPaths(
        parentID: '',
        chains: _allChains,
    );

    // blog('all chains paths : -');
    // ChainPathConverter.blogPaths(_allChainsPaths);

  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    super.dispose();
    _isSearching.dispose();
    _foundChains.dispose();
    _searchValue.dispose();
  }
// -----------------------------------------------------------------------------
  Future<void> _onStripTap({
    /// => 'phid_a/phid_b/phid_c/'
    @required String phraseIDPath,
}) async {

    /// => 'phid_a/phid_b/phid_c'
    final String _cleanedPath = removeTextAfterLastSpecialCharacter(phraseIDPath, '/');
    /// => <String>[phid_a, phid_b, phid_c]
    final List<String> _pathNodes = _cleanedPath.split('/');
    /// => phid_c
    final String _phid = _pathNodes.last;
    /// => translation
    final PhraseProvider _phraseProvider = Provider.of<PhraseProvider>(context, listen: false);
    final String _phraseName = superPhrase(context, _phid, providerOverride: _phraseProvider);
    /// => single path chain
    final Chain _pathChain = ChainPathConverter.createChainFromSinglePath(
        path: phraseIDPath
    );

    final double _clearWidth = BottomDialog.clearWidth(context);
    final double _dialogHeight = superScreenHeight(context) * 0.65;

    await BottomDialog.showBottomDialog(
        context: context,
        draggable: true,
        title: _phraseName,
        height: _dialogHeight,
        child: SizedBox(
          width: _clearWidth,
          height: BottomDialog.clearHeight(
            context: context,
            draggable: true,
            titleIsOn: true,
            overridingDialogHeight: _dialogHeight,
          ),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(bottom: Ratioz.horizon),
            children: <Widget>[

              DataStrip(
                dataKey: 'Path',
                dataValue: phraseIDPath,
                width: _clearWidth,
                withHeadline: true,
                onTap: () => copyToClipboard(context: context, copy: phraseIDPath),
              ),

              DataStripKey(
                dataKey: 'Chain',
                width: _clearWidth,
                height: DataStripWithHeadline.keyRowHeight,
              ),

              ChainTreeViewer(
                width: _clearWidth,
                chain: _pathChain,
                onStripTap: (String path){blog(path);},
                searchValue: null,
                initiallyExpanded: true,
              ),

              SizedBox(
                width: _clearWidth,
                child: Row(
                  children: <Widget>[

                    DreamBox(
                      height: 40,
                      verse: 'change $_phid',
                      verseScaleFactor: 0.7,
                      verseColor: Colorz.black255,
                      // verseWeight: VerseWeight.thin,
                      color: Colorz.yellow255,
                      margins: 10,
                      onTap: () async {

                        blog('lineeeeeeeeeeeeeeeeeeeeeeeeeee-------------------');

                        final String _rootChainID = ChainPathConverter.getRootChainID(
                          path: phraseIDPath,
                        );
                        final Chain _chain = Chain.getChainFromChainsByID(
                            chainID: _rootChainID,
                            chains: _allChains,
                        );

                        _chain.blogChain();

                        blog('lineeeeeeeeeeeeeeeeeeeeeeeeeee-------------------');

                        final Chain _newChain = await Chain.updateNode(
                          context: context,
                          oldPhid: _phid,
                          newPhid: 'SEXXXY',
                          sourceChain: _chain,
                        );

                        _newChain.blogChain();

                        blog('lineeeeeeeeeeeeeeeeeeeeeeeeeee-------------------');

                      },
                    ),


                  ],
                ),
              ),


            ],
          ),
        ),
    );

  }
// -----------------------------------------------------------------------------
  final ValueNotifier<bool> _isSearching = ValueNotifier<bool>(false); /// tamam disposed
  final ValueNotifier<List<Chain>> _foundChains = ValueNotifier<List<Chain>>(null); /// tamam disposed
  final ValueNotifier<String> _searchValue = ValueNotifier(null); /// tamam disposed
// ------------------------------------------------
  Future<void> onSearch(String text) async {
    await onSearchChains(
      text: text,
      searchValue: _searchValue,
      isSearching: _isSearching,
      allChains: _allChains,
      allChainsPaths: _allChainsPaths,
      foundChains: _foundChains,
    );
  }
// -----------------------------------------------------------------------------

// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _screenHeight = Scale.superScreenHeightWithoutSafeArea(context);

    return MainLayout(
      key: const ValueKey<String>('ChainsManagerScreen'),
      pageTitle: 'All Keywords',
      appBarType: AppBarType.search,
      pyramidsAreOn: true,
      sectionButtonIsOn: false,
      zoneButtonIsOn: false,
      skyType: SkyType.black,
      onSearchSubmit: onSearch,
      onSearchChanged: onSearch,
      appBarRowWidgets: <Widget>[

        const Expander(),

        /// UPLOAD CHAIN
        DreamBox(
          height: 40,
          verse: 'BACKUP',
          secondLine: 'All Chains',
          iconSizeFactor: 0.6,
          margins: const EdgeInsets.symmetric(horizontal: 5),
          onTap: () => onBackupAllChains(context),
        ),

      ],

      layoutWidget: PageBubble(
        screenHeightWithoutSafeArea: _screenHeight,
        appBarType: AppBarType.search,
        color: Colorz.white20,
        child: ValueListenableBuilder<bool>(
          valueListenable: _isSearching,
          builder: (_, bool isSearching, Widget child){

            if (isSearching == true){
              return ValueListenableBuilder(
                  valueListenable: _foundChains,
                  builder: (_, List<Chain> foundChains, Widget child){

                    return ChainsTreesStarter(
                      width: PageBubble.clearWidth(context),
                      chains: foundChains,
                      onStripTap: (String path) => _onStripTap(
                          phraseIDPath: path
                      ),
                      searchValue: _searchValue,
                    );

                  }
              );
            }

            else {
              return ChainsTreesStarter(
                  width: PageBubble.clearWidth(context),
                  chains: _allChains,
                  onStripTap: (String path) => _onStripTap(
                      phraseIDPath: path
                  )
              );
            }

          },
        ),
      ),

    );
  }
}
