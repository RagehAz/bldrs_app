import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:basics/helpers/classes/space/borderers.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/b_bz/sub/author_model.dart';
import 'package:bldrs/b_views/j_flyer/a_flyer_screen/xx_header_controllers.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/a_header/a_slate/d_labels/fff_author_label.dart';
import 'package:flutter/material.dart';

class AuthorsWrap extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const AuthorsWrap({
    required this.bzModel,
    required this.boxWidth,
    super.key
  });
  // --------------------
  final BzModel? bzModel;
  final double boxWidth;
  // -----------------------------------------------------------------------------
  Future<void> onAuthorTap(AuthorModel author) async {

    await onCallTap(
        bzModel: bzModel?.copyWith(
          authors: [author],
        ),
        flyerModel: null,
    );

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Container(
      width: boxWidth,
      // constraints: const BoxConstraints(
      //   maxHeight: 200,
      // ),
      decoration: const BoxDecoration(
        // color: Colorz.white10,
        borderRadius: Borderers.constantCornersAll10,
      ),
      child: Wrap(
        // crossAxisAlignment: CrossAxisAlignment.start,
        runSpacing: 10,
        spacing: 10,
        children: <Widget>[

          if (Mapper.checkCanLoopList(bzModel?.authors) == true)
            ...List.generate( bzModel!.authors!.length, (index){
              final AuthorModel _author = bzModel!.authors![index];
              return AuthorLabel(
                flyerBoxWidth: boxWidth * 0.75,
                authorID: _author.userID,
                bzModel: bzModel,
                onlyShowAuthorImage: true,
                onLabelTap: () => onAuthorTap(_author),
              );
            }),

        ],
      ),
    );

  }
  // -----------------------------------------------------------------------------
}
