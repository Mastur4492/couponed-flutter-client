# Coupon App

A cross-platform Flutter application for exploring and managing coupons.  
Users can view available coupons, filter them by category, and add new ones.  
This repository contains the mobile, web, desktop, and backend code required to run the project.

---

## 🔍 Project Overview

- **Platform:** Flutter (Android, iOS, Web, macOS, Windows, Linux)
- **State management:** Provider
- **Networking:** `api_service.dart` handles REST requests
- **Architecture:** MVC-like with `models`, `providers`, and `services`

The app demonstrates basic CRUD operations against an external API and serves as a learning project for Flutter developers.

---

## 🚀 Getting Started

### Prerequisites

1. [Flutter SDK](https://docs.flutter.dev/get-started/install) (version flutter 3.0 or later)
2. A supported IDE (VS Code, Android Studio, etc.)
3. Device or emulator for your target platform

### Setup

```bash
# clone the repository
git clone https://github.com/youruser/coupon_app.git
cd coupon_app

# fetch dependencies
flutter pub get
```

### Run the app

```bash
# for mobile
flutter run

# for web
flutter run -d chrome

# for desktop
flutter run -d windows  # or macos/linux
```

---

## 🗂️ Project Structure

```text
lib/
├── main.dart          # application entry point
├── models/
│   └── coupon.dart    # coupon data class
├── providers/
│   └── coupon_provider.dart  # state management logic
└── services/
    └── api_service.dart      # REST API client
```

Other notable folders:

- `android/`, `ios/`, `web/`, `linux/`, `macos/`, `windows/` – platform-specific code
- `test/` – unit and widget tests

---

## 📦 Dependencies

See `pubspec.yaml` for the complete list. Key packages include:

- `provider` – state management
- `http` – networking

---

## 🧪 Testing

Run the unit and widget tests with:

```bash
flutter test
```

Add new tests under the `test/` directory as you expand functionality.

---

## ✅ Contribution

Contributions are welcome! Please open an issue or submit a pull request with:

- a clear description of the problem or feature
- scoped, tested changes

---

## 📄 License

This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.

---
