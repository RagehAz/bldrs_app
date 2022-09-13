import 'package:bldrs/a_models/chain/a_chain.dart';
import 'package:bldrs/a_models/chain/aa_chain_path_converter.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/layouts/custom_layouts/page_bubble.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/separator_line.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/b_views/z_components/texting/data_strip/data_strip.dart';
import 'package:bldrs/b_views/z_components/texting/data_strip/data_strip_with_headline.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/bubbles/text_field_bubble.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/x_dashboard/a_modules/c_chains_editor/old_editor/chain_viewer_structure/chain_tree_viewer.dart';
import 'package:bldrs/x_dashboard/a_modules/c_chains_editor/old_editor/chain_viewer_structure/chains_tree_starter.dart';
import 'package:flutter/material.dart';

class ChainEditorPage extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ChainEditorPage({
    @required this.screenHeight,
    @required this.textController,
    @required this.path,
    @required this.onUpdateNode,
    @required this.allChains,
    @required this.appBarType,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double screenHeight;
  final TextEditingController textController;
  final ValueNotifier<String> path;
  final Function onUpdateNode;
  final List<Chain> allChains;
  final AppBarType appBarType;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _clearWidth = PageBubble.clearWidth(context);

    return SizedBox(
      width: Scale.superScreenWidth(context),
      height: screenHeight,
      child: ValueListenableBuilder(
        valueListenable: path,
        child: TextFieldBubble(
          appBarType: appBarType,
          titleVerse: const Verse(text: 'ID', translate: false),
          textController: textController,
        ),
        builder: (_, String _path, Widget textField){

          final Chain _singlePathChain = ChainPathConverter.createChainFromSinglePath(
              path: _path,
          );

          final String _phid = ChainPathConverter.getLastPathNode(_path);

          final String _phraseName = _phid;

          final List<Chain> _relatedChains = ChainPathConverter.findPhidRelatedChains(
              chains: allChains,
              phid: _phid,
          );

          return ListView(
            padding: PageBubble.topMargin(
              context: context,
              appBarType: AppBarType.search,
              withProgressBar: false,
            ),
            physics: const BouncingScrollPhysics(),
            children: <Widget>[

              /// TEXT FIELD
              textField,

              SizedBox(
                width: _clearWidth,
                child: Row(
                  children: <Widget>[

                    DreamBox(
                      height: 40,
                      verse: const Verse(text: 'Update', translate: false),
                      verseScaleFactor: 0.7,
                      verseColor: Colorz.black255,
                      // verseWeight: VerseWeight.thin,
                      color: Colorz.yellow255,
                      margins: 10,
                      onTap: onUpdateNode,
                    ),

                    DreamBox(
                      height: 40,
                      verse: const Verse(text: 'Copy ID', translate: false),
                      verseScaleFactor: 0.7,
                      verseColor: Colorz.black255,
                      // verseWeight: VerseWeight.thin,
                      color: Colorz.yellow255,
                      margins: 0,
                      onTap: () => Keyboard.copyToClipboard(context: context, copy: textController.text),
                    ),


                  ],
                ),
              ),

              const SeparatorLine(),

              /// TRANSLATION
              if (_path != null)
                DataStrip(
                  dataKey: 'Translation',
                  dataValue: _phraseName,
                  width: _clearWidth,
                  withHeadline: true,
                  color: Colorz.black255,
                  onTap: () => Keyboard.copyToClipboard(
                    context: context,
                    copy: _phraseName,
                  ),
                ),

              /// PATH TO ROOT
              if (_path != null)
              DataStrip(
                dataKey: 'Path to root',
                dataValue: _path,
                width: _clearWidth,
                withHeadline: true,
                color: Colorz.black255,
                highlightText: ValueNotifier<String>(_phid),
                onTap: () => Keyboard.copyToClipboard(
                  context: context,
                  copy: _path,
                ),
              ),

              /// CHAIN TO ROOT TITLE
              if (_path != null)
              DataStripKey(
                dataKey: 'Chain to Root',
                width: _clearWidth,
                height: DataStripWithHeadline.keyRowHeight,
              ),

              const SeparatorLine(),

              /// CHAIN TO ROOT
              if (_path != null)
              SizedBox(
                width: _clearWidth,
                child: ChainTreeViewer(
                  width: _clearWidth,
                  chain: _singlePathChain,
                  onStripTap: (String path){blog(path);},
                  searchValue: ValueNotifier<String>(_phid),
                  initiallyExpanded: true,
                  index: 0,
                ),
              ),

              const SeparatorLine(),

              /// ALL RELATED CHAINS TITLE
              if (_path != null)
                DataStripKey(
                  dataKey:  'Related Chains',
                  width: _clearWidth,
                  height: DataStripWithHeadline.keyRowHeight,
                ),

              SuperVerse(
                verse: Verse.plain('All Nodes that include ( $_phid ) in their paths'),
                size: 1,
                italic: true,
                centered: false,
                margin: 5,
              ),

              /// RELATED CHAINS
              if (_path != null)
                PageBubble(
                  screenHeightWithoutSafeArea: 300,
                  appBarType: AppBarType.non,
                  color: Colorz.white20,
                  child: ChainsTreesStarter(
                    width: _clearWidth,
                    chains: _relatedChains,
                    onStripTap: (String path){blog(path);},
                    searchValue: ValueNotifier<String>(_phid),
                    initiallyExpanded: true,
                  ),
                ),

              const Horizon(),

            ],
          );

        },
      ),
    );

  }
}
