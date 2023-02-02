import '../../../../domain/enums.dart';
import '../../../../domain/repository/trending_repository.dart';
import '../../../global/base/state_notifier.dart';
import 'state/home_state.dart';

class HomeController extends StateNotifier<HomeState> {
  TimeWindow timeWindow = TimeWindow.day;
  HomeController(
    super.state, {
    required this.trendingRepository,
  });
  TimeWindow get timeWindowSelected => timeWindow;
  void set(TimeWindow timeWindow) {
    this.timeWindow = timeWindow;
  }

  final TrendingRepository trendingRepository;

  Future<void> fetch() async {
    update(HomeState.loading(true));
    final result = await trendingRepository.getMoviesAndSeries(timeWindow);
    result.when(left: (failure) {
      update(HomeState.loading(false));
      update(HomeState.error());
    }, right: (data) {
      update(HomeState.loading(false));
      update(HomeState.success(data));
    });
  }
}
