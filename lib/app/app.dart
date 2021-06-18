import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:wiki_search/ui/second/second_view.dart';
import 'package:wiki_search/ui/startup/startup_view.dart';

@StackedApp(routes: [
  CupertinoRoute(page: StartUpView, initial: true),
  CupertinoRoute(page: SecondView),
], dependencies: [
  LazySingleton(classType: NavigationService),
])
class AppSetup {}
