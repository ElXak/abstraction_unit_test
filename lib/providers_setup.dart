import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'services/api/api.dart';
import 'services/api/http_api.dart';
import 'services/storage/localstorage_service.dart';
import 'services/storage/storage_service.dart';

List<SingleChildWidget> providers = [
  Provider<StorageService>.value(value: LocalStorageService()),
  Provider<Api>.value(value: HttpApi())
];
