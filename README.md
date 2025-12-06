# assignmettask

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

================================================
# Video URL



================================================

## 1. Firebase Phone Authentication Setup
Creating the Firebase Project

Go to https://console.firebase.google.com
 and create a new project.

Add an Android app. Make sure to add SHA-1 and SHA-256 keys (required for auto OTP verification on Android).

Add a Web app for OTP login in the browser.

Enable “Phone Authentication” inside the Authentication tab.

Generating firebase_options.dart

Run the command:

flutterfire configure


This generates the firebase_options.dart file automatically and links your Firebase apps.

Web Setup

For web builds, Firebase requires reCAPTCHA. Ensure that Phone Authentication is enabled under “Sign-in providers”.

Initialization

Add Firebase initialization in your main.dart:

await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);

## 2. Dependencies Used
get: ^4.7.3
bloc: ^9.1.0
provider: ^6.1.5+1
firebase_core: ^4.2.1
firebase_auth: ^6.1.2
dio: ^5.9.0
shimmer: ^2.0.0


GetX is used for routing, state and DI.
Dio is used for API calls.
Firebase Auth handles OTP login.
Shimmer is used for loading placeholders.
Optional packages like Bloc and Provider can be used for more structured state layers if needed.

## 3. Project Structure

lib/
 ├── controllers/
 |
 │    ├── auth_controller.dart
 │    └── object_controller.dart
 │
 ├── data/
 │    ├── models/ (API response models)
 │    ├── network/ (Dio setup and API constants)
 │
 ├── exceptions/ (error handling classes)
 │
 ├── routes/ (GetX pages, route names, and auth guard)
 │
 ├── screens/
 │    ├── auth/ (login and OTP screens)
 │    ├── home/ (list, details and form screens)
 │    └── splash_screen.dart
 │
 ├── utils/
 │    ├── error_handler.dart
 │    ├── loading.dart
 │
 └── firebase_options.dart


The structure is designed to be clean, scalable and easy to maintain.
All controllers contain pure business logic.
All API interactions go through a separate service class.
All errors funnel through a central exception handler.

## 4. REST API (CRUD – Using Dio)

Base URL:

https://api.restful-api.dev


Endpoints used:

GET /objects → fetch list

GET /objects/{id} → fetch one

POST /objects → create new item

PUT /objects/{id} → update full object

DELETE /objects/{id} → remove object

Each API call is wrapped with:

try/catch blocks

network exception mapping

readable error messages displayed with Get.snackbar

All API calls return strongly typed model classes.

## 5. Authentication Flow (Phone OTP)

User enters phone number.

Firebase sends an OTP.

User enters the OTP on the next screen.

Firebase verifies and returns a user.

AuthGuard checks FirebaseAuth.instance.currentUser.

Only authenticated users can access home and CRUD screens.

This method works on both mobile and web.

# 6. UI / UX Notes

Modern card-based list UI using soft pastel colors.

Details screen displays the formatted fields of the selected object.

Form screen allows dynamic key–value fields instead of writing JSON manually.

Inline loaders are used on buttons for create, update and delete.

Shimmer used for loading states in lists.

Navigation is smooth and responsive on mobile and web.

Entire UI is responsive via LayoutBuilder and flexible widgets.

## 7. Error Handling

There are three main exception groups:

NetworkExceptions – API/HTTP level (timeouts, no internet, bad responses)

FirebaseExceptions – authentication errors (invalid OTP, rate limit, etc.)

AppException – general runtime issues

All errors are passed through a unified ErrorHandler, which displays a message via Get.snackbar.

This keeps error messages consistent across the whole application.

# 8. Design Choices

GetX is used because it simplifies routing, reactivity and dependency injection.

Dio is selected due to its reliability and built-in interceptors.

Controllers contain business logic, keeping UI clean and declarative.

API service is reusable and keeps networking concerns separated.

Models have toJson/fromJson for safe and typed transformations.

Loading states are separated (createLoading, updateLoading, deleteLoading) for button-level control.

This structure keeps the codebase scalable and easy to expand.

# 9. Limitations

No caching layer (Hive or shared_preferences can be added).

No offline support.

No repository pattern (would improve testability).

Token is not stored securely because this API does not require authentication.

UI components like buttons and text fields are not yet abstracted into reusable widgets.

Currently using GetX only; Bloc or Provider can be used for additional complexity.

# 10. Future Improvements

Add reusable UI components (AppButton, AppTextField, AppCard).

Add secure token storage using flutter_secure_storage.

Add repository layer between controllers and API service.

Add pagination when fetching the object list.

Add better input validation for form fields.

Implement Lottie-based loading animation.

Introduce theme management for dark mode.

Create custom Dio interceptors (logging, retry, and error formatting).

Improve responsiveness with breakpoints for large screens.

Add unit tests for controllers and services.

# 11. Running the Project

# Mobile (Android/iOS)
flutter pub get

flutter run

# Web
flutter run -d chrome

# Build for Firebase Hosting
flutter build web

firebase deploy