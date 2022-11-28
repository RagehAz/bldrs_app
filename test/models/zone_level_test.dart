import 'package:bldrs/a_models/d_zone/a_zoning/zone_stages.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){

  const ZoneStages _zoneLevel = ZoneStages(
    hidden: ['1', '2', '3'],
    inactive: ['4', '5', '6'],
    active: ['7', '8', '9'],
    public: ['10', '11', '12'],
  );

  // -----------------------------------------------------------------------------
  test('copyListWith', () {

      final ZoneStages _new = _zoneLevel.copyListWith(
        newList: ['1', '2', '3', '4'],
        type: StageType.hidden,
      );

      const ZoneStages _shouldBe =  ZoneStages(
        hidden: ['1', '2', '3', '4'],
        inactive: ['4', '5', '6'],
        active: ['7', '8', '9'],
        public: ['10', '11', '12'],
      );

      expect(_new, _shouldBe);


    });
  // ---------------------------
  test('copyListWith 2', () {

    ZoneStages _new = _zoneLevel.copyListWith(
      newList: ['xxx'],
      type: StageType.hidden,
    );

    _new = _new.copyListWith(
      newList: null,
      type: StageType.active,
    );

    _new = _new.copyListWith(
      newList: [],
      type: StageType.public,
    );

    const ZoneStages _shouldBe =  ZoneStages(
      hidden: ['xxx'],
      inactive: ['4', '5', '6'],
      active: ['7', '8', '9'],
      public: [],
    );

    expect(_new, _shouldBe);


  });
  // ---------------------------
  test('getIDsByLevel', () {

    const StageType _type = StageType.hidden;

    final List<String> _list = _zoneLevel.getIDsByStage(_type);

    const List<String> _shouldBe = ['1', '2', '3'];

    expect(_list, _shouldBe);

    final List<String> _list2 = _zoneLevel.getIDsByStage(null);
    final List<String> _shouldBe2 = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12'];
    expect(_list2, _shouldBe2);

  });
  // ---------------------------
  test('getLevelTypeByID', () {

    final StageType _type = _zoneLevel.getStageTypeByID('11');
    expect(_type, StageType.public);

    final StageType _type2 = _zoneLevel.getStageTypeByID(null);
    expect(_type2, null);

    final StageType _type3 = _zoneLevel.getStageTypeByID('13');
    expect(_type3, null);

    final StageType _type4 = _zoneLevel.getStageTypeByID('2');
    expect(_type4, StageType.hidden);

  });
  // ---------------------------
  test('checkHasID', () {

    final bool _has1 = _zoneLevel.checkHasID(
      id: '1',
    );
    final bool _has1InHidden = _zoneLevel.checkHasID(
      id: '1',
      zoneStageType: StageType.hidden,
    );
    final bool _has1InActive = _zoneLevel.checkHasID(
      id: '1',
      zoneStageType: StageType.active,
    );

    final bool _has15 = _zoneLevel.checkHasID(
      id: '15'
    );
    final bool _has15InHidden = _zoneLevel.checkHasID(
      id: '15',
      zoneStageType: StageType.hidden,
    );

    expect(_has1, true);
    expect(_has1InHidden, true);
    expect(_has1InActive, false);

    expect(_has15, false);
    expect(_has15InHidden, false);


  });
  // -----------------------------------------------------------------------------
  test('removeIDFromZoneLevel', () {

    final ZoneStages _new = ZoneStages.removeIDFromZoneStage(
      id: 'XX',
      zoneStages: _zoneLevel,
    );
    const ZoneStages _shouldBe = ZoneStages(
      hidden: ['1', '2', '3'],
      inactive: ['4', '5', '6'],
      active: ['7', '8', '9'],
      public: ['10', '11', '12'],
    );
    expect(_new, _shouldBe);

    ZoneStages _new2 = ZoneStages.removeIDFromZoneStage(
      id: '1',
      zoneStages: _zoneLevel,
    );

    _new2 = ZoneStages.removeIDFromZoneStage(
      id: '8',
      zoneStages: _new2,
    );

    const ZoneStages _shouldBe2 = ZoneStages(
      hidden: ['2', '3'],
      inactive: ['4', '5', '6'],
      active: ['7', '9'],
      public: ['10', '11', '12'],
    );
    expect(_new2, _shouldBe2);

  });
  // ---------------------------
  test('addIDToZoneLevel', () {

    final ZoneStages _new = ZoneStages.insertIDToZoneStages(
      id: 'XX',
      newType: StageType.active,
      zoneStages: _zoneLevel,
    );

    const ZoneStages _shouldBe = ZoneStages(
      hidden: ['1', '2', '3'],
      inactive: ['4', '5', '6'],
      active: ['7', '8', '9', 'XX'],
      public: ['10', '11', '12'],
    );

    expect(_new, _shouldBe);


  });
  // ---------------------------
  test('addIDToZoneLevel2', () {

    final ZoneStages _new = ZoneStages.insertIDToZoneStages(
      id: '9',
      newType: StageType.active,
      zoneStages: _zoneLevel,
    );

    const ZoneStages _shouldBe = ZoneStages(
      hidden: ['1', '2', '3'],
      inactive: ['4', '5', '6'],
      active: ['7', '8', '9',],
      public: ['10', '11', '12'],
    );

    expect(_new, _shouldBe);


  });
  // ---------------------------
  test('addIDToZoneLevel3', () {

    final ZoneStages _new = ZoneStages.insertIDToZoneStages(
      id: '9',
      newType: StageType.inactive,
      zoneStages: _zoneLevel,
    );

    const ZoneStages _shouldBe = ZoneStages(
      hidden: ['1', '2', '3'],
      inactive: ['4', '5', '6', '9'],
      active: ['7', '8',],
      public: ['10', '11', '12'],
    );

    expect(_new, _shouldBe);


  });
  // -----------------------------------------------------------------------------
}
