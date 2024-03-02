import 'package:basics/components/bubbles/bubble/bubble.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/space/scale.dart';
import 'package:basics/helpers/strings/stringer.dart';
import 'package:basics/helpers/strings/text_check.dart';
import 'package:bldrs/a_models/x_secondary/contact_model.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:bldrs/z_components/bubbles/a_structure/bldrs_bubble_header_vm.dart';
import 'package:bldrs/z_components/bubbles/b_variants/text_field_bubble/text_field_bubble.dart';
import 'package:bldrs/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/z_components/texting/bullet_points/bldrs_bullet_points.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

class SocialFieldEditorBubble extends StatefulWidget {
  // --------------------------------------------------------------------------
  const SocialFieldEditorBubble({
    required this.contacts,
    required this.onContactChanged,
    this.forbiddenLinks = const [],
    super.key
  });
  // --------------------
  final List<ContactModel>? contacts;
  final Function(ContactModel contact) onContactChanged;
  final List<String> forbiddenLinks;
  // --------------------
  @override
  _SocialFieldEditorBubbleState createState() => _SocialFieldEditorBubbleState();
  // --------------------------------------------------------------------------
}

class _SocialFieldEditorBubbleState extends State<SocialFieldEditorBubble> {
  // -----------------------------------------------------------------------------
  List<ContactModel> _socialContacts = [];
  final List<TextEditingController> _controllers = [];
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    _socialContacts = ContactModel.filterSocialMediaContacts(widget.contacts);

    _controllers.addAll(
      List.generate(_socialContacts.length, (index) => TextEditingController())
    );

    for (final ContactModel social in _socialContacts) {
      final int _index = _socialContacts.indexOf(social);
      _controllers[_index].text = social.value ?? '';
    }

  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {

    if (_isInit && mounted) {
      _isInit = false; // good

      asyncInSync(() async {

      });

    }
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void didUpdateWidget(SocialFieldEditorBubble oldWidget) {
    super.didUpdateWidget(oldWidget);

    /// NO NEED
    if (
    ContactModel.checkContactsListsAreIdentical(
      contacts1: widget.contacts,
      contacts2: oldWidget.contacts,
    ) == false
    ) {

      setState(() {
        _socialContacts = ContactModel.filterSocialMediaContacts(widget.contacts);

      });

      for (final ContactModel social in _socialContacts) {
        final int _index = _socialContacts.indexOf(social);
        _controllers[_index].text = social.value ?? '';
      }

    }
  }
  // --------------------
  @override
  void dispose() {
    super.dispose();
    for (final TextEditingController controller in _controllers) {
      controller.dispose();
    }
  }
  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onPasteURL({
    required ContactModel contact,
    required String? text,
  }) async {

    if (TextCheck.isEmpty(text) == false){

      final ContactModel _newContact = contact.copyWith(
        value: text,
      );

      final int _index = _socialContacts.indexOf(contact);
      _controllers[_index].text = text!;

      widget.onContactChanged(_newContact);

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void _onContactChanged(ContactModel contact, String? value){

      final ContactModel _newContact = contact.copyWith(
        value: value,
      );

      widget.onContactChanged(_newContact);

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _clearWidth = Bubble.clearWidth(context: context);
    final bool _appIsLTR = UiProvider.checkAppIsLeftToRight();
    // --------------------
    return Bubble(
      bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
        context: context,
        headlineVerse: const Verse(
          id: 'phid_social_media_contacts',
          translate: true,
        ),
      ),
      appIsLTR: _appIsLTR,
      hasBottomPadding: false,
      columnChildren: <Widget>[

        const BldrsBulletPoints(
            bulletPoints: <Verse>[
              Verse(id: 'phid_fields_are_optional', translate: true),
            ],
          showBottomLine: false,
        ),

        /// SELECTED CONTACT TYPES
        ...List.generate(_socialContacts.length, (index){

          final ContactModel _contact = _socialContacts[index];

          return BldrsTextFieldBubble(
            appBarType: AppBarType.non,
            // hasBottomPadding: true,
            bubbleWidth: _clearWidth,
            textController: _controllers[index],
            bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
              context: context,
            ),
            textSize: 1,
            pasteFunction: (String? text) => _onPasteURL(
              contact: _contact,
              text: text,
            ),
            onTextChanged: (String? text) => _onContactChanged(_contact, text),
            leadingIcon: ContactModel.concludeContactIcon(
              contactType: _contact.type,
              isPublic: true,
            ),
            textDirection: TextDirection.ltr,
            hintTextDirection: TextDirection.ltr,
            keyboardTextInputType: TextInputType.url,
            validator: (String? text){

              final String? _error = Formers.socialLinkValidator(
                url: text,
                contactType: _contact.type,
                isMandatory: false,
              );

              if (_error != null){
                return _error;
              }
              else {

                if (Lister.checkCanLoop(widget.forbiddenLinks) == false){
                  return null;
                }
                else {

                  final bool _isUsed = Stringer.checkStringsContainString(
                      strings: widget.forbiddenLinks,
                      string: text,
                  );

                  if (_isUsed == true){
                    return 'This link can not be used';
                  }
                  else {
                    return null;
                  }

                }

              }

            },
          );

        }),

      ],
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}

class SocialBox extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const SocialBox({
    required this.type,
    required this.onTap,
    this.size = 30,
    super.key,
  });
  // --------------------
  final ContactType type;
  final double size;
  final Function onTap;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return BldrsBox(
      height: size,
      width: size,
      icon: ContactModel.concludeContactIcon(
        contactType: type,
        isPublic: true,
      ),
      margins: Scale.superInsets(
        context: context,
        appIsLTR: UiProvider.checkAppIsLeftToRight(),
        enRight: 5,
      ),
      onTap: onTap,
    );

  }
  // -----------------------------------------------------------------------------
}
