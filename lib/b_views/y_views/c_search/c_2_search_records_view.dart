import 'package:bldrs/a_models/flyer/records/record_model.dart';
import 'package:bldrs/d_providers/general_provider.dart';
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
        padding: const EdgeInsets.only(top: Ratioz.appBarBigHeight + Ratioz.appBarMargin * 2, bottom: Ratioz.horizon),
        itemBuilder: (BuildContext context, int index) {

          final RecordModel _searchRecord = _searchRecords[index];

          return WideButton(
            verse: _searchRecord?.recordDetails.toString(),
          );

        });
  }

}
