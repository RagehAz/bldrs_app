import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/e_db/fire/ops/auth_ops.dart' as FireAuthOps;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class ReviewUserLabel extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ReviewUserLabel({
    @required this.tinyUser,
    @required this.hasEditButton,
    @required this.onReviewOptions,
    Key key,
  }) : super(key: key);

  /// --------------------------------------------------------------------------
  final UserModel tinyUser;
  final bool hasEditButton;
  final Function onReviewOptions;

  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        DreamBox(
          height: 40,
          // width: 40,
          margins: 5,
          icon: tinyUser?.pic,
          verse: tinyUser?.name,
          verseScaleFactor: 0.6,
          secondLine: tinyUser?.title,
          iconRounded: false,
          bubble: false,
          onTap: () => blog('aho'),
        ),
        const Expander(),
        if (tinyUser?.id == FireAuthOps.superUserID() && hasEditButton == true)
          DreamBox(
            height: 30,
            width: 30,
            icon: Iconz.more,
            iconSizeFactor: 0.6,
            margins:
                const EdgeInsets.symmetric(horizontal: Ratioz.appBarPadding),
            color: Colorz.white10,
            onTap: () => onReviewOptions(),
          ),
      ],
    );
  }
}
