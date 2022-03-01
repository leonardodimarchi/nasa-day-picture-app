import 'package:flutter_modular/flutter_modular.dart';
import 'package:nasa_picture_of_the_day/core/http_client/http_client_implementation.dart';
import 'package:nasa_picture_of_the_day/core/utils/converters/date_to_string_converter.dart';
import 'package:nasa_picture_of_the_day/features/data/datasources/nasa_datasource_implementation.dart';
import 'package:nasa_picture_of_the_day/features/data/repositories/space_media_repository_implementation.dart';
import 'package:nasa_picture_of_the_day/features/domain/usecases/get_space_media_by_date_usecase.dart';
import 'package:nasa_picture_of_the_day/features/presenter/controllers/home_store.dart';
import 'package:nasa_picture_of_the_day/features/presenter/pages/home_page.dart';
import 'package:nasa_picture_of_the_day/features/presenter/pages/picture_page.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.factory((i) => HomeStore(i())),
    Bind.lazySingleton((i) => GetSpaceMediaByDateUseCase(i())),
    Bind.lazySingleton((i) => SpaceMediaRepositoryImplementation(i())),
    Bind.lazySingleton((i) => NasaDatasourceImplementation(converter: i(), httpClient: i())),
    Bind.lazySingleton((i) => HttpClientImplementation()),
    Bind.lazySingleton((i) => DateToStringConverter()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, __) => const HomePage()),
    ChildRoute('/picture', child: (_, args) => PicturePage.fromArgs(args.data)),
  ];
}