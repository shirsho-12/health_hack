import '../../../features/force_update/models/app_info.dart';
import '../../../features/force_update/models/minimum_version.dart';
import '../../../features/force_update/use_case/get_app_info_use_case.dart';
import '../../../features/force_update/use_case/get_minimum_version_use_case.dart';
import '../../../router/mobile_router.dart';

/// Class that manages and evaluates whether the app should be updated or not.
///
/// It starts from the `verifyVersion` function, which fetches this information from the server,
/// and checks if the current version of the app is the minimum version supported by the server.
/// If not, it redirects the app to the update screen.
///
/// ***To use this module correctly, make sure all necessary dependencies are in your project.***
abstract class ForceUpdateProtocol {
  void verifySession();
}

class ForceUpdate extends ForceUpdateProtocol {
  // Private properties
  final GetAppInfoUseCaseProtocol getAppInfoUseCase;
  final GetMinimumVersionUseCaseProtocol getMinimumVersionUseCase;

  // Constructor
  ForceUpdate({
    required this.getAppInfoUseCase,
    required this.getMinimumVersionUseCase,
  });

  // Public functions
  @override
  void verifySession() {
    getAppInfoUseCase.execute(
      completion: (appInfo) {
        _getServerMinimumVersionBy(appInfo);
      },
    );
  }

  // Private functions
  void _getServerMinimumVersionBy(AppInfo appInfo) {
    getMinimumVersionUseCase.execute(
      platform: appInfo.platform,
      success: (minimumVersion) {
        _checkAppVersionToForceUpdateIfNeeded(appInfo, minimumVersion);
      },
    );
  }

  void _checkAppVersionToForceUpdateIfNeeded(
    AppInfo appInfo,
    MinimumVersion minimumVersion,
  ) {
    if (appInfo.version.toIntVersion >=
        minimumVersion.versionNumber.toIntVersion) {
      return;
    }

    MobileRouter.redirectToForceUpdate(
      isRequiredVersion: minimumVersion.isRequiredVersion ?? false,
    );
  }
}

extension IntExtensions on String {
  int get toIntVersion {
    return int.parse(replaceAll('.', ''));
  }
}
