import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:nasa_picture_of_the_day/core/errors/failures.dart';

abstract class UseCase<Output, Input> {
  Future<Either<Failure, Output>> call(Input params);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}