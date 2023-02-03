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

  Future<void> init() async {
    await getMoviesAndSeries();
    await getPerformers();
  }

  Future<void> getMoviesAndSeries() async {
    state = state.copyWith(
        moviesAndSeries: const MoviesAndSeriesState.loading(true));
    final result = await trendingRepository.getMoviesAndSeries(timeWindow);
    result.when(left: (failure) {
      state = state.copyWith(
          moviesAndSeries: const MoviesAndSeriesState.loading(false));

      state =
          state.copyWith(moviesAndSeries: const MoviesAndSeriesState.error());
    }, right: (data) {
      state = state.copyWith(
          moviesAndSeries: const MoviesAndSeriesState.loading(false));
      state =
          state.copyWith(moviesAndSeries: MoviesAndSeriesState.success(data));
    });
  }

  Future<void> getPerformers() async {
    state = state.copyWith(performers: const PerformersState.loading(true));
    final result = await trendingRepository.getPerformers();
    result.when(left: (failure) {
      state = state.copyWith(performers: const PerformersState.loading(false));
      state = state.copyWith(performers: const PerformersState.failed());
    }, right: (data) {
      state = state.copyWith(performers: const PerformersState.loading(false));
      state = state.copyWith(performers: PerformersState.success(data));
    });
  }
}
