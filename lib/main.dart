import 'package:chatbot_agents/config/api_config.dart';
import 'package:chatbot_agents/constants/app_colors.dart';
import 'package:chatbot_agents/provider/auth_provider.dart';
import 'package:chatbot_agents/service/api/jarvis_api_service.dart';
import 'package:chatbot_agents/views/email_reply/email_reply_view.dart';
import 'package:chatbot_agents/views/forgot_password/enter_email_view.dart';
import 'package:chatbot_agents/views/login/login_view.dart';
import 'package:chatbot_agents/views/main/main_view.dart';
import 'package:chatbot_agents/views/protected_route.dart';
import 'package:chatbot_agents/views/register/register_view.dart';
import 'package:chatbot_agents/views/subscription/subscription.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

final getIt = GetIt.asNewInstance();

// For dependency injection
void setup() {
  getIt.registerSingleton<JarvisApiService>(JarvisApiService.init(ApiConfig.jarvisUrl));
}

void main() async {
  await dotenv.load();
  setup();
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme:
              ColorScheme.fromSeed(seedColor: AppColors.primaryBackground),
          useMaterial3: true,
        ),
        initialRoute: "/login",
        routes: {
          '/login': (context) => const LoginView(),
          '/register': (context) => const RegisterView(),
          '/forgot_password': (context) => const EnterEmailView(),
          '/main': (context) => const ProtectedRoute(child: MainView()),
          '/subscription': (context) => const ProtectedRoute(child: SubscriptionView()),
          '/email-reply': (context) => ProtectedRoute(child: EmailReplyView()),
        },
      )));
}
