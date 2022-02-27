import 'package:nasa_picture_of_the_day/core/errors/exceptions.dart';
import 'package:nasa_picture_of_the_day/features/data/datasources/space_media_datasource.dart';
import 'package:nasa_picture_of_the_day/features/domain/entities/space_media_entity.dart';
import 'package:nasa_picture_of_the_day/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:nasa_picture_of_the_day/features/domain/repositories/space_media_repository.dart';

class SpaceMediaRepositoryImplementation implements SpaceMediaRepository {
  final SpaceMediaDatasource datasource;

  SpaceMediaRepositoryImplementation(this.datasource);

  @override
  Future<Either<Failure, SpaceMediaEntity>> getSpaceMediaByDate(DateTime date) async {
    try {
      final result = await datasource.getSpaceMediaByDate(date);

      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}