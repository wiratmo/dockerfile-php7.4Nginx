# 📦 CI3 Docker Setup (PHP-FPM + Nginx + MySQL)

Struktur proyek ini menggunakan Docker untuk menjalankan aplikasi CI3 secara terisolasi dan terpisah antara service: PHP-FPM (CI3), Nginx, dan MySQL.

## 📁 Struktur Direktori
```
.
├── Dockerfile
├── README.md
├── docker-compose.yml
├── init.sh
├── nginx
│   └── default.conf
└── src
    └── README.md

4 directories, 8 files
```

## 🧩 Penjelasan Setiap Bagian

| File/Folder        | Deskripsi Singkat                                                                 |
|--------------------|-----------------------------------------------------------------------------------|
| `Dockerfile`        | Membangun image untuk CI3 berbasis `php:7.4-fpm`, menginstal ekstensi dan Composer |
| `docker-compose.yml` | Menjalankan ketiga service utama (CI3 App, Nginx, MySQL) secara bersamaan     |
| `init.sh`           | Script entrypoint untuk menjalankan `composer install`, migrate, dan `php-fpm`    |
| `nginx/default.conf`| Konfigurasi server Nginx agar bisa meneruskan request ke container CI3        |
| `src/`              | Direktori tempat source code CI3 berada                                       |

## ⚙️ Pengaturan Awal Sebelum Menjalankan Docker

Sebelum menjalankan proyek CI3 dengan Docker, pastikan beberapa hal berikut telah disiapkan dan disesuaikan:

1. **Folder `src/`**
   - Pastikan folder `src/` berisi source code CI3.
   - Jika belum ada, Anda dapat melakukan clone dari repository GitHub menggunakan perintah:
     ```bash
     git clone <url-repo-CI3> src
     ```
   - setup config/database.php
      ```bash
      'hostname' => 'db',
      'username' => 'ceklab_user',
      'password' => 'ceklab_pass',
      'database' => 'ceklab',
      ```

2. **File `Dockerfile`**
   - Sesuaikan versi PHP yang dibutuhkan, misalnya `php:7.4-fpm` atau versi lainnya.
   - Tambahkan dependensi yang diperlukan sesuai kebutuhan proyek menggunakan `apt-get install ...`.

3. **File `docker-compose.yml`**
   - Ubah nama container agar sesuai dengan nama proyek (misalnya `ceklab_app`, `ceklab_db`, dll).
   - Atur environment pada service `db` seperti nama database, username, dan password.
   - Pastikan port pada service `nginx` tidak bentrok dengan container Docker lain (misal: gunakan `9002:80`, `9003:80`, dst.).

4. **File `nginx/default.conf`**
   - Sesuaikan konfigurasi `fastcgi_pass` dengan nama container CI3 yang digunakan pada `docker-compose.yml`.
   - Contoh:
     ```nginx
     fastcgi_pass ceklab_app:9000;
     ```

---

💡 **Tips Tambahan:**
- Gunakan perintah `docker-compose up --build` saat pertama kali menjalankan, agar perubahan pada Dockerfile ikut diterapkan.


## ✅ Cara Menjalankan

```bash
docker-compose up -d --build
```

## ⚙️ Pengaturan CI3

Setelah semua container berjalan, masuk ke dalam container CI3 menggunakan:

```bash
docker exec -it <nama-container> bash
```

contoh

``` bash
docker exec -it ceklab_app bash

