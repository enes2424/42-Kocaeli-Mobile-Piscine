# 42-Kocaeli-Mobile-Piscine
## Mobile Module 05 - Advanced UI Components ve Calendar Integration

Bu proje, 42 Okulu Mobile Piscine eğitiminin altıncı modülüdür. Bu modül, advanced UI patterns, calendar integration, complex navigation systems ve enhanced user experience konularını derinlemesine işler. Table Calendar library kullanımı, Shell Route navigation, Bottom Navigation Bar ve advanced diary management becerilerini geliştirir.

## 📅 Advanced Diary App Projesi

### advanced_diary_app - Gelişmiş Günlük Uygulaması
**Dosya:** `mobileModule05/advanced_diary_app/lib/main.dart`

Calendar integration ve advanced navigation ile professional günlük uygulaması.
- **Özellikler:** Table Calendar integration, Shell Route navigation, Bottom Navigation Bar, Advanced UI patterns
- **Packages:** `table_calendar: ^3.2.0`, `flutter_riverpod: ^2.6.1`, `supabase_flutter: ^2.9.1`, `go_router: ^16.0.0`
- **Açıklama:** Advanced UI components ile calendar-based diary management
- **Ana Özellikler:**

#### 📅 **Calendar Integration**
- **Table Calendar Widget**: Professional calendar component
- **Multi-format Support**: Month, Two Weeks, Week views
- **Date Selection**: Interactive day selection
- **Entry Filtering**: Date-based diary entry display
- **Calendar Styling**: Custom theming ve color schemes
- **Responsive Heights**: Dynamic calendar sizing based on format

#### 🧭 **Advanced Navigation System**
- **Shell Route Pattern**: Persistent bottom navigation
- **Multi-page Architecture**: Profile ve Agenda pages
- **Bottom Navigation Bar**: Icon-based tab switching
- **Route Protection**: Authentication-based access control
- **Deep Linking**: Direct page access via URLs
- **Navigation State**: Persistent selected tab indication

#### 🎨 **Enhanced UI Components**
- **Bottom Navigation**: Dual-page navigation system
- **Calendar Views**: Interactive calendar widget
- **Filtered Listings**: Date-specific entry display
- **Dynamic Heights**: Responsive component sizing
- **Background Integration**: Full-screen asset backgrounds
- **Custom Styling**: Enhanced visual hierarchy

#### 📋 **Advanced Diary Management**
- **Date-filtered Entries**: Calendar-based entry filtering
- **Dynamic Entry Display**: Real-time entry updates
- **Enhanced Card Layout**: Improved visual presentation
- **User Profile Display**: Personalized header information
- **Multi-view Support**: Profile ve Agenda perspectives
- **Seamless Navigation**: Smooth transitions between views
#### 🎯 **Calendar Features**
```dart
// Calendar configuration
TableCalendar(
  firstDay: DateTime.utc(2010, 10, 16),
  lastDay: DateTime.utc(2030, 3, 14),
  focusedDay: _focusedDay,
  calendarFormat: _calendarFormat, // Month, TwoWeeks, Week
  selectedDayPredicate: (day) => isSameDay(_focusedDay, day),
  onDaySelected: (selectedDay, focusedDay) {
    setState(() => _focusedDay = focusedDay);
  },
)
```

#### 📋 **Modüler Kod Yapısı**
```
lib/
├── main.dart (Ana uygulama ve background setup)
└── src/
    ├── database/
    │   ├── database.dart (Supabase initialization)
    │   ├── authentication.dart (Auth state management)
    │   └── diary_operations.dart (CRUD operations)
    ├── pages/
    │   ├── welcome_page.dart (Landing page)
    │   ├── login_page.dart (OAuth login interface)
    │   ├── profile_page.dart (User profile ve diary list)
    │   └── agenda_page.dart (Calendar ve filtered entries)
    ├── router/
    │   └── router.dart (Shell Route ve navigation config)
    └── utils/
        ├── diary_operations.dart (Calendar filtering ve UI dialogs)
        └── snackbar.dart (User feedback system)
```

