# Flutter Note Mobile App

A cross-platform note-taking application built with Flutter. Easily create, edit, and manage your notes on Android, iOS, Windows, macOS, Linux, and Web.

## Features

- Create, edit, and delete notes
- Cross-platform support (Android, iOS, Web, Windows, macOS, Linux)
- Firebase integration for cloud sync
- Localizations (multi-language support)
- Beautiful and responsive UI

## Getting Started

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- [Dart SDK](https://dart.dev/get-dart)
- Firebase account (for cloud sync)

### Installation

1. Clone the repository:
   ```sh
   git clone https://github.com/yourusername/flutter-note-mobile-app.git
   cd flutter-note-mobile-app
   ```
2. Install dependencies:
   ```sh
   flutter pub get
   ```
3. Configure Firebase:
   - Add your Firebase configuration files (`google-services.json` for Android, `GoogleService-Info.plist` for iOS) to the respective platform folders.
   - Update `firebase.json` as needed.
4. Run the app:
   ```sh
   flutter run
   ```

## Project Structure

- `lib/` - Main application code
- `test/` - Unit and widget tests
- `web/` - Web platform files
- `ios/`, `android/`, `windows/`, `macos/`, `linux/` - Platform-specific code

## Localization

This app supports multiple languages. See `l10n.yaml` for configuration.

## Contributing

Contributions are welcome! Please open issues or submit pull requests for improvements.

## License

This project is licensed under the MIT License.

---

For more information, see the official Flutter documentation: [flutter.dev](https://flutter.dev/)
