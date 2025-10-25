# DealWise - Flutter E-commerce App Task List

---

## 📋 Implementation Tasks (Aligned with Phases)

---

### **Phase 0: Project Setup**

- [x] ~~Create GitHub repository and add collaborators~~
- [ ] Initialize Flutter project named `dealwise` and push to GitHub
- [ ] Configure app name and launcher icon
- [ ] Add essential dependencies to `pubspec.yaml`:
  - `flutter_bloc` (state management)
  - `shared_preferences` (persist onboarding & auth state)
  - `dio` (HTTP client for API)
  - `flutter_secure_storage` (secure token storage)
- [ ] Define base URL and app constants (e.g., in `lib/core/constants.dart`)

---

### **Phase 1: Authentication & Onboarding**

- [ ] Implement Splash Screen (with logo and auto-navigate logic)
- [ ] Implement Onboarding Screen (show only on first launch using `shared_preferences`)
- [ ] Implement Login Screen
- [ ] Implement Register Screen
- [ ] Implement OTP Verification Screen
- [ ] Implement Forgot Password Screen
- [ ] Implement Reset Password Screen
- [ ] Set up `AuthCubit` with states for all auth flows
- [ ] Integrate authentication APIs (login, register, OTP, password reset)

---

### **Phase 2: Core E-commerce Features**

- [ ] Implement Home Screen (with offers, categories, and product list)
- [ ] Implement Products Filtered by Category Screen
- [ ] Implement Product Details Screen (with reviews section)
- [ ] Implement Cart Screen (view and manage items)
- [ ] Implement Product Management Screen (add/delete products – admin-only logic optional)
- [ ] Set up `ProductCubit` for product-related state
- [ ] Set up `CartCubit` for cart operations
- [ ] Integrate product and cart APIs

---

### **Phase 3: User Profile & Settings**

- [ ] Implement Profile/Settings Screen (display user info, theme toggle, logout)
- [ ] Implement Change Password Screen
- [ ] Implement Privacy & Policy Screen
- [ ] Implement About Us Screen
- [ ] Implement Contact Us Screen
- [ ] Persist user session and theme preference using `shared_preferences`

---

### **Phase 4: Navigation & Polish**

- [ ] Set up app-wide navigation
- [ ] Test all screens and user flows (auth, browse, cart, profile)
- [ ] Conduct final code review and clean up unused code
