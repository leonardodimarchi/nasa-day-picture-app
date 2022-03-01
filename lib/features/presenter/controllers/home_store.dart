import 'package:flutter_triple/flutter_triple.dart';
import 'package:nasa_picture_of_the_day/core/errors/failures.dart';
import 'package:nasa_picture_of_the_day/features/domain/entities/space_media_entity.dart';
import 'package:nasa_picture_of_the_day/features/domain/usecases/get_space_media_by_date_usecase.dart';

class HomeStore extends NotifierStore<Failure, SpaceMediaEntity> {
  final GetSpaceMediaByDateUseCase usecase;

  HomeStore(this.usecase) : super(const SpaceMediaEntity(
    description: '', 
    type: '', 
    title: '', 
    url: '',
  ));

  getSpaceMediaByDate(DateTime? date) async {
    setLoading(true);

    final spaceMedia = await usecase(date);

    spaceMedia.fold(
      (error) => setError(error), 
      (success) => update(success),
    );
  }
}