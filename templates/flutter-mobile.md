# 📱 {{_project_name_}} - Flutter Mobile App

Cross-platform mobile application built with Flutter and Dart, optimized for Android and iOS.

## 🛠 Tech Stack

- **Flutter** - Google's UI toolkit for cross-platform apps
- **Dart** - Programming language optimized for client development
- **Provider/Riverpod** - State management
- **HTTP/Dio** - Network requests
- **Hive/SQLite** - Local storage
- **Firebase** - Backend services (optional)

## 🚀 Quick Start

```bash
# Install dependencies
flutter pub get

# Run on Android
flutter run

# Run on iOS (macOS only)
flutter run

# Build APK
flutter build apk

# Build iOS (macOS only)
flutter build ios

# Run tests
flutter test

# Analyze code
flutter analyze
```

## 📱 Features

- **Cross-Platform** - Single codebase for Android and iOS
- **Material Design** - Beautiful, native-feeling UI
- **Responsive Layout** - Adapts to different screen sizes
- **Offline Support** - Local storage and caching
- **Push Notifications** - Firebase Cloud Messaging
- **Dark Mode** - System-aware theme switching
- **Internationalization** - Multi-language support

## 🏗 Project Structure

```
{{_project_name_}}/
├── android/
├── ios/
├── lib/
│   ├── core/
│   │   ├── constants/
│   │   ├── themes/
│   │   ├── utils/
│   │   └── services/
│   ├── features/
│   │   ├── auth/
│   │   │   ├── data/
│   │   │   ├── domain/
│   │   │   └── presentation/
│   │   ├── home/
│   │   └── profile/
│   ├── shared/
│   │   ├── widgets/
│   │   ├── models/
│   │   └── providers/
│   ├── l10n/
│   └── main.dart
├── test/
├── assets/
│   ├── images/
│   ├── icons/
│   └── fonts/
├── pubspec.yaml
└── analysis_options.yaml
```

## 🎨 UI Components

### Custom Button Widget
```dart
class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 48),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: isLoading
          ? const CircularProgressIndicator()
          : Text(text),
    );
  }
}
```

### Responsive Layout
```dart
class ResponsiveWidget extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;

  const ResponsiveWidget({
    Key? key,
    required this.mobile,
    this.tablet,
    this.desktop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 1200) {
          return desktop ?? tablet ?? mobile;
        } else if (constraints.maxWidth >= 600) {
          return tablet ?? mobile;
        } else {
          return mobile;
        }
      },
    );
  }
}
```

## 🔐 State Management

Using Provider pattern for state management:

```dart
// User Provider
class UserProvider extends ChangeNotifier {
  User? _user;
  bool _isLoading = false;

  User? get user => _user;
  bool get isLoading => _isLoading;

  Future<void> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      _user = await AuthService.login(email, password);
    } catch (e) {
      throw Exception('Login failed: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void logout() {
    _user = null;
    notifyListeners();
  }
}

// Usage in Widget
class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        return Scaffold(
          body: userProvider.isLoading
              ? const Center(child: CircularProgressIndicator())
              : LoginForm(),
        );
      },
    );
  }
}
```

## 🌐 Networking

HTTP requests with error handling:

```dart
class ApiService {
  static const String baseUrl = 'https://api.example.com';
  static final Dio _dio = Dio();

  static Future<List<Post>> getPosts() async {
    try {
      final response = await _dio.get('$baseUrl/posts');
      return (response.data as List)
          .map((json) => Post.fromJson(json))
          .toList();
    } on DioError catch (e) {
      throw _handleError(e);
    }
  }

  static Exception _handleError(DioError error) {
    switch (error.type) {
      case DioErrorType.connectTimeout:
        return Exception('Connection timeout');
      case DioErrorType.receiveTimeout:
        return Exception('Receive timeout');
      case DioErrorType.response:
        return Exception('Server error: ${error.response?.statusCode}');
      default:
        return Exception('Network error');
    }
  }
}
```

## 💾 Local Storage

Using Hive for local storage:

```dart
// Model
@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String email;

  User({required this.id, required this.name, required this.email});
}

// Storage Service
class StorageService {
  static const String userBoxName = 'users';

  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(UserAdapter());
    await Hive.openBox<User>(userBoxName);
  }

  static Future<void> saveUser(User user) async {
    final box = Hive.box<User>(userBoxName);
    await box.put('current_user', user);
  }

  static User? getCurrentUser() {
    final box = Hive.box<User>(userBoxName);
    return box.get('current_user');
  }
}
```

## 🔔 Push Notifications

Firebase Cloud Messaging setup:

```dart
class NotificationService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  static Future<void> initialize() async {
    // Request permission
    await _messaging.requestPermission();

    // Get token
    String? token = await _messaging.getToken();
    print('FCM Token: $token');

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _showNotification(message);
    });

    // Handle background messages
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  static void _showNotification(RemoteMessage message) {
    // Show local notification
  }
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling background message: ${message.messageId}');
}
```

## 🧪 Testing

Unit and widget tests:

```dart
// Unit test
void main() {
  group('User Model', () {
    test('should create user from JSON', () {
      final json = {
        'id': '1',
        'name': 'John Doe',
        'email': 'john@example.com',
      };

      final user = User.fromJson(json);

      expect(user.id, '1');
      expect(user.name, 'John Doe');
      expect(user.email, 'john@example.com');
    });
  });
}

// Widget test
void main() {
  testWidgets('CustomButton shows loading indicator', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomButton(
            text: 'Login',
            onPressed: () {},
            isLoading: true,
          ),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text('Login'), findsNothing);
  });
}
```

## 🚀 Building & Deployment

### Android
```bash
# Debug APK
flutter build apk --debug

# Release APK
flutter build apk --release

# App Bundle for Play Store
flutter build appbundle --release
```

### iOS
```bash
# Debug build
flutter build ios --debug

# Release build
flutter build ios --release

# Archive for App Store
flutter build ipa
```

### Code Signing
```bash
# Android - Generate keystore
keytool -genkey -v -keystore ~/keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias key

# Add to android/key.properties
storePassword=your_password
keyPassword=your_password
keyAlias=key
storeFile=keystore.jks
```

## 🌍 Internationalization

Add multiple language support:

```yaml
# pubspec.yaml
dependencies:
  flutter_localizations:
    sdk: flutter

flutter:
  generate: true
```

```dart
// l10n/app_en.arb
{
  "hello": "Hello",
  "welcome": "Welcome to {appName}",
  "@welcome": {
    "placeholders": {
      "appName": {
        "type": "String"
      }
    }
  }
}

// Usage
Text(AppLocalizations.of(context)!.hello)
```

## 🎨 Theming

Custom theme with dark mode:

```dart
class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primarySwatch: Colors.blue,
      brightness: Brightness.light,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      primarySwatch: Colors.blue,
      brightness: Brightness.dark,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
    );
  }
}
```

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Make your changes
4. Run tests (`flutter test`)
5. Commit your changes (`git commit -m 'Add some amazing feature'`)
6. Push to the branch (`git push origin feature/amazing-feature`)
7. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Dart team for the excellent language
- Firebase for backend services
- Material Design for UI guidelines

---

**Happy coding! 📱✨**