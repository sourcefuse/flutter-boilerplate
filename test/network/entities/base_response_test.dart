import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:clean_arch/network/entities/base_response.dart';

import '../../fixtures/fixture_reader.dart';


void main() {

  const tBaseResponse = BaseResponse<dynamic>(data: true, success: true);

  test('check model type', () async {
    expect(tBaseResponse, isA<BaseResponse>());
  });

  group('fromJson', () {
    test('should return a valid base model', () async {
      // arrange
      final Map<String, dynamic> jsonMap = json.decode(fixture('base_response.json'));

      //act
      final result = BaseResponse.fromJson(jsonMap);

      //assert
      expect(result, tBaseResponse);
    });

    test('success is a bool', () async {
      //assert
      expect(tBaseResponse.success, isA<bool>());
    });
  });
}
