import 'package:bldrs/a_models/bz/author_model.dart';
import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/bz_profile/authors_page/author_card.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/a_header/author_label.dart';
import 'package:bldrs/b_views/z_components/layouts/custom_layouts/centered_list_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/unfinished_night_sky.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/c_controllers/f_bz_controllers/c_author_editor_controller.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
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

  ValueNotifier<bool> _isFuckingMaster;
// -----------------------------------------------------------------------------
  /// --- LOCAL LOADING BLOCK
  final ValueNotifier<bool> _loading = ValueNotifier(false); /// tamam disposed
  // Future<void> _triggerLoading() async {
  //   _loading.value = !_loading.value;
  //   blogLoading(
  //     loading: _loading.value,
  //     callerName: 'SearchBzzScreen',
  //   );
  // }
// -----------------------------------
  @override
  void initState() {
    super.initState();

    _isFuckingMaster = ValueNotifier(widget.authorModel.isMaster);
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
    _isFuckingMaster.dispose();

    super.dispose();
  }
// -----------------------------------------------------------------------------
  Future<void> _setIsMaster(bool x) async {
    _isFuckingMaster.value = x;

    await onChangeAuthorRoleOps(
      context: context,
      isMaster: _isFuckingMaster,
      author: widget.authorModel,

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
            centered: true,
            margins: superMargins(
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

              /// IS MASTER
              SuperVerse(
                italic: true,
                weight: VerseWeight.thin,
                verse: AuthorCard.getAuthorRoleLine(
                    isMaster: widget.authorModel.isMaster,
                ),
              ),

              /// PADDING
              const SizedBox(
                width: 20,
                height: 20,
              ),

            ],
          ),

        ValueListenableBuilder(
            valueListenable: _isFuckingMaster,
            builder: (_, bool isMaster, Widget child){

              return Column(
                children: <Widget>[

                  FuckingButtonAuthorShit(
                    verse: 'Team member',
                    isOn: !isMaster,
                    icon: Iconz.normalUser,
                    onTap: () => _setIsMaster(false),
                  ),

                  FuckingButtonAuthorShit(
                    verse: 'Account Admin',
                    isOn: isMaster,
                    icon: Iconz.bz,
                    onTap: () => _setIsMaster(true),
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
    @required this.onTap,
    @required this.isOn,
    @required this.icon,
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
      margins: superInsets(
          context: context,
          bottom: 10,
      ),
      onTap: onTap,
    );
  }

}
