import 'package:chatbot_agents/models/get_conversation_history/message_renderer_model.dart';
import 'package:chatbot_agents/models/get_conversation_history/message_response_model.dart';

class MessageMapper {
  static List<MessageRendererModel> toMessageRendererModels(List<MessageResponseModel> messages) {
    List<MessageRendererModel> result = [];
    
    for (var message in messages) {
      
      if (message.query != null) {
        result.add( MessageRendererModel(
          content: message.query!,
          isUserMessage: true,
        ));
      }
      
      if (message.answer != null) {
        result.add( MessageRendererModel(
          content: message.answer!,
          isUserMessage: false,
        ));
      }
      
      //result.addAll(_toMessageRendererModel(message));
    }
    
    return result;
  }
}