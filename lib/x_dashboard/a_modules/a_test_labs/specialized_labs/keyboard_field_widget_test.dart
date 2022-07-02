import 'package:bldrs/a_models/ui/keyboard_model.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/keyboard_field/a_keyboard_floating_field.dart';
import 'package:bldrs/b_views/z_components/texting/super_text_field/a_super_text_field.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class KeyboardFieldWidgetTest extends StatefulWidget {

  const KeyboardFieldWidgetTest({
    Key key
  }) : super(key: key);

  @override
  State<KeyboardFieldWidgetTest> createState() => _KeyboardFieldWidgetTestState();

}

class _KeyboardFieldWidgetTestState extends State<KeyboardFieldWidgetTest> {

  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colorz.skyDarkBlue,

        body: ListView(
          children: <Widget>[

            const Stratosphere(),

            SuperTextField(
              title: 'Test',
              width: 200,
              fieldColor: Colorz.bloodTest,
              textController: _controller,
              onTap: () async {

                final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);

                final KeyboardModel model = KeyboardModel(
                  title: 'Hey There !',
                  hintText: null,
                  controller: _controller,
                  minLines: 1,
                  maxLines: 5,
                  maxLength: 100,
                  textInputAction: TextInputAction.newline,
                  textInputType: TextInputType.multiline,
                  focusNode: FocusNode(),
                  canObscure: false,
                  counterIsOn: false,
                );

                _uiProvider.setKeyboard(
                    model: model,
                    notify: true);

              },
            ),

          ],
        ),
        bottomSheet: const KeyboardFloatingField(),

      ),
    );

  }
}
