import 'package:bldrs/a_models/ui/keyboard_model.dart';
import 'package:bldrs/b_views/z_components/animators/widget_fader.dart';
import 'package:bldrs/b_views/z_components/app_bar/bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/back_anb_search_button.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/super_text_field/a_super_text_field.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
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
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colorz.skyDarkBlue,
        body: ListView(
          children: <Widget>[

            const Stratosphere(),

            SuperTextField(
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
                );

                _uiProvider.setKeyboard(
                    model: model,
                    notify: true);

              },
            ),

          ],
        ),
        bottomSheet: const KeyboardFieldWidget(),

      ),
    );

  }
}

class KeyboardFieldWidget extends StatelessWidget {

  const KeyboardFieldWidget({
    Key key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final bool _keyboardIs = keyboardIsOn(context);

    if (_keyboardIs == false){
      return const SizedBox();
    }

    else {
      return Container(
        width: Scale.superScreenWidth(context),
        height: 300,
        color: Colorz.grey80,
        alignment: Alignment.bottomCenter,
        child: WidgetFader(
          fadeType: FadeType.fadeIn,
          duration: const Duration(milliseconds: 250),
          builder: (double value, Widget child){

            blog('widget fader : $value');

            return Transform.scale(
              scaleY: value,
              alignment: Alignment.bottomCenter,
              child: Opacity(
                opacity: value,
                child: child,
              ),
            );

          },
          child: Selector<UiProvider, KeyboardModel>(
            selector: (_, UiProvider uiProvider) => uiProvider.keyboardModel,
            builder: (_, KeyboardModel model, Widget child){

              return Stack(
                alignment: Alignment.topCenter,
                children: <Widget>[

                  Bubble(
                    width: BldrsAppBar.width(context),
                    bubbleColor: Colorz.black230,
                    centered: true,
                    columnChildren: <Widget>[

                      SuperVerse(
                        verse: model?.title?.toUpperCase(),
                        margin: 10,
                        italic: true,
                        weight: VerseWeight.black,
                      ),

                      SuperTextField(
                        width: BldrsAppBar.width(context) - 20,
                        textSize: 3,
                        minLines: model?.minLines,
                        maxLines: model?.maxLines,
                        maxLength: model?.maxLength,
                        textController: model?.controller,
                        keyboardTextInputAction: model?.textInputAction,
                        keyboardTextInputType: model?.textInputType,
                        hintText: model?.hintText,
                      ),

                    ],
                  ),

                  Container(
                    width: BldrsAppBar.width(context),
                    height: 50,
                    margin: const EdgeInsets.only(top: 10),
                    alignment: superCenterAlignment(context),
                    padding: const EdgeInsets.all(5),
                    child: BackAndSearchButton(
                      backAndSearchAction: BackAndSearchAction.goBack,
                      onTap: (){
                        closeKeyboard(context);
                      },
                    ),
                  ),

                ],
              );

            },
          ),
        ),
      );
    }

  }
}
