# DealWise - Flutter E-commerce App Task List

---

## 📋 Implementation Tasks (Sequential Order)

---

### **Phase 0: Initial Setup**
- [x] ~~Create GitHub repository and add collaborators~~
- [ ] Initialize Flutter Project
  - [ ] Create a new Flutter project named `dealwise`
  - [ ] Push the initial project to GitHub
- [ ] Add Dependencies
  - [ ] Add the following dependencies to `pubspec.yaml`:
    - `flutter_bloc: ^8.1.3`
    - `shared_preferences: ^2.2.2`
    - `dio: ^5.3.2`
    - `flutter_svg: ^2.0.7`
    - `intl: ^0.18.1`
    - `fluttertoast: ^8.2.2`
    - `image_picker: ^1.0.4`
    - `cached_network_image: ^3.3.0`
  - [ ] Run `flutter pub get`
- [ ] Set Up App Icon and Name
  - [ ] Replace the default app icon in `android/app/src/main/res`
  - [ ] Replace the default app icon in `ios/Runner/Assets.xcassets`
  - [ ] Update the app name in `android/app/src/main/AndroidManifest.xml`
  - [ ] Update the app name in `ios/Runner/Info.plist`
- [ ] Set Up Base URL and Constants
  - [ ] Create a `constants.dart` file in the `lib/core/constants` folder
  - [ ] Add the base URL and app name
- [ ] Set Up Project Structure
  - [ ] Create the following folders in `lib`:
    ```
    lib/
    ├── core/
    │   ├── constants/
    │   ├── utils/
    │   └── widgets/
    ├── data/
    │   ├── models/
    │   ├── repositories/
    │   └── services/
    ├── presentation/
    │   ├── screens/
    │   ├── viewmodels/
    │   └── widgets/
    └── main.dart
    ```

---

### **Phase 1: Authentication & Onboarding Screens**
- [ ] Implement Splash Screen
- [ ] Implement Onboarding Screen
- [ ] Implement Login Screen
- [ ] Implement Register Screen
- [ ] Implement OTP Verification Screen
- [ ] Implement Forgot Password Screen
- [ ] Implement Reset Password Screen

---

### **Phase 2: Core E-commerce Screens**
- [ ] Implement Home Screen
- [ ] Implement Products Filtered by Category Screen
- [ ] Implement Product Details Screen
- [ ] Implement Cart Screen
- [ ] Implement Product Management Screen

---

### **Phase 3: User Profile & Settings Screens**
- [ ] Implement Profile/Settings Screen
- [ ] Implement Change Password Screen
- [ ] Implement Privacy & Policy Screen
- [ ] Implement About Us Screen
- [ ] Implement Contact Us Screen

---

### **Phase 4: State Management, API Integration, and Finalization**
- [ ] Set Up Cubit for State Management
  - [ ] Create `AuthCubit` for authentication state
  - [ ] Create `ProductCubit` for product state
  - [ ] Create `CartCubit` for cart state
- [ ] Integrate Authentication API
- [ ] Integrate Product API
- [ ] Integrate Cart API
- [ ] Set Up App Navigation
- [ ] Implement Loading States
- [ ] Test All Screens
- [ ] Optimize UI/UX
- [ ] Final Code Review
