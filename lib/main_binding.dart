import 'package:get/instance_manager.dart';
import 'package:manga_track_app/app/data/core/local/shared_pref.dart';
import 'package:manga_track_app/app/data/core/network/api_interceptor.dart';
import 'package:manga_track_app/app/data/core/network/api_provider.dart';
import 'package:manga_track_app/app/data/data/datasources/manga/manga_remote_data_source.dart';
import 'package:manga_track_app/app/data/data/repositories/manga_repository_impl.dart';
import 'package:manga_track_app/app/data/domain/repositories/manga_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainBinding extends Bindings {
  @override
  Future<void> dependencies() async {
    final sharedPref = await SharedPreferences.getInstance();
    Get.put(SharedPreferencesManager(sharedPreferences: sharedPref), permanent: true);

    /// API PROVIDER
    Get.put(ApiInterceptor(sharedPreferencesManager: Get.find()), permanent: true);
    Get.put<ApiProvider>(ApiProviderImpl(Get.find()), permanent: true);

    /// MANGA
    Get.put<MangaRemoteDataSource>(MangaRemoteDataSourceImpl(apiProvider: Get.find()), permanent: true);
    Get.put<MangaRepository>(MangaRepositoryImpl(remoteDataSource: Get.find()), permanent: true);
  }
}
