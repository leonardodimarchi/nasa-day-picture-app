import 'package:equatable/equatable.dart';

// Internal APP Exceptions
abstract class Failure extends Equatable {}

class ServerFailure extends Failure {
  @override
  List<Object?> get props => [];
}