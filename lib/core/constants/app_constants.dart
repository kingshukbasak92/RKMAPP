class AppConstants {
  // App Information
  static const String appName = 'RKMDaily';
  static const String appVersion = '1.0.0';
  
  // API Configuration
  static const String baseUrl = 'https://api.rkmdaily.com/v1';
  static const Duration apiTimeout = Duration(seconds: 30);
  
  // Local Storage Keys
  static const String themeModeKey = 'theme_mode';
  static const String localeKey = 'locale';
  static const String authTokenKey = 'auth_token';
  static const String userDataKey = 'user_data';
  
  // Animation Durations
  static const Duration animationDuration = Duration(milliseconds: 300);
  static const Duration buttonAnimationDuration = Duration(milliseconds: 200);
  
  // Pagination
  static const int defaultPageSize = 10;
  
  // Validation
  static const int minPasswordLength = 8;
  static const int maxPasswordLength = 32;
  
  // Date & Time Formats
  static const String dateFormat = 'MMM dd, yyyy';
  static const String timeFormat = 'h:mm a';
  static const String dateTimeFormat = 'MMM dd, yyyy h:mm a';
  
  // App Settings
  static const bool isDebug = bool.fromEnvironment('dart.vm.product') == false;
}
