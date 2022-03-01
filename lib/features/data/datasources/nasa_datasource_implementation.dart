import 'dart:convert';

import 'package:nasa_picture_of_the_day/core/errors/exceptions.dart';
import 'package:nasa_picture_of_the_day/core/http_client/http_client.dart';
import 'package:nasa_picture_of_the_day/core/utils/converters/date_to_string_converter.dart';
import 'package:nasa_picture_of_the_day/core/utils/keys/nasa_api_keys.dart';
import 'package:nasa_picture_of_the_day/features/data/datasources/endpoints/nasa_endpoints.dart';
import 'package:nasa_picture_of_the_day/features/data/datasources/space_media_datasource.dart';
import 'package:nasa_picture_of_the_day/features/data/models/space_media_model.dart';

class NasaDatasourceImplementation implements SpaceMediaDatasource {
  final DateToStringConverter converter;
  final HttpClient httpClient;

  NasaDatasourceImplementation({
    required this.converter,
    required this.httpClient,
  });

  @override
  Future<SpaceMediaModel> getSpaceMediaByDate(DateTime date) async {
    final url = NasaEndpoints.apod(NasaApiKeys.apiKey, DateToStringConverter.convert(date));
    final response = await httpClient.get(url);

    if (response.statusCode == 200) {
      return SpaceMediaModel.fromJson(jsonDecode(response.data));
    } else {
      throw ServerException();
    }
  }
}