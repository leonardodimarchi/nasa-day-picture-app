import 'package:nasa_picture_of_the_day/features/domain/entities/space_media_entity.dart';

class SpaceMediaModel extends SpaceMediaEntity {
  const SpaceMediaModel({
    required String description,
    required String type,
    required String title,
    required String url,
  }) : super(
    description: description, 
    title: title, 
    type: type,
    url: url,
  );

    factory SpaceMediaModel.fromJson(Map<String, dynamic> json) => 
      SpaceMediaModel(
        description: json['explanation'], 
        type: json['media_type'], 
        title: json['title'], 
        url: json['url'],
      );

    Map<String, dynamic> toJson() => {
      'explanation': description,
      'media_type': type,
      'title': title,
      'url': url,
    };
}