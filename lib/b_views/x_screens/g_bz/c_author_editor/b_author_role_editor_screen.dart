import 'package:bldrs/a_models/bz/author_model.dart';
import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/bz_profile/authors_page/author_card.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/a_header/author_label.dart';
import 'package:bldrs/b_views/z_components/layouts/custom_layouts/centered_list_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/c_controllers/g_bz_controllers/c_author_editor/a_author_editor_controller.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:flutter/material.dart';

class AuthorRoleEditorScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const AuthorRoleEditorScreen({
    @required this.authorModel,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final AuthorModel authorModel;
  /// --------------------------------------------------------------------------
  @override
  _AuthorRoleEditorScreenState createState() => _AuthorRoleEditorScreenState();
/// --------------------------------------------------------------------------
}

class _AuthorRoleEditorScreenState extends State<AuthorRoleEditorScreen> {

  ValueNotifier<AuthorRole> _authorRole;
// -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false); /// tamam disposed
// -----------
  /*
  Future<void> _triggerLoading({bool setTo}) async {
    if (mounted == true){
      if (setTo == null){
        _loading.value = !_loading.value;
      }
      else {
        _loading.value = setTo;
      }
      blogLoading(loading: _loading.value, callerName: 'AuthorRoleEditorScreen',);
    }
  }
   */
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    _authorRole = ValueNotifier(widget.authorModel.role);
  }
// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      // _triggerLoading().then((_) async {
      //
      //   await _triggerLoading();
      // });

      _isInit = false;
    }
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {

    _loading.dispose();
    _authorRole.dispose();

    super.dispose();
  }
// -----------------------------------------------------------------------------
  Future<void> _setAuthorRole(AuthorRole role) async {

    final bool _canChangeRole = await _checkCanChangeRole(role);

    if (_canChangeRole == true){

      _authorRole.value = role;

      await onChangeAuthorRoleOps(
        context: context,
        authorRole: _authorRole,
        author: widget.authorModel,

      );

    }

  }
// -----------------------------------------------------------------------------
  Future<bool> _checkCanChangeRole(AuthorRole role) async {
    bool _canChange = false;

    /// IF AUTHOR IS ALREADY THE CREATOR
    if (widget.authorModel.role == AuthorRole.creator){

      /// WHEN CHOOSING SOMETHING OTHER THAN CREATOR
      if (role != AuthorRole.creator){

        await CenterDialog.showCenterDialog(
          context: context,
          titleVerse: '##Can Not Demote Account creator',
          bodyVerse: '##the Author Role of ${widget.authorModel.name} can not be changed.',
        );

      }

    }

    /// IF AUTHOR IS NOT THE CREATOR
    else {

      /// WHEN CHOOSING CREATOR
      if (role == AuthorRole.creator){

        await CenterDialog.showCenterDialog(
          context: context,
          titleVerse: '##Only one account creator is allowed',
        );

      }

      /// WHEN CHOOSING OTHER THAN CREATOR
      else {
        _canChange = true;
      }

    }

    return _canChange;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final BzModel _bzModel = BzzProvider.proGetActiveBzModel(
        context: context,
        listen: true,
    );

    return CenteredListLayout(
      skyType: SkyType.black,
      columnChildren: <Widget>[

        Bubble(
            centered: true,
            margins: Scale.superMargins(
              margins: 20
            ),
            columnChildren: <Widget>[

              /// PADDING
              const SizedBox(
                width: 20,
                height: 20,
              ),

              /// USER PIC
              Center(
                child: AuthorPic(
                  width: 100,
                  authorPic: widget.authorModel.pic,
                ),
              ),

              /// USER NAME
              SuperVerse(
                verse: widget.authorModel.name,
                shadow: true,
                size: 4,
                margin: 5,
                maxLines: 2,
                labelColor: Colorz.white10,
              ),

              /// JOB TITLE
              SuperVerse(
                italic: true,
                weight: VerseWeight.thin,
                verse: AuthorCard.getAuthorTitleLine(
                  title: widget.authorModel.title,
                  companyName: _bzModel.name,
                ),
              ),

              /// AUTHOR ROLE
              SuperVerse(
                italic: true,
                weight: VerseWeight.thin,
                verse: AuthorModel.translateRole(
                  context: context,
                  role: widget.authorModel.role,
                ),
              ),

              /// PADDING
              const SizedBox(
                width: 20,
                height: 20,
              ),

            ],
          ),

        ValueListenableBuilder<AuthorRole>(
            valueListenable: _authorRole,
            builder: (_, AuthorRole role, Widget child){

              return Column(
                children: <Widget>[

                  FuckingButtonAuthorShit(
                    verse: '##Account Creator',
                    isOn: role == AuthorRole.creator,
                    icon: Iconz.normalUser,
                    onTap: () => _setAuthorRole(AuthorRole.creator),
                  ),

                  FuckingButtonAuthorShit(
                    verse: '##Team member',
                    isOn: role == AuthorRole.teamMember,
                    icon: Iconz.normalUser,
                    onTap: () => _setAuthorRole(AuthorRole.teamMember),
                  ),

                  FuckingButtonAuthorShit(
                    verse: '##Account Moderator',
                    isOn: role == AuthorRole.moderator,
                    icon: Iconz.bz,
                    onTap: () => _setAuthorRole(AuthorRole.moderator),
                  ),

                ],
              );

            }
        ),




      ],
    );

  }
}

class FuckingButtonAuthorShit extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FuckingButtonAuthorShit({
    @required this.verse,
    @required this.isOn,
    @required this.icon,
    this.onTap,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final String verse;
  final Function onTap;
  final bool isOn;
  final String icon;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return DreamBox(
      height: 50,
      width: 300,
      verse: isOn == true ? verse.toUpperCase() : verse,
      icon: icon,
      iconSizeFactor: 0.6,
      verseScaleFactor: 1.5,
      color: isOn == true ? Colorz.yellow255 : Colorz.nothing,
      iconColor: isOn == true ? Colorz.black255 : Colorz.white255,
      verseColor: isOn == true ? Colorz.black255 : Colorz.white255,
      verseShadow: false,
      verseWeight: isOn == true ? VerseWeight.black : VerseWeight.thin,
      verseItalic: true,
      margins: Scale.superInsets(
          context: context,
          bottom: 10,
      ),
      onTap: onTap,
    );
  }

}
