---
title: Apa itu Nginx
layout: learning
author: iqbwl
---
## Apa sih Nginx itu?

Nginx ini merupakan perangkat lunak yang berfungsi sebagai layanan HTTP dan reverse proxy.

Nginx ini dikembangkan oleh Igor Sysoev untuk menjawab permasalahan C10k (ten thousand connections). Ten thousand connections ini merupakan tantangan yang dihadapi server ketika harus menangani atau mengelola sepuluh ribu koneksi diwaktu yang bersamaan.

Nginx juga dapat digunakan sebagai load balancer, singkatnya Nginx ini berperan sebagai pembagi beban. Nginx akan mengatur beban berdasarkan kriteria yang sudah ditentukan.


## Cara kerja Nginx

Seperti yang disinggung pada pembahasan sebelumnya mengenai nginx sebagai jawaban atas Ten thousand connections problem, Nginx bekerja menggunakan apa yang disebut sebagai “an asynchronous event-driven architecture”.

Jika web server tradisional menjadikan setiap request pengguna sebagai proses baru dan tunggal, maka Nginx ini merespon banyak request dalam 1 worker process. Setiap worker process akan meneruskan request ke master process dan memberikan respon berupa output/tampilan yang diminta.

Dengan cara kerja tersebut, sangat memungkinkan bagi nginx untuk menangani atau mengelola ribuan koneksi dalam waktu yang bersamaan.