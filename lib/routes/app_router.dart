import 'package:go_router/go_router.dart';

import '../models/api_colombia_item.dart';
import '../views/dashboard/dashboard_view.dart';
import '../views/detail/endpoint_detail_view.dart';
import '../views/list/endpoint_list_view.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const DashboardView(),
    ),
    GoRoute(
      path: '/list/:endpointKey',
      builder: (context, state) {
        final endpointKey = state.pathParameters['endpointKey'] ?? '';
        return EndpointListView(endpointKey: endpointKey);
      },
    ),
    GoRoute(
      path: '/detail/:endpointKey/:id',
      builder: (context, state) {
        final endpointKey = state.pathParameters['endpointKey'] ?? '';
        final id = state.pathParameters['id'] ?? '';
        final itemFromExtra =
            state.extra is ApiColombiaItem ? state.extra as ApiColombiaItem : null;

        return EndpointDetailView(
          endpointKey: endpointKey,
          id: id,
          itemFromExtra: itemFromExtra,
        );
      },
    ),
  ],
);