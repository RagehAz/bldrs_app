import 'package:bldrs/a_models/f_flyer/publication_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  group('PublicationModel.toMap()', () {
    test('Should return a non-null map', () {
      const publication = PublicationModel.emptyModel;

      final result = publication.toMap();

      expect(result, isNotNull);
    });

    test('Should return a map with all the required keys', () {
      const PublicationModel publication = PublicationModel.emptyModel;

      final result = publication.toMap();

      expect(5, result.keys.length);
    });

    test('Should return a map with correct key-value pairs', () {
      final List<String> drafts = ['draft1', 'draft2'];
      final List<String> pendings = ['pending1'];
      final List<String> published = [];
      final List<String> unpublished = ['unpublished1', 'unpublished2'];
      final List<String> suspended = [];

      final publication = PublicationModel(
        drafts: drafts,
        pendings: pendings,
        published: published,
        unpublished: unpublished,
        suspended: suspended,
      );

      final result = publication.toMap();

      expect(result['drafts'], drafts);
      expect(result['pendings'], pendings);
      expect(result['published'], published);
      expect(result['unpublished'], unpublished);
      expect(result['suspended'], suspended);
    });

    test('Should return a map with empty lists if the input lists are null', () {
      const PublicationModel publication = PublicationModel.emptyModel;

      final result = publication.toMap();

      expect(result['drafts'], []);
      expect(result['pendings'], []);
      expect(result['published'], []);
      expect(result['unpublished'], []);
      expect(result['suspended'], []);
    });

    test('Should return a map with empty lists if the input lists are empty', () {
      const PublicationModel publication = PublicationModel.emptyModel;

      final result = publication.toMap();

      expect(result['drafts'], []);
      expect(result['pendings'], []);
      expect(result['published'], []);
      expect(result['unpublished'], []);
      expect(result['suspended'], []);
    });

    test('Should not include null values in the map', () {
      const publication = PublicationModel(
        drafts: ['draft1'],
        pendings: [],
        published: [],
        unpublished: ['unpublished1'],
        suspended: [],
      );

      final result = publication.toMap();

      expect(result.containsKey('drafts'), true);
      expect(result.containsKey('pendings'), true);
      expect(result.containsKey('published'), true);
      expect(result.containsKey('unpublished'), true);
      expect(result.containsKey('suspended'), true);
    });

    test('Should return the correct map size', () {
      const PublicationModel publication = PublicationModel(
        drafts: ['draft1'],
        pendings: ['pending1', 'pending2'],
        published: [],
        unpublished: ['unpublished1', 'unpublished2', 'unpublished3'],
        suspended: [],
      );

      final result = publication.toMap();

      expect(result.length, 5);
    });
  });

  group('PublicationModel.decipher()', () {
    test('Should return an empty PublicationModel when the input map is null', () {
      final result = PublicationModel.decipher(null);

      expect(result.drafts, isEmpty);
      expect(result.pendings, isEmpty);
      expect(result.published, isEmpty);
      expect(result.unpublished, isEmpty);
      expect(result.suspended, isEmpty);
    });

    test('Should correctly decipher the input map into a PublicationModel', () {
      final inputMap = {
        'drafts': [1, 2, 3],
        'pendings': ['pending1', 'pending2'],
        'published': [],
        'unpublished': [true, false],
        'suspended': [4.5],
      };

      final result = PublicationModel.decipher(inputMap);

      expect(result.drafts, ['1', '2', '3']);
      expect(result.pendings, ['pending1', 'pending2']);
      expect(result.published, isEmpty);
      expect(result.unpublished, ['true', 'false']);
      expect(result.suspended, ['4.5']);
    });

    test('Should return an empty PublicationModel when the input map has missing keys', () {
      final inputMap = {
        'drafts': ['draft1', 'draft2'],
        'pendings': ['pending1', 'pending2'],
        'published': [],
        'unpublished': [],
        'suspended': [],
      };

      final result = PublicationModel.decipher(inputMap);

      expect(result.drafts, isNotEmpty);
      expect(result.pendings, isNotEmpty);
      expect(result.published, isEmpty);
      expect(result.unpublished, isEmpty);
      expect(result.suspended, isEmpty);
    });

    test('Should correctly handle empty lists in the input map', () {
      final inputMap = {
        'drafts': [],
        'pendings': [],
        'published': [],
        'unpublished': [],
        'suspended': [],
      };

      final result = PublicationModel.decipher(inputMap);

      expect(result.drafts, isEmpty);
      expect(result.pendings, isEmpty);
      expect(result.published, isEmpty);
      expect(result.unpublished, isEmpty);
      expect(result.suspended, isEmpty);
    });

    test('Should correctly handle null values in the input map', () {
      final inputMap = {
        'drafts': null,
        'pendings': ['pending1'],
        'published': null,
        'unpublished': [1, null, 3],
        'suspended': null,
      };

      final result = PublicationModel.decipher(inputMap);

      expect(result.drafts, isEmpty);
      expect(result.pendings, ['pending1']);
      expect(result.published, isEmpty);
      expect(result.unpublished, ['1', 'null', '3']);
      expect(result.suspended, isEmpty);
    });

    test('Should return an empty PublicationModel when the input map is empty', () {
      final Map<String, dynamic> inputMap = {};

      final result = PublicationModel.decipher(inputMap);

      expect(result.drafts, isEmpty);
      expect(result.pendings, isEmpty);
      expect(result.published, isEmpty);
      expect(result.unpublished, isEmpty);
      expect(result.suspended, isEmpty);
    });

    test('Should correctly decipher the input map with non-string values', () {
      final inputMap = {
        'drafts': [1, 2, 3],
        'pendings': [true, false],
        'published': [4.5],
        'unpublished': [null],
        'suspended': ['suspended1', null, 'suspended3'],
      };

      final result = PublicationModel.decipher(inputMap);

      expect(result.drafts, ['1', '2', '3']);
      expect(result.pendings, ['true', 'false']);
      expect(result.published, ['4.5']);
      expect(result.unpublished, ['null']);
      expect(result.suspended, ['suspended1', 'null', 'suspended3']);
    });
  });

  group('PublicationModel.getFlyerState()', () {

    test('Should return PublishState.draft when flyerID is in the drafts list', () {
      const PublicationModel pub = PublicationModel(
        drafts: ['draft1', 'draft2'],
        pendings: [],
        published: [],
        unpublished: [],
        suspended: [],
      );

      final result = PublicationModel.getFlyerState(pub: pub, flyerID: 'draft1');

      expect(result, PublishState.draft);
    });

    test('Should return PublishState.pending when flyerID is in the pendings list', () {
      const PublicationModel pub = PublicationModel(
        drafts: [],
        pendings: ['pending1', 'pending2'],
        published: [],
        unpublished: [],
        suspended: [],
      );

      final result = PublicationModel.getFlyerState(pub: pub, flyerID: 'pending2');

      expect(result, PublishState.pending);
    });

    test('Should return PublishState.published when flyerID is in the published list', () {
      const PublicationModel pub = PublicationModel(
        drafts: [],
        pendings: [],
        published: ['published1'],
        unpublished: [],
        suspended: [],
      );

      final result = PublicationModel.getFlyerState(pub: pub, flyerID: 'published1');

      expect(result, PublishState.published);
    });

    test('Should return PublishState.unpublished when flyerID is in the unpublished list', () {
      const PublicationModel pub = PublicationModel(
        drafts: [],
        pendings: [],
        published: [],
        unpublished: ['unpublished1', 'unpublished2'],
        suspended: [],
      );

      final result = PublicationModel.getFlyerState(pub: pub, flyerID: 'unpublished2');

      expect(result, PublishState.unpublished);
    });

    test('Should return PublishState.suspended when flyerID is in the suspended list', () {
      const PublicationModel pub = PublicationModel(
        drafts: [],
        pendings: [],
        published: [],
        unpublished: [],
        suspended: ['suspended1'],
      );

      final result = PublicationModel.getFlyerState(pub: pub, flyerID: 'suspended1');

      expect(result, PublishState.suspended);
    });

    test('Should return null when flyerID is not in any of the lists', () {
      const PublicationModel pub = PublicationModel(
        drafts: ['draft1'],
        pendings: ['pending1'],
        published: [],
        unpublished: [],
        suspended: [],
      );

      final result = PublicationModel.getFlyerState(pub: pub, flyerID: 'nonExistentFlyer');

      expect(result, null);
    });

    test('Should return null when the input PublicationModel is empty', () {
      const PublicationModel pub = PublicationModel.emptyModel;

      final result = PublicationModel.getFlyerState(pub: pub, flyerID: 'someFlyer');

      expect(result, null);
    });

  });

  group('PublicationModel.getFlyersIDsByState()', () {
    test('Should return the drafts list when the state is PublishState.draft', () {
      const PublicationModel pub = PublicationModel(
        drafts: ['draft1', 'draft2'],
        pendings: [],
        published: [],
        unpublished: [],
        suspended: [],
      );

      final result = PublicationModel.getFlyersIDsByState(pub: pub, state: PublishState.draft);

      expect(result, pub.drafts);
    });

    test('Should return the pendings list when the state is PublishState.pending', () {
      const PublicationModel pub = PublicationModel(
        drafts: [],
        pendings: ['pending1', 'pending2'],
        published: [],
        unpublished: [],
        suspended: [],
      );

      final result = PublicationModel.getFlyersIDsByState(pub: pub, state: PublishState.pending);

      expect(result, pub.pendings);
    });

    test('Should return the published list when the state is PublishState.published', () {
      const PublicationModel pub = PublicationModel(
        drafts: [],
        pendings: [],
        published: ['published1'],
        unpublished: [],
        suspended: [],
      );

      final result = PublicationModel.getFlyersIDsByState(pub: pub, state: PublishState.published);

      expect(result, pub.published);
    });

    test('Should return the unpublished list when the state is PublishState.unpublished', () {
      const PublicationModel pub = PublicationModel(
        drafts: [],
        pendings: [],
        published: [],
        unpublished: ['unpublished1', 'unpublished2'],
        suspended: [],
      );

      final result =
          PublicationModel.getFlyersIDsByState(pub: pub, state: PublishState.unpublished);

      expect(result, pub.unpublished);
    });

    test('Should return the suspended list when the state is PublishState.suspended', () {
      const PublicationModel pub = PublicationModel(
        drafts: [],
        pendings: [],
        published: [],
        unpublished: [],
        suspended: ['suspended1'],
      );

      final result = PublicationModel.getFlyersIDsByState(pub: pub, state: PublishState.suspended);

      expect(result, pub.suspended);
    });

    test('Should return an empty list when the state does not match any lists', () {
      const PublicationModel pub = PublicationModel(
        drafts: ['draft1'],
        pendings: ['pending1'],
        published: [],
        unpublished: [],
        suspended: [],
      );

      final result = PublicationModel.getFlyersIDsByState(pub: pub, state: PublishState.suspended);

      expect(result, isEmpty);
    });

    test('Should return an empty list when the input PublicationModel is empty', () {
      const PublicationModel pub = PublicationModel.emptyModel;

      final result = PublicationModel.getFlyersIDsByState(pub: pub, state: PublishState.pending);

      expect(result, isEmpty);
    });

  });

  group('PublicationModel.replaceFlyersIDsInState()', () {
    test('Should replace the drafts list with the new list when the state is PublishState.draft',
        () {
      const pub = PublicationModel(
        drafts: ['draft1', 'draft2'],
        pendings: [],
        published: [],
        unpublished: [],
        suspended: [],
      );
      final newList = ['newDraft1', 'newDraft2'];

      final result = PublicationModel.replaceFlyersIDsInState(
        pub: pub,
        newList: newList,
        state: PublishState.draft,
      );

      expect(result.drafts, newList);
      expect(result.pendings, pub.pendings);
      expect(result.published, pub.published);
      expect(result.unpublished, pub.unpublished);
      expect(result.suspended, pub.suspended);
    });

    test(
        'Should replace the pendings list with the new list when the state is PublishState.pending',
        () {
      const PublicationModel pub = PublicationModel(
        drafts: [],
        pendings: ['pending1', 'pending2'],
        published: [],
        unpublished: [],
        suspended: [],
      );
      final newList = ['newPending1', 'newPending2'];

      final result = PublicationModel.replaceFlyersIDsInState(
        pub: pub,
        newList: newList,
        state: PublishState.pending,
      );

      expect(result.drafts, pub.drafts);
      expect(result.pendings, newList);
      expect(result.published, pub.published);
      expect(result.unpublished, pub.unpublished);
      expect(result.suspended, pub.suspended);
    });

    test(
        'Should replace the published list with the new list when the state is PublishState.published',
        () {
      const PublicationModel pub = PublicationModel(
        drafts: [],
        pendings: [],
        published: ['published1'],
        unpublished: [],
        suspended: [],
      );
      final newList = ['newPublished1'];

      final result = PublicationModel.replaceFlyersIDsInState(
        pub: pub,
        newList: newList,
        state: PublishState.published,
      );

      expect(result.drafts, pub.drafts);
      expect(result.pendings, pub.pendings);
      expect(result.published, newList);
      expect(result.unpublished, pub.unpublished);
      expect(result.suspended, pub.suspended);
    });

    test(
        'Should replace the unpublished list with the new list when the state is PublishState.unpublished',
        () {
      const PublicationModel pub = PublicationModel(
        drafts: [],
        pendings: [],
        published: [],
        unpublished: ['unpublished1', 'unpublished2'],
        suspended: [],
      );
      final newList = ['newUnpublished1', 'newUnpublished2'];

      final result = PublicationModel.replaceFlyersIDsInState(
        pub: pub,
        newList: newList,
        state: PublishState.unpublished,
      );

      expect(result.drafts, pub.drafts);
      expect(result.pendings, pub.pendings);
      expect(result.published, pub.published);
      expect(result.unpublished, newList);
      expect(result.suspended, pub.suspended);
    });

    test(
        'Should replace the suspended list with the new list when the state is PublishState.suspended',
        () {
      const PublicationModel pub = PublicationModel(
        drafts: [],
        pendings: [],
        published: [],
        unpublished: [],
        suspended: ['suspended1'],
      );
      final newList = ['newSuspended1'];

      final result = PublicationModel.replaceFlyersIDsInState(
        pub: pub,
        newList: newList,
        state: PublishState.suspended,
      );

      expect(result.drafts, pub.drafts);
      expect(result.pendings, pub.pendings);
      expect(result.published, pub.published);
      expect(result.unpublished, pub.unpublished);
      expect(result.suspended, newList);
    });

    test('Should return the same PublicationModel when the input PublicationModel is empty', () {
      const PublicationModel pub = PublicationModel.emptyModel;
      final newList = ['newFlyer'];

      final result = PublicationModel.replaceFlyersIDsInState(
        pub: pub,
        newList: newList,
        state: PublishState.pending,
      );

      expect(result, const PublicationModel(drafts: [], pendings: ['newFlyer'], published: [], unpublished: [], suspended: []));
    });
  });

  group('PublicationModel.addNewFlyerIDToPublication()', () {
    test('Should add the new flyer ID to the drafts list when the state is PublishState.draft', () {
      const PublicationModel pub = PublicationModel(
        drafts: ['draft1', 'draft2'],
        pendings: [],
        published: [],
        unpublished: [],
        suspended: [],
      );
      const newFlyerID = 'newDraft';

      final result = PublicationModel.addNewFlyerIDToPublication(
        pub: pub,
        flyerID: newFlyerID,
        toState: PublishState.draft,
      );

      expect(result.drafts, contains(newFlyerID));
      expect(result.pendings, pub.pendings);
      expect(result.published, pub.published);
      expect(result.unpublished, pub.unpublished);
      expect(result.suspended, pub.suspended);
    });

    test('Should add the new flyer ID to the pendings list when the state is PublishState.pending',
        () {
      const PublicationModel pub = PublicationModel(
        drafts: [],
        pendings: ['pending1', 'pending2'],
        published: [],
        unpublished: [],
        suspended: [],
      );
      const newFlyerID = 'newPending';

      final result = PublicationModel.addNewFlyerIDToPublication(
        pub: pub,
        flyerID: newFlyerID,
        toState: PublishState.pending,
      );

      expect(result.drafts, pub.drafts);
      expect(result.pendings, contains(newFlyerID));
      expect(result.published, pub.published);
      expect(result.unpublished, pub.unpublished);
      expect(result.suspended, pub.suspended);
    });

    test(
        'Should add the new flyer ID to the published list when the state is PublishState.published',
        () {
      const PublicationModel pub = PublicationModel(
        drafts: [],
        pendings: [],
        published: ['published1'],
        unpublished: [],
        suspended: [],
      );
      const newFlyerID = 'newPublished';

      final result = PublicationModel.addNewFlyerIDToPublication(
        pub: pub,
        flyerID: newFlyerID,
        toState: PublishState.published,
      );

      expect(result.drafts, pub.drafts);
      expect(result.pendings, pub.pendings);
      expect(result.published, contains(newFlyerID));
      expect(result.unpublished, pub.unpublished);
      expect(result.suspended, pub.suspended);
    });

    test(
        'Should add the new flyer ID to the unpublished list when the state is PublishState.unpublished',
        () {
      const PublicationModel pub = PublicationModel(
        drafts: [],
        pendings: [],
        published: [],
        unpublished: ['unpublished1', 'unpublished2'],
        suspended: [],
      );
      const newFlyerID = 'newUnpublished';

      final result = PublicationModel.addNewFlyerIDToPublication(
        pub: pub,
        flyerID: newFlyerID,
        toState: PublishState.unpublished,
      );

      expect(result.drafts, pub.drafts);
      expect(result.pendings, pub.pendings);
      expect(result.published, pub.published);
      expect(result.unpublished, contains(newFlyerID));
      expect(result.suspended, pub.suspended);
    });

    test(
        'Should add the new flyer ID to the suspended list when the state is PublishState.suspended',
        () {
      const PublicationModel pub = PublicationModel(
        drafts: [],
        pendings: [],
        published: [],
        unpublished: [],
        suspended: ['suspended1'],
      );
      const newFlyerID = 'newSuspended';

      final result = PublicationModel.addNewFlyerIDToPublication(
        pub: pub,
        flyerID: newFlyerID,
        toState: PublishState.suspended,
      );

      expect(result.drafts, pub.drafts);
      expect(result.pendings, pub.pendings);
      expect(result.published, pub.published);
      expect(result.unpublished, pub.unpublished);
      expect(result.suspended, contains(newFlyerID));
    });

    test('Should return the same PublicationModel when the input PublicationModel is empty', () {
      const PublicationModel pub = PublicationModel.emptyModel;
      const newFlyerID = 'newFlyer';

      final result = PublicationModel.addNewFlyerIDToPublication(
        pub: pub,
        flyerID: newFlyerID,
        toState: PublishState.pending,
      );

      expect(result, const PublicationModel(
        drafts: [],
        pendings: ['newFlyer'],
        published: [],
        suspended: [],
        unpublished: [],
      ));
    });


  });

  group('PublicationModel.bringIDToStart()', () {
    test(
        'Should bring the flyerID to the start of the drafts list when the state is PublishState.draft',
        () {
      const PublicationModel pub = PublicationModel(
        drafts: ['draft1', 'draft2', 'draft3'],
        pendings: [],
        published: [],
        unpublished: [],
        suspended: [],
      );
      const flyerID = 'draft2';

      final result = PublicationModel.bringIDToStart(
        pub: pub,
        flyerID: flyerID,
        toState: PublishState.draft,
      );

      expect(result.drafts.first, flyerID);
      expect(result.drafts, containsAllInOrder(['draft1', 'draft3']));
      expect(result.pendings, pub.pendings);
      expect(result.published, pub.published);
      expect(result.unpublished, pub.unpublished);
      expect(result.suspended, pub.suspended);
    });

    test(
        'Should bring the flyerID to the start of the pendings list when the state is PublishState.pending',
        () {
      const PublicationModel pub = PublicationModel(
        drafts: [],
        pendings: ['pending1', 'pending2', 'pending3'],
        published: [],
        unpublished: [],
        suspended: [],
      );
      const flyerID = 'pending2';

      final result = PublicationModel.bringIDToStart(
        pub: pub,
        flyerID: flyerID,
        toState: PublishState.pending,
      );

      expect(result.pendings.first, flyerID);
      expect(result.pendings, containsAllInOrder(['pending1', 'pending3']));
      expect(result.drafts, pub.drafts);
      expect(result.published, pub.published);
      expect(result.unpublished, pub.unpublished);
      expect(result.suspended, pub.suspended);
    });

    test(
        'Should bring the flyerID to the start of the published list when the state is PublishState.published',
        () {
      const pub = PublicationModel(
        drafts: [],
        pendings: [],
        published: ['published1', 'published2', 'published3'],
        unpublished: [],
        suspended: [],
      );
      const flyerID = 'published2';

      final result = PublicationModel.bringIDToStart(
        pub: pub,
        flyerID: flyerID,
        toState: PublishState.published,
      );

      expect(result.published.first, flyerID);
      expect(result.published, containsAllInOrder(['published1', 'published3']));
      expect(result.drafts, pub.drafts);
      expect(result.pendings, pub.pendings);
      expect(result.unpublished, pub.unpublished);
      expect(result.suspended, pub.suspended);
    });

    test(
        'Should bring the flyerID to the start of the unpublished list when the state is PublishState.unpublished',
        () {
      const pub = PublicationModel(
        drafts: [],
        pendings: [],
        published: [],
        unpublished: ['unpublished1', 'unpublished2', 'unpublished3'],
        suspended: [],
      );
      const flyerID = 'unpublished2';

      final result = PublicationModel.bringIDToStart(
        pub: pub,
        flyerID: flyerID,
        toState: PublishState.unpublished,
      );

      expect(result.unpublished.first, flyerID);
      expect(result.unpublished, containsAllInOrder(['unpublished1', 'unpublished3']));
      expect(result.drafts, pub.drafts);
      expect(result.pendings, pub.pendings);
      expect(result.published, pub.published);
      expect(result.suspended, pub.suspended);
    });

    test(
        'Should bring the flyerID to the start of the suspended list when the state is PublishState.suspended',
        () {
      const pub = PublicationModel(
        drafts: [],
        pendings: [],
        published: [],
        unpublished: [],
        suspended: ['suspended1', 'suspended2', 'suspended3'],
      );
      const flyerID = 'suspended2';

      final result = PublicationModel.bringIDToStart(
        pub: pub,
        flyerID: flyerID,
        toState: PublishState.suspended,
      );

      expect(result.suspended.first, flyerID);
      expect(result.suspended, containsAllInOrder(['suspended1', 'suspended3']));
      expect(result.drafts, pub.drafts);
      expect(result.pendings, pub.pendings);
      expect(result.published, pub.published);
      expect(result.unpublished, pub.unpublished);
    });

  });

  group('PublicationModel.moveFlyerIDFToNewState()', () {
    test('Should move the flyerID from drafts to pendings when moving to PublishState.pending', () {
      const pub = PublicationModel(
        drafts: ['draft1', 'draft2'],
        pendings: [],
        published: [],
        unpublished: [],
        suspended: [],
      );
      const flyerID = 'draft1';

      final result = PublicationModel.moveFlyerIDFToNewState(
        pub: pub,
        flyerID: flyerID,
        toState: PublishState.pending,
      );

      expect(result.drafts.contains(flyerID), false);
      expect(result.pendings, contains(flyerID));
      expect(result.pendings.length, 1);
      expect(result.pendings.first, flyerID);
      expect(result.published, pub.published);
      expect(result.unpublished, pub.unpublished);
      expect(result.suspended, pub.suspended);
    });

    test('Should move the flyerID from pendings to drafts when moving to PublishState.draft', () {
      const pub = PublicationModel(
        drafts: [],
        pendings: ['pending1', 'pending2'],
        published: [],
        unpublished: [],
        suspended: [],
      );
      const flyerID = 'pending2';

      final result = PublicationModel.moveFlyerIDFToNewState(
        pub: pub,
        flyerID: flyerID,
        toState: PublishState.draft,
      );

      expect(result.pendings.contains(flyerID), false);
      expect(result.drafts, contains(flyerID));
      expect(result.drafts.length, 1);
      expect(result.drafts.first, flyerID);
      expect(result.published, pub.published);
      expect(result.unpublished, pub.unpublished);
      expect(result.suspended, pub.suspended);
    });

    test('Should move the flyerID from drafts to published when moving to PublishState.published',
        () {
      const pub = PublicationModel(
        drafts: ['draft1', 'draft2'],
        pendings: [],
        published: [],
        unpublished: [],
        suspended: [],
      );
      const flyerID = 'draft2';

      final result = PublicationModel.moveFlyerIDFToNewState(
        pub: pub,
        flyerID: flyerID,
        toState: PublishState.published,
      );

      expect(result.drafts.contains(flyerID), false);
      expect(result.published, contains(flyerID));
      expect(result.published.length, 1);
      expect(result.published.first, flyerID);
      expect(result.pendings, pub.pendings);
      expect(result.unpublished, pub.unpublished);
      expect(result.suspended, pub.suspended);
    });

    test(
        'Should move the flyerID from unpublished to suspended when moving to PublishState.suspended',
        () {
      const pub = PublicationModel(
        drafts: [],
        pendings: [],
        published: [],
        unpublished: ['unpublished1', 'unpublished2'],
        suspended: [],
      );
      const flyerID = 'unpublished2';

      final result = PublicationModel.moveFlyerIDFToNewState(
        pub: pub,
        flyerID: flyerID,
        toState: PublishState.suspended,
      );

      expect(result.unpublished.contains(flyerID), false);
      expect(result.suspended, contains(flyerID));
      expect(result.suspended.length, 1);
      expect(result.suspended.first, flyerID);
      expect(result.drafts, pub.drafts);
      expect(result.pendings, pub.pendings);
      expect(result.published, pub.published);
    });

    test('Should return the same PublicationModel when the flyerID is not in the specified state',
        () {
      const pub = PublicationModel(
        drafts: ['draft1'],
        pendings: ['pending1'],
        published: [],
        unpublished: [],
        suspended: [],
      );
      const flyerID = 'newFlyer';

      final result = PublicationModel.moveFlyerIDFToNewState(
        pub: pub,
        flyerID: flyerID,
        toState: PublishState.suspended,
      );

      expect(result, pub);
    });

    test('Should return the same PublicationModel when the input PublicationModel is empty', () {
      const pub = PublicationModel.emptyModel;
      const flyerID = 'newFlyer';

      final result = PublicationModel.moveFlyerIDFToNewState(
        pub: pub,
        flyerID: flyerID,
        toState: PublishState.pending,
      );

      expect(result, pub);
    });

  });

  group('PublicationModel.insertFlyerInPublications()', () {
    test('Should add the new flyer ID to drafts when the flyer does not exist', () {
      const pub = PublicationModel.emptyModel;
      const flyerID = 'newFlyer';
      const toState = PublishState.draft;

      final result = PublicationModel.insertFlyerInPublications(
        pub: pub,
        flyerID: flyerID,
        toState: toState,
      );

      expect(result.drafts, contains(flyerID));
      expect(result.drafts.length, 1);
      expect(result.drafts.first, flyerID);
      expect(result.pendings, pub.pendings);
      expect(result.published, pub.published);
      expect(result.unpublished, pub.unpublished);
      expect(result.suspended, pub.suspended);
    });

    test(
        'Should bring the flyerID to the start of the drafts when the flyer is in drafts and moving to the same state',
        () {
      const pub = PublicationModel(
        drafts: ['draft1', 'draft2'],
        pendings: [],
        published: [],
        unpublished: [],
        suspended: [],
      );
      const flyerID = 'draft2';
      const toState = PublishState.draft;

      final result = PublicationModel.insertFlyerInPublications(
        pub: pub,
        flyerID: flyerID,
        toState: toState,
      );

      expect(result.drafts.first, flyerID);
      expect(result.drafts, containsAllInOrder(['draft1']));
      expect(result.pendings, pub.pendings);
      expect(result.published, pub.published);
      expect(result.unpublished, pub.unpublished);
      expect(result.suspended, pub.suspended);
    });

    test(
        'Should move the flyerID from drafts to published when the flyer is in drafts and moving to PublishState.published',
        () {
      const pub = PublicationModel(
        drafts: ['draft1', 'draft2'],
        pendings: [],
        published: [],
        unpublished: [],
        suspended: [],
      );
      const flyerID = 'draft2';
      const toState = PublishState.published;

      final result = PublicationModel.insertFlyerInPublications(
        pub: pub,
        flyerID: flyerID,
        toState: toState,
      );

      expect(result.drafts.contains(flyerID), false);
      expect(result.published, contains(flyerID));
      expect(result.published.length, 1);
      expect(result.published.first, flyerID);
      expect(result.pendings, pub.pendings);
      expect(result.unpublished, pub.unpublished);
      expect(result.suspended, pub.suspended);
    });

    test(
        'Should move the flyerID from drafts to pendings when the flyer is in drafts and moving to PublishState.pending',
        () {
      const pub = PublicationModel(
        drafts: ['draft1', 'draft2'],
        pendings: [],
        published: [],
        unpublished: [],
        suspended: [],
      );
      const flyerID = 'draft2';
      const toState = PublishState.pending;

      final result = PublicationModel.insertFlyerInPublications(
        pub: pub,
        flyerID: flyerID,
        toState: toState,
      );

      expect(result.drafts.contains(flyerID), false);
      expect(result.pendings, contains(flyerID));
      expect(result.pendings.length, 1);
      expect(result.pendings.first, flyerID);
      expect(result.published, pub.published);
      expect(result.unpublished, pub.unpublished);
      expect(result.suspended, pub.suspended);
    });

    test('Should move the flyerID from unpublished to suspended when the flyer is in unpublished and moving to PublishState.suspended',
        () {
      const pub = PublicationModel(
        drafts: [],
        pendings: [],
        published: [],
        unpublished: ['unpublished1', 'unpublished2'],
        suspended: [],
      );
      const flyerID = 'unpublished2';
      const toState = PublishState.suspended;

      final result = PublicationModel.insertFlyerInPublications(
        pub: pub,
        flyerID: flyerID,
        toState: toState,
      );

      expect(result.unpublished.contains(flyerID), false);
      expect(result.suspended, contains(flyerID));
      expect(result.suspended.length, 1);
      expect(result.suspended.first, flyerID);
      expect(result.drafts, pub.drafts);
      expect(result.pendings, pub.pendings);
      expect(result.published, pub.published);
    });


    test('Should return the same PublicationModel when the input PublicationModel is empty', () {
      const pub = PublicationModel.emptyModel;
      const flyerID = 'newFlyer';
      const toState = PublishState.pending;

      final result = PublicationModel.insertFlyerInPublications(
        pub: pub,
        flyerID: flyerID,
        toState: toState,
      );

      const PublicationModel shouldBe = PublicationModel(
          drafts: [],
          pendings: [flyerID],
          published: [],
          unpublished: [],
          suspended: [],
      );

      expect(result, shouldBe);
    });

  });

  group('PublicationModel.checkPublicationsAreIdentical ()', () {

    test('Should return true when both PublicationModel objects are null', () {
      const pub1 = null;
      const pub2 = null;

      final result = PublicationModel.checkPublicationsAreIdentical(
        pub1: pub1,
        pub2: pub2,
      );

      expect(result, true);
    });

    test('Should return false when one of the PublicationModel objects is null', () {
      const pub1 = PublicationModel(
        drafts: ['draft1'],
        pendings: ['pending1'],
        published: [],
        unpublished: [],
        suspended: [],
      );
      const pub2 = null;

      final result = PublicationModel.checkPublicationsAreIdentical(
        pub1: pub1,
        pub2: pub2,
      );

      expect(result, false);
    });

    test('Should return true when both PublicationModel objects have identical lists', () {
      const pub1 = PublicationModel(
        drafts: ['draft1', 'draft2'],
        pendings: ['pending1', 'pending2'],
        published: ['published1', 'published2'],
        unpublished: ['unpublished1', 'unpublished2'],
        suspended: ['suspended1', 'suspended2'],
      );
      const pub2 = PublicationModel(
        drafts: ['draft1', 'draft2'],
        pendings: ['pending1', 'pending2'],
        published: ['published1', 'published2'],
        unpublished: ['unpublished1', 'unpublished2'],
        suspended: ['suspended1', 'suspended2'],
      );

      final result = PublicationModel.checkPublicationsAreIdentical(
        pub1: pub1,
        pub2: pub2,
      );

      expect(result, true);
    });


    test('Should return false when drafts lists are different', () {
      const pub1 = PublicationModel(
        drafts: ['draft1', 'draft2'],
        pendings: [],
        published: [],
        unpublished: [],
        suspended: [],
      );
      const pub2 = PublicationModel(
        drafts: ['draft1', 'draft3'],
        pendings: [],
        published: [],
        unpublished: [],
        suspended: [],
      );

      final result = PublicationModel.checkPublicationsAreIdentical(
        pub1: pub1,
        pub2: pub2,
      );

      expect(result, false);
    });

    test('Should return false when pendings lists are different', () {
      const pub1 = PublicationModel(
        drafts: [],
        pendings: ['pending1', 'pending2'],
        published: [],
        unpublished: [],
        suspended: [],
      );
      const pub2 = PublicationModel(
        drafts: [],
        pendings: ['pending1', 'pending3'],
        published: [],
        unpublished: [],
        suspended: [],
      );

      final result = PublicationModel.checkPublicationsAreIdentical(
        pub1: pub1,
        pub2: pub2,
      );

      expect(result, false);
    });

    test('Should return false when published lists are different', () {
      const pub1 = PublicationModel(
        drafts: [],
        pendings: [],
        published: ['published1', 'published2'],
        unpublished: [],
        suspended: [],
      );
      const pub2 = PublicationModel(
        drafts: [],
        pendings: [],
        published: ['published1', 'published3'],
        unpublished: [],
        suspended: [],
      );

      final result = PublicationModel.checkPublicationsAreIdentical(
        pub1: pub1,
        pub2: pub2,
      );

      expect(result, false);
    });

    test('Should return false when unpublished lists are different', () {
      const pub1 = PublicationModel(
        drafts: [],
        pendings: [],
        published: [],
        unpublished: ['unpublished1', 'unpublished2'],
        suspended: [],
      );
      const pub2 = PublicationModel(
        drafts: [],
        pendings: [],
        published: [],
        unpublished: ['unpublished1', 'unpublished3'],
        suspended: [],
      );

      final result = PublicationModel.checkPublicationsAreIdentical(
        pub1: pub1,
        pub2: pub2,
      );

      expect(result, false);
    });

    test('Should return false when suspended lists are different', () {
      const pub1 = PublicationModel(
        drafts: [],
        pendings: [],
        published: [],
        unpublished: [],
        suspended: ['suspended1', 'suspended2'],
      );
      const pub2 = PublicationModel(
        drafts: [],
        pendings: [],
        published: [],
        unpublished: [],
        suspended: ['suspended1', 'suspended3'],
      );

      final result = PublicationModel.checkPublicationsAreIdentical(
        pub1: pub1,
        pub2: pub2,
      );

      expect(result, false);
    });
  });

}
