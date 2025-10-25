# DealWise - Flutter E-commerce App Task List

---
## 📋 Implementation Tasks (Sequential Order)

### **Sample Done Task**
- [x] ~~Create GitHub repository and add collaborators~~

---

### **Phase 1: Project Setup & Initialization**
- [ ] **Initialize Flutter Project**
  - [ ] Create a new Flutter project named `dealwise`
  - [ ] Push the initial project to GitHub

- [ ] **Add Dependencies**
  - [ ] Add the following dependencies to `pubspec.yaml`:
    ```yaml
    dependencies:
      flutter_bloc: ^8.1.3
      shared_preferences: ^2.2.2
      http: ^1.1.0
      flutter_svg: ^2.0.7
      intl: ^0.18.1
      fluttertoast: ^8.2.2
      image_picker: ^1.0.4
      cached_network_image: ^3.3.0
    ```
  - [ ] Run `flutter pub get`

- [ ] **Set Up App Icon and Name**
  - [ ] Replace the default app icon in `android/app/src/main/res`
  - [ ] Replace the default app icon in `ios/Runner/Assets.xcassets`
  - [ ] Update the app name in `android/app/src/main/AndroidManifest.xml`
  - [ ] Update the app name in `ios/Runner/Info.plist`

- [ ] **Set Up Base URL and Constants**
  - [ ] Create a `constants.dart` file in the `lib/core/constants` folder
  - [ ] Add the base URL:
    ```dart
    class Constants {
      static const String baseUrl = "https://accessories-eshop.runasp.net";
      static const String appName = "DealWise";
    }
    ```

- [ ] **Set Up Project Structure**
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

### **Phase 2: Authentication & Onboarding Screens**
- [ ] **Implement Splash Screen**
  - [ ] Design the splash screen UI with the app logo
  - [ ] Use `SharedPreferences` to check if the user is logged in
  - [ ] Navigate to the onboarding screen if it's the first launch
  - [ ] Navigate to the home screen if the user is logged in

- [ ] **Implement Onboarding Screen**
  - [ ] Design a single onboarding screen introducing the app
  - [ ] Add a "Get Started" button
  - [ ] Use `SharedPreferences` to mark onboarding as completed

- [ ] **Implement Login Screen**
  - [ ] Design the login screen UI (email, password fields, login button)
  - [ ] Add input validation for email and password
  - [ ] Implement API call for authentication
  - [ ] Handle login success (navigate to home screen)
  - [ ] Handle login failure (show error message)
  - [ ] Add a "Forgot Password?" button

- [ ] **Implement Register Screen**
  - [ ] Design the registration screen UI (name, email, password, confirm password)
  - [ ] Add input validation for all fields
  - [ ] Implement API call for user registration
  - [ ] Handle registration success (navigate to OTP verification)
  - [ ] Handle registration failure (show error message)

- [ ] **Implement OTP Verification Screen**
  - [ ] Design the OTP verification screen UI (OTP input fields, verify button)
  - [ ] Implement OTP verification logic
  - [ ] Handle OTP verification success (navigate to home screen)
  - [ ] Handle OTP verification failure (show error message)

- [ ] **Implement Forgot Password Screen**
  - [ ] Design the forgot password screen UI (email field, submit button)
  - [ ] Add input validation for email
  - [ ] Implement API call to send password reset link/OTP
  - [ ] Handle success (navigate to reset password screen)
  - [ ] Handle failure (show error message)

- [ ] **Implement Reset Password Screen**
  - [ ] Design the reset password screen UI (new password, confirm password, submit button)
  - [ ] Add input validation for password fields
  - [ ] Implement API call to reset password
  - [ ] Handle success (navigate to login screen)
  - [ ] Handle failure (show error message)

---

### **Phase 3: Core E-commerce Screens**
- [ ] **Implement Home Screen**
  - [ ] Design the home screen UI (offers, products, categories)
  - [ ] Fetch and display offers from the API
  - [ ] Fetch and display all products from the API
  - [ ] Fetch and display categories from the API
  - [ ] Implement navigation to product details screen
  - [ ] Implement navigation to category filter screen

- [ ] **Implement Products Filtered by Category Screen**
  - [ ] Design the category filter screen UI
  - [ ] Fetch and display products based on the selected category
  - [ ] Implement a back button to return to the home screen

- [ ] **Implement Product Details Screen**
  - [ ] Design the product details screen UI (image, name, price, description, reviews)
  - [ ] Fetch and display product details from the API
  - [ ] Fetch and display product reviews from the API
  - [ ] Implement "Add to Cart" button functionality

- [ ] **Implement Cart Screen**
  - [ ] Design the cart screen UI (list of products, total price, checkout button)
  - [ ] Fetch and display cart items from local storage or API
  - [ ] Implement functionality to remove products from the cart
  - [ ] Update the total price dynamically

- [ ] **Implement Product Management Screen**
  - [ ] Design the product management screen UI (add/delete products)
  - [ ] Implement form for adding new products (name, price, description, image)
  - [ ] Implement API call to add a new product
  - [ ] Implement functionality to delete existing products
  - [ ] Handle success/failure for both actions

---

### **Phase 4: User Profile & Settings Screens**
- [ ] **Implement Profile/Settings Screen**
  - [ ] Design the profile screen UI (user info, settings options)
  - [ ] Display user information (email, name, photo)
  - [ ] Implement theme change (light/dark mode)
  - [ ] Add "Change Password" option
  - [ ] Add "Logout" option
  - [ ] Add "Privacy & Policy", "About Us", and "Contact Us" options

- [ ] **Implement Change Password Screen**
  - [ ] Design the change password screen UI (current password, new password, confirm password)
  - [ ] Add input validation for all fields
  - [ ] Implement API call to change password
  - [ ] Handle success (show success message)
  - [ ] Handle failure (show error message)

- [ ] **Implement Privacy & Policy Screen**
  - [ ] Design a static screen to display privacy policy content

- [ ] **Implement About Us Screen**
  - [ ] Design a static screen to display app and team information

- [ ] **Implement Contact Us Screen**
  - [ ] Design a screen to display contact information (email, phone, social media)

---

### **Phase 5: State Management & Logic**
- [ ] **Set Up Cubit for State Management**
  - [ ] Create `AuthCubit` for authentication state
  - [ ] Create `ProductCubit` for product state
  - [ ] Create `CartCubit` for cart state
  - [ ] Implement state changes for each Cubit

- [ ] **Implement SharedPreferences for Persistence**
  - [ ] Save user login state using `SharedPreferences`
  - [ ] Save onboarding completion state using `SharedPreferences`

---

### **Phase 6: API Integration**
- [ ] **Integrate Authentication API**
  - [ ] Connect login, registration, OTP verification, and password reset to the API
  - [ ] Handle API responses and errors

- [ ] **Integrate Product API**
  - [ ] Fetch and display products on home and category screens
  - [ ] Implement adding/deleting products via the API

- [ ] **Integrate Cart API**
  - [ ] Sync cart screen with the backend to add/remove products

---

### **Phase 7: Navigation & Routing**
- [ ] **Set Up App Navigation**
  - [ ] Implement named routes for all screens
  - [ ] Set up navigation between screens using `Navigator`

- [ ] **Implement Loading States**
  - [ ] Add loading indicators for API calls
  - [ ] Add error handling for failed API calls

---

### **Phase 8: Testing & Finalization**
- [ ] **Test All Screens**
  - [ ] Test splash, onboarding, and authentication screens
  - [ ] Test home, product, and cart screens
  - [ ] Test profile and settings screens

- [ ] **Optimize UI/UX**
  - [ ] Ensure consistent colors, fonts, and spacing
  - [ ] Improve user experience based on feedback

- [ ] **Final Code Review**
  - [ ] Review code for best practices
  - [ ] Ensure all team members have pushed their changes
