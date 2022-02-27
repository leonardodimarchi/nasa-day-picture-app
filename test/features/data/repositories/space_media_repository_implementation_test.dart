import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa_picture_of_the_day/core/errors/exceptions.dart';
import 'package:nasa_picture_of_the_day/core/errors/failures.dart';
import 'package:nasa_picture_of_the_day/features/data/datasources/space_media_datasource.dart';
import 'package:nasa_picture_of_the_day/features/data/models/space_media_model.dart';
import 'package:nasa_picture_of_the_day/features/data/repositories/space_media_repository_implementation.dart';

class MockSpaceMediaDatasource extends Mock implements SpaceMediaDatasource {

}

void main() {
  late SpaceMediaRepositoryImplementation repository;
  late SpaceMediaDatasource datasource;

  setUp(() {
    datasource = MockSpaceMediaDatasource();
    repository = SpaceMediaRepositoryImplementation(datasource);
  });

  final mockedDate = DateTime(2022, 11, 04);
  const mockedSpaceMediaModel = SpaceMediaModel(
    title: 'Galaxy image',
    description: 'Today\'s galaxy image',
    type: 'image',
    url: 'https://apod.nasa.gov/apod/image/2202/PerseveranceSol354Nav1_1br2_KenKremer1024.jpg'
  );

  test('Should return Space Media model when calls the datasource', () async {
    // Arrange
    when(() => datasource.getSpaceMediaByDate(mockedDate)).thenAnswer((_) async => mockedSpaceMediaModel);

    // Act
    final result = await repository.getSpaceMediaByDate(mockedDate);

    // Assert
    expect(result, const Right(mockedSpaceMediaModel));
    verify(() => datasource.getSpaceMediaByDate(mockedDate)).called(1);
  });

  test('Should return a Server Failure when the call to the datasource is unsucessful', () async {
    // Arrange
    when(() => datasource.getSpaceMediaByDate(mockedDate)).thenThrow(ServerException());

    // Act
    final result = await repository.getSpaceMediaByDate(mockedDate);

    // Assert
    expect(result, Left(ServerFailure()));
    verify(() => datasource.getSpaceMediaByDate(mockedDate)).called(1);
  });
}