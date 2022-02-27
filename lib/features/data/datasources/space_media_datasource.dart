import 'package:nasa_picture_of_the_day/features/data/models/space_media_model.dart';

abstract class SpaceMediaDatasource {
  Future<SpaceMediaModel> getSpaceMediaByDate(DateTime date);
}