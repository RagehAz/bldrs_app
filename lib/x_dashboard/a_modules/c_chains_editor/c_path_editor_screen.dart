import 'package:bldrs/a_models/chain/aa_chain_path_converter.dart';
import 'package:bldrs/a_models/chain/dd_data_creation.dart';
import 'package:bldrs/a_models/ui/keyboard_model.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/bubbles/text_field_bubble.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/text_mod.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/x_dashboard/a_modules/c_pickers_editors/x_pickers_editor_controller.dart';
import 'package:flutter/material.dart';

class PathEditorScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const PathEditorScreen({
    @required this.path,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final String path;
  /// --------------------------------------------------------------------------
  @override
  _PathEditorScreenState createState() => _PathEditorScreenState();
  // --------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static String _pathCreationValidator(String path){

    final List<String> _nodes = ChainPathConverter.splitPathNodes(path);

    String _message;

    for (int i = 0; i < _nodes.length; i++){

      final String _node = _nodes[i];
      final bool _startsWith = TextCheck.stringStartsExactlyWith(
        text: _node,
        startsWith: 'phid_',
      );

      if (_startsWith == false){
        _message = 'node ${i+1} : ( $_node ) : should start with "phid_"';
      }

    }

    if (_nodes.length < 2){
      _message = 'Path should at-least have 2 nodes';
    }

    if (TextCheck.stringContainsSubString(string: path, subString: ' ') == true){
      _message = 'Path should not have Empty spaces';
    }
    // blog('_pathCreationValidator : _message : $_message');

    return _message;
  }
  // --------------------------------------------------------------------------
}

class _PathEditorScreenState extends State<PathEditorScreen> {
  // -----------------------------------------------------------------------------
  KeyboardModel _keyboardModel;
  final ValueNotifier<bool> _canSubmit = ValueNotifier<bool>(false);
  final TextEditingController _controller = TextEditingController();
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  /*
  Future<void> _triggerLoading({
    bool setTo,
  }) async {
    if (mounted == true){
      if (setTo == null){
        _loading.value = !_loading.value;
      }
      else {
        _loading.value = setTo;
      }
      blogLoading(loading: _loading.value, callerName: 'KeyboardScreen',);
    }
  }
   */
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    _keyboardModel = KeyboardModel.standardModel().copyWith(
      globalKey: GlobalKey<FormState>(),
      focusNode: FocusNode(),
      titleVerse: 'Edit path',
      translateTitle: false,
      hintVerse: 'phid_aaa/phid_bbb ...',
      initialText: widget.path,
      minLines: 2,
      maxLines: 5,
      maxLength: 1000,
      isFloatingField: false,
      textInputAction: TextInputAction.done,
      textInputType: TextInputType.url,
      counterIsOn: true,
      isFormField: true,
      validator: (String text) => PathEditorScreen._pathCreationValidator(text),
    );

    _controller.text = _keyboardModel.initialText;

  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      // _triggerLoading().then((_) async {
      //
      //   /// FUCK
      //
      //   await _triggerLoading();
      // });

      _isInit = false;
    }
    super.didChangeDependencies();
  }
  // --------------------
  /// TAMAM
  @override
  void dispose() {
    _loading.dispose();
    _canSubmit.dispose();
    _controller.dispose();
    _keyboardModel.focusNode.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  void _onTextChanged(String text){

    if (_keyboardModel.onChanged != null){
      _keyboardModel.onChanged(text);
    }

    if (_keyboardModel.validator != null){

      if (_keyboardModel.validator(_controller.text) == null){
        _canSubmit.value = true;
      }
      else {
        _canSubmit.value = false;
      }

    }

  }
  // --------------------
  void _onSubmit (String text){

    Keyboard.closeKeyboard(context);

    Nav.goBack(
      context: context,
      invoker: 'PathEditorScreen',
      passedData: ChainPathConverter.fixPathFormatting(text),
    );

    if (_keyboardModel.onSubmitted != null){
      if (_keyboardModel.validator == null || _keyboardModel.validator(text) == null){
        _keyboardModel.onSubmitted(text);
      }
    }

  }
  // --------------------
  void _onAddPhid(){
    _setController('${_controller.text}phid_');
  }
  // --------------------
  Future<void> _onPickPhid() async {

    final String _phid = await pickAPhid(context);

    if (TextCheck.isEmpty(_phid) == false){
      _setController('${_controller.text}$_phid/');
    }

  }

  Future<void> _onAddDataCreator() async {

    await BottomDialog.showButtonsBottomDialog(
        context: context,
        draggable: true,
        numberOfWidgets: DataCreation.dataCreatorsList.length,
      buttonHeight: 40,
      builder: (_, PhraseProvider phrasePro){

          return <Widget>[

            ...List.generate(DataCreation.dataCreatorsList.length, (index){

              final DataCreator _dataCreator = DataCreation.dataCreatorsList[index];
              final String _dataCreatorString = DataCreation.cipherDataCreator(_dataCreator);

              return BottomDialog.wideButton(
                  context: context,
                  verse: _dataCreatorString,
              );

            }),

          ];

      }
    );

  }
  // --------------------
  Future<void> _onClear() async {

    if (TextCheck.textControllerIsEmpty(_controller) == false){

      final bool _result = await Dialogs.bottomBoolDialog(
        context: context,
        titleVerse: 'Clear Path ?',
      );

      if (_result == true){
        _setController('');
      }

    }

  }
  // --------------------
  Future<void> _onDeleteLastNode() async {

    if (TextCheck.textControllerIsEmpty(_controller) == false){

      final String _lastNode = ChainPathConverter.getLastPathNode(_controller.text);

      final bool _result = await Dialogs.bottomBoolDialog(
        context: context,
        titleVerse: 'Delete last node ( $_lastNode ) ?',
      );

      if (_result == true){
        _setController(ChainPathConverter.removeLastPathNode(path: _controller.text));
      }

    }

  }
  // --------------------
  void _setController(String text){
    _controller.text = text;
    TextMod.setControllerSelectionAtEnd(_controller);
    Formers.focusOnNode(_keyboardModel.focusNode);
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return MainLayout(
      skyType: SkyType.black,
      appBarType: AppBarType.basic,
      sectionButtonIsOn: false,
      layoutWidget: ValueListenableBuilder(
        valueListenable: _canSubmit,
        builder: (_, bool canSubmit, Widget child){

          return Column(
            children: <Widget>[

              const Stratosphere(),

              /// TEXT FIELD
              TextFieldBubble(
                focusNode: _keyboardModel.focusNode,
                globalKey: _keyboardModel.globalKey,
                appBarType: AppBarType.basic,
                isFloatingField: _keyboardModel.isFloatingField,
                titleVerse: _keyboardModel.titleVerse,
                translateTitle: _keyboardModel.translateTitle,
                textController: _controller,
                maxLines: _keyboardModel.maxLines,
                minLines: _keyboardModel.minLines,
                maxLength: _keyboardModel.maxLength,
                hintText: _keyboardModel.hintVerse,
                counterIsOn: _keyboardModel.counterIsOn,
                keyboardTextInputType: _keyboardModel.textInputType,
                keyboardTextInputAction: _keyboardModel.textInputAction,
                autoFocus: true,
                isFormField: _keyboardModel.isFormField,
                onSubmitted: _onSubmit,
                // autoValidate: true,
                validator: () => _keyboardModel.validator(_controller.text),
                textOnChanged: _onTextChanged,
              ),

              const SizedBox(
                width: 10,
                height: 10,
              ),

              /// PICK PHID - ADD PHID -- CONFIRM
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[

                    const SizedBox(
                      width: 10,
                      height: 10,
                    ),

                    /// SELECT PHID
                    DreamBox(
                      height: 40,
                      verseScaleFactor: 0.6,
                      color: Colorz.blue80,
                      verse:'pick phid',
                      verseItalic: true,
                      onTap: () => _onPickPhid(),
                    ),

                    const SizedBox(
                      width: 5,
                      height: 10,
                    ),

                    /// ADD PHID
                    DreamBox(
                      height: 40,
                      verseScaleFactor: 0.6,
                      color: Colorz.blue80,
                      verse:'Add "phid_"',
                      verseItalic: true,
                      onTap: () => _onAddPhid(),
                    ),

                    const Expander(),

                    /// CONFIRM
                    DreamBox(
                      isDeactivated: !canSubmit,
                      height: 40,
                      color: Colorz.green50,
                      verseScaleFactor: 0.6,
                      verse:'- Confirm -',
                      verseCasing: VerseCasing.upperCase,
                      verseItalic: true,
                      onTap: () => _onSubmit(_controller.text),
                    ),

                    const SizedBox(
                      width: 10,
                      height: 10,
                    ),

                  ],
                ),

              const SizedBox(
                width: 10,
                height: 5,
              ),

              /// CLEAR - REMOVE LAST NODE
              ValueListenableBuilder(
                  valueListenable: _controller,
                  builder: (_, TextEditingValue text, Widget child){

                return Row(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[

                    const SizedBox(
                      width: 10,
                      height: 5,
                    ),

                    /// CLEAR
                    DreamBox(
                      height: 40,
                      verseScaleFactor: 0.6,
                      color: Colorz.blue80,
                      verse:'Clear',
                      verseItalic: true,
                      isDeactivated: TextCheck.isEmpty(text.text),
                      onTap: () => _onClear(),
                    ),

                    const SizedBox(
                      width: 5,
                      height: 5,
                    ),

                    /// REMOVE LAST NODE
                    DreamBox(
                      height: 40,
                      verseScaleFactor: 0.6,
                      color: Colorz.blue80,
                      verse:'Remove last Node',
                      verseItalic: true,
                      isDeactivated: TextCheck.isEmpty(text.text),
                      onTap: () => _onDeleteLastNode(),
                    ),

                    const SizedBox(
                      width: 5,
                      height: 5,
                    ),

                    /// REMOVE LAST NODE
                    DreamBox(
                      height: 40,
                      verseScaleFactor: 0.6,
                      color: Colorz.blue80,
                      verse:'Add Data creator',
                      verseItalic: true,
                      isDeactivated: TextCheck.isEmpty(text.text),
                      onTap: () => _onAddDataCreator(),
                    ),

                  ],
                );

              }),

              const Horizon(),

            ],
          );

        },
      ),
    );

  }
// -----------------------------------------------------------------------------
}
