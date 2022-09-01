import 'package:bldrs/a_models/bz/author_model.dart';
import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/b_views/f_bz/c_author_editor_screen/x_author_editor_screen_controller.dart';
import 'package:bldrs/b_views/f_bz/c_author_editor_screen/z_components/author_role_button.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble_header.dart';
import 'package:bldrs/b_views/z_components/bz_profile/authors_page/author_card.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/a_header/author_label.dart';
import 'package:bldrs/b_views/z_components/layouts/custom_layouts/centered_list_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
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

  ValueNotifier<AuthorRole> _tempRole;
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
    _tempRole = ValueNotifier(widget.authorModel.role);
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

    _tempRole.dispose();
    _loading.dispose();

    super.dispose();
  }
// -----------------------------------------------------------------------------
  Future<void> _setAuthorRole(AuthorRole role) async {

    await setAuthorRole(
      context: context,
      oldAuthor: widget.authorModel,
      selectedRole: role,
      tempRole: _tempRole,
    );

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
          headerViewModel: const BubbleHeaderVM(
              centered: true
          ),
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
            valueListenable: _tempRole,
            builder: (_, AuthorRole role, Widget child){

              return Column(
                children: <Widget>[

                  AuthorRoleButton(
                    verse: '##Account Creator',
                    isOn: role == AuthorRole.creator,
                    icon: Iconz.normalUser,
                    onTap: () => _setAuthorRole(AuthorRole.creator),
                  ),

                  AuthorRoleButton(
                    verse: '##Team member',
                    isOn: role == AuthorRole.teamMember,
                    icon: Iconz.normalUser,
                    onTap: () => _setAuthorRole(AuthorRole.teamMember),
                  ),

                  AuthorRoleButton(
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