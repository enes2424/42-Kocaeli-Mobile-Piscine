# 42 Kocaeli Mobile Piscine
## Mobile Module 01 - İleri UI ve Navigation

Bu proje, 42 Okulu Mobile Piscine eğitiminin ikinci modülüdür. Bu modül, Flutter'da daha karmaşık UI bileşenleri, navigation sistemi, tab yönetimi ve responsive design konularını derinlemesine işler. TabBar, TextField, lifecycle yönetimi ve adaptive UI geliştirme becerilerini geliştirir.

## 🌤️ Weather App Projesi

### weather_app - Hava Durumu Uygulaması
**Dosya:** `mobileModule01/weather_app/lib/main.dart`

Tabbed interface ile çok sayfalı hava durumu uygulaması.
- **Özellikler:** TabBar navigation, arama fonksiyonu, responsive design
- **Widget'lar:** `TabController`, `TabBar`, `TabBarView`, `TextField`, `BottomAppBar`
- **Açıklama:** Karmaşık navigation ve state management
- **Ana Özellikler:**

#### 🔍 **Arama Sistemi**
- **TextField Integration**: Dinamik arama çubuğu
- **Search Controller**: TextEditingController ile input yönetimi
- **Real-time Feedback**: Anlık arama sonuçları
- **UI Elements:**
  - Search icon (Icons.search) 
  - Placeholder text: "Search location..."
  - Send button (Icons.send) için action
  - Responsive visibility (ekran boyutuna göre gizleme)

#### 📱 **Tab Navigation Sistemi**
- **3 Ana Tab**: Currently, Today, Weekly
- **TabController**: SingleTickerProviderStateMixin ile lifecycle yönetimi
- **BottomAppBar**: Modern tab navigation tasarımı
- **Tab Icons**:
  - Currently: `Icons.settings`
  - Today: `Icons.today` 
  - Weekly: `Icons.calendar_view_week`
- **Indicator Styling**: Mavi accent color ile aktif tab gösterimi

#### 🎨 **Responsive Design Features**
- **MediaQuery Integration**: Ekran boyutu algılama
- **Adaptive Layout**: Çok küçük ekranlarda UI elementlerini gizleme
- **Width Constraints**: Minimum 60px genişlik kontrolü
- **Height Constraints**: Minimum 136px + padding kontrolü
- **FittedBox**: Text scaling ve overflow koruması

#### 🏗️ **Widget Architecture**
```
Scaffold
├── AppBar (Conditional rendering based on width)
│   ├── Title (TextField for search)
│   └── Actions (Send button)
├── Body
│   └── TabBarView
│       ├── Currently Page
│       ├── Today Page  
│       └── Weekly Page
└── BottomNavigationBar (TabBar)
```

#### 💻 **State Management**
- **StatefulWidget**: Dinamik content yönetimi
- **TextEditingController**: Input field kontrolü
- **TabController**: Tab geçişleri
- **Lifecycle Methods**:
  - `initState()`: Controller initialization
  - `dispose()`: Memory leak prevention
- **setState()**: UI güncelleme ve arama state yönetimi

#### 🎪 **Advanced UI Components**
- **LayoutBuilder**: Responsive text sizing
- **FittedBox**: Dynamic text scaling
- **SingleChildScrollView**: Scrollable content
- **Column Layout**: Vertical content alignment
- **Container Styling**: Visual separators

#### 🌈 **Color Theming**
- **Primary**: `Color.fromARGB(255, 91, 93, 114)` (Dark Blue Grey)
- **Text Colors**: White variations (white, white54, white38)
- **Accent**: Blue for indicators and labels
- **Transparency**: Overlay color management

#### 📐 **Layout Patterns**
- **Conditional Rendering**: Width/height based UI decisions
- **Flexible Text**: Dynamic font sizing with FittedBox
- **Responsive Actions**: Ekran boyutuna göre element gizleme
- **Centered Layout**: Cross-axis alignment
- **Scrollable Views**: Overflow protection

## 🔧 Kurulum ve Çalıştırma

### Flutter SDK Kurulumu
```bash
# Flutter SDK indirme (Linux)
wget https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.16.0-stable.tar.xz
tar xf flutter_linux_3.16.0-stable.tar.xz

# PATH'e ekleme
export PATH="$PATH:`pwd`/flutter/bin"

# Doctor kontrolü
flutter doctor
```

### Weather App Çalıştırma
```bash
# Weather app dizinine gitme
cd mobileModule01/weather_app

# Dependencies yükleme
flutter pub get

# App icon generation
flutter pub run flutter_launcher_icons:main

# Uygulamayı çalıştırma
flutter run

# Build commands
flutter build apk --release
flutter build ios --release
```

### Assets Yönetimi
```yaml
# pubspec.yaml konfigürasyonu
flutter:
  uses-material-design: true
  assets:
    - assets/icon/weather.png

# Icon configuration
flutter_launcher_icons:
  android: true
  ios: true
  web:
    generate: true
    image_path: "assets/icon/weather.png"
```

## 🎯 Module 01 - Öğrenilen Kavramlar

### 1. **Tab Navigation**
   - **TabController**: Tab geçiş yönetimi
   - **TabBar/TabBarView**: Synchronized navigation
   - **BottomAppBar**: Modern navigation patterns
   - **Tab Indicators**: Visual feedback systems

### 2. **Advanced State Management**
   - **SingleTickerProviderStateMixin**: Animation lifecycle
   - **Multiple Controllers**: TextEditingController + TabController
   - **Lifecycle Management**: initState, dispose patterns
   - **Memory Management**: Controller disposal

### 3. **Responsive Design Mastery**
   - **MediaQuery**: Screen dimension detection
   - **Conditional Rendering**: UI adaptation
   - **Flexible Layouts**: Dynamic sizing
   - **Breakpoint Management**: Width/height thresholds

### 4. **Input Handling**
   - **TextField Advanced**: Styling ve customization
   - **onSubmitted Callback**: Enter key handling
   - **InputDecoration**: Icons ve placeholder management
   - **Focus Management**: User interaction flow

### 5. **Layout Optimization**
   - **LayoutBuilder**: Constraint-based rendering
   - **FittedBox**: Content scaling
   - **SingleChildScrollView**: Overflow prevention
   - **Stack/Column**: Complex positioning

### 6. **Asset Management**
   - **App Icons**: Multi-platform icon generation
   - **Asset Integration**: Image ve resource management
   - **Launcher Icons**: Platform-specific configurations

---

## 🚀 Tüm Modüller - İleri Seviye Özellikler

### Module 00 vs Module 01 Karşılaştırma

| Aspect | Module 00 | Module 01 |
|--------|-----------|-----------|
| **Complexity** | Basic widgets | Advanced navigation |
| **State** | Simple setState | Multi-controller management |
| **Layout** | Static layouts | Responsive + adaptive |
| **Navigation** | Single screen | Tab-based navigation |
| **Input** | Button interactions | Text input + validation |
| **Lifecycle** | Basic widget lifecycle | Advanced with mixins |

### Combined Learning Path
1. **Foundation** (Module 00): Widget basics, simple state
2. **Navigation** (Module 01): Tabs, input handling
3. **Architecture**: Scalable app structure
4. **Performance**: Optimization techniques
