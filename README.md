# 42-Kocaeli-Mobile-Piscine
## Mobile Module 00 - Flutter Temelleri ve UI Geliştirme

Bu proje, 42 Okulu Mobile Piscine eğitiminin ilk modülüdür. Flutter framework'ü ile mobile uygulama geliştirme, Dart programlama dili temelleri, widget sistemi ve kullanıcı arayüzü tasarımı becerilerini geliştirmek için tasarlanmıştır.

## 📚 Egzersizler

### ex00 - Temel Flutter Uygulaması
**Dosya:** `mobileModule00/ex00/lib/main.dart`

Flutter'da basit bir UI bileşeni oluşturma.
- **Özellikler:** Statik metin ve buton içeren basit arayüz
- **Widget'lar:** `MaterialApp`, `Scaffold`, `Container`, `ElevatedButton`
- **Açıklama:** Temel Flutter widget'larının kullanımı ve styling
- **UI Özellikleri:**
  - Sarı-yeşil renk teması ile özelleştirilmiş Container
  - Yuvarlak köşeli tasarım (BorderRadius)
  - Ortalanmış layout yapısı
  - Konsola çıktı veren buton etkileşimi

### ex01 - State Management
**Dosya:** `mobileModule00/ex01/lib/main.dart`

StatefulWidget kullanarak dinamik UI bileşeni.
- **Özellikler:** Durum değişimi ile metin değiştirme
- **Widget'lar:** `StatefulWidget`, `setState`, dynamic text rendering
- **Açıklama:** Flutter'da state yönetimi ve UI güncellemeleri
- **Fonksiyonalite:**
  - İlk durum: "A simple text" gösterimi
  - Buton tıklaması ile "Hello World" mesajına geçiş
  - `setState()` ile dinamik UI güncelleme
  - Boolean flag ile durum kontrolü

### ex02 - Calculator Layout (Temel)
**Dosya:** `mobileModule00/ex02/lib/main.dart`

Hesap makinesi arayüzünün temel layout'u.
- **Özellikler:** Grid layout ile buton düzenlemesi, responsive tasarım
- **Widget'lar:** `AppBar`, `Stack`, `Wrap`, responsive sizing
- **Açıklama:** Karmaşık layout yönetimi ve ekran boyutlarına uyum
- **UI Bileşenleri:**
  - 19 adet hesap makineesi butonu (0-9, +, -, x, /, =, C, AC, ., 00)
  - 5x4 grid düzenlemesi
  - Renk kategorilendirmesi (sayılar, operatörler, fonksiyonlar)
  - Responsive boyutlandırma (ekran boyutuna göre uyum)
  - Mavi-gri renk teması

### calculator_app - Fonksiyonel Hesap Makinesi
**Dosya:** `mobileModule00/calculator_app/lib/main.dart`

Tam fonksiyonel hesap makinesi uygulaması.
- **Özellikler:** Matematiksel işlemler, expression parsing, hata yönetimi
- **Algoritma:** Özel parsing algoritması ile işlem önceliği
- **Açıklama:** Gerçek hesap makinesi mantığı ve kompleks string işleme
- **Fonksiyonaliteler:**
  - **Dört işlem:** Toplama (+), çıkarma (-), çarpma (x), bölme (/)
  - **İşlem önceliği:** Çarpma/bölme önce, sonra toplama/çıkarma
  - **Hata yönetimi:** Sıfıra bölme kontrolü, geçersiz expression uyarıları
  - **UI Özellikleri:**
    - Gerçek zamanlı expression gösterimi
    - Sonuç hesaplama ve gösterimi
    - C (Clear): Son karakteri silme
    - AC (All Clear): Tüm expression'ı temizleme
    - Decimal number desteği
  - **Parsing Algoritması:**
    - String tokenization (sayılar ve operatörler ayrıştırma)
    - Matematiksel öncelik kuralları uygulaması
    - Negatif sayı desteği
    - Exception handling ile güvenli hesaplama

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

### Proje Çalıştırma
```bash
# Proje dizinine gitme
cd mobileModule00/ex00  # veya ex01, ex02, calculator_app

# Bağımlılıkları yükleme
flutter pub get

# Uygulamayı çalıştırma (emülatör/device)
flutter run

# Release build
flutter build apk
flutter build ios
```

### VS Code Konfigürasyonu
```bash
# Flutter ve Dart extensions yükleme
code --install-extension dart-code.flutter
code --install-extension dart-code.dart-code
```

## 🎯 Öğrenilen Kavramlar

### 1. **Flutter Widget Sistemi**
   - **StatelessWidget**: Statik UI bileşenleri
   - **StatefulWidget**: Dinamik UI bileşenleri
   - **Widget Tree**: Hiyerarşik UI yapısı
   - **Build Context**: Widget context yönetimi

### 2. **Layout ve Styling**
   - **Container**: Padding, margin, decoration
   - **Column/Row**: Flex layout sistemi
   - **Stack**: Overlay positioning
   - **Responsive Design**: MediaQuery ile ekran uyumu

### 3. **State Management**
   - **setState()**: Widget state güncelleme
   - **Stateful Lifecycle**: initState, build, dispose
   - **Event Handling**: onPressed, user interactions

### 4. **Dart Programming**
   - **String Manipulation**: StringBuffer, substring operations
   - **List Operations**: Dynamic list management
   - **Exception Handling**: try-catch blokları
   - **Parsing Algorithms**: Custom string parsing

### 5. **UI/UX Principles**
   - **Material Design**: Google'ın tasarım dili
   - **Color Theming**: Tutarlı renk şemaları
   - **Typography**: Font sizing ve styling
   - **User Feedback**: Visual ve console feedback

### 6. **Mathematical Computing**
   - **Expression Parsing**: String to math conversion
   - **Operation Precedence**: Matematik işlem önceliği
   - **Floating Point**: Decimal number handling
   - **Error Handling**: Division by zero, invalid inputs

## 📋 Teknik Detaylar

### Kullanılan Technologies
- **Flutter SDK**: 3.16.0+
- **Dart**: 3.2.0+
- **Material Design**: Google UI framework
- **Platform Support**: Android, iOS, Web, Desktop

### Color Scheme
- **Primary**: `Color.fromARGB(255, 96, 125, 139)` (Blue Grey)
- **Secondary**: `Color.fromARGB(255, 55, 71, 79)` (Dark Grey)
- **Accent**: `Color.fromARGB(255, 98, 98, 0)` (Olive)
- **Error**: `Color.fromARGB(255, 163, 50, 54)` (Red)

### Widget Architecture
```
MaterialApp
├── Scaffold
│   ├── AppBar
│   └── Body
│       ├── Stack (Display area)
│       └── Container (Button grid)
│           └── Wrap (Responsive buttons)
```

## 🚀 İleri Seviye Özellikler

### Calculator App Algoritması
1. **Tokenization**: Expression'ı sayı ve operatörlere ayırma
2. **Precedence Handling**: Çarpma/bölme önceliği
3. **Sign Management**: Negatif sayı desteği
4. **Error Prevention**: Güvenli parsing ve hesaplama

### Responsive Design Pattern
- **MediaQuery**: Ekran boyutu algılama
- **Flexible Sizing**: Dinamik widget boyutlandırma
- **Orientation Support**: Portre/landscape uyumu
