# sayakaya_test

Cukup clone lalu flutter pub get untuk bisa menjalankan applikasi-nya

## Technology dan package yang digunakan
1. State Management menggunakan BLOC
2. Routing menggunakan GETX
3. Charting menggunakan FL_CHART
4. Graphql request menggunakan graphql_flutter

## Fitur yang terdapat dalam applikasi
1. Homepage akan menampilkan data terbaru dunia kasus covid terbaru
2. list country akan menampilkan keseluruhan negara yang ada beserta rangkuman singkat jumlah kasus barunya
3. ketika memilih salah satu negara maka akan terdapat chart untuk hari ini, kemarin, dan kemarin lusa untuk kasus covid terbaru dinegara tersebut
4. di bawah dari chart terdapat data lengkap 3 hari kasus COVID. mulai dari jumlah test, kematian, kasus baru, dll.
5. error handling saat terjadi limitasi dengan server, sumber API nya sangat terbatas dalam jumlah akses, sehingga sering sekali mendapatkan error dan data tidak muncul sehingga harus dihandle errornya dan memunculkan pop up
6. melakukan sorting dari tertinggi ke terendah berdasarkan beberapa category, misalnya, jumlah case baru, jumlah kematian tertinggi, jumlah test tertinggi dan lainnya
