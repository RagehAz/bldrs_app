import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/widgets/general/bubbles/following_bzz_bubble.dart';
import 'package:bldrs/b_views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/c_controllers/g_user_screen_controller.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserFollowingPage extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const UserFollowingPage({
    @required this.userModel,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final UserModel userModel;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: true);
    final List<BzModel> _followedBzz = _bzzProvider.followedBzz;

    return Column(
      children: <Widget>[

        FollowingBzzBubble(
          bzzModels: _followedBzz,
        ),

        const Expander(),

        Align(
          alignment: superCenterAlignment(context),
          child: DreamBox(
            height: 50,
            margins: const EdgeInsets.all(Ratioz.appBarMargin),
            // width: Scale.appBarWidth(context),
            color: Colorz.yellow255,
            verse: 'Invite Businesses you know',
            secondLine: 'To join Bldrs.net',
            secondLineColor: Colorz.black255,
            secondLineScaleFactor: 1.2,
            verseColor: Colorz.black255,
            verseCentered: false,
            icon: Iconz.bz,
            iconColor: Colorz.black255,
            iconSizeFactor: 0.7,
            onTap: () => onInviteBusinessesTap(context),
          ),
        ),

      ],
    );

  }
}
