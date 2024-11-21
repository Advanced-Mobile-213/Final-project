import 'package:chatbot_agents/config/api_config.dart';
import 'package:chatbot_agents/constants/app_colors.dart';
import 'package:chatbot_agents/di/get_it_instance.dart';
import 'package:chatbot_agents/provider/auth_provider.dart';
import 'package:chatbot_agents/service/auth_service.dart';
import 'package:chatbot_agents/service/token_service/token_service.dart';
import 'package:chatbot_agents/service/user_service.dart';
import 'package:chatbot_agents/utils/network/jarvis_api_client.dart';
import 'package:chatbot_agents/service/conversation_service/conversation_service.dart';
import 'package:chatbot_agents/view_models/conversation_view_model.dart';
import 'package:chatbot_agents/view_models/list_conversations_view_model.dart';
import 'package:chatbot_agents/views/email_reply/email_reply_view.dart';
import 'package:chatbot_agents/views/forgot_password/enter_email_view.dart';
import 'package:chatbot_agents/views/login/login_view.dart';
import 'package:chatbot_agents/views/main/main_view.dart';
import 'package:chatbot_agents/views/protected_route.dart';
import 'package:chatbot_agents/views/register/register_view.dart';
import 'package:chatbot_agents/views/subscription/subscription.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';


// For dependency injection
void setup() {
  GetItInstance.getIt.registerSingleton<JarvisApiClient>(JarvisApiClient.init(ApiConfig.jarvisUrl));
  //GetItInstance.getIt.registerSingleton<SharedPreferencesUtil>(SharedPreferencesUtil());
  GetItInstance.getIt.registerSingleton<ConversationService>(ConversationService());
  GetItInstance.getIt.registerSingleton<TokenService>(TokenService());
  GetItInstance.getIt.registerSingleton<AuthService>(AuthService());
  GetItInstance.getIt.registerSingleton<UserService>(UserService());
}

void main() async {
  await dotenv.load();
  setup();
  WidgetsFlutterBinding.ensureInitialized();

  // final accessToken = await SharedPreferencesUtil.getAccessToken();
  // final refreshToken = await SharedPreferencesUtil.getRefreshToken();

  // if (accessToken != null && refreshToken != null) {
  //   GetItInstance.getIt<JarvisApiService>().setToken(accessToken, refreshToken);
  // }

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ListConversationsViewModel()),
        ChangeNotifierProvider(create: (_) => ConversationViewModel()),
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
