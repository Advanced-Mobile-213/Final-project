import 'package:chatbot_agents/config/api_config.dart';
import 'package:chatbot_agents/config/app_config.dart';
import 'package:chatbot_agents/di/get_it_instance.dart';
import 'package:chatbot_agents/service/ai_bot_service.dart';
import 'package:chatbot_agents/service/auth_service.dart';
import 'package:chatbot_agents/service/bot_integration_service.dart';
import 'package:chatbot_agents/service/conversation_service.dart';
import 'package:chatbot_agents/service/email_service.dart';
import 'package:chatbot_agents/service/knowledge_data_source_service.dart';
import 'package:chatbot_agents/service/knowledge_service.dart';
import 'package:chatbot_agents/service/prompt_service.dart';
import 'package:chatbot_agents/service/token_service.dart';
import 'package:chatbot_agents/service/user_service.dart';
import 'package:chatbot_agents/utils/network/jarvis_api_client.dart';
import 'package:chatbot_agents/utils/network/knowledge_base_api_client.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ServiceDi {
  static void setup() {
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
}