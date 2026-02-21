# U-Tweet — University Social Networking App (Flutter + Firebase)

U-Tweet is a real-time social networking mobile application built for **University of Lahore (UOL)** students.  
It helps students connect through university-focused posts, interactions, profiles, and discovery features—while keeping the platform restricted to the university community. :contentReference[oaicite:1]{index=1}

---

##  Key Features UTWEET

- **Authentication & Registration**
  - Secure sign up / sign in using **Firebase Authentication**
  - Designed to support university-only onboarding (UOL student accounts) :contentReference[oaicite:2]{index=2}

- **Tweet Feed (Real-time)**
  - Create and view tweets in real time
  - Live updates using Firestore streaming / StreamBuilder :contentReference[oaicite:3]{index=3}

- **Engagement**
  - Like / Unlike tweets
  - Comment system with real-time count updates :contentReference[oaicite:4]{index=4}

- **User Profiles**
  - Edit bio and upload profile picture
  - Profile image stored in Firebase Storage; profile updates stored in Firestore :contentReference[oaicite:5]{index=5}

- **Follow / Unfollow**
  - Followers / following stored in user documents and updated live :contentReference[oaicite:6]{index=6}

- **People Map (Approximate location)**
  - View users on a map using generalized location (city/zone) for privacy :contentReference[oaicite:7]{index=7}

- **UOL Confessions (Moderated)**
  - Anonymous confession submissions stored without UID
  - Admin reviews and posts approved confessions publicly :contentReference[oaicite:8]{index=8}

---

## 🧰 Tech Stack

- **Flutter** (Cross-platform UI)
- **Dart**
- **Firebase**
  - Firebase Auth (Authentication)
  - Cloud Firestore (Real-time database)
  - Firebase Storage (Media storage)
- **Provider** (State management)
- **Maps / Location**
  - Flutter OSM Plugin (OpenStreetMap)
  - Geolocator + Geocoding :contentReference[oaicite:9]{index=9}

---

## 📁 Project Structure

Typical structure used in this app:

```text
lib/
├── models/        # user_model.dart, tweet_model.dart
├── screens/       # auth, feed, profile, etc.
│   ├── auth/
│   ├── feed/
│   └── profile/
├── services/      # auth_service.dart, tweet_service.dart (Firebase logic)
├── widgets/       # reusable UI components (tweet_card.dart, profile_avatar.dart)
└── main.dart      # app entry, routing
