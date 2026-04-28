# Flutter Employee Manager

Aplikasi manajemen karyawan berbasis Flutter dengan autentikasi, CRUD karyawan, dan arsitektur Clean Architecture + BLoC.

## Download APK

[⬇️ Download APK (app-release.apk)](files/app-release.apk)

### Account
user: demo
pass: test1234

---

## Fitur

- **Login / Logout** — Autentikasi berbasis username & password dengan penyimpanan sesi di SharedPreferences
- **Daftar Karyawan** — Menampilkan semua karyawan dengan pull-to-refresh
- **Detail Karyawan** — Melihat informasi lengkap karyawan (nama, email, telepon, website, perusahaan)
- **Tambah Karyawan** — Form dengan validasi input
- **Edit Karyawan** — Pre-fill form dari data yang sudah ada
- **Hapus Karyawan** — Konfirmasi dialog sebelum menghapus
- **Auth Guard** — Redirect otomatis ke halaman login jika belum terautentikasi

---

## Arsitektur

Proyek menggunakan **Clean Architecture** dengan tiga lapisan:

```
UI Layer       → Screens, Widgets
Domain Layer   → Cubits, Repository interfaces
Data Layer     → ApiClient (HTTP), CacheClient (SharedPreferences)
```

**State Management:** `flutter_bloc` (Cubit)  
**Routing:** `go_router` dengan redirect guard  
**DI:** Manual constructor injection

---

## Tech Stack

| Kategori | Library |
|---|---|
| State Management | `flutter_bloc ^9.1.1` |
| Routing | `go_router ^17.2.2` |
| Model | `equatable ^2.0.8` |
| Storage | `shared_preferences ^2.5.5` |
| HTTP | `http ^1.6.0` |
| Testing | `mockito ^5.4.4`, `bloc_test ^10.0.0` |

---

## Struktur Proyek

```
lib/
├── main.dart
└── src/
    ├── app.dart
    ├── app_router.dart
    ├── common/
    │   ├── constant/        # URL, CacheKey, ApiException, AppValidator
    │   └── model/           # Employee, EmployeeData, User, UserData
    └── core/
        ├── client/          # ApiClient, CacheClient
        ├── cubit/           # AuthenticationDataCubit, EmployeeListCubit, dll.
        └── repository/      # AuthenticationRepository, EmployeeRepository
```

---

## Menjalankan Proyek

```bash
# Install dependencies
flutter pub get

# Generate mock files (untuk testing)
dart run build_runner build --delete-conflicting-outputs

# Jalankan aplikasi
flutter run

# Jalankan semua test
flutter test

# Cek lint
flutter analyze
```

---

## Testing

67 unit test tersedia, mencakup:

- **Model tests** — `Employee`, `EmployeeData`, `User`, `UserData` (fromJson, toJson, round-trip)
- **Validator tests** — `AppValidator` (required, email, password)
- **Cubit tests** — `AuthenticationActionCubit`, `AuthenticationDataCubit`, `EmployeeListCubit`, `CreateEmployeeCubit`, `DeleteEmployeeCubit`
- **Repository tests** — `AuthenticationRepository`, `EmployeeRepository`

```
✓ 67 tests passed
✓ 0 lint issues
```

---

## API

Menggunakan custom REST API di `https://reqres.in/api/collections` dengan `project_id` sebagai query parameter.

| Endpoint | Method | Keterangan |
|---|---|---|
| `/login/records` | GET | Fetch semua login records, match client-side |
| `/employee/records` | GET | Daftar semua karyawan |
| `/employee/records/:id` | GET | Detail karyawan |
| `/employee/records` | POST | Tambah karyawan |
| `/employee/records/:id` | PUT | Edit karyawan |
| `/employee/records/:id` | DELETE | Hapus karyawan |
