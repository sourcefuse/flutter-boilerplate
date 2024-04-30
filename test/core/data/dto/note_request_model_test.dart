import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:clean_arch/core/data/dto/note_request_model.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
  final tNoteRequestModel = NoteRequestModel('testUid');

  test('check model type', () async {
    expect(tNoteRequestModel, isA<NoteRequestModel>());
  });

  group('fromJson', () {
    test('should return a valid model when the JSON is String', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('note_request.json'));

      //act
      final result = NoteRequestModel.fromJson(jsonMap);

      //assert
      expect(result, tNoteRequestModel);
    });

    test('uid is a String', () async {
      //assert
      expect(tNoteRequestModel.uid, isA<String>());
    });
  });

  group('toJson', () {
    test('should return a JSON map containing the proper data', () async {
      //arrange

      //act
      final result = tNoteRequestModel.toJson();
      //assert
      final expectedMap = {"uid": "testUid"};
      expect(result, expectedMap);
    });
  });
}
