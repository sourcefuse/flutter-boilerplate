import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:clean_arch/core/data/dto/note_model.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
  final tNoteModel = NoteModel(
    uid: 'testUid',
    isDeleted: false,
    title: '55',
    description: '55',
    priority: 0,
  );

  test('check model type', () async {
    expect(tNoteModel, isA<NoteModel>());
  });

  group('fromJson', () {
    test('should return a valid model when the JSON is an integer', () async {
      // arrange
      final Map<String, dynamic> jsonMap = json.decode(fixture('note.json'));

      //act
      final result = NoteModel.fromJson(jsonMap);

      //assert
      expect(result, tNoteModel);
    });

    test('priority is an integer number', () async {
      //assert
      expect(tNoteModel.priority, isA<int>());
    });
  });

  group('toJson', () {
    test('should return a JSON map containing the proper data', () async {
      //arrange

      //act
      final result = tNoteModel.toJson();
      //assert
      final expectedMap = {
        'id': null,
        "uid": "testUid",
        "isDeleted": false,
        "title": "55",
        "description": "55",
        'date': null,
        "priority": 0,
      };
      expect(result, expectedMap);
    });
  });
}
