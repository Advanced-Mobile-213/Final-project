import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService {
  static final FirebaseAnalytics _firebaseAnalytics = FirebaseAnalytics.instance;
  
  FirebaseAnalyticsObserver getAnalyticsObserver() {
    return FirebaseAnalyticsObserver(analytics: _firebaseAnalytics);
  }

  Future<void> logEvent(String eventName, Map<String, Object>? parameters)
    async {
    await _firebaseAnalytics.logEvent(
      name: eventName, 
      parameters: parameters );
  }
}