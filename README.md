# 📱 Catalogue

**Catalogue** is an iOS app written in **Swift** using **SwiftUI** with **MVVM architecture**.
It integrates **Firebase** for authentication and data storage.

---

## 🧩 Project Structure

```
catalogue/
├── catalogue.xcodeproj
├── catalogue/
│   ├── models/               → Data models
│   ├── view_models/          → ViewModels
│   ├── views/                → SwiftUI screens
│   ├── other/
│   │   ├── Assets.xcassets
│   │   ├── Launch Screen.storyboard
│   │   └── GoogleService-Info.plist 🔒 (not included)
│   └── Info.plist
└── .gitignore
```

---

## 🚀 Requirements

* macOS 13+
* Xcode 15+
* iOS 16+
* Swift 5.9+

---

## ⚙️ Setup

1. Clone the repo:

```bash
git clone https://github.com/daniele-NA/catalogue.git
cd catalogue
```

2. Open the project in Xcode:

```bash
open catalogue.xcodeproj
```

3. Add Firebase config:

   * Get `GoogleService-Info.plist` from Firebase Console
   * Place it in `catalogue/other/GoogleService-Info.plist`

4. Build and run the app in Xcode (or simulator).

---

## 🔐 Security

* `GoogleService-Info.plist` is **excluded from Git** for security.
* `xcuserdata/` and `DerivedData/` are also ignored.
* Only safe project files are in the repo.

---

## 🛠️ Tech Stack

* SwiftUI (UI)
* MVVM architecture
* Firebase Authentication & Firestore
* Swift Package Manager / CocoaPods

---

## 📧 Author

**Daniele** – [GitHub](https://github.com/daniele-NA)
