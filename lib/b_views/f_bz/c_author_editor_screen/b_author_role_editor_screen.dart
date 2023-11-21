import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/bubbles/bubble/bubble.dart';
import 'package:basics/bubbles/model/bubble_header_vm.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/b_bz/sub/author_model.dart';
import 'package:bldrs/b_views/f_bz/c_author_editor_screen/x_author_editor_screen_controller.dart';
import 'package:bldrs/b_views/f_bz/c_author_editor_screen/z_components/author_role_button.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/a_header/a_slate/d_labels/ffff_author_pic.dart';
import 'package:bldrs/b_views/z_components/bz_profile/authors_page/author_card.dart';
import 'package:bldrs/b_views/z_components/layouts/custom_layouts/floating_layout.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:basics/bldrs_theme/night_sky/night_sky.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/c_protocols/bz_protocols/provider/bzz_provider.dart';
import 'package:flutter/material.dart';
import 'package:basics/helpers/classes/space/scale.dart';

class AuthorRoleEditorScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const AuthorRoleEditorScreen({
    required this.authorModel,
    super.key
  });
  /// --------------------------------------------------------------------------
  final AuthorModel? authorModel;
  /// --------------------------------------------------------------------------
  @override
  _AuthorRoleEditorScreenState createState() => _AuthorRoleEditorScreenState();
  /// --------------------------------------------------------------------------
}

class _AuthorRoleEditorScreenState extends State<AuthorRoleEditorScreen> {
  // -----------------------------------------------------------------------------
  late ValueNotifier<AuthorRole?> _tempRole;
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  /*
  Future<void> _triggerLoading({required bool setTo}) async {
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
    _tempRole = ValueNotifier(widget.authorModel?.role);
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {

    if (_isInit && mounted) {
      _isInit = false; // good

      // _triggerLoading().then((_) async {
      //
      //   await _triggerLoading();
      // });

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
      oldAuthor: widget.authorModel,
      selectedRole: role,
      tempRole: _tempRole,
      mounted: mounted,
    );

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final BzModel? _bzModel = BzzProvider.proGetActiveBzModel(
      context: context,
      listen: true,
    );

    final double _bubbleWidth = Bubble.bubbleWidth(context: context);

    return FloatingLayout(
      canSwipeBack: false,
      skyType: SkyType.grey,
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
                authorPic: widget.authorModel?.picPath,
              ),
            ),

            /// USER NAME
            BldrsText(
              width: _bubbleWidth,
              verse: Verse(
                id: widget.authorModel?.name,
                translate: false,
              ),
              shadow: true,
              size: 4,
              margin: 5,
              maxLines: 2,
              labelColor: Colorz.white10,
            ),

            /// JOB TITLE
            BldrsText(
              width: _bubbleWidth,
              italic: true,
              weight: VerseWeight.thin,
              verse: AuthorCard.getAuthorTitleLine(
                title: widget.authorModel?.title,
                companyName: _bzModel?.name,
              ),
              maxLines: 3,
            ),

            /// AUTHOR ROLE
            BldrsText(
              width: _bubbleWidth,
              italic: true,
              weight: VerseWeight.thin,
              verse: Verse(
                id: AuthorModel.getAuthorRolePhid(
                  role: widget.authorModel?.role,
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

        ValueListenableBuilder<AuthorRole?>(
            valueListenable: _tempRole,
            builder: (_, AuthorRole? role, Widget? child){

              return Column(
                children: <Widget>[

                  BldrsText(
                    width: AuthorRoleButton.getWidth(context),
                    verse: const Verse(
                      id: 'phid_select_role',
                      translate: true,
                      casing: Casing.upperCase
                    ),
                    italic: true,
                    maxLines: 2,
                    size: 3,
                    margin: 20,
                  ),

                  AuthorRoleButton(
                    verse: const Verse(
                      id: 'phid_creator',
                      translate: true,
                    ),
                    isOn: role == AuthorRole.creator,
                    icon: Iconz.normalUser,
                    onTap: () => _setAuthorRole(AuthorRole.creator),
                  ),

                  AuthorRoleButton(
                    verse: const Verse(
                      id: 'phid_teamMember',
                      translate: true
                    ),
                    isOn: role == AuthorRole.teamMember,
                    icon: Iconz.normalUser,
                    onTap: () => _setAuthorRole(AuthorRole.teamMember),
                  ),

                  AuthorRoleButton(
                    verse: const Verse(
                      id: 'phid_moderator',
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
