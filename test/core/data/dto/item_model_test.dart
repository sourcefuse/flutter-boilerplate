import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:clean_arch/core/data/dto/item_model.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
  const tItemModel = ItemModel(
    uid: 'testUid',
    isDeleted: false,
    title: '55',
    description: '55',
    priority: 0,
  );

  test('check model type', () async {
    expect(tItemModel, isA<ItemModel>());
  });

  group('fromJson', () {
    test('should return a valid model when the JSON is an integer', () async {
      // arrange
      final Map<String, dynamic> jsonMap = json.decode(fixture('note.json'));

      //act
      final result = ItemModel.fromJson(jsonMap);

      //assert
      expect(result, tItemModel);
    });

    test('priority is an integer number', () async {
      //assert
      expect(tItemModel.priority, isA<int>());
    });
  });

  group('toJson', () {
    test('should return a JSON map containing the proper data', () async {
      //arrange

      //act
      final result = tItemModel.toJson();
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
