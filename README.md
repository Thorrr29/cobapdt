# edutrack

![Home](src/home.png)

Edutrack ini merupaka sebuah aplikasi sistem pemesanan kursus online sederhana yang dibuat dengan menggunakan PHP dan MySQL. Tujuannya adalah untuk melihat kursus yang ada dan mendaftar kursus lalu membayarnya dengan aman dan terstruktur, dengan menerapkan stored procedure, trigger, transaction, dan stored function. Sistem ini juga dilengkapi dengan mekanisme backup otomatis untuk menjaga keamanan data pengguna jika terjadi sebuah kesalahan sistem.

![Home](src/home.png)

# Detail Konsep

## Stored Procedure

![WhatsApp Image 2025-06-13 at 22 06 24_e91cea25](https://github.com/user-attachments/assets/d29b8186-ee74-4a45-a701-a45b128f3a1a)

Querry : 
![Screenshot 2025-06-13 205903](https://github.com/user-attachments/assets/c7436cf6-53e0-413f-92c6-647855c32fba)

## Trigger

![WhatsApp Image 2025-06-13 at 22 09 13_3c880887](https://github.com/user-attachments/assets/848ce0df-7b96-4bb6-8f44-bd5c1d7106a6)

Querry : 
![Screenshot 2025-06-13 205727](https://github.com/user-attachments/assets/b9550f68-67f0-4711-ac03-23157257baaa)
![image](https://github.com/user-attachments/assets/e4d321a1-7f27-464e-a573-42c03b25a315)

## Transaction

## Stored Function
Querry:
![Screenshot 2025-06-13 220938](https://github.com/user-attachments/assets/9bb5e7e4-14fe-4704-9f9b-df6b4876c36c)

![image](https://github.com/user-attachments/assets/93346451-eb95-48f5-a6e2-92234c08e6df)
Function TotalPaidByCourse untuk menghitung jumlah nominal uang yang telah dibayar untuk kursus tertentu. Berikut adalah cara untuk menampilkan Riwayat Pembayaran dengan menggunakan CALL Function:

![image](https://github.com/user-attachments/assets/22b654a6-1732-4e80-802d-9c3fbb46f667)
![image](https://github.com/user-attachments/assets/7b0d34f3-2fd7-4ba0-8664-dea37d134ae6)


## Backup Database
Backup database pada sistem web ini berfungsi untuk melindungi data transaksi agar tidak hilang akibat kerusakan sistem, kesalahan pengguna, atau serangan siber. Dengan backup, data penting seperti riwayat pembayaran, informasi pengguna, dan status transaksi dapat dipulihkan jika terjadi kegagalan sistem, sehingga menjaga keandalan layanan dan keamanan pengguna.
Querry:
![Screenshot 2025-06-14 024009](https://github.com/user-attachments/assets/6eb9b726-3f7b-4e71-be8d-3d54407e3682)

Lalu dilakukan juga TASK SCHEDULER agar backup dapat dilakukan secara otomatis berdasarkan schedule yang sudah ditetapkan (Pada Projek ini Setiap Hari Pukul 00:00 WIB).
Kode:
![image](https://github.com/user-attachments/assets/58b77b55-3f72-4fe0-b38c-160cdb27d1be)
Hasil backup Otomatis: 
![Screenshot 2025-06-14 025645](https://github.com/user-attachments/assets/86391765-ab5a-49d5-bd9e-804421d98e81)


## Relevansi dengan Pemrosesan Data Terdistribusi

