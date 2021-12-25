import 'package:bldrs/a_models/flyer/records/record_model.dart';
import 'package:bldrs/b_views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/c_controllers/c_0_search_controller.dart';
import 'package:bldrs/d_providers/general_provider.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/timerz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/xxx_dashboard/widgets/wide_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchRecordsView extends StatelessWidget {
// -----------------------------------------------------------------------------
  const SearchRecordsView({
    Key key
  }) : super(key: key);
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final GeneralProvider _generalProvider = Provider.of<GeneralProvider>(context, listen: true);
    final List<RecordModel> _searchRecords = _generalProvider.searchRecords;

    return ListView.builder(
        itemCount: _searchRecords.length,
        reverse: true,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(top: Ratioz.appBarBigHeight + Ratioz.appBarMargin * 2, bottom: Ratioz.horizon),
        itemBuilder: (BuildContext context, int index) {

          final RecordModel _searchRecord = _searchRecords[index];

          return DreamBox(
            height: 50,
            width: superScreenWidth(context) - (2 * Ratioz.appBarMargin),
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
          );

        });
  }

}
