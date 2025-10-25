# DealWise - Flutter E-commerce App Task List

---

## 📋 Implementation Tasks (Aligned with Phases)

---

### **Phase 0: Project Setup**

- [x] ~~wise-0: Create GitHub repository and add collaborators~~
- [x] ~~wise-1: Initialize Flutter project named `dealwise` and push initial commit~~
- [ ] wise-2: Configure app name ("DealWise") and launcher icon
- [ ] wise-3: Add essential dependencies to `pubspec.yaml`:
  - `flutter_bloc`
  - `shared_preferences`
  - `dio`
  - `flutter_secure_storage`
- [ ] wise-4: Define base URL and app constants in `lib/core/constants.dart`

---

### **Phase 1: Authentication & Onboarding**

- [ ] wise-5: Implement Splash Screen (logo + 2s delay → auth/home)
- [ ] wise-6: Implement Onboarding Screen (single page, skip button, mark seen via `shared_preferences`)
- [ ] wise-7: Implement Login Screen (email/password + navigate to home on success)
- [ ] wise-8: Implement Register Screen (name/email/password + validation)
- [ ] wise-9: Implement OTP Verification Screen (6-digit input, resend option)
- [ ] wise-10: Implement Forgot Password Screen (email input)
- [ ] wise-11: Implement Reset Password Screen (new password + confirm)
- [ ] wise-12: Create `AuthCubit` with states for all auth flows (initial, loading, success, error)
- [ ] wise-13: Integrate authentication APIs (login, register, OTP, forgot/reset password)

---

### **Phase 2: Core E-commerce Features**

- [ ] wise-14: Implement Home Screen (offers carousel, categories list, product grid)
- [ ] wise-15: Implement Products by Category Screen (fetch & display filtered products)
- [ ] wise-16: Implement Product Details Screen (image, price, description, reviews section, "Add to Cart" button)
- [ ] wise-17: Implement Cart Screen (list items, update quantity, remove item, total price)
- [ ] wise-18: Implement Product Management Screen (form to add new product; delete button on product card)
- [ ] wise-19: Create `ProductCubit` for fetching and managing products
- [ ] wise-20: Create `CartCubit` for adding/removing/updating cart items
- [ ] wise-21: Integrate Product and Cart APIs (CRUD operations)

---

### **Phase 3: User Profile & Settings**

- [ ] wise-22: Implement Profile/Settings Screen (user name/email/photo, theme toggle, logout button)
- [ ] wise-23: Implement Change Password Screen (current + new password fields)
- [ ] wise-24: Implement Privacy & Policy Screen (static text from requirements)
- [ ] wise-25: Implement About Us Screen (app info, version, team credits)
- [ ] wise-26: Implement Contact Us Screen (email, phone, support form)
- [ ] wise-27: Persist login state and theme preference using `shared_preferences`

---

### **Phase 4: Navigation & Polish**

- [ ] wise-28: Set up app-wide navigation (authenticated vs unauthenticated routes)
- [ ] wise-29: Test all user flows (onboarding → auth → browse → cart → profile → logout)
- [ ] wise-30: Final code review, remove dead code, ensure MVVM structure is clean
