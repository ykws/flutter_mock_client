import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_mock_client/main.dart';

class MockClient extends Mock implements http.Client {}

main() {
  group('fetchPost', () {
    test('returns a Post if the http call completes successfully', () async {
      final client = MockClient();

      when(client.get('https://jsonplaceholder.typicode.com/posts/1'))
        .thenAnswer((_) async => http.Response('{"title": "Test"}', 200));

      expect(await fetchPost(client), const TypeMatcher<Post>());
    });

    test('throws an exception if the http call completes with an error', () {
      final client = MockClient();

      when(client.get('https://jsonplaceholder.typicode.com/posts/1'))
        .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(fetchPost(client), throwsException);
    });
  });
}
