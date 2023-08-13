import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/helpers/classes/space/borderers.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/k_statistics/record_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/info_button/a_info_button_structure/ggg_mini_user_banner.dart';
import 'package:bldrs/b_views/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/user_protocols/protocols/a_user_protocols.dart';
import 'package:flutter/material.dart';
import 'package:fire/super_fire.dart';

class FlyerRecordsBox extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const FlyerRecordsBox({
    required this.pageWidth,
    required this.headlineVerse,
    required this.icon,
    required this.realNodePath,
    required this.flyerID,
    required this.bzID,
    super.key
  });
  /// -----------------------
  final double pageWidth;
  final Verse headlineVerse;
  final String icon;
  final String realNodePath;
  final String flyerID;
  final String bzID;
  /// -----------------------
  @override
  State<FlyerRecordsBox> createState() => _FlyerRecordsBoxState();
  /// --------------------------------------------------------------------------
}

class _FlyerRecordsBoxState extends State<FlyerRecordsBox> {
  // --------------------------------------------------------------------------
  late PaginationController _paginatorController;
  // ------------------------------
  @override
  void initState() {
    super.initState();

    _paginatorController = PaginationController.initialize(
      addExtraMapsAtEnd: true,
      // idFieldName: 'id',
      // onDataChanged: ,
    );

  }
  // ------------------------------
  @override
  void dispose() {
    _paginatorController.dispose();
    super.dispose();
  }
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[

        /// HEADLINE
        BldrsBox(
          height: 30,
          verse: widget.headlineVerse,
          verseWeight: VerseWeight.thin,
          verseItalic: true,
          icon: widget.icon,
          iconSizeFactor: 0.6,
          verseScaleFactor: 1 / 0.6,
          bubble: false,
          verseCentered: false,
          margins: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        ),

        /// PAGINATOR
        RealCollPaginator(
            paginationController: _paginatorController,
            paginationQuery: RealQueryModel.createAscendingQueryModel(
              path: widget.realNodePath,
              limit: 6,
              idFieldName: 'id',
              fieldNameToOrderBy: 'timeStamp',
            ),
            builder: (_, List<Map<String, dynamic>>? maps, bool loading, Widget? child){

              List<RecordModel> _records = RecordModel.decipherRecords(
                maps: maps ?? [],
                flyerID: widget.flyerID,
                bzID: widget.bzID,
                fromJSON: true,
              );

              _records = RecordModel.cleanDuplicateUsers(
                records: _records,
              );

              return Container(
                width: widget.pageWidth,
                height: 100,
                decoration: const BoxDecoration(
                  color: Colorz.white20,
                  borderRadius: Borderers.constantCornersAll10,
                ),
                child: ListView.builder(
                  controller: _paginatorController.scrollController,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(10),
                  scrollDirection: Axis.horizontal,
                  itemCount: _records.length,
                  itemBuilder: (_, int index){
                    return FutureBuilder(
                      future: UserProtocols.fetch(userID: _records[index].userID),
                      builder: (_, AsyncSnapshot<UserModel?> snapshot){

                        final UserModel? _user = snapshot.data;

                        return MiniUserBanner(
                          size: 50,
                          userModel: _user,
                        );

                      },
                    );
                    },
                ),
              );

            }
            ),

      ],
    );

  }
}
