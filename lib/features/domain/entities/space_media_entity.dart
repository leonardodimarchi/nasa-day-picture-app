import 'package:equatable/equatable.dart';

class SpaceMediaEntity extends Equatable {
  final String description;
  final String type;
  final String title;
  final String url;

  const SpaceMediaEntity({
    required this.description, 
    required this.type, 
    required this.title, 
    required this.url
  });

  @override
  List<Object?> get props => [
    description,
    type,
    title,
    url,
  ];
}