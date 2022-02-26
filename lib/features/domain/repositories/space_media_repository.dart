import 'package:dartz/dartz.dart';
import 'package:nasa_picture_of_the_day/core/errors/failures.dart';
import 'package:nasa_picture_of_the_day/features/domain/entities/space_media_entity.dart';

abstract class SpaceMediaRepository {
  Future<Either<Failure, SpaceMediaEntity>> getSpaceMediaByDate(DateTime date);
}