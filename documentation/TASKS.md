# DealWise - Flutter E-commerce App Task List

---

## 📋 Implementation Tasks (Aligned with Phases)

---

### **Phase 0: Project Setup**

-   [x] ~~wise-0: Create GitHub repository and add collaborators~~
-   [x] ~~wise-1: Initialize Flutter project named `dealwise` and push initial commit~~
-   [x] ~~wise-2: Configure app name ("DealWise") and launcher icon / Icon for the app~~
-   [x] ~~wise-3: Add essential dependencies to `pubspec.yaml`:~~
    -   [x] ~~`flutter_bloc`~~
    -   [x] ~~`shared_preferences`~~
    -   [x] ~~`dio`~~
    -   [x] ~~`http` optional~~
    -   [x] ~~`flutter_secure_storage`~~
-   [x] wise-4: Creating all features folders / Screen files placeholders
-   [ ] The Colors folder for themeing
-   [ ] wise-5: Define Routes
-   [ ] wise-6: Define base URL and app constants in `lib/core/constants.dart`

---

### **Phase 1: Authentication & Onboarding**

-   [ ] wise-14: Create `AuthCubit` with states for all auth flows (initial, loading, success, error)
-   [ ] wise-7: Implement Splash Screen (logo + 2s delay → auth/home)
-   [ ] wise-8: Implement Onboarding Screen (single page, skip button, mark seen via `shared_preferences`)
-   [ ] wise-10: Implement Register Screen (name/email/password + validation)
-   [ ] wise-9: Implement Login Screen (email/password + navigate to home on success)
-   [ ] wise-11: Implement OTP Verification Screen (6-digit input, resend option)
-   [ ] wise-12: Implement Forgot Password Screen (email input)
-   [ ] wise-13: Implement Reset Password Screen (new password + confirm)
-   [ ] wise-15: Making Screens First , Then The usable Shared widgets && refactor

---

### **Phase 2: Core E-commerce Features**

-   [ ] wise-21: Create `ProductCubit` for fetching and managing products
-   [ ] wise-22: Create `CartCubit` for adding/removing/updating cart items
-   [ ] wise-16: Implement Home Screen (offers carousel, categories list, product grid)
-   [ ] wise-17: Implement Products by Category Screen (fetch & display filtered products)
-   [ ] wise-18: Implement Product Details Screen (image, price, description, reviews section, "Add to Cart" button)
-   [ ] wise-19: Implement Cart Screen (list items, update quantity, remove item, total price)
-   [ ] wise-20: Implement Product Management Screen (form to add new product; delete button on product card)
-   [ ] wise-23: Making Screens First , Then The usable Shared widgets && refactor

---

### **Phase 3: User Profile & Settings**

-   [ ] wise-24: Implement Profile/Settings Screen (user name/email/photo, theme toggle, logout button)
-   [ ] wise-25: Implement Change Password Screen (current + new password fields)
-   [ ] wise-26: Implement Privacy & Policy Screen (static text from requirements)
-   [ ] wise-27: Implement About Us Screen (app info, version, team credits)
-   [ ] wise-28: Implement Contact Us Screen (email, phone, support form)
-   [ ] wise-29: Making Screens First , Then The usable Shared widgets && refactor

---

### **Phase 4: Navigation & Polish**

-   [ ] wise-30: Set up app-wide navigation (authenticated vs unauthenticated routes)
-   [ ] wise-31: Test all user flows (onboarding → auth → browse → cart → profile → logout)
-   [ ] wise-32: Final code review, remove dead code, ensure MVVM structure is clean
-   [ ] wise-33: Shared widgets && refactor