#### 🎨 **UI Components ve Widgets**
- **StatefulWidget**: Complex calendar state management
- **ConsumerWidget**: Riverpod state consumption
- **FutureBuilder**: Asenkron diary data loading
- **TableCalendar**: Professional calendar widget
- **Shell Route**: Persistent navigation structure
- **Bottom Navigation Bar**: Dual-page navigation system

#### 📅 **Calendar Integration Features**
- **Multiple Calendar Formats**: Month, Two Weeks, Week views
- **Date Filtering**: Entry display based on selected date
- **Interactive Selection**: Touch-based date selection
- **Dynamic Heights**: Calendar size adaptation
- **Visual Indicators**: Date-based entry highlighting
- **Calendar Navigation**: Month/year navigation controls
```dart
// Calendar format switching
double getCalendarHeight(CalendarFormat format) {
  switch (format) {
    case CalendarFormat.month: return 340;
    case CalendarFormat.twoWeeks: return 184;
    case CalendarFormat.week: return 132;
  }
}
```

#### 🔧 **Advanced Navigation Patterns**
- **Shell Route Architecture**: Persistent bottom navigation
- **Tab-based Navigation**: Icon-driven page switching
- **Route State Management**: Selected tab persistence
- **Authentication Guards**: Protected route access
- **Deep Linking Support**: Direct page navigation
- **Navigation Callbacks**: Event-driven tab switching
- **Calendar Integration**: Date-based entry filtering

#### 🎯 **User Experience Features**
- **Dual Navigation**: Profile ve Agenda tab switching
- **Calendar Interaction**: Interactive date selection
- **Filtered Views**: Date-specific entry display
- **Enhanced Profiles**: User metadata display
- **Smooth Transitions**: Seamless navigation flow
- **Responsive Design**: Adaptive layouts için MediaQuery
- **Background States**: Farklı app durumları için UI adaptasyonu

#### 🔗 **Dependencies**
```yaml
dependencies:
  table_calendar: ^3.2.0         # Professional calendar widget
  flutter_riverpod: ^2.6.1      # Modern state management
  supabase_flutter: ^2.9.1      # Backend services
  go_router: ^16.0.0           # Advanced routing with Shell Routes
  cupertino_icons: ^1.0.8      # iOS style icons
  flutter_launcher_icons: ^0.14.4  # App icon generation

assets:
  - assets/background.jpeg      # Full-screen app background
  - assets/google_logo.png      # Google OAuth logo
  - assets/github_logo.png      # GitHub OAuth logo
  - assets/diary_icon.png       # App icon
```

#### 🔍 **Calendar-based Operations**
- **Date Selection**: Interactive calendar date picking
- **Entry Filtering**: Display entries for selected date only
- **Calendar Formats**: Month, Two Weeks, Week view switching
- **Visual Integration**: Calendar ve entry list coordination
- **UI Elements:**
  - Calendar widget: Full TableCalendar integration
  - Format switcher: Dynamic view mode changes
  - Date highlighting: Selected day indication
  - Filtered entries: Date-specific diary display

#### 📱 **Enhanced Navigation System**
- **Shell Route Architecture**: Persistent bottom navigation
- **2 Main Tabs**: Profile ve Agenda
- **Bottom Navigation Bar**: Icon-based navigation
- **Tab Structure**:
  - Profile: `Icons.person` - User profile ve all entries
  - Agenda: `Icons.calendar_today` - Calendar ve filtered entries
- **Navigation State**: Active tab highlighting ve persistence
- **Authentication Flow**: Welcome → Login → (Profile ↔ Agenda)

#### 🎨 **Responsive Design Features**
- **Dynamic Calendar Heights**: Format-based size adaptation
- **Adaptive Layouts**: MediaQuery-driven responsive design
- **Flexible Navigation**: Bottom navigation persistence
- **Calendar Responsiveness**: View format switching
- **Screen Optimization**: Height ve width constraint handling

#### 🏗️ **App Architecture**
```
MaterialApp.router
├── Shell Route (Persistent Navigation)
│   ├── Bottom Navigation Bar
│   │   ├── Profile Tab (All entries)
│   │   └── Agenda Tab (Calendar + filtered entries)
│   ├── Profile Page
│   └── Agenda Page (Calendar Integration)
├── Authentication Routes
│   ├── Welcome Page
│   └── Login Page (OAuth)
├── Calendar Integration
│   ├── TableCalendar Widget
│   ├── Date Selection Logic
│   └── Entry Filtering System
└── Background Container
    └── Full-screen asset background
```

#### 💻 **Advanced State Management**
- **Calendar State**: TableCalendar format ve focused day management
- **Navigation State**: Bottom navigation tab persistence
- **Filter State**: Date-based entry filtering logic
- **UI State**: Dynamic height calculations
- **Provider Integration**: Riverpod ile global state coordination
- **Route State**: Shell Route ile navigation persistence

#### 🎪 **Modern UI Components**
- **TableCalendar Widget**: Professional calendar implementation
- **Shell Route Navigation**: Persistent bottom navigation
- **Dynamic Containers**: Responsive height calculations
- **Background Assets**: Full-screen image integration
- **Material Design 3**: Modern design language
- **Calendar Theming**: Custom color schemes ve styling

#### 🌈 **Enhanced Theming System**
- **Calendar Background**: `Colors.amber.withAlpha(100)` (Highlighted)
- **Navigation Background**: `Colors.black.withAlpha(150)` (Semi-transparent)
- **Selected Tab Color**: `Color.fromARGB(255, 187, 65, 21)` (Orange)
- **Unselected Tab Color**: `Colors.white`
- **Calendar Selection**: Dynamic date highlighting
- **Font Family**: 'Cursive' için consistent diary aesthetic

#### 📐 **Layout Patterns**
- **Calendar Layout**: TableCalendar widget integration
- **Shell Route Layout**: Persistent navigation structure
- **Dynamic Heights**: Calendar format-based sizing
- **Filtered ListView**: Date-specific entry display
- **Bottom Navigation**: Tab-based navigation system
- **Responsive Containers**: Adaptive component sizing

#### 🎨 **Visual Design System**
- **Calendar Integration**: Professional calendar widget styling
- **Navigation Icons**: Semantic icon representation
- **Date Highlighting**: Visual selection feedback
- **Entry Filtering**: Date-based visual organization
- **Background Assets**: Full-screen image integration
- **Consistent Typography**: Cursive font family throughout

## 🔧 Kurulum ve Çalıştırma

### Flutter SDK Kurulumu
```bash
# Flutter SDK indirme (Linux)
wget https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.24.0-stable.tar.xz
tar xf flutter_linux_3.24.0-stable.tar.xz

# PATH'e ekleme
export PATH="$PATH:`pwd`/flutter/bin"

# Doctor kontrolü
flutter doctor
```

### Advanced Diary App Çalıştırma
```bash
# Advanced diary app dizinine gitme
cd mobileModule05/advanced_diary_app

# Dependencies yükleme
flutter pub get

# App icon generation
flutter pub run flutter_launcher_icons:main

# Android Permissions (android/app/src/main/AndroidManifest.xml)
<uses-permission android:name="android.permission.INTERNET" />

# iOS Permissions (ios/Runner/Info.plist)
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsArbitraryLoads</key>
    <true/>
</dict>

# Assets kontrolü
# Aşağıdaki dosyaların mevcut olduğundan emin olun:
# - assets/background.jpeg
# - assets/google_logo.png  
# - assets/github_logo.png
# - assets/diary_icon.png

# Uygulamayı çalıştırma
flutter run

# Build commands (calendar performansı için release mode önerilir)
flutter build apk --release
flutter build ios --release
```

### Supabase Backend Setup
```bash
# Supabase project configuration (lib/src/database/database.dart)
# URL: https://iuwkxavzpbalisxgqodo.supabase.co
# AnonKey: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...

# Database Schema (SQL)
CREATE TABLE notes (
  id SERIAL PRIMARY KEY,
  usermail TEXT NOT NULL,
  title TEXT NOT NULL,
  text TEXT NOT NULL,
  icon_index INTEGER NOT NULL,
  date TIMESTAMP DEFAULT NOW()
);

# OAuth Provider Setup
# Google OAuth: console.developers.google.com
# GitHub OAuth: github.com/settings/applications
```

### Development Tips
```bash
# Hot reload için debug mode
flutter run --debug

# State management debugging
flutter run --dart-define=RIVERPOD_DEBUG=true

# Web support
flutter run -d chrome --web-port=3000
```

## 🎯 Module 05 - Öğrenilen Kavramlar

### 1. **Calendar Integration**
   - **Table Calendar Widget**: Professional calendar component
   - **Date Selection**: Interactive calendar navigation
   - **Multiple Formats**: Month, Two Weeks, Week views
   - **Entry Filtering**: Date-based content display

### 2. **Advanced Navigation**
   - **Shell Route Pattern**: Persistent navigation structure
   - **Bottom Navigation Bar**: Tab-based interface
   - **Navigation State**: Tab selection persistence
   - **Deep Linking**: Direct page access

### 3. **Enhanced UI Patterns**
   - **Dynamic Heights**: Responsive component sizing
   - **Calendar Styling**: Custom theming ve colors
   - **Background Integration**: Full-screen asset backgrounds
   - **Visual Hierarchy**: Enhanced design patterns

### 4. **State Coordination**
   - **Calendar State**: Date selection management
   - **Filter State**: Entry filtering logic
   - **Navigation State**: Tab persistence
   - **UI Responsiveness**: Dynamic layout adaptation

### 5. **User Experience Enhancement**
   - **Dual View System**: Profile ve Agenda perspectives
   - **Interactive Calendar**: Touch-based date selection
   - **Filtered Content**: Date-specific entry display
   - **Smooth Navigation**: Seamless tab transitions

### 6. **Advanced Component Integration**
   - **Third-party Libraries**: Table Calendar integration
   - **Custom Filtering**: Date-based logic implementation
   - **Responsive Design**: Adaptive calendar sizing
   - **Performance Optimization**: Efficient rendering patterns

---

---

## 🚀 Module Evolution - Öğrenme Yolculuğu

### Module Karşılaştırma

| Aspect | Module 00 | Module 01 | Module 02 | Module 03 | Module 04 | Module 05 |
|--------|-----------|-----------|-----------|-----------|-----------|-----------|
| **Focus** | Basic widgets | Navigation | API Integration | Data Visualization | State Management | Calendar Integration |
| **Complexity** | Static UI | Tab-based | Real-time data | Interactive charts | Backend integration | Advanced UI Components |
| **State** | Simple setState | Multi-controller | Async state management | Chart data management | Riverpod providers | Calendar state coordination |
| **Data** | Hardcoded | User input | External APIs | Visual data representation | Database operations | Date-filtered content |
| **Architecture** | Single file | Organized widgets | Modular structure | Advanced patterns | Full-stack patterns | Component integration |
| **User Experience** | Basic interactions | Enhanced UI | Production-level | Interactive visualizations | Authenticated workflows | Calendar-driven interface |
| **Dependencies** | Core Flutter | Basic packages | HTTP, GPS | Charts, advanced UI | State management, Backend | Calendar widgets, Navigation |

### Progressive Learning Path
1. **Foundation** (Module 00): Widget basics, layout
2. **Interaction** (Module 01): Navigation, input handling  
3. **Integration** (Module 02): APIs, real-world data
4. **Visualization** (Module 03): Charts, advanced UI, performance
5. **Backend** (Module 04): State management, authentication, database
6. **Advanced UI** (Module 05): Calendar integration, enhanced navigation

### Advanced Concepts Introduced
- **Calendar Integration**: Table Calendar widget, date selection, multiple formats
- **Shell Route Navigation**: Persistent bottom navigation, tab-based architecture
- **Advanced State Coordination**: Calendar state, filter logic, navigation persistence
- **Enhanced UI Patterns**: Dynamic heights, responsive design, visual hierarchy
- **Third-party Library Integration**: Professional calendar component usage
- **Date-based Filtering**: Content filtering based on calendar selection
- **Multi-view Architecture**: Profile ve Agenda dual perspectives