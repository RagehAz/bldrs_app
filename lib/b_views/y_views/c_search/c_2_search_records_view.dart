import 'package:bldrs/a_models/flyer/records/record_model.dart';
import 'package:bldrs/b_views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/c_controllers/c_0_search_controller.dart';
import 'package:bldrs/d_providers/search_provider.dart';
import 'package:bldrs/e_db/fire/methods/firestore.dart';
import 'package:bldrs/e_db/fire/methods/paths.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchRecordsView extends StatelessWidget {
// -----------------------------------------------------------------------------
  const SearchRecordsView({
    @required this.scrollController,
    Key key
  }) : super(key: key);
// -----------------------------------------------------------------------------
  final ScrollController scrollController;
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final SearchProvider _searchProvider = Provider.of<SearchProvider>(context, listen: false);
    final List<RecordModel> _searchRecords = _searchProvider.searchRecords;

    _searchRecords.sort((RecordModel a, RecordModel b){
      final DateTime _timeA = a.timeStamp;
      final DateTime _timeB = b.timeStamp;
      return _timeB.compareTo(_timeA);
    });

    // _searchRecords.reversed;

    return ListView.builder(
        itemCount: _searchRecords.length,
        shrinkWrap: true,
        controller: scrollController,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(top: Ratioz.appBarBigHeight + Ratioz.appBarMargin * 2, bottom: Ratioz.horizon),
        itemBuilder: (BuildContext context, int index) {

          final RecordModel _searchRecord = _searchRecords[index];

          return
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                DreamBox(
                  height: 50,
                  width: superScreenWidth(context) - (2 * Ratioz.appBarMargin) - 60,
                  verse: _searchRecord?.recordDetails.toString(),
                  icon: Iconz.clock,
                  iconSizeFactor: 0.4,
                  verseCentered: false,
                  verseScaleFactor: 1.6,
                  margins: const EdgeInsets.only(bottom: Ratioz.appBarMargin),
                  onTap: () => onSearchRecordTap(
                    context: context,
                    record: _searchRecord,
                  ),
                ),

                DreamBox(
                  width: 50,
                  height: 50,
                  margins: const EdgeInsets.only(left: 5, right: 5, bottom: Ratioz.appBarMargin),
                  icon: Iconz.xLarge,
                  iconSizeFactor: 0.4,
                  onTap: () async {

                    await deleteDoc(
                        context: context,
                        collName: FireColl.records,
                        docName: _searchRecord.recordID,
                    );

                    _searchProvider.deleteASearchRecord(_searchRecord);

                  },
                ),


              ],

            )

            ;

        });
  }

}
