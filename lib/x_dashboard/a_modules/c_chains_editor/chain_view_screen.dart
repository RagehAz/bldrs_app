import 'package:bldrs/a_models/chain/chain.dart';
import 'package:bldrs/a_models/chain/chain_path_converter/chain_path_converter.dart';
import 'package:bldrs/a_models/ui/keyboard_model.dart';
import 'package:bldrs/b_views/x_screens/j_chains/components/expander_structure/b_chain_splitter.dart';
import 'package:bldrs/b_views/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/text_mod.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:flutter/material.dart';

class ChainViewScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const ChainViewScreen({
    @required this.chain,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Chain chain;
  /// --------------------------------------------------------------------------
  @override
  State<ChainViewScreen> createState() => _ChainViewScreenState();
  /// --------------------------------------------------------------------------
}

class _ChainViewScreenState extends State<ChainViewScreen> {
// -----------------------------------------------------------------------------
  ValueNotifier<Chain> _chain;
// -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
// -----------
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
    _chain = ValueNotifier(widget.chain);
  }
// -----------------------------------------------------------------------------
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
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    _loading.dispose();
    _chain.dispose();
    super.dispose();
  }
// -----------------------------------------------------------------------------
  Future<void> onPhidTap(String path, String phid) async {

    await BottomDialog.showButtonsBottomDialog(
        context: context,
        numberOfWidgets: 2,
        draggable: true,
        title: path,
        buttonHeight: 50,
        builder: (_, PhraseProvider phrasePro){

          return <Widget>[

            BottomDialog.wideButton(
                context: context,
                verse: 'Delete',
                onTap: () async {

                  Nav.goBack(context: context, invoker: 'onPhidTap delete button');

                  final bool _continue = await CenterDialog.showCenterDialog(
                    context: context,
                    title: 'Delete ${phid} ?',
                    body: 'this path will be deleted :-'
                        '\n[ $path ]',
                    boolDialog: true,
                  );

                  if (_continue == true){

                    final Chain _updated = Chain.removePathFromChain(
                        chain: _chain.value,
                        path: path,
                    );

                    _chain.value = _updated;

                    await TopDialog.showSuccessDialog(
                      context: context,
                      firstLine: '( $phid ) has been deleted',
                    );

                  }

                }),


            BottomDialog.wideButton(
              context: context,
              verse: 'Edit',
            ),

          ];

        }
    );

  }

  @override
  Widget build(BuildContext context) {

    return MainLayout(
      pageTitle: widget.chain.id,
      sectionButtonIsOn: false,
      appBarType: AppBarType.basic,
      appBarRowWidgets: <Widget>[

        const Expander(),

        ValueListenableBuilder(
          valueListenable: _chain,
          builder: (_, Chain chain, Widget child){

            final bool _areIdentical = Chain.checkChainsPathsAreIdentical(
                chain1: chain,
                chain2: widget.chain,
            );

            return AppBarButton(
              verse: 'Sync',
              isDeactivated: _areIdentical,
            );

            },
        ),

      ],
      layoutWidget: Container(
        width: Scale.superScreenWidth(context),
        height: Scale.superScreenHeightWithoutSafeArea(context),
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: Stratosphere.stratosphereSandwich,
          child: ValueListenableBuilder(
            valueListenable: _chain,
            builder: (_, Chain chain, Widget child){

              // chain.blogChain();

              return ChainSplitter(
                initiallyExpanded: false,
                chainOrChainsOrSonOrSons: chain,
                onSelectPhid: onPhidTap,
                onAddToPath: (String path) async {
                  blog('path was  : $path');
                  // final String _p = TextMod.removeTextBeforeFirstSpecialCharacter(path, '/');
                  final String _path = TextMod.removeTextBeforeFirstSpecialCharacter(path, '/');
                  blog('path aho is  : $_path');

                  String _output;
                  void doneWithPath(String text){
                    _output = text;
                    Keyboard.closeKeyboard(context);
                  }

                  _output = await BottomDialog.keyboardDialog(
                    context: context,
                    // confirmButtonIsOn: true,
                    keyboardModel: KeyboardModel.standardModel().copyWith(
                        title: 'Add to path',
                        hintText: _path,
                        controller: TextEditingController(text: '$_path/'),
                        minLines: 3,
                        maxLines: 8,
                        maxLength: 1000,
                        isFloatingField: false,
                        // textInputAction: TextInputAction.done,
                        textInputType: TextInputType.url,
                        // onChanged: (String text){},
                        onSubmitted: doneWithPath,
                        onEditingComplete: doneWithPath,
                    ),
                  );

                  blog('newPath is : $_output');

                  final Chain _updated = Chain.addPathToChain(
                    chain: chain,
                    path: '$_output/',
                  );

                  _updated.blogChain();

                  _chain.value = _updated;

                },

              );

            },

          ),
        ),
      ),
    );

  }
}
