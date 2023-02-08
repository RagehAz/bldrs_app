import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/b_bz/sub/author_model.dart';
import 'package:bldrs/b_views/f_bz/c_author_editor_screen/x_author_editor_screen_controller.dart';
import 'package:bldrs/b_views/f_bz/c_author_editor_screen/z_components/author_role_button.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/a_header/a_slate/d_labels/ffff_author_pic.dart';
import 'package:bldrs/b_views/z_components/bz_profile/authors_page/author_card.dart';
import 'package:bldrs/b_views/z_components/layouts/custom_layouts/floating_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/c_protocols/bz_protocols/provider/bzz_provider.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:bubbles/bubbles.dart';
import 'package:flutter/material.dart';
import 'package:scale/scale.dart';

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
  // -----------------------------------------------------------------------------
  ValueNotifier<AuthorRole> _tempRole;
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
    _tempRole = ValueNotifier(widget.authorModel.role);
  }
  // --------------------
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
  // --------------------
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
      mounted: mounted,
    );

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final BzModel _bzModel = BzzProvider.proGetActiveBzModel(
      context: context,
      listen: true,
    );

    return FloatingLayout(
      skyType: SkyType.black,
      columnChildren: <Widget>[

        Bubble(
          bubbleHeaderVM: const BubbleHeaderVM(
              centered: true
          ),
          margin: Scale.constantMarginsAll20,
          columnChildren: <Widget>[

            /// PADDING
            const SizedBox(
              width: 20,
              height: 20,
            ),

            /// USER PIC
            Center(
              child: AuthorPic(
                size: 100,
                authorPic: widget.authorModel.picPath,
              ),
            ),

            /// USER NAME
            SuperVerse(
              verse: Verse(
                text: widget.authorModel.name,
                translate: false,
              ),
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
              verse: Verse(
                text: AuthorModel.getAuthorRolePhid(
                  context: context,
                  role: widget.authorModel.role,
                ),
                translate: true,
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
                    verse: const Verse(
                      text: 'phid_account_creator',
                      translate: true,
                    ),
                    isOn: role == AuthorRole.creator,
                    icon: Iconz.normalUser,
                    onTap: () => _setAuthorRole(AuthorRole.creator),
                  ),

                  AuthorRoleButton(
                    verse: const Verse(
                      text: 'phid_team_member',
                      translate: true
                    ),
                    isOn: role == AuthorRole.teamMember,
                    icon: Iconz.normalUser,
                    onTap: () => _setAuthorRole(AuthorRole.teamMember),
                  ),

                  AuthorRoleButton(
                    verse: const Verse(
                      text: 'phid_account_moderator',
                      translate: true,
                    ),
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
  // -----------------------------------------------------------------------------
}
