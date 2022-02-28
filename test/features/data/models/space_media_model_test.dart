import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:nasa_picture_of_the_day/features/data/models/space_media_model.dart';
import 'package:nasa_picture_of_the_day/features/domain/entities/space_media_entity.dart';

import '../../../mocks/space_media_mock.dart';

void main() {
  const mockedSpaceMediaModel = SpaceMediaModel(
    title: 'Galaxy image',
    description: 'Today\'s galaxy image',
    type: 'image',
    url: 'https://apod.nasa.gov/apod/image/2202/PerseveranceSol354Nav1_1br2_KenKremer1024.jpg'
  );

  test('Should be a subclass of SpaceMediaEntity', () {
    expect(mockedSpaceMediaModel, isA<SpaceMediaEntity>());
  });

  test('Should return a valid model (fromJson)', () {
    // Arrange
    final Map<String, dynamic> jsonMap = json.decode(mockSpaceMedia);

    // Act
    final spaceMediaFromJson = SpaceMediaModel.fromJson(jsonMap);

    // Assert
    expect(spaceMediaFromJson, mockedSpaceMediaModel);
  });

  test('Should return a json map with the proper data when calling toJson method', () {
    final expectedMap = {
      "title": 'Galaxy image',
      "explanation": 'Today\'s galaxy image',
      "media_type": 'image',
      "url": 'https://apod.nasa.gov/apod/image/2202/PerseveranceSol354Nav1_1br2_KenKremer1024.jpg'
    };

    final spaceMediaToJson = mockedSpaceMediaModel.toJson();

    expect(spaceMediaToJson, expectedMap);
  });
}
