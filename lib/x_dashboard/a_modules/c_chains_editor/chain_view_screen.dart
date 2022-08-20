import 'package:bldrs/a_models/chain/chain.dart';
import 'package:bldrs/a_models/chain/chain_path_converter/chain_path_converter.dart';
import 'package:bldrs/a_models/ui/keyboard_model.dart';
import 'package:bldrs/b_views/x_screens/j_chains/components/expander_structure/b_chain_splitter.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble_bullet_points.dart';
import 'package:bldrs/b_views/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
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

    final String _path = ChainPathConverter.fixPathFormatting(path);

    await BottomDialog.showButtonsBottomDialog(
        context: context,
        numberOfWidgets: 7,
        draggable: true,
        title: phid,
        buttonHeight: 50,
        builder: (_, PhraseProvider phrasePro){

          return <Widget>[

            /// PATH SPLIT
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: BubbleBulletPoints(
                bulletPoints: ChainPathConverter.splitPathNodes(_path),
                bubbleWidth: BottomDialog.clearWidth(context),
              ),
            ),

            /// EDIT
            BottomDialog.wideButton(
              context: context,
              verse: 'Edit',
              onTap: () => onEditPhid(
                path: _path,
                phid: phid,
              ),
            ),

            /// DELETE
            BottomDialog.wideButton(
              context: context,
              verse: 'Delete',
              onTap: () => onDeletePhid(
                path: _path,
                phid: phid,
              ),
            ),

          ];

        }
    );

  }
// -----------------------------------------------------------------------------
  Future<void> onAddNewPath (String path) async {
    blog('path was  : $path');

    final String _path = ChainPathConverter.fixPathFormatting(path);
    blog('path aho is  : $_path');

    final String _typedPath = await pathKeyboardDialog(
      path: path,
      title: 'Add to path',
    );

    final Chain _updated = Chain.addPathToChain(
      chain: _chain.value,
      path: _typedPath,
    );

    // _updated.blogChain();

    _chain.value = _updated;

  }
// -----------------------------------------------------------------------------
  Future<void> onDeletePhid ({
    @required String phid,
    @required String path,
  }) async {

    Nav.goBack(
        context: context,
        invoker: 'onDeletePhid delete button',
    );

    final bool _continue = await CenterDialog.showCenterDialog(
      context: context,
      title: 'Delete $phid ?',
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

  }
// -----------------------------------------------------------------------------
  Future<void> onEditPhid({
    @required String phid,
    @required String path,
  }) async {

    Nav.goBack(context: context, invoker: 'onEditPhid');

    final String _typedPath = await pathKeyboardDialog(
      path: path,
      title: 'Edit path',
    );

    if (path != _typedPath){

      final bool _continue = await CenterDialog.showCenterDialog(
        context: context,
        height: 500,
        title: 'Edit this path ?',
        body: 'old\n$path'
            '\n\n'
            'new\n$_typedPath',
        boolDialog: true,
      );

      if (_continue == true){

        final Chain _updated = Chain.replaceChainPathWithPath(
          chain: _chain.value,
          pathToRemove: path,
          pathToReplace: _typedPath,
        );

        _chain.value = _updated;

      }

    }

  }
// -----------------------------------------------------------------------------
  final TextEditingController _controller = TextEditingController();
  final FocusNode _node = FocusNode();
  Future<String> pathKeyboardDialog({
    @required String path,
    @required String title,
  }) async {

    String _typedPath;
     _controller.text = ChainPathConverter.fixPathFormatting(path);

    void doneWithPath(String text){
      _typedPath = ChainPathConverter.fixPathFormatting(text);
    }

    _typedPath = await BottomDialog.keyboardDialog(
      context: context,
      keyboardModel: KeyboardModel.standardModel().copyWith(
        title: title,
        hintText: path,
        controller: _controller,
        focusNode: _node,
        minLines: 3,
        maxLines: 8,
        maxLength: 1000,
        isFloatingField: false,
        textInputAction: TextInputAction.done,
        textInputType: TextInputType.url,
        // onChanged: (String text){},
        onSubmitted: doneWithPath,
        onEditingComplete: doneWithPath,
      ),
    );

    _typedPath = ChainPathConverter.fixPathFormatting(_typedPath);

    return _typedPath;
  }
// -----------------------------------------------------------------------------
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
                onAddToPath: onAddNewPath,

              );

            },

          ),
        ),
      ),
    );

  }
}
