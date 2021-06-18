import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:wiki_search/ui/splash_screen/splash_view.dart';
import 'package:wiki_search/ui/startup/startup_view.dart';

@StackedApp(routes: [
  MaterialRoute(page: SplashScreen, initial: true),
  MaterialRoute(page: StartUpView),
], dependencies: [
  LazySingleton(classType: NavigationService),
])
class AppSetup {}
