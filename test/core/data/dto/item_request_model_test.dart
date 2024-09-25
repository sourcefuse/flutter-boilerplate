import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:clean_arch/core/data/dto/item_request_model.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
  const tItemRequestModel = ItemRequestModel('testUid');

  test('check model type', () async {
    expect(tItemRequestModel, isA<ItemRequestModel>());
  });

  group('fromJson', () {
    test('should return a valid model when the JSON is String', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('note_request.json'));

      //act
      final result = ItemRequestModel.fromJson(jsonMap);

      //assert
      expect(result, tItemRequestModel);
    });

    test('uid is a String', () async {
      //assert
      expect(tItemRequestModel.uid, isA<String>());
    });
  });

  group('toJson', () {
    test('should return a JSON map containing the proper data', () async {
      //arrange

      //act
      final result = tItemRequestModel.toJson();
      //assert
      final expectedMap = {"uid": "testUid"};
      expect(result, expectedMap);
    });
  });
}
