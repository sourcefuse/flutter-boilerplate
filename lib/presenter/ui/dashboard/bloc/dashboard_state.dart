import 'package:clean_arch/core/data/model/dashboard_res_model/dashboard_response.dart';

abstract class DashboardState {}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final List<DashboardResponse> items;

  DashboardLoaded(this.items);
}

class DashboardError extends DashboardState {
  final String message;

  DashboardError(this.message);
}

class DashboardEmptyState extends DashboardState {
  final String message;

  DashboardEmptyState(this.message);
}
