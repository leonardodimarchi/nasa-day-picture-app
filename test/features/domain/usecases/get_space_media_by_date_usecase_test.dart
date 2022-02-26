import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa_picture_of_the_day/core/errors/failures.dart';
import 'package:nasa_picture_of_the_day/features/domain/entities/space_media_entity.dart';
import 'package:nasa_picture_of_the_day/features/domain/repositories/space_media_repository.dart';
import 'package:nasa_picture_of_the_day/features/domain/usecases/get_space_media_by_date_usecase.dart';

class MockSpaceMediaRepository extends Mock implements SpaceMediaRepository{

}

void main() {
  late GetSpaceMediaByDateUseCase usecase;
  late SpaceMediaRepository repository;

  setUp(() {
    repository = MockSpaceMediaRepository();
    usecase = GetSpaceMediaByDateUseCase(repository);
  });

  const mockSpaceMedia = SpaceMediaEntity(
    description: 'This Navcam mosaic from Perseverance looks out over the car-sized rover\'s deck, across the floor of Jezero crater on Mars. Frames used to construct the mosaic',
    type: 'image', 
    title: 'Media Title', 
    url: 'https://apod.nasa.gov/apod/image/2202/PerseveranceSol354Nav1_1br2_KenKremer1024.jpg',
  );

  final mockedDate = DateTime(2022, 11, 04);
  
  test('Should get space media for a given date from the repository', () async {
    when(() => repository.getSpaceMediaByDate(mockedDate)).thenAnswer((_) async => const Right<Failure, SpaceMediaEntity>(mockSpaceMedia));

    final result = await usecase(mockedDate);

    expect(result, const Right(mockSpaceMedia));
    verify(() => repository.getSpaceMediaByDate(mockedDate)).called(1);
  });

  test('should return a failure when unsuccessful', () async {
    when(() => repository.getSpaceMediaByDate(mockedDate))
    .thenAnswer((_) async => Left<Failure, SpaceMediaEntity>(ServerFailure()));

    final result = await usecase(mockedDate);

    expect(result, Left(ServerFailure()));
    verify(() => repository.getSpaceMediaByDate(mockedDate)).called(1);
  });
}