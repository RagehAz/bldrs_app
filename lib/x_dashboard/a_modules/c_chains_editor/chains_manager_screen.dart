import 'package:bldrs/a_models/chain/chain.dart';
import 'package:bldrs/a_models/chain/chain_path_converter/chain_path_converter.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/unfinished_night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/d_providers/chains_provider.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/e_db/fire/methods/firestore.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/f_helpers/theme/wordz.dart' as Wordz;
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
  List<String> _allChainsPhrases;
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

    _allChainsPhrases = ChainPathConverter.generateChainsPaths(
        parentID: '',
        chains: _allChains,
    );

    blog('all chains paths : -');
    ChainPathConverter.blogPaths(_allChainsPhrases);

  }
// -----------------------------------------------------------------------------
  Future<void> _onUploadChains() async {

    // final Chain _keywordsChain = _chainsProvider.keywordsChain;
    // final Chain _specsChain = _chainsProvider.specsChain;

    // final Chain _keywordsChain = await ChainOps.readKeywordsChain(context);

    // _keywordsChain?.blogChain();
    //
    // final List<Chain> _newSpecsChains = <Chain>[
    //   propertySalePrice,
    //   propertyRentPrice,
    //   propertyDecorationStyle,
    //   designType,
    //   projectCost,
    //   constructionDuration,
    // ];
    //
    // await onAddMoreSpecsChainsToExistingSpecsChains(
    //   context: context,
    //   chainsToAdd: _newSpecsChains,
    // );


    await deleteAllCollectionDocs(
        context: context,
        collName: 'countries',
    );

    // return 'b';
  }
// -----------------------------------------------------------------------------
  Future<void> _onStripTap({
    @required String phraseIDPath, // will look like this 'idA/idB/idC'
}) async {

    blog(phraseIDPath);

  }
// -----------------------------------------------------------------------------
  final ValueNotifier<bool> _isSearching = ValueNotifier<bool>(false);
  final ValueNotifier<List<Chain>> _foundChains = ValueNotifier<List<Chain>>(null);
// ------------------------------------------------
  Future<void> _onSearchSubmit(String text) async {


    triggerIsSearchingNotifier(
        text: text,
        isSearching: _isSearching
    );

    blog('text is : $text : isSearching : ${_isSearching.value}');

    if (_isSearching.value == true){
      _onSearchChains(
        chains: _allChains,
        text: text,
      );
    }


  }
// ------------------------------------------------
  void _onSearchChains({
    @required List<Chain> chains,
    @required String text,
}){

    blog('all paths : $_allChainsPhrases');

    /// SEARCH CHAINS FOR MATCH CASES
    final List<String> _foundPaths = ChainPathConverter.findPathsContainingPhid(
        paths: _allChainsPhrases,
        phid: text
    );

    blog('found paths : $_foundPaths');

    final List<Chain> _foundPathsChains = ChainPathConverter.createChainsFromPaths(
        paths: _foundPaths,
    );

    /// SET FOUND CHAINS AS SEARCH RESULT
    _foundChains.value = _foundPathsChains;

  }
// ------------------------------------------------
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
      onSearchSubmit: (String text) => _onSearchSubmit(text),
      onSearchChanged: (String text) => _onSearchSubmit(text),
      appBarRowWidgets: <Widget>[

        const Expander(),

        /// UPLOAD CHAIN
        DreamBox(
          height: 40,
          verse: 'Upload',
          secondLine: 'Chains',
          iconSizeFactor: 0.6,
          onTap: _onUploadChains,
        ),

        /// SWITCH LANGUAGE BUTTON
        DreamBox(
          height: 40,
          icon: Iconz.language,
          iconSizeFactor: 0.6,
          margins: const EdgeInsets.symmetric(horizontal: 5),
          onTap: () async {

            final PhraseProvider _phraseProvider = Provider.of<PhraseProvider>(context, listen: false);
            final String _currentLangCode = Wordz.languageCode(context);
            await _phraseProvider.changeAppLang(
                context: context,
                langCode: _currentLangCode == 'en' ? 'ar' : 'en',
            );

            setState(() {});

          },
        ),

      ],

      layoutWidget: ValueListenableBuilder<bool>(
        valueListenable: _isSearching,
        builder: (_, bool isSearching, Widget child){

          if (isSearching == true){
            return ValueListenableBuilder(
                valueListenable: _foundChains,
                builder: (_, List<Chain> chains, Widget child){

                  return ChainsTreesStarter(
                      chains: chains,
                      onStripTap: (String path) => _onStripTap(
                          phraseIDPath: path
                      )
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
