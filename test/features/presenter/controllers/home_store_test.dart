import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa_picture_of_the_day/core/errors/failures.dart';
import 'package:nasa_picture_of_the_day/features/domain/usecases/get_space_media_by_date_usecase.dart';
import 'package:nasa_picture_of_the_day/features/presenter/controllers/home_store.dart';

import '../../../mocks/date_mock.dart';
import '../../../mocks/space_media_entity_mock.dart';

class MockGetSpaceMediaByDateUseCase extends Mock implements GetSpaceMediaByDateUseCase {

}

void main() {
  late HomeStore homeStore;
  late GetSpaceMediaByDateUseCase mockUsecase;

  setUp((){
    mockUsecase = MockGetSpaceMediaByDateUseCase();
    homeStore = HomeStore(mockUsecase);

    registerFallbackValue(DateTime(0, 0, 0));
  });

  final mockedFailure = ServerFailure();

  test('Should return a SpaceMedia entity from the usecase', () async {
    when(() => mockUsecase(any())).thenAnswer((_) async => const Right(mockSpaceMediaEntity));

    await homeStore.getSpaceMediaByDate(mockedDate);

    homeStore.observer(
      onState: (state) {
        expect(state, mockSpaceMediaEntity);
        verify(() => mockUsecase(mockedDate)).called(1);
      },
    );
  });

    test('Should return a failure from the usecase when there is an error', () async {
    when(() => mockUsecase(any())).thenAnswer((_) async => Left(mockedFailure));

    await homeStore.getSpaceMediaByDate(mockedDate);

    homeStore.observer(
      onError: (error) {
        expect(error, mockedFailure);
        verify(() => mockUsecase(mockedDate)).called(1);
      }
    );
  });
}