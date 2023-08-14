
import 'lifecycle_manager_platform_interface.dart';
import 'models/lifecycle.dart';

class LifecycleManager {

  Future<Lifecycle> getApplicationLifecycle() {
    return LifecycleManagerPlatform.instance.getApplicationLifecycle();
  }

}
