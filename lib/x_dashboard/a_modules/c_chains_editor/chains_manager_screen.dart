import 'package:bldrs/a_models/chain/chain.dart';
import 'package:bldrs/a_models/chain/chain_path_converter/chain_path_converter.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/unfinished_night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/texting/data_strip.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/d_providers/chains_provider.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/e_db/fire/methods/firestore.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/f_helpers/theme/wordz.dart' as Wordz;
import 'package:bldrs/x_dashboard/a_modules/c_chains_editor/chains_controller.dart';
import 'package:bldrs/x_dashboard/a_modules/c_chains_editor/widgets/chains_data_tree_starter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChainsManagerScreen extends StatefulWidget {

  const ChainsManagerScreen({
    Key key
  }) : super(key: key);

  @override
  _ChainsManagerScreenState createState() => _ChainsManagerScreenState();
}

class _ChainsManagerScreenState extends State<ChainsManagerScreen> {
// -----------------------------------------------------------------------------
  List<Chain> _allChains;
  List<String> _allChainsPaths;
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(context, listen: false);
    final Chain _keywordsChain = _chainsProvider.keywordsChain;
    final Chain _specsChain = _chainsProvider.specsChain;

    _allChains = <Chain>[
      _keywordsChain,
      _specsChain,
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
    @required String phraseIDPath, // will look like this 'idA/idB/idC'
}) async {

    blog('phrase id path is : $phraseIDPath');
    final PhraseProvider _phraseProvider = Provider.of<PhraseProvider>(context, listen: false);

    final List<String> _pathNodes = phraseIDPath.split('/');
    final String _phid = _pathNodes.last;
    final String _phraseName = superPhrase(context, _phid, providerOverride: _phraseProvider);

    final double _clearWidth = BottomDialog.clearWidth(context);

    await BottomDialog.showBottomDialog(
        context: context,
        draggable: true,
        title: _phraseName,
        child: Container(
          width: _clearWidth,
          height: BottomDialog.clearHeight(context: context, draggable: true, titleIsOn: true),
          // color: Colorz.bloodTest,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(bottom: Ratioz.horizon),
            children: <Widget>[

              DataStrip(
                dataKey: 'Path',
                dataValue: phraseIDPath,
                width: _clearWidth,
                onTap: () => copyToClipboard(context: context, copy: phraseIDPath),
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
      appBarRowWidgets: const <Widget>[

        Expander(),

        /// UPLOAD CHAIN
        // DreamBox(
        //   height: 40,
        //   verse: 'Upload',
        //   secondLine: 'Chains',
        //   iconSizeFactor: 0.6,
        //   onTap: onUploadChains,
        // ),

      ],

      layoutWidget: ValueListenableBuilder<bool>(
        valueListenable: _isSearching,
        builder: (_, bool isSearching, Widget child){

          if (isSearching == true){
            return ValueListenableBuilder(
                valueListenable: _foundChains,
                builder: (_, List<Chain> foundChains, Widget child){

                  return ChainsTreesStarter(
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
                chains: _allChains,
                onStripTap: (String path) => _onStripTap(
                    phraseIDPath: path
                )
            );
          }

        },
      ),

    );
  }
}
