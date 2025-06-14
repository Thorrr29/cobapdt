# edutrack

![Home](src/home.png)

Edutrack ini merupaka sebuah aplikasi sistem pemesanan kursus online sederhana yang dibuat dengan menggunakan PHP dan MySQL. Tujuannya adalah untuk melihat kursus yang ada dan mendaftar kursus lalu membayarnya dengan aman dan terstruktur, dengan menerapkan stored procedure, trigger, transaction, dan stored function. Sistem ini juga dilengkapi dengan mekanisme backup otomatis untuk menjaga keamanan data pengguna jika terjadi sebuah kesalahan sistem.

# Detail Konsep

## Stored Procedure
Stored procedure adalah sekumpulan perintah SQL yang disimpan di dalam database dan dapat dijalankan (dipanggil) berkali-kali. Dalam sistem (EduTrack), stored procedure digunakan untuk menangani proses seperti pendaftaran kursus, pembayaran, atau cek status kursus secara efisien dan aman.
![WhatsApp Image 2025-06-13 at 22 06 24_e91cea25](https://github.com/user-attachments/assets/d29b8186-ee74-4a45-a701-a45b128f3a1a)

Querry : 

![Screenshot 2025-06-13 205903](https://github.com/user-attachments/assets/c7436cf6-53e0-413f-92c6-647855c32fba)

## Trigger

![WhatsApp Image 2025-06-13 at 22 09 13_3c880887](https://github.com/user-attachments/assets/848ce0df-7b96-4bb6-8f44-bd5c1d7106a6)

Querry : 

![Screenshot 2025-06-13 205727](https://github.com/user-attachments/assets/b9550f68-67f0-4711-ac03-23157257baaa)

Trigger akan mengubah status pada tabel enrollment lalu akan menampilkan status yang sudah di update pada web
![image](https://github.com/user-attachments/assets/e4d321a1-7f27-464e-a573-42c03b25a315)
![image](https://github.com/user-attachments/assets/f53a7e22-cfae-445d-83d8-753c3152ae39)


## Transaction
![image](https://github.com/user-attachments/assets/e3610dd3-08f4-416e-8080-4415cbeebea1)

Dalam sistem pemesanan kursus online ini, prinsip transaksi juga sangat penting seperti halnya di sistem perbankan. Misalnya, saat pengguna melakukan pembayaran untuk mendaftar ke sebuah kursus, prosesnya tidak hanya mencatat nominal pembayaran, tetapi juga memverifikasi status pendaftaran dan memastikan bahwa pembayaran belum dilakukan sebelumnya. Proses ini dibungkus dalam beginTransaction() dan commit() untuk menjamin bahwa semua langkah berjalan tuntas. Jika terjadi masalah, seperti data pembayaran gagal disimpan atau kursus sudah dibayar sebelumnya, maka rollback() akan dijalankan untuk membatalkan seluruh proses. Dengan begitu, sistem mencegah kondisi tidak konsisten, seperti pembayaran tercatat tetapi status kursus tetap belum aktif.

## Stored Function
Querry:

![Screenshot 2025-06-13 220938](https://github.com/user-attachments/assets/9bb5e7e4-14fe-4704-9f9b-df6b4876c36c)

![image](https://github.com/user-attachments/assets/93346451-eb95-48f5-a6e2-92234c08e6df)

Function TotalPaidByCourse untuk menghitung jumlah nominal uang yang telah dibayar untuk kursus tertentu. Berikut adalah cara untuk menampilkan Riwayat Pembayaran dengan menggunakan CALL Function:

![image](https://github.com/user-attachments/assets/22b654a6-1732-4e80-802d-9c3fbb46f667)
![image](https://github.com/user-attachments/assets/7b0d34f3-2fd7-4ba0-8664-dea37d134ae6)


## Backup Database
Backup database pada sistem web ini berfungsi untuk melindungi data transaksi agar tidak hilang akibat kerusakan sistem, kesalahan pengguna, atau serangan siber. Dengan backup, data penting seperti riwayat pembayaran, informasi pengguna, dan status transaksi dapat dipulihkan jika terjadi kegagalan sistem, sehingga menjaga keandalan layanan dan keamanan pengguna. Pada sistem ini, admin yang akan melakukan backup secara berkala, namun juga ada Task Scheduler yang akan melakukan backup secara otomatis

Querry:

![Screenshot 2025-06-14 024009](https://github.com/user-attachments/assets/6eb9b726-3f7b-4e71-be8d-3d54407e3682)

Hasil Backup Manual oleh Admin :

![image](https://github.com/user-attachments/assets/5a4129a0-7dc8-48f6-898e-4dac7faad672)
![image](https://github.com/user-attachments/assets/f7845ab6-b060-4c8e-986c-654efbd9f015)


Lalu dilakukan juga TASK SCHEDULER agar backup dapat dilakukan secara otomatis berdasarkan schedule yang sudah ditetapkan (Pada Projek ini Setiap Hari Pukul 00:00 WIB).

Kode:

![image](https://github.com/user-attachments/assets/58b77b55-3f72-4fe0-b38c-160cdb27d1be)

Hasil backup Otomatis: 

![Screenshot 2025-06-14 025645](https://github.com/user-attachments/assets/86391765-ab5a-49d5-bd9e-804421d98e81)


## Relevansi dengan Pemrosesan Data Terdistribusi
Sistem EduTrack dirancang dengan mempertimbangkan prinsip-prinsip dasar pemrosesan data terdistribusi, agar dapat melayani banyak pengguna secara serentak dan tetap menjaga keandalan sistem:

- Konsistensi: Proses pendaftaran kursus, pembayaran, dan pengelolaan data dilakukan melalui stored procedure agar setiap transaksi memiliki aturan yang sama, terpusat di sisi database.

- Reliabilitas: Pemanfaatan trigger dan transaction membantu sistem tetap berjalan aman dan benar, bahkan ketika terjadi interupsi jaringan atau kesalahan sistem.

- Integritas: Karena logika aplikasi disimpan langsung di database, hasil dan validasi tetap konsisten meskipun diakses dari berbagai platform seperti web, API, atau panel admin.

