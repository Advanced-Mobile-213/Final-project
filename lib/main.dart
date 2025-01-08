import 'dart:async';

import 'package:chatbot_agents/constants/app_colors.dart';
import 'package:chatbot_agents/di/get_it_instance.dart';
import 'package:chatbot_agents/di/service_di.dart';
import 'package:chatbot_agents/firebase_options.dart';
import 'package:chatbot_agents/navigation/app_route.dart';
import 'package:chatbot_agents/provider/app_provider.dart';
import 'package:chatbot_agents/service/analytics_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

Future<void> main() async {
  await dotenv.load();
  await SentryFlutter.init(
    (options) {
      options.dsn = dotenv.env['SENTRY_DSN']; 
      // Set tracesSampleRate to 1.0 to capture 100% of transactions for tracing.
      // We recommend adjusting this value in production.
      options.tracesSampleRate = 1.0;
      // The sampling rate for profiling is relative to tracesSampleRate
      // Setting to 1.0 will profile 100% of sampled transactions:
      options.profilesSampleRate = 1.0;
    },
    appRunner: () async {
      
      ServiceDi.setup();
      //setup();
      WidgetsFlutterBinding.ensureInitialized();

      try {
        await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
        GetItInstance.getIt.registerSingleton<AnalyticsService>(AnalyticsService());

        // if (!kIsWeb && (defaultTargetPlatform == TargetPlatform.android 
        //   || defaultTargetPlatform == TargetPlatform.iOS)) {
        //   unawaited(MobileAds.instance.initialize());
        // }

        unawaited(MobileAds.instance.initialize());
        
      } catch (e) {
        print('-->Error occurs when initialized plugin: $e');
      }
  
      runApp(const MyApp());
    },
  );
}
  
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppProviders(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme:
              ColorScheme.fromSeed(seedColor: AppColors.primaryBackground),
          useMaterial3: true,
        ),
        navigatorObservers: <NavigatorObserver>[
          GetItInstance.getIt<AnalyticsService>().getAnalyticsObserver(),
        ],
        initialRoute: "/login",
        routes: appRoutes, 
      ),
    );
  }
}

