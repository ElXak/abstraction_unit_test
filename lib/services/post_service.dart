import 'api/api.dart';
import 'storage/storage_service.dart';

class PostService {
  Api _api;
  StorageService _storageService;

  PostService({Api api, StorageService storageService})
      : _api = api,
        _storageService = storageService;

  Future<bool> likePost(int postId) async {
    var localLikeSuccess = await _storageService.likePost(postId);
    var postLiked = await _api.likePost(postId);

    if (postLiked) {
      return true;
    }

    if (localLikeSuccess) {
      await _storageService.likePost(postId, unlike: true);
    }

    return false;
  }
}
