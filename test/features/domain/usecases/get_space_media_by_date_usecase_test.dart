import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa_picture_of_the_day/core/errors/failures.dart';
import 'package:nasa_picture_of_the_day/features/domain/entities/space_media_entity.dart';
import 'package:nasa_picture_of_the_day/features/domain/repositories/space_media_repository.dart';
import 'package:nasa_picture_of_the_day/features/domain/usecases/get_space_media_by_date_usecase.dart';
import '../../../mocks/date_mock.dart';
import '../../../mocks/space_media_entity_mock.dart';

class MockSpaceMediaRepository extends Mock implements SpaceMediaRepository {

}

void main() {
  late GetSpaceMediaByDateUseCase usecase;
  late SpaceMediaRepository repository;

  setUp(() {
    repository = MockSpaceMediaRepository();
    usecase = GetSpaceMediaByDateUseCase(repository);
  });

  
  test('Should return space media for a given date from the repository', () async {
    when(() => repository.getSpaceMediaByDate(any())).thenAnswer((_) async => const Right<Failure, SpaceMediaEntity>(mockSpaceMediaEntity));

    final result = await usecase(mockedDate);

    expect(result, const Right(mockSpaceMediaEntity));
    verify(() => repository.getSpaceMediaByDate(mockedDate)).called(1);
  });

  test('Should return a failure when the repository call is unsuccessful', () async {
    when(() => repository.getSpaceMediaByDate(any()))
    .thenAnswer((_) async => Left<Failure, SpaceMediaEntity>(ServerFailure()));

    final result = await usecase(mockedDate);

    expect(result, Left(ServerFailure()));
    verify(() => repository.getSpaceMediaByDate(mockedDate)).called(1);
  });

  test('Should return NullParam failure when date is Null', () async {
    final result = await usecase(null);

    expect(result, Left(NullParamFailure()));
    verifyNever(() => repository.getSpaceMediaByDate(mockedDate));
  });
}