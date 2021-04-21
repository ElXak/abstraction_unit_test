import 'package:abstraction_unit_test/services/api/api.dart';
import 'package:abstraction_unit_test/services/post_service.dart';
import 'package:abstraction_unit_test/services/storage/storage_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockStorageService extends Mock implements StorageService {}

class MockApi extends Mock implements Api {}

void main() {
  group('PostService Test | ', () {
    test('Constructing Service should find correct dependencies', () {
      var postService = PostService();
      expect(postService != null, true);
    });

    test('Give postId 1, should call localStorageService with 1', () async {
      var mockStorageService = MockStorageService();

      var mockApi = MockApi();
      // return fake true
      when(mockApi.likePost(1)).thenAnswer((_) => Future.value(true));

      var postService =
          PostService(api: mockApi, storageService: mockStorageService);
      await postService.likePost(1);

      verify(mockStorageService.likePost(1));
    });

    test('Given like fails, should revert localLike', () async {
      var mockStorageService = MockStorageService();
      // Like was successful locally
      when(mockStorageService.likePost(1))
          .thenAnswer((_) => Future.value(true));

      var mockApi = MockApi();
      // Like failed on the api
      when(mockApi.likePost(1)).thenAnswer((_) => Future.value(false));

      var postService =
          PostService(api: mockApi, storageService: mockStorageService);
      await postService.likePost(1);

      // confirm the storage like was called with unlike
      verify(mockStorageService.likePost(1, unlike: true));
    });
  });
}
