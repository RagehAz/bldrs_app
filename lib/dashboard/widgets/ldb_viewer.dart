import 'package:bldrs/controllers/drafters/keyboarders.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/providers/local_db/models/ldb_column.dart';
import 'package:bldrs/providers/local_db/models/ldb_table.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:flutter/material.dart';

class LDBViewer extends StatelessWidget {
  final LDBTable table;
  final Function onRowTap;
  final Color color;


  const LDBViewer({
    @required this.table,
    this.onRowTap,
    this.color = Colorz.BloodTest,
});
// -----------------------------------------------------------------------------
  static List<Widget> rows({BuildContext context, List<Map<String, Object>>maps, String primaryKey, Function onRowTap, Color color = Colorz.BloodTest}){

    final String _primaryKey = primaryKey;
    final double _screenWidth = Scale.superScreenWidth(context);

    return
      List.generate(
          maps?.length ?? 0,
              (index){

            final Map<String, Object> _map = maps[index];

            final List<Object> _keys = _map.keys.toList();
            final List<Object> _values = _map.values.toList();


            final String _primaryValue = _map['$_primaryKey'];
            // int _idInt = Numberers.stringToInt(_id);

            return
              Container(
                width: _screenWidth,
                height: 42,
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: false,
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[

                    DreamBox(
                      height: 37,
                      width: 37,
                      icon: Iconz.Flyer,
                      iconSizeFactor: 0.7,
                      bubble: onRowTap ==  null ? false : true,
                      onTap: (){

                        if (onRowTap !=  null){
                          onRowTap(_primaryValue);
                        }

                      },
                      // margins: EdgeInsets.all(5),
                    ),

                    DreamBox(
                      height: 40,
                      width: 40,
                      verse: '${index + 1}',
                      verseScaleFactor: 0.6,
                      margins: EdgeInsets.all(5),
                      bubble: false,
                      color: Colorz.White10,
                    ),

                    ...List.generate(
                        _values.length,
                            (i){

                          String _key = _keys[i];
                          String _value = _values[i].toString();

                          return
                            ValueBox(
                              dataKey: _key,
                              value: _value,
                              color: color,
                            );

                        }
                    ),

                  ],
                ),
              );

          });
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final String _primaryKey = LDBColumn.getPrimaryKeyFromColumns(table?.columns);
    final double _screenWidth = Scale.superScreenWidth(context);

    return Container(
      width: _screenWidth,
      color: Colorz.White10,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        controller: ScrollController(),
        child: Column(
          children: <Widget>[

            ...rows(
              context: context,
              color: color,
              maps: table.maps,
              primaryKey: _primaryKey,
              onRowTap: onRowTap,
            ),

          ],
        ),
      ),
    );
  }
}

class ValueBox extends StatelessWidget {
  final String dataKey;
  final dynamic value;
  final Color color;

  const ValueBox({
    @required this.dataKey,
    @required this.value,
    this.color = Colorz.BloodTest,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Keyboarders.copyToClipboard(
        context: context,
        copy: value,
      ),
      child: Container(
        height: 40,
        width: 80,
        color: color,
        margin: const EdgeInsets.all(2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            SuperVerse(
              verse: dataKey,
              weight: VerseWeight.thin,
              italic: true,
              size: 1,
            ),

            SuperVerse(
              verse: '${value.toString()}',
              weight: VerseWeight.bold,
              italic: false,
              size: 1,
            ),

          ],
        ),
      ),
    );
  }
}
