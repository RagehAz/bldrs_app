import 'package:bldrs/a_models/d_zone/a_zoning/zone_level.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){

  const ZoneLevel _zoneLevel = ZoneLevel(
    hidden: ['1', '2', '3'],
    inactive: ['4', '5', '6'],
    active: ['7', '8', '9'],
    public: ['10', '11', '12'],
  );

  // -----------------------------------------------------------------------------
  test('copyListWith', () {

      final ZoneLevel _new = _zoneLevel.copyListWith(
        newList: ['1', '2', '3', '4'],
        type: ZoneLevelType.hidden,
      );

      const ZoneLevel _shouldBe =  ZoneLevel(
        hidden: ['1', '2', '3', '4'],
        inactive: ['4', '5', '6'],
        active: ['7', '8', '9'],
        public: ['10', '11', '12'],
      );

      expect(_new, _shouldBe);


    });
  // ---------------------------
  test('copyListWith 2', () {

    ZoneLevel _new = _zoneLevel.copyListWith(
      newList: ['xxx'],
      type: ZoneLevelType.hidden,
    );

    _new = _new.copyListWith(
      newList: null,
      type: ZoneLevelType.active,
    );

    _new = _new.copyListWith(
      newList: [],
      type: ZoneLevelType.public,
    );

    const ZoneLevel _shouldBe =  ZoneLevel(
      hidden: ['xxx'],
      inactive: ['4', '5', '6'],
      active: ['7', '8', '9'],
      public: [],
    );

    expect(_new, _shouldBe);


  });
  // ---------------------------
  test('getIDsByLevel', () {

    const ZoneLevelType _type = ZoneLevelType.hidden;

    final List<String> _list = _zoneLevel.getIDsByLevel(_type);

    const List<String> _shouldBe = ['1', '2', '3'];

    expect(_list, _shouldBe);

    final List<String> _list2 = _zoneLevel.getIDsByLevel(null);
    final List<String> _shouldBe2 = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12'];
    expect(_list2, _shouldBe2);

  });
  // ---------------------------
  test('getLevelTypeByID', () {

    final ZoneLevelType _type = _zoneLevel.getLevelTypeByID('11');
    expect(_type, ZoneLevelType.public);

    final ZoneLevelType _type2 = _zoneLevel.getLevelTypeByID(null);
    expect(_type2, null);

    final ZoneLevelType _type3 = _zoneLevel.getLevelTypeByID('13');
    expect(_type3, null);

    final ZoneLevelType _type4 = _zoneLevel.getLevelTypeByID('2');
    expect(_type4, ZoneLevelType.hidden);

  });
  // ---------------------------
  test('checkHasID', () {

    final bool _has1 = _zoneLevel.checkHasID(
      id: '1',
    );
    final bool _has1InHidden = _zoneLevel.checkHasID(
      id: '1',
      levelType: ZoneLevelType.hidden,
    );
    final bool _has1InActive = _zoneLevel.checkHasID(
      id: '1',
      levelType: ZoneLevelType.active,
    );

    final bool _has15 = _zoneLevel.checkHasID(
      id: '15'
    );
    final bool _has15InHidden = _zoneLevel.checkHasID(
      id: '15',
      levelType: ZoneLevelType.hidden,
    );

    expect(_has1, true);
    expect(_has1InHidden, true);
    expect(_has1InActive, false);

    expect(_has15, false);
    expect(_has15InHidden, false);


  });
  // -----------------------------------------------------------------------------
  test('removeIDFromZoneLevel', () {

    final ZoneLevel _new = ZoneLevel.removeIDFromZoneLevel(
      id: 'XX',
      zoneLevel: _zoneLevel,
    );
    const ZoneLevel _shouldBe = ZoneLevel(
      hidden: ['1', '2', '3'],
      inactive: ['4', '5', '6'],
      active: ['7', '8', '9'],
      public: ['10', '11', '12'],
    );
    expect(_new, _shouldBe);

    ZoneLevel _new2 = ZoneLevel.removeIDFromZoneLevel(
      id: '1',
      zoneLevel: _zoneLevel,
    );

    _new2 = ZoneLevel.removeIDFromZoneLevel(
      id: '8',
      zoneLevel: _new2,
    );

    const ZoneLevel _shouldBe2 = ZoneLevel(
      hidden: ['2', '3'],
      inactive: ['4', '5', '6'],
      active: ['7', '9'],
      public: ['10', '11', '12'],
    );
    expect(_new2, _shouldBe2);

  });
  // ---------------------------
  test('addIDToZoneLevel', () {

    final ZoneLevel _new = ZoneLevel.insertIDToZoneLevel(
      id: 'XX',
      newType: ZoneLevelType.active,
      zoneLevel: _zoneLevel,
    );

    const ZoneLevel _shouldBe = ZoneLevel(
      hidden: ['1', '2', '3'],
      inactive: ['4', '5', '6'],
      active: ['7', '8', '9', 'XX'],
      public: ['10', '11', '12'],
    );

    expect(_new, _shouldBe);


  });
  // ---------------------------
  test('addIDToZoneLevel2', () {

    final ZoneLevel _new = ZoneLevel.insertIDToZoneLevel(
      id: '9',
      newType: ZoneLevelType.active,
      zoneLevel: _zoneLevel,
    );

    const ZoneLevel _shouldBe = ZoneLevel(
      hidden: ['1', '2', '3'],
      inactive: ['4', '5', '6'],
      active: ['7', '8', '9',],
      public: ['10', '11', '12'],
    );

    expect(_new, _shouldBe);


  });
  // ---------------------------
  test('addIDToZoneLevel3', () {

    final ZoneLevel _new = ZoneLevel.insertIDToZoneLevel(
      id: '9',
      newType: ZoneLevelType.inactive,
      zoneLevel: _zoneLevel,
    );

    const ZoneLevel _shouldBe = ZoneLevel(
      hidden: ['1', '2', '3'],
      inactive: ['4', '5', '6', '9'],
      active: ['7', '8',],
      public: ['10', '11', '12'],
    );

    expect(_new, _shouldBe);


  });
  // -----------------------------------------------------------------------------
}
