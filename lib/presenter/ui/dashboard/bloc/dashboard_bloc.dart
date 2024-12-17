import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../network/client/api_client.dart';
import 'dashboard_event.dart';
import 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final ApiClient apiService; // Your Retrofit service class
  DashboardBloc({required this.apiService}) : super(DashboardInitial()) {
    on<FetchDashboardData>((event, emit) async {
      ///----On LoginButtonPressedEvent
      emit(DashboardLoading());
      await handleApiCall(emit);
    });
  }

  Future<void> handleApiCall(Emitter<DashboardState> emit) async {
    try {
      final response = await apiService.fetchDashboardData();
      if (response != null && response.isNotEmpty) {
        emit(DashboardLoaded(response));
      } else {
        emit(DashboardEmptyState("No data available."));
      }
    } catch (e) {
      emit(DashboardError("Invalid username or password"));
    }
  }
}
