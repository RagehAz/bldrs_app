import 'package:bldrs/a_models/chain/chain.dart';
import 'package:bldrs/a_models/chain/chain_path_converter/chain_path_converter.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/page_bubble.dart';
import 'package:bldrs/b_views/z_components/texting/data_strip.dart';
import 'package:bldrs/b_views/z_components/texting/data_strip_with_headline.dart';
import 'package:bldrs/b_views/z_components/texting/text_field_bubble.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/x_dashboard/a_modules/c_chains_editor/chain_viewer_structure/chain_tree_viewer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChainEditorPage extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ChainEditorPage({
    @required this.screenHeight,
    @required this.textController,
    @required this.path,
    @required this.onUpdateNode,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double screenHeight;
  final TextEditingController textController;
  final ValueNotifier<String> path;
  final Function onUpdateNode;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _clearWidth = PageBubble.clearWidth(context);

    return Container(
      width: superScreenWidth(context),
      height: screenHeight,
      // color: Colorz.bloodTest,
      padding: PageBubble.topMargin(AppBarType.search),
      child: ValueListenableBuilder(
        valueListenable: path,
        child: TextFieldBubble(
          title: 'ID',
          textController: textController,
        ),
        builder: (_, String _path, Widget textField){

          final Chain _singlePathChain = ChainPathConverter.createChainFromSinglePath(
              path: _path,
          );

          final String _phid = ChainPathConverter.getLastPathNode(_path);

          final PhraseProvider _phraseProvider = Provider.of<PhraseProvider>(context, listen: true);
          final String _phraseName = superPhrase(context, _phid, providerOverride: _phraseProvider);

          return Column(
            children: <Widget>[

              textField,

              if (_path != null)
                DataStrip(
                  dataKey: 'Translation',
                  dataValue: _phraseName,
                  width: _clearWidth,
                  withHeadline: true,
                  onTap: () => copyToClipboard(
                    context: context,
                    copy: _phraseName,
                  ),
                ),

              if (_path != null)
              DataStrip(
                dataKey: 'Path to root',
                dataValue: _path,
                width: _clearWidth,
                withHeadline: true,
                onTap: () => copyToClipboard(
                  context: context,
                  copy: _path,
                ),
              ),

              if (_path != null)
              DataStripKey(
                dataKey: 'Chain',
                width: _clearWidth,
                height: DataStripWithHeadline.keyRowHeight,
              ),

              if (_path != null)
              ChainTreeViewer(
                width: _clearWidth,
                chain: _singlePathChain,
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
                      verse: 'Update',
                      secondLine: _phid,
                      verseScaleFactor: 0.7,
                      verseColor: Colorz.black255,
                      // verseWeight: VerseWeight.thin,
                      color: Colorz.yellow255,
                      margins: 10,
                      onTap: onUpdateNode,
                    ),


                  ],
                ),
              ),


            ],
          );

        },
      ),
    );

  }
}
