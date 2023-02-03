import 'package:bldrs/a_models/a_user/sub/agenda_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/b_bz/sub/bz_typer.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){

  const AgendaModel dummyAgenda = AgendaModel(
    all: [
      'dev1', 'dev2',
      'bro1', 'bro2',
      'des1', 'des2',
      'con1', 'con2',
      'art1', 'art2',
      'man1', 'man2',
      'sup1', 'sup2',
    ],
    developers: ['dev1', 'dev2',],
    brokers: ['bro1', 'bro2',],
    designers: ['des1', 'des2',],
    contractors: ['con1', 'con2',],
    artisans: ['art1', 'art2',],
    manufacturers: ['man1', 'man2',],
    suppliers: ['sup1', 'sup2',],
  );

  final BzModel _bz1 = BzModel.dummyBz('x').copyWith(
      bzTypes: [BzType.developer, BzType.broker],
  );
  // -----------------------------------------------------------------------------
  test('dummyAgenda.toMap()', () {

    final Map<String, dynamic> _ciphered = dummyAgenda.toMap();

    final Map<String, dynamic> _result = {
      'all': [
        'dev1', 'dev2',
        'bro1', 'bro2',
        'des1', 'des2',
        'con1', 'con2',
        'art1', 'art2',
        'man1', 'man2',
        'sup1', 'sup2',
      ],
      'developers': ['dev1', 'dev2',],
      'brokers': ['bro1', 'bro2',],
      'designers': ['des1', 'des2',],
      'contractors': ['con1', 'con2',],
      'artisans': ['art1', 'art2',],
      'manufacturers': ['man1', 'man2',],
      'suppliers': ['sup1', 'sup2',],
    };

    expect(_ciphered, _result);
  });
  // -----------------------------------------------------------------------------
  test('dummyAgenda.toMap()', () {

    final Map<String, dynamic> _ciphered = dummyAgenda.toMap();
    final AgendaModel _deciphered = AgendaModel.decipher(_ciphered);

    expect(_ciphered, _deciphered.toMap());
  });
  // -----------------------------------------------------------------------------
  test('addBz', () {

    final AgendaModel _agenda = AgendaModel.addBz(
        bzModel: _bz1,
        oldAgenda: dummyAgenda,
    );

    const AgendaModel _expected = AgendaModel(
      all: [
        'dev1', 'dev2',
        'bro1', 'bro2',
        'des1', 'des2',
        'con1', 'con2',
        'art1', 'art2',
        'man1', 'man2',
        'sup1', 'sup2', 'x'
      ],
      developers: ['dev1', 'dev2', 'x'],
      brokers: ['bro1', 'bro2', 'x'],
      designers: ['des1', 'des2',],
      contractors: ['con1', 'con2',],
      artisans: ['art1', 'art2',],
      manufacturers: ['man1', 'man2',],
      suppliers: ['sup1', 'sup2',],
    );

    expect(_agenda, _expected.toMap());
  });
  // -----------------------------------------------------------------------------
  test('equality', () {

    const AgendaModel _initial = AgendaModel(
      all: [
        'dev1', 'dev2',
        'bro1', 'bro2',
        'des1', 'des2',
        'con1', 'con2',
        'art1', 'art2',
        'man1', 'man2',
        'sup1', 'sup2', 'x'
      ],
      developers: ['dev1', 'dev2', 'x'],
      brokers: ['bro1', 'bro2', 'x'],
      designers: ['des1', 'des2',],
      contractors: ['con1', 'con2',],
      artisans: ['art1', 'art2',],
      manufacturers: ['man1', 'man2',],
      suppliers: ['sup1', 'sup2',],
    );
    const AgendaModel _expected = AgendaModel(
      all: [
        'dev1', 'dev2',
        'bro1', 'bro2',
        'des1', 'des2',
        'con1', 'con2',
        'art1', 'art2',
        'man1', 'man2',
        'sup1', 'sup2', 'x'
      ],
      developers: ['dev1', 'dev2', 'x'],
      brokers: ['bro1', 'bro2', 'x'],
      designers: ['des1', 'des2',],
      contractors: ['con1', 'con2',],
      artisans: ['art1', 'art2',],
      manufacturers: ['man1', 'man2',],
      suppliers: ['sup1', 'sup2',],
    );

    expect(_initial == _expected, true);
  });
  // -----------------------------------------------------------------------------
}
