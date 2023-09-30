// ignore_for_file: unused_element
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/b_views/f_bz/a_bz_profile_screen/b_about_page/aaa2_bz_about_page.dart';
import 'package:bldrs/b_views/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/loading/loading_full_screen_layer.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:basics/bldrs_theme/night_sky/night_sky.dart';
import 'package:bldrs/c_protocols/bz_protocols/protocols/a_bz_protocols.dart';
import 'package:bldrs/f_helpers/router/d_bldrs_nav.dart';
import 'package:flutter/material.dart';

class BzPreviewScreen extends StatefulWidget {
  // --------------------------------------------------------------------------
  const BzPreviewScreen({
    required this.bzID,
    super.key
  });
  // --------------------
  final String? bzID;
  // --------------------
  @override
  State<BzPreviewScreen> createState() => _BzPreviewScreenState();
  // --------------------------------------------------------------------------
}

class _BzPreviewScreenState extends State<BzPreviewScreen> {
  // --------------------
  bool _loading = true;
  BzModel? bzModel;
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {

    if (_isInit && mounted) {
      _isInit = false; // good

      asyncInSync(() async {
        // -------------------------------
        final BzModel? _bzModel = await BzProtocols.fetchBz(
          bzID: widget.bzID,
        );

        if (mounted){
          setState(() {
            _loading = false;
            bzModel = _bzModel;
          });
        }
        // -----------------------------
      });

    }

    super.didChangeDependencies();
  }
  // --------------------
  @override
  Widget build(BuildContext context) {

    bzModel?.blogBz(invoker: 'BzPreviewScreen');

    final bool _bzIsNotFound = bzModel == null || bzModel?.id == null || bzModel?.name == null;

    return MainLayout(
      skyType: SkyType.grey,
      pyramidsAreOn: true,
      title: Verse(
        id: bzModel?.name,
        translate: false,
      ),
      onBack: () => BldrsNav.backFromPreviewScreen(),
      appBarType: AppBarType.basic,
      // appBarRowWidgets: <Widget>[
      //
      //   const Expander(),
      //
      //   if (imAdmin(context) == true)
      //     AppBarButton(
      //       verse: Verse.plain('refetch'),
      //       onTap: () async {
      //
      //         await Nav.jumpToBzPreviewScreen(
      //             context: context,
      //             bzID: bzModel.id,
      //         );
      //
      //       },
      //     ),
      //
      // ],
      child:
      _loading == true ?
      const LoadingFullScreenLayer()
          :
      _bzIsNotFound == true ?
      const _NoBzFoundView()
          :
      BzAboutPage(
        bzModel: bzModel,
        showGallery: true,
        showAuthors: true,
        // showContacts: true,
      ),
    );

  }
  // --------------------
}

class _NoBzFoundView extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const _NoBzFoundView({
    super.key
  });
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return const Stack(
      alignment: Alignment.center,
      children: <Widget>[

        BldrsBox(
          height: 400,
          width: 400,
          icon: Iconz.bz,
          bubble: false,
          opacity: 0.04,
        ),

        BldrsText(
        verse: Verse(
          id: 'phid_bz_account_not_found',
          translate: true,
        ),
        size: 3,
        maxLines: 2,
      ),

      ],
    );

  }
  // -----------------------------------------------------------------------------
}
