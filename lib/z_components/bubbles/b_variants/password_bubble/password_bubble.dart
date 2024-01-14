import 'package:basics/animators/widgets/widget_fader.dart';
import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bubbles/bubble/bubble.dart';
import 'package:bldrs/z_components/bubbles/a_structure/bldrs_bubble_header_vm.dart';
import 'package:bldrs/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/z_components/bubbles/b_variants/text_field_bubble/text_field_bubble.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/f_helpers/drafters/bldrs_aligners.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:flutter/material.dart';

class PasswordBubbles extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const PasswordBubbles({
    required this.appBarType,
    required this.passwordController,
    required this.showPasswordOnly,
    required this.passwordValidator,
    required this.onSubmitted,
    required this.passwordConfirmationController,
    required this.passwordConfirmationValidator,
    required this.passwordNode,
    required this.confirmPasswordNode,
    required this.isObscured,
    required this.onForgotPassword,
    this.bubbleWidth,
    this.isTheSuperKeyboardField = false,
    this.goOnKeyboardGo = true,
    this.mainAxisAlignment,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double? bubbleWidth;
  final TextEditingController passwordController;
  final bool showPasswordOnly;
  final String? Function(String?)? passwordValidator;
  final Function(String?)? onSubmitted;
  final TextEditingController? passwordConfirmationController;
  final String? Function(String?)? passwordConfirmationValidator;
  final bool isTheSuperKeyboardField;
  final AppBarType appBarType;
  final FocusNode passwordNode;
  final FocusNode? confirmPasswordNode;
  final bool goOnKeyboardGo;
  final ValueNotifier<bool> isObscured;
  final MainAxisAlignment? mainAxisAlignment;
  final Function onForgotPassword;
  /// --------------------------------------------------------------------------
  TextInputAction _getTextInputAction(){

    if (showPasswordOnly == true){
      return goOnKeyboardGo ? TextInputAction.go : TextInputAction.next;
    }

    else {
      return TextInputAction.next;
    }

  }
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final TextInputAction _keyboardAction = _getTextInputAction();

    return Column(
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
      children: <Widget>[

        /// PASSWORD
        BldrsTextFieldBubble(
          bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
            context: context,
            headlineVerse: const Verse(id: 'phid_password', translate: true),
            redDot: true,
          ),
          focusNode: passwordNode,
          appBarType: appBarType,
          bubbleWidth: bubbleWidth,
          isFormField: true,
          key: const ValueKey<String>('password'),
          textController: passwordController,
          textDirection: TextDirection.ltr,
          keyboardTextInputType: TextInputType.visiblePassword,
          keyboardTextInputAction: _keyboardAction,
          validator: passwordValidator,
          hintVerse: Verse.plain('...'),
          bulletPoints: const <Verse>[
            Verse(id: 'phid_min6Char', translate: true,),
          ],
          isObscured: isObscured,
          onSubmitted: (String? text){

            if (onSubmitted != null){
              onSubmitted?.call(text);
            }

            if (showPasswordOnly == false){
              Formers.focusOnNode(confirmPasswordNode);
            }

          },
          isFloatingField: isTheSuperKeyboardField,
          columnChildren: <Widget>[

            if (showPasswordOnly == true)
            Container(
              width: Bubble.clearWidth(context: context) - 35,
              alignment: BldrsAligners.superInverseCenterAlignment(context),
              child: BldrsBox(
                height: 30,
                verse: const Verse(
                  id: 'phid_forgot_password',
                  translate: true,
                ),
                color: Colorz.white10,
                verseScaleFactor: 0.95,
                verseWeight: VerseWeight.thin,
                corners: 5,
                bubble: false,
                onTap: onForgotPassword,
              ),
            ),

          ],
        ),

        /// CONFIRM PASSWORD
        if (showPasswordOnly == false)
          WidgetFader(
            fadeType: FadeType.fadeIn,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
            builder: (double value, Widget? child){

              return Transform.scale(
                scaleY: value,
                alignment: Alignment.topCenter,
                child: child,
              );

            },
            child: BldrsTextFieldBubble(
              bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
                context: context,
                headlineVerse: const Verse(
                  id: 'phid_confirmPassword',
                  translate: true,
                ),
                redDot: true,
              ),
              focusNode: confirmPasswordNode,
              appBarType: appBarType,
              isFormField: true,
              key: const ValueKey<String>('confirm'),
              textController: passwordConfirmationController,
              textDirection: TextDirection.ltr,
              keyboardTextInputType: TextInputType.visiblePassword,
              keyboardTextInputAction: _keyboardAction,
              validator: passwordConfirmationValidator,
              bulletPoints: const <Verse>[
                Verse(id: 'phid_min6Char', translate: true),
              ],
              isObscured: isObscured,
              onSubmitted: onSubmitted,
            ),
          ),

      ],

    );
  }
  /// --------------------------------------------------------------------------
}
