# STRICT RULES FOR AI AGENTS — DO NOT IGNORE

If you are an AI assistant working on this project, you **MUST** follow these rules without exception. Breaking these rules will severely damage the architecture and vision of the app.

---

## 1. PRODUCT VISION (Non-Negotiable)
- **Ghindora is NOT a Notes app.**
- **Ghindora is NOT a standard CRUD inventory app.**
- **Ghindora IS a Personal Visual Memory System.** 
- Every feature you build must serve the core loop: **Capture → Remember → Find → Understand**.
- When an item is moved, it is NOT simply a database update. It is a **"Memory Trail"**. Treat location changes as historical events (already implemented in `ItemHistory`).

## 2. ARCHITECTURE & TECH STACK
- **State Management:** You MUST use `flutter_riverpod`. Do not introduce Provider, Bloc, GetX, or any other state management tool.
- **Routing:** You MUST use `go_router`. Use `context.push()` and `context.go()` with the paths defined in `RouteNames`.
- **Database:** You MUST use `drift` (SQLite). 

## 3. DATA & STORAGE CONSTRAINTS
- **Local First:** The app is currently 100% offline. **DO NOT** write code for Firebase, Cloud Firestore, or REST APIs unless the user explicitly commands you to transition the app to the cloud.
- **NO BLOB IMAGES:** Images are saved in the app's local document directory. The Drift database only stores the `String imagePath`. **NEVER** convert images to Base64 or BLOBs to store in the database.

## 4. UI / UX DESIGN RULES
- **Visuals Matter:** The UI must be modern, clean, and visual-first.
- **Use the Design System:** Do not hardcode colors, padding, or text styles. 
  - Use `AppColors.primary`, `AppSpacing.md`, `AppTextStyles.bodyLarge`, etc.
  - Use predefined components (`PrimaryButton`, `AppEmptyView`, `AppLoader`, `ItemCard`).
- **Minimize Typing:** Users hate typing. Use chips, bottom sheets, and visual selectors instead of text fields whenever possible.

## 5. ENVIRONMENT & BUILD RULES (Windows)
- The user is developing on a **Windows OS**.
- **Daemon Issue:** The Kotlin daemon fails on this machine sometimes. The `android/gradle.properties` file must maintain `kotlin.incremental=false`. Do not touch this.
- **App Icons:** `flutter_launcher_icons` breaks the build on this specific setup. **DO NOT** attempt to run it or add it to `pubspec.yaml`. App icons must be managed manually.

## 6. CODE MODIFICATION WORKFLOW
- **Plan First:** If the user asks for a complex feature, write an implementation plan and ask for approval before modifying files.
- **No Blind Overwrites:** When editing existing files, use your edit/replace tools carefully. Do not delete existing functionalities (like the Memory Trail) when adding new ones.

---
*By reading this document, you acknowledge that you will adhere to these constraints.*
