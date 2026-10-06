# 🏥 Medical App

O aplicație Flutter cross-platform pentru gestionarea consultațiilor medicale, dezvoltată ca parte a laboratoarelor de programare cross-platform.

## 📱 Capturi de ecran

| Home Screen | Appointment Details |
|-------------|---------------------|
| ![Home](screenshots/home.png) | ![Appointment](screenshots/appointment.png) |

## ✨ Funcționalități

### 🏠 Home Screen
- **Header personalizat** cu avatar utilizator și notificări
- **Search bar** cu filtrare live a doctorilor
- **Sortare** după nume, distanță sau preț
- **Card Appointment** cu detalii programare și video call
- **Health Services** - 4 categorii selectabile (Tooth, Eye, Lungs, Ear)
- **Nearby Doctors** - listă cu doctori apropiați
- **Favorite toggle** pentru fiecare doctor

### 📋 Appointment Details
- **Info doctor** complet (poză, nume, specialitate)
- **Acțiuni rapide**: chat, phone call, video call
- **Payment** - afișare preț
- **Details** - descriere
- **Working Hours** - selectare oră programare
- **Date** - selectare dată cu calendar picker
- **Book an Appointment** - confirmare programare

### 🔧 State Management
- **Loading** - se afișează 2 secunde la pornire
- **Success** - datele sunt încărcate
- **Empty** - nu sunt rezultate la căutare
- **Error** - eroare la încărcare cu buton Retry

## 🛠️ Tehnologii folosite

| Tehnologie | Versiune | Scop |
|------------|----------|------|
| **Flutter** | 3.x | Framework cross-platform |
| **Dart** | 3.x | Limbaj de programare |
| **flutter_bloc** | ^8.1.6 | State Management |
| **equatable** | ^2.0.5 | Comparare obiecte |
| **flutter_svg** | ^2.0.10 | Iconițe SVG |

## 🚀 Instalare

### Cerințe
- Flutter SDK 3.7+
- Android Studio / VS Code
- Dispozitiv Android sau emulator

### Pași

```bash
# 1. Clonează repository-ul
git clone https://github.com/USERNAME/medical_app.git

# 2. Intră în folder
cd medical_app

# 3. Instalează dependințele
flutter pub get

# 4. Rulează aplicația
flutter run
📦 Build APK
bash
# Curăță proiectul
flutter clean

# Descarcă dependințele
flutter pub get

# Build APK optimizat
flutter build apk --release --split-per-abi
Rezultat: APK-urile se găsesc în build/app/outputs/flutter-apk/:

app-arm64-v8a-release.apk - telefoane moderne

app-armeabi-v7a-release.apk - telefoane vechi

app-x86_64-release.apk - emulatoare

📊 State Management Flow
text
┌─────────────────┐
│  HomeCubit()    │  → Constructor
│  ..loadData()   │  → Apelează imediat
└────────┬────────┘
         ↓
┌─────────────────┐
│  HomeLoading    │  → Se afișează spinner
└────────┬────────┘
         ↓
┌─────────────────┐
│  JsonLoader     │  → Încarcă JSON async
│  loadHomeData() │
└────────┬────────┘
         ↓
    ┌────┴────┐
    ↓         ↓
┌────────┐  ┌──────────┐
│Success │  │  Error   │
└────┬───┘  └──────────┘
     ↓
┌─────────────────────┐
│  BlocBuilder        │  → Reconstruiește UI
│  buildSuccess...    │
└─────────────────────┘
🎨 Paleta de culori
Culoare	HEX	Utilizare
Primary	#2EA3B5	Buton principal, accente
Background	#FFFFFF	Fundal ecrane
Background Grey	#F5F5F5	Fundal card-uri
Text Primary	#1A1A1A	Text principal
Text Secondary	#8E8E93	Text secundar
📝 Fișierul JSON de date
Datele sunt stocate în assets/data/lab_v2.json și sunt încărcate asincron la pornirea aplicației. Structura include:

homeScreen: date pentru ecranul principal

user - info utilizator

notifications - stare notificări

search - hint căutare

appointment - programare viitoare

healthServices - 4 categorii

nearbyDoctors - listă doctori

appointmentDetails: date pentru ecranul de programare

doctor - info doctor (Dr. Upul)

payment - info plată

details - descriere

workingHours - ore disponibile

date - date disponibile

🔄 Funcționalități async
Încărcare JSON: rootBundle.loadString() + json.decode()

Simulare delay: Future.delayed(Duration(seconds: 2))

Try/catch: pentru gestionarea erorilor

📄 Licență
Acest proiect este creat în scop educațional ca parte a laboratoarelor de programare cross-platform.

👨‍💻 Autor
Cataraga Maxim

GitHub: @CataragaMaxim