import 'dart:async';

import 'package:chatbot_agents/config/api_config.dart';
import 'package:chatbot_agents/config/app_config.dart';
import 'package:chatbot_agents/constants/app_colors.dart';
import 'package:chatbot_agents/di/get_it_instance.dart';
import 'package:chatbot_agents/firebase_options.dart';
import 'package:chatbot_agents/provider/auth_provider.dart';
import 'package:chatbot_agents/service/ai_bot_service.dart';
import 'package:chatbot_agents/service/analytics_service.dart';
import 'package:chatbot_agents/service/email_service.dart';
import 'package:chatbot_agents/service/knowledge_data_source_service.dart';
import 'package:chatbot_agents/service/knowledge_service.dart';
import 'package:chatbot_agents/service/token_service.dart';
import 'package:chatbot_agents/service/auth_service.dart';
import 'package:chatbot_agents/service/user_service.dart';
import 'package:chatbot_agents/utils/network/jarvis_api_client.dart';
import 'package:chatbot_agents/service/conversation_service.dart';
import 'package:chatbot_agents/utils/network/knowledge_base_api_client.dart';
import 'package:chatbot_agents/view_models/conversation_view_model.dart';
import 'package:chatbot_agents/view_models/email_reply_view_model.dart';
import 'package:chatbot_agents/view_models/knowledge_unit_view_model.dart';
import 'package:chatbot_agents/view_models/knowledge_view_model.dart';
import 'package:chatbot_agents/view_models/list_conversations_view_model.dart';
import 'package:chatbot_agents/view_models/main_view_model.dart';
import 'package:chatbot_agents/view_models/profile_view_model.dart';
import 'package:chatbot_agents/views/email_reply/email_reply_view.dart';
import 'package:chatbot_agents/views/forgot_password/enter_email_view.dart';
import 'package:chatbot_agents/views/login/login_view.dart';
import 'package:chatbot_agents/views/main/main_view.dart';
import 'package:chatbot_agents/views/protected_route.dart';
import 'package:chatbot_agents/views/register/register_view.dart';
import 'package:chatbot_agents/views/subscription/subscription.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'view_models/prompt_view_model.dart';
import 'package:chatbot_agents/service/prompt_service.dart';
import 'package:chatbot_agents/view_models/ai_bot_view_model.dart';
import 'package:chatbot_agents/service/bot_integration_service.dart';
import 'package:chatbot_agents/view_models/bot_configuration_view_model.dart';

// For dependency injection
void setup() {
  GetItInstance.getIt.registerSingleton<JarvisApiClient>(
      JarvisApiClient.init(ApiConfig.jarvisUrl));
  GetItInstance.getIt.registerSingleton<KnowledgeBaseApiClient>(
      KnowledgeBaseApiClient.init(ApiConfig.knowledgeUrl));
  GetItInstance.getIt.registerSingleton<GoogleSignIn>(GoogleSignIn(
    clientId: AppConfig.GoogleOauthClientId,
    scopes: <String>[
      'email',
    ],
  ));
  //GetItInstance.getIt.registerSingleton<SharedPreferencesUtil>(SharedPreferencesUtil());
  GetItInstance.getIt
      .registerSingleton<ConversationService>(ConversationService());
  GetItInstance.getIt.registerSingleton<TokenService>(TokenService());
  GetItInstance.getIt.registerSingleton<AuthService>(AuthService());
  GetItInstance.getIt.registerSingleton<UserService>(UserService());
  GetItInstance.getIt.registerSingleton<PromptService>(PromptService());
  GetItInstance.getIt.registerSingleton<AiBotService>(AiBotService());
  GetItInstance.getIt.registerSingleton<KnowledgeService>(KnowledgeService());
  GetItInstance.getIt
      .registerSingleton<BotIntegrationService>(BotIntegrationService());
  GetItInstance.getIt.registerSingleton<KnowledgeDataSourceService>(KnowledgeDataSourceService());
  GetItInstance.getIt.registerSingleton<EmailService>(EmailService());
}

void main() async {
  await dotenv.load();
  setup();
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    GetItInstance.getIt.registerSingleton<AnalyticsService>(AnalyticsService());

    unawaited(MobileAds.instance.initialize());
  } catch (e) {
    print('-->Error occurs when initialized plugin: $e');
  }
  // final accessToken = await SharedPreferencesUtil.getAccessToken();
  // final refreshToken = await SharedPreferencesUtil.getRefreshToken();

  // if (accessToken != null && refreshToken != null) {
  //   GetItInstance.getIt<JarvisApiService>().setToken(accessToken, refreshToken);
  // }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ListConversationsViewModel()),
        ChangeNotifierProvider(create: (_) => ConversationViewModel()),
        ChangeNotifierProvider(create: (_) => PromptViewModel()),
        ChangeNotifierProvider(create: (_) => AiBotViewModel()),
        ChangeNotifierProvider(create: (_) => KnowledgeViewModel()),
        ChangeNotifierProvider(create: (_) => BotConfigurationViewModel()),
        ChangeNotifierProvider(create: (_) => KnowledgeUnitViewModel()),
        ChangeNotifierProvider(create: (_) => EmailReplyViewModel()),
        ChangeNotifierProvider(create: (_) => ProfileViewModel()),
        ChangeNotifierProvider(create: (_) => MainViewModel()),
      ],
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
        routes: {
          '/login': (context) => const LoginView(),
          '/register': (context) => const RegisterView(),
          '/forgot_password': (context) => const EnterEmailView(),
          '/main': (context) => const ProtectedRoute(child: MainView()),
          '/subscription': (context) =>
              const ProtectedRoute(child: SubscriptionView()),
          '/email-reply': (context) => const ProtectedRoute(child: EmailReplyView()),
        },
      ),
    );
  }
}
