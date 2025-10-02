# 42-Kocaeli-Mobile-Piscine
## Mobile Module 02 - API Entegrasyonu ve Gelişmiş State Yönetimi

Bu proje, 42 Okulu Mobile Piscine eğitiminin üçüncü modülüdür. Bu modül, HTTP istekleri, API entegrasyonu, GPS konum servisleri, gelişmiş arama fonksiyonları ve asenkron programming konularını derinlemesine işler. Gerçek zamanlı veri yönetimi, error handling ve permission management becerilerini geliştirir.

## 🌤️ Medium Weather App Projesi

### medium_weather_app - Gelişmiş Hava Durumu Uygulaması
**Dosya:** `mobileModule02/medium_weather_app/lib/main.dart`

API entegrasyonu ve GPS servisleri ile tam fonksiyonel hava durumu uygulaması.
- **Özellikler:** HTTP istekleri, GPS lokasyon, arama önerileri, real-time data
- **Packages:** `geolocator`, `http`, `diacritic`, modüler kod yapısı
- **Açıklama:** Production-level mobile app development
- **Ana Özellikler:**

#### 🛰️ **GPS ve Konum Servisleri**
- **Geolocator Package**: Gerçek zamanlı konum algılama
- **Permission Management**: Dinamik izin kontrolü
- **Location Services**: Servis durumu kontrolü
- **Error Handling**: Konum hatalarında fallback mekanizması
- **Auto Location**: Uygulama açılışında otomatik konum alma
- **Background Location**: Sürekli konum güncellemeleri

#### 🌐 **API Entegrasyonu**
- **HTTP Requests**: RESTful API çağrıları
- **JSON Parsing**: Kompleks veri yapıları işleme
- **Error Handling**: Network hatalarında graceful degradation
- **Rate Limiting**: API çağrı optimizasyonu
- **Offline Support**: Bağlantı kesintilerinde kullanıcı bilgilendirme
- **Data Caching**: Performans optimizasyonu

#### 🔍 **Gelişmiş Arama Sistemi**
- **Real-time Suggestions**: Typing sırasında anlık öneriler
- **Autocomplete**: API-based location suggestions
- **Text Highlighting**: Arama terimlerinin vurgulanması
- **Location Formatting**: Şehir, bölge, ülke formatlaması
- **Duplicate Handling**: Tekrar eden sonuçların filtrelenmesi
- **Cursor Management**: Text input sırasında cursor pozisyon kontrolü

#### 📋 **Modüler Kod Yapısı**
```
lib/
├── main.dart (Ana uygulama)
└── src/
    ├── location.dart (Konum data modeli)
    ├── where_are_we.dart (GPS servisleri)
    ├── permission.dart (İzin yönetimi)
    ├── searcher.dart (Arama ve API)
    ├── utils.dart (Utility fonksiyonlar)
    └── fill_the_views.dart (UI data provider)
```

#### 🎨 **Adaptive UI Components**
- **FutureBuilder**: Asenkron veri yükleme
- **CircularProgressIndicator**: Loading states
- **ListView.Builder**: Dinamik liste oluşturma
- **RichText**: Text formatting ve highlighting
- **Conditional Rendering**: State-based UI değişimleri
- **Error States**: Network ve konum hatalarında özel UI

#### 🔧 **State Management Patterns**
- **Multiple Controllers**: Koordineli state yönetimi
- **Async Operations**: Future ve async/await patterns
- **Error State Handling**: Çok katmanlı hata yönetimi
- **Loading States**: Kullanıcı feedback sistemleri
- **Data Validation**: Input validasyon ve sanitization
- **Memory Management**: Controller ve listener disposal

#### 🎯 **User Experience Features**
- **Smart Search**: Virgül ve boşluk otomatik formatlaması
- **Tap to Select**: Öneri listesinden seçim
- **Visual Feedback**: Hata durumlarında renk değişimi
- **Responsive Design**: Farklı ekran boyutlarına uyum
- **Background States**: Farklı app durumları için UI adaptasyonu

#### 🔗 **Dependencies**
```yaml
dependencies:
  geolocator: ^13.0.2    # GPS ve konum servisleri
  http: ^1.3.0           # HTTP client
  diacritic: ^0.1.3      # Text normalization
  flutter_launcher_icons: ^0.14.3  # App icon generation
```

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

### Medium Weather App Çalıştırma
```bash
# Medium weather app dizinine gitme
cd mobileModule02/medium_weather_app

# Dependencies yükleme
flutter pub get

# App icon generation
flutter pub run flutter_launcher_icons:main

# Permissions (Android)
# android/app/src/main/AndroidManifest.xml
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
<uses-permission android:name="android.permission.INTERNET" />

# Permissions (iOS)
# ios/Runner/Info.plist
<key>NSLocationWhenInUseUsageDescription</key>
<string>This app needs location access to provide weather information.</string>

# Uygulamayı çalıştırma
flutter run

# Build commands
flutter build apk --release
flutter build ipa --release
```

### API Endpoints
```
# Geocoding API
https://geocoding-api.open-meteo.com/v1/search?name={query}

# Weather API  
https://api.open-meteo.com/v1/forecast?latitude={lat}&longitude={lon}
```

## 🎯 Module 02 - Öğrenilen Kavramlar

### 1. **HTTP ve API Entegrasyonu**
   - **HTTP Package**: RESTful API çağrıları
   - **JSON Parsing**: Kompleks veri yapıları decode/encode
   - **Error Handling**: Network exception management
   - **Async Programming**: Future, async/await patterns

### 2. **GPS ve Konum Servisleri**
   - **Geolocator**: Platform-specific location services
   - **Permission Handling**: Runtime permission requests
   - **Location Updates**: Real-time position tracking
   - **Service Status**: Location service availability check

### 3. **Gelişmiş State Management**
   - **Multiple Async Operations**: Koordineli async state
   - **Error State Patterns**: Çok katmanlı hata yönetimi
   - **Loading State Management**: User feedback systems
   - **Data Validation**: Input sanitization ve validation

### 4. **UI/UX Advanced Patterns**
   - **FutureBuilder**: Async widget building
   - **Conditional Rendering**: State-based UI adaptation
   - **ListView.Builder**: Performance optimized lists
   - **RichText**: Advanced text formatting

### 5. **Modüler Architecture**
   - **Separation of Concerns**: Feature-based kod organizasyonu
   - **Data Models**: Type-safe veri yapıları
   - **Service Classes**: API ve GPS servis abstraction
   - **Utility Functions**: Reusable helper methods

### 6. **Production Considerations**
   - **Error Boundary**: Graceful error handling
   - **Performance Optimization**: Efficient API calls
   - **Memory Management**: Resource cleanup
   - **User Experience**: Loading states ve feedback

---

## 🚀 Module Evolution - Öğrenme Yolculuğu

### Module Karşılaştırma

| Aspect | Module 00 | Module 01 | Module 02 |
|--------|-----------|-----------|-----------|
| **Focus** | Basic widgets | Navigation | API Integration |
| **Complexity** | Static UI | Tab-based | Real-time data |
| **State** | Simple setState | Multi-controller | Async state management |
| **Data** | Hardcoded | User input | External APIs |
| **Architecture** | Single file | Organized widgets | Modular structure |
| **User Experience** | Basic interactions | Enhanced UI | Production-level |

### Progressive Learning Path
1. **Foundation** (Module 00): Widget basics, layout
2. **Interaction** (Module 01): Navigation, input handling  
3. **Integration** (Module 02): APIs, real-world data
4. **Production**: Deployment, optimization, testing

### Advanced Concepts Introduced
- **Asynchronous Programming**: Future, Stream, async/await
- **Network Programming**: HTTP clients, JSON processing
- **Platform Services**: GPS, permissions, device capabilities
- **Error Handling**: Graceful degradation, user feedback
- **Code Organization**: Modular architecture, separation of concerns
