import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa_picture_of_the_day/core/errors/exceptions.dart';
import 'package:nasa_picture_of_the_day/core/http_client/http_client.dart';
import 'package:nasa_picture_of_the_day/core/utils/converters/date_to_string_converter.dart';
import 'package:nasa_picture_of_the_day/features/data/datasources/space_media_datasource.dart';
import 'package:nasa_picture_of_the_day/features/data/datasources/nasa_datasource_implementation.dart';
import 'package:nasa_picture_of_the_day/features/data/models/space_media_model.dart';

import '../../../mocks/date_mock.dart';
import '../../../mocks/space_media_mock.dart';

class HttpClientMock extends Mock implements HttpClient {

}

void main() {
  late SpaceMediaDatasource datasource;
  late HttpClient httpClient;
  late DateToStringConverter converter;

  setUp(() {
    httpClient = HttpClientMock();
    converter = DateToStringConverter();
    datasource = NasaDatasourceImplementation(httpClient: httpClient, converter: converter);
  });

  const expectedUrl = 'https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY&date=2021-02-04';

  void successMock() {
    when(() => httpClient.get(any())).thenAnswer((_) async => HttpResponse(data: mockSpaceMedia, statusCode: 200));
  }

  test('Should call get method with correct url', () async {
    successMock();

    await datasource.getSpaceMediaByDate(mockedDate);

    verify(() => httpClient.get(expectedUrl)).called(1);
  });

  test('Should return a SpaceMediaModel when successfull', () async {
    successMock();
    const expectedSpaceMediaModel = SpaceMediaModel(
      title: 'Galaxy image',
      description: 'Today\'s galaxy image',
      type: 'image',
      url: 'https://apod.nasa.gov/apod/image/2202/PerseveranceSol354Nav1_1br2_KenKremer1024.jpg'
    );

    final result =  await datasource.getSpaceMediaByDate(mockedDate);

    expect(result, expectedSpaceMediaModel);
  });

  test('Should throw a ServerException when the call is unsuccessfull', () async {
    when(() => httpClient.get(any()))
      .thenAnswer((_) async => HttpResponse(
        data: 'Something went wrong', 
        statusCode: 400,
      ));

    final result = datasource.getSpaceMediaByDate(mockedDate);

    expect(() => result, throwsA(ServerException()));
  });
}