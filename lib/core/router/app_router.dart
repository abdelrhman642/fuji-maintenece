import 'package:flutter_project/features/auth/presentation/screens/login_view.dart';
import 'package:flutter_project/features/auth/presentation/screens/register_view.dart';
import 'package:flutter_project/features/auth/presentation/screens/splash_screen_view.dart';
import 'package:flutter_project/features/home/presentation/screens/home_view.dart';
import 'package:flutter_project/features/maintenance/presentation/screens/maintenance%D9%80view.dart';
import 'package:flutter_project/features/maintenance/presentation/screens/vacation_cost_view.dart';
import 'package:flutter_project/features/reports/presentation/screens/crash_report_view.dart';
import 'package:flutter_project/features/reports/presentation/screens/malfunction_crash_report_view.dart';
import 'package:flutter_project/features/reports/presentation/screens/report_details_view.dart';
import 'package:flutter_project/features/reports/presentation/screens/sent_report_view.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const SplashScreenView()),
    GoRoute(path: '/login', builder: (context, state) => const LoginView()),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterView(),
    ),
    GoRoute(path: '/home', builder: (context, state) => HomeView()),
    GoRoute(
      path: '/maintenance',
      builder: (context, state) => const MaintenanceView(),
    ),
    GoRoute(
      path: '/vacation-cost',
      builder: (context, state) => const VacationCostView(),
    ),
    GoRoute(
      path: '/crash-report',
      builder: (context, state) => const CrashReportView(),
    ),
    GoRoute(
      path: '/malfunction-crash-report',
      builder: (context, state) => const MalfunctionCrashreportPage(),
    ),
    GoRoute(
      path: '/report-details',
      builder: (context, state) => const ReportDetailsView(),
    ),
    GoRoute(
      path: '/sent-report',
      builder: (context, state) => const SentReportView(),
    ),
  ],
);
