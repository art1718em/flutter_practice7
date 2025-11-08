import 'package:go_router/go_router.dart';
import '../car_expenses/screens/add_expense_screen.dart';
import '../car_expenses/state/car_expenses_container.dart';
import '../service_history/screens/add_service_record_screen.dart';
import '../service_history/screens/service_history_screen.dart';
import '../vehicle_info/screens/vehicle_info_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/expenses',
  routes: [
    GoRoute(
        path: '/expenses',
        builder: (context, state) => const CarExpensesContainer(),
        routes: [
          GoRoute(
            path: 'add',
            builder: (context, state) => const AddExpenseScreen(),
          ),
        ]),
    GoRoute(
      path: '/info',
      builder: (context, state) => const VehicleInfoScreen(),
    ),
    GoRoute(
        path: '/history',
        builder: (context, state) => const ServiceHistoryScreen(),
        routes: [
          GoRoute(
            path: 'add',
            builder: (context, state) => const AddServiceRecordScreen(),
          ),
        ]),
  ],
);
