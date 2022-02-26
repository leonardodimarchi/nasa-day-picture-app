import 'package:nasa_picture_of_the_day/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:nasa_picture_of_the_day/core/usecase/usecase.dart';
import 'package:nasa_picture_of_the_day/features/domain/entities/space_media_entity.dart';
import 'package:nasa_picture_of_the_day/features/domain/repositories/space_media_repository.dart';

class GetSpaceMediaByDateUseCase implements UseCase<SpaceMediaEntity, DateTime> {
  final SpaceMediaRepository repository;

  GetSpaceMediaByDateUseCase(this.repository);

  @override
  Future<Either<Failure, SpaceMediaEntity>> call(DateTime date) async {
    return await repository.getSpaceMediaByDate(date);
  }
}