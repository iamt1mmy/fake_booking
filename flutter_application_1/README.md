
# Travel App (flutter_application_1)

Acest proiect este o aplicație demo Flutter care afișează o listă de destinații turistice,
o pagină de detaliu pentru fiecare destinație și funcționalități de căutare, sortare și comutare temă.

**Scurtă prezentare**
- Limbaj: Dart
- Framework: Flutter
- Scop: demo UI pentru listare de destinații, navigare și teme (light/dark)

**Funcționalități principale**
- Listă de destinații cu imagine, locație și rating.
- Căutare live pe titlu și locație.
- Sortare după rating sau nume (asc/desc).
- Navigare la ecran de detalii cu bară expandabilă (SliverAppBar).
- Comutare temă light/dark din AppBar.

**Dependențe**
- `flutter` (SDK) — folosit implicit
- `cupertino_icons` — iconițe iOS

## Structura proiectului (importante)

- `lib/main.dart` — punctul de intrare; `MyApp` gestionează `ThemeMode` și furnizează `HomeScreen`.
- `lib/models/destination.dart` — model simplu `Destination` (title, location, description, imageUrl, rating).
- `lib/data/destinations_data.dart` — listă hardcodata `destinations` folosită pentru demo (imaginele provin din URL-uri externe).
- `lib/widgets/destination_card.dart` — `CustomDestinationCard` afișează imagine, titlu, locație și rating; navighează la `DetailScreen` la tap.
- `lib/screens/home_screen.dart` — ecranul principal cu căutare, sortare și listă.
- `lib/screens/detail_screen.dart` — ecranul de detalii, folosește `SliverAppBar` cu imagine și conținut scrollabil.

Alte foldere generate de Flutter: `android/`, `ios/`, `web/`, `windows/`, `macos/`, `linux/`.

## Observații despre date și imagini
- Datele sunt hardcodate în `lib/data/destinations_data.dart` pentru ușurința demo-ului.
- Imaginile sunt încărcate prin `Image.network(...)`. Pe web sau în medii restricționate, încărcarea poate eșua din cauza politicilor CORS sau a URL-urilor invalide.
- Sugestie: folosiți pachetul `cached_network_image` pentru caching și afișare mai robustă a imaginilor.

## Cum rulezi local

1. Deschide un terminal în directorul proiectului (`flutter_application_1`).

2. Obține dependențele:

```bash
flutter pub get
```

3. Rulează aplicația pe un dispozitiv conectat sau emulator:

```bash
flutter run
```

4. Pentru a construi APK (Android):

```bash
flutter build apk --release
```

Pentru iOS, folosește `flutter build ios` și deschide proiectul în Xcode (macOS necesar).

## Testare și formatare
- Rulează testele (dacă le adaugi):

```bash
flutter test
```

- Formatează codul:

```bash
dart format .
```

## Comentarii în cod
- Am adăugat comentarii `///` de documentație pentru clase și metode principale în `lib/`.
- Am adăugat comentarii `//` acolo unde logica e mai puțin evidentă (de ex. sortare, errorBuilder pentru imagini).

## Posibile îmbunătățiri
- Persistența temei (ex: salvare în `SharedPreferences` sau `hydrated_bloc`) pentru a păstra preferința utilizatorului.
- Înlocuirea datelor hardcodate cu un API REST sau GraphQL și adăugarea paginării.
- Folosirea `cached_network_image` pentru caching și placeholder-uri.
- Adăugarea testelor widget/integrate.
- Localizare (i18n) pentru limba interfeței.

## Probleme cunoscute / atenționări
- Depinde de conexiunea la Internet pentru imaginile externe.
- Fișierele sunt scrise pentru Flutter SDK `sdk: ^3.10.1` (vezi `pubspec.yaml`).

## Următorii pași sugerați
1. Vrei să commit aceste schimbări? Pot să fac eu un `git commit` (`git` trebuie configurat în workspace).
2. Vrei să adaug `cached_network_image` și să înlocuiesc `Image.network` cu un placeholder? Pot implementa asta.

---
Documentația a fost generată după analiza fișierelor din `lib/` și `pubspec.yaml`.

Dacă dorești, pot extinde README cu diagrame simple sau cu instrucțiuni de contribuție.
