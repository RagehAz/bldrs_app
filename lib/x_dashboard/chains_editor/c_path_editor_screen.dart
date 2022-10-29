import 'package:bldrs/a_models/c_chain/aa_chain_path_converter.dart';
import 'package:bldrs/a_models/c_chain/aaa_phider.dart';
import 'package:bldrs/a_models/c_chain/dd_data_creation.dart';
import 'package:bldrs/a_models/x_utilities/keyboard_model.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble_header.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/text_field_bubble/text_field_bubble.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/text_mod.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/x_dashboard/phrase_editor/x_phrase_editor_controllers.dart';
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

    /// DATA CREATOR IS MISPLACED
    final String _dataCreatorValidation = _dataCreatorValidator(path);
    if (_dataCreatorValidation != null){
      _message = _dataCreatorValidation;
    }

    else {

      /// ALWAYS START WITH PHID
      if (Mapper.checkCanLoopList(_nodes) == true){
        for (int i = 0; i < _nodes.length; i++){
          final String _node = Phider.removeIndexFromPhid(phid: _nodes[i]);
          if (_pathHasDataCreator(_node) == false){
            final bool _startsWith = TextCheck.stringStartsExactlyWith(
              text: _node,
              startsWith: 'phid_',
            );
            if (_startsWith == false){
              _message = 'node ${i+1} : ( $_node ) : should start with "phid_"';
            }
          }
        }
      }

      /// NOT LESS THAN 2 NODES
      if (_nodes.length < 2){
        _message = 'Path should at-least have 2 nodes';
      }

      /// NO EMPTY SPACES
      if (TextCheck.stringContainsSubString(string: path, subString: ' ') == true){
        _message = 'Path should not have Empty spaces';
      }

    }




    return _message;
  }
  // --------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static String _dataCreatorValidator(String path){
    String _message;

    if (TextCheck.isEmpty(path) == false){

      final bool _pathContains = _pathHasDataCreator(path);

      if (_pathContains == true){

        final List<String> _nodes = ChainPathConverter.splitPathNodes('${path}x');

        if (_nodes.length > 2){
          _message = 'DataCreator chain can only have two nodes';
        }
        else if (_nodes.length == 1){
          _message = 'DataCreator can only be in second node in a two nodes chain';
        }
        else if (_nodes.length > 1){

          final bool _isAtSecondNode = _pathHasDataCreator(_nodes[1]);

          if (_isAtSecondNode == false){
            _message = 'Where the fuck did you place the DataCreator man ?';
          }

        }

      }

    }

    return _message;
  }
  // --------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static bool _pathHasDataCreator(String path){
    return TextCheck.stringContainsSubString(
      string: path,
      subString: 'DataCreator',
    );
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

    _keyboardModel = KeyboardModel.standardModel().copyWith(
      globalKey: GlobalKey<FormState>(),
      focusNode: FocusNode(),
      titleVerse: const Verse(
        text: 'Edit path',
        translate: false,
      ),
      hintVerse: const Verse(
        text: 'phid_aaa/phid_bbb ...',
        translate: false,
      ),
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
  /// TESTED : WORKS PERFECT
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
  /// TESTED : WORKS PERFECT
  Future<void> _onSubmit (String text) async {

    Keyboard.closeKeyboard(context);

    await Nav.goBack(
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
  /// TESTED : WORKS PERFECT
  void _onAddTextAtEnd(String text){
    _setController('${_controller.text}$text');
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onPickPhid() async {

    final String _phid = await pickAPhidFast(context);

    if (TextCheck.isEmpty(_phid) == false){
      _setController('${_controller.text}$_phid/');
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onAddDataCreator() async {

    await BottomDialog.showButtonsBottomDialog(
        context: context,
        draggable: true,
        numberOfWidgets: DataCreation.dataCreatorsList.length,
        buttonHeight: 40,
        builder: (_){

          return <Widget>[

            ...List.generate(DataCreation.dataCreatorsList.length, (index){

              final DataCreator _dataCreator = DataCreation.dataCreatorsList[index];
              final String _dataCreatorString = DataCreation.cipherDataCreator(_dataCreator);

              return BottomDialog.wideButton(
                  height: 40,
                  context: context,
                  verse: Verse.plain(_dataCreatorString),
                  onTap: () async {
                    await Nav.goBack(context: context, invoker: '_onAddDataCreator');
                    _setController('${_controller.text}$_dataCreatorString');
                  }
                  );

            }),

          ];

        }
        );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onClear() async {

    if (TextCheck.textControllerIsEmpty(_controller) == false){

      final bool _result = await Dialogs.bottomBoolDialog(
        context: context,
        titleVerse: Verse.plain('Clear Path ?'),
      );

      if (_result == true){
        _setController('');
      }

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onDeleteLastNode() async {

    if (TextCheck.textControllerIsEmpty(_controller) == false){

      final String _lastNode = ChainPathConverter.getLastPathNode(_controller.text);

      final bool _result = await Dialogs.bottomBoolDialog(
        context: context,
        titleVerse: Verse.plain('Delete last node ( $_lastNode ) ?'),
      );

      if (_result == true){
        _setController(ChainPathConverter.removeLastPathNode(path: _controller.text));
      }

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void _setController(String text){
    _controller.text = text;
    TextMod.setControllerSelectionAtEnd(_controller);
    Formers.focusOnNode(_keyboardModel.focusNode);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  bool _canAddDataCreator(){

    final bool _hasSlash = TextCheck.stringContainsSubString(string: _controller.text, subString: '/');
    final List<String> _nodes = ChainPathConverter.splitPathNodes('${_controller.text}x');

    bool _canAdd = false;

    if (_hasSlash == true){
      if (_nodes.length > 1 && _nodes.length < 3){
        _canAdd = true;
      }
    }

    if (PathEditorScreen._pathHasDataCreator(_controller.text) == true){
      _canAdd = false;
    }

    return _canAdd;
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return MainLayout(
      skyType: SkyType.black,
      appBarType: AppBarType.basic,
      layoutWidget: ValueListenableBuilder(
        valueListenable: _canSubmit,
        builder: (_, bool canSubmit, Widget child){

          return Column(
            children: <Widget>[

              const Stratosphere(),

              /// TEXT FIELD
              TextFieldBubble(
                focusNode: _keyboardModel.focusNode,
                headerViewModel: BubbleHeaderVM(
                  headlineVerse: _keyboardModel.titleVerse
                ),
                formKey: _keyboardModel.globalKey,
                appBarType: AppBarType.basic,
                isFloatingField: _keyboardModel.isFloatingField,
                textController: _controller,
                maxLines: _keyboardModel.maxLines,
                minLines: _keyboardModel.minLines,
                maxLength: _keyboardModel.maxLength,
                hintVerse: _keyboardModel.hintVerse,
                counterIsOn: _keyboardModel.counterIsOn,
                keyboardTextInputType: _keyboardModel.textInputType,
                keyboardTextInputAction: _keyboardModel.textInputAction,
                autoFocus: true,
                isFormField: _keyboardModel.isFormField,
                onSubmitted: _onSubmit,
                // autoValidate: true,
                validator: (String text) => _keyboardModel.validator(_controller.text),
                onTextChanged: _onTextChanged,
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
                      verse: const Verse(
                        text: 'pick phid',
                        translate: false,
                      ),
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
                      verse: const Verse(
                        text: 'Add "phid_"',
                        translate: false,
                      ),
                      verseItalic: true,
                      onTap: () => _onAddTextAtEnd('phid_'),
                    ),

                    const SizedBox(
                      width: 5,
                      height: 10,
                    ),

                    /// ADD /
                    DreamBox(
                      height: 40,
                      verseScaleFactor: 0.6,
                      color: Colorz.blue80,
                      verse: const Verse(
                        text: 'Add "/"',
                        translate: false,
                      ),
                      verseItalic: true,
                      onTap: () => _onAddTextAtEnd('/'),
                    ),

                    const Expander(),

                    /// CONFIRM
                    DreamBox(
                      isDeactivated: !canSubmit,
                      height: 40,
                      color: Colorz.green50,
                      verseScaleFactor: 0.6,
                      verse: const Verse(
                        text: '- Confirm -',
                        translate: false,
                        casing: Casing.upperCase,
                      ),
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

              /// CLEAR - REMOVE LAST NODE - ADD DATA CREATOR
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
                      verse: const Verse(
                        text: 'Clear',
                        translate: false,
                      ),
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
                      verse: const Verse(
                        text: 'Remove last Node',
                        translate: false,
                      ),
                      verseItalic: true,
                      isDeactivated: TextCheck.isEmpty(text.text),
                      onTap: () => _onDeleteLastNode(),
                    ),

                    const SizedBox(
                      width: 5,
                      height: 5,
                    ),

                    /// ADD DATA CREATOR
                    DreamBox(
                      height: 40,
                      verseScaleFactor: 0.6,
                      color: Colorz.blue80,
                      verse: const Verse(
                        text: 'Add Data creator',
                        translate: false,
                      ),
                      verseItalic: true,
                      isDeactivated: !_canAddDataCreator(),
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
