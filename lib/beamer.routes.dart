import 'package:beamer/beamer.dart'
    show
        BeamGuard,
        BeamPage,
        BeamPageType,
        BeamerDelegate,
        RoutesLocationBuilder;
import 'package:flutter/widgets.dart' show ValueKey;
import 'package:supabase_isar_riverpod_playground/src/config/constants.dart';
import 'package:supabase_isar_riverpod_playground/src/modules/authentication/view/authentication.dart';
import 'package:supabase_isar_riverpod_playground/src/modules/home/view/home.view.dart';
import 'package:supabase_isar_riverpod_playground/src/modules/maintenance.break/maintenance.break.dart';
import 'package:supabase_isar_riverpod_playground/src/modules/settings/view/setting.view.dart';
import 'package:supabase_isar_riverpod_playground/src/shared/page_not_found/page_not_found.dart';
import 'package:supabase_isar_riverpod_playground/src/supabase/init.dart';

import 'app.routes.dart';

final routerDelegate = BeamerDelegate(
  initialPath: AppRoutes.homeRoute,
  notFoundPage: const BeamPage(
    title: 'Page not found - $appName',
    child: KPageNotFound(error: '404 - Page not found!'),
  ),
  locationBuilder: RoutesLocationBuilder(
    routes: {
      AppRoutes.homeRoute: (_, __, ___) {
        return const BeamPage(
          key: ValueKey(AppRoutes.homeRoute),
          title: appName,
          type: BeamPageType.fadeTransition,
          child: HomeView(),
        );
      },
      AppRoutes.authenticationRoute: (_, __, ___) {
        return const BeamPage(
          key: ValueKey(AppRoutes.authenticationRoute),
          title: '$appName - Authentication',
          type: BeamPageType.fadeTransition,
          child: AuthenticationView(),
        );
      },
      AppRoutes.settingsRoute: (_, __, ___) {
        return const BeamPage(
          key: ValueKey(AppRoutes.settingsRoute),
          title: '$appName - Settings',
          type: BeamPageType.fadeTransition,
          child: SettingsView(),
        );
      },
      AppRoutes.maintenanceBreakRoute: (_, __, ___) {
        return const BeamPage(
          key: ValueKey(AppRoutes.maintenanceBreakRoute),
          title: '$appName - Maintenance break',
          type: BeamPageType.fadeTransition,
          child: MaintenanceBreak(),
        );
      },
      AppRoutes.serverDisconnectedRoute: (_, __, ___) {
        return const BeamPage(
          key: ValueKey(AppRoutes.serverDisconnectedRoute),
          title: '$appName - Server disconnected',
          type: BeamPageType.fadeTransition,
          child: KServerNotRunning(),
        );
      },
    },
  ),
  guards: [
    BeamGuard(
      pathPatterns: AppRoutes.allRoutes,
      check: (_, __) => !AppRoutes.isMaintenanceBreak,
      beamToNamed: (_, __) => AppRoutes.maintenanceBreakRoute,
    ),
    BeamGuard(
      pathPatterns: [AppRoutes.maintenanceBreakRoute],
      check: (_, __) => AppRoutes.isMaintenanceBreak,
      beamToNamed: (_, __) => AppRoutes.homeRoute,
    ),
    // BeamGuard(
    //   pathPatterns: AppRoutes.allRoutes,
    //   check: (_, __) => isServerRunning,
    //   beamToNamed: (_, __) => AppRoutes.serverDisconnectedRoute,
    // ),
    // BeamGuard(
    //   pathPatterns: [AppRoutes.serverDisconnectedRoute],
    //   check: (_, __) => !isServerRunning,
    //   beamToNamed: (_, __) => AppRoutes.homeRoute,
    // ),
    BeamGuard(
      pathPatterns: AppRoutes.allAuthRequiredRoutes,
      check: (_, __) => sbc.auth.currentUser != null,
      beamToNamed: (_, __) => AppRoutes.authenticationRoute,
    ),
    BeamGuard(
      pathPatterns: [AppRoutes.authenticationRoute],
      check: (_, __) => sbc.auth.currentUser == null,
      beamToNamed: (_, __) => AppRoutes.homeRoute,
    ),
  ],
);
