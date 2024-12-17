import 'package:clean_arch/network/client/api_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clean_arch/presenter/ui/dashboard/side_navigation_drawer.dart';
import 'bloc/dashboard_bloc.dart';
import 'bloc/dashboard_event.dart';
import 'bloc/dashboard_state.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DashboardBloc(
          apiService:
              ApiClient(baseUrl: "https://jsonplaceholder.typicode.com"))
        ..add(FetchDashboardData()), // Trigger the data fetch
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Dashboard'),
        ),
        drawer: const SideNavigationDrawer(),
        body: BlocBuilder<DashboardBloc, DashboardState>(
          builder: (context, state) {
            if (state is DashboardLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is DashboardLoaded) {
              return ListView.builder(
                itemCount: state.items.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(state.items[index].title ?? ''),
                  );
                },
              );
            } else if (state is DashboardError) {
              return Center(child: Text('Error: ${state.message}'));
            }
            return const Center(child: Text('No data available.'));
          },
        ),
      ),
    );
  }
}
