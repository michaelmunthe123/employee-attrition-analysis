# Employee Attrition Analysis

Project portfolio **Michael Munthe** untuk menganalisis employee attrition menggunakan Python, SQL, visualisasi, dan machine learning ringan.

📓 [Buka notebook di Google Colab](https://colab.research.google.com/github/michaelmunthe123/employee-attrition-analysis/blob/main/Employee_Attrition_Analysis_Final.ipynb)  
📂 [Lihat repository](https://github.com/michaelmunthe123/employee-attrition-analysis)

## Tujuan Project

Project ini bertujuan untuk:

- Memahami proporsi attrition dalam dataset.
- Membandingkan karakteristik pekerjaan dan proporsi attrition antarsegmen.
- Menyusun business insights serta rekomendasi untuk investigasi lebih lanjut.
- Mempraktikkan SQL dan mengevaluasi model klasifikasi sederhana terhadap baseline.

Semua temuan menunjukkan **asosiasi, bukan hubungan sebab-akibat**.

## Dataset

Dataset: [IBM HR Analytics Employee Attrition & Performance](https://www.kaggle.com/datasets/pavansubhasht/ibm-hr-analytics-attrition-dataset).

Dataset ini **fiktif dan digunakan untuk pembelajaran**, bukan data tenaga kerja IBM yang sebenarnya.

| Informasi | Nilai |
|---|---|
| Jumlah observasi | 1.470 |
| Jumlah kolom awal | 35 |
| Jumlah kolom setelah cleaning | 31 |
| Target | `Attrition`: Yes / No |
| Label attrition Yes | 237 |
| Proporsi attrition | 16,12% |

Tidak ada periode pengamatan atau tanggal keluar. Karena itu, proporsi tersebut **bukan tingkat turnover tahunan**.

Salinan publik yang digunakan untuk validasi tersedia di [repository dataset](https://github.com/b1gvini/ibm-hr-analytics-attrition-dataset).

## Tools

- **Python:** pandas, NumPy, Matplotlib, Seaborn, scikit-learn.
- **SQL:** SQLite melalui database in-memory di notebook.
- **Environment:** Google Colab atau Jupyter Notebook.

## Struktur Repository

```text
employee-attrition-analysis/
├── README.md
├── Employee_Attrition_Analysis_Final.ipynb
├── analysis.sql
└── requirements.txt
```

| File | Fungsi |
|---|---|
| `Employee_Attrition_Analysis_Final.ipynb` | Analisis lengkap beserta penjelasan, visualisasi, dan hasil eksekusi |
| `analysis.sql` | Query agregasi untuk overall attrition, departemen, lembur, dan masa kerja |
| `requirements.txt` | Library untuk menjalankan analisis secara lokal |
| `README.md` | Ringkasan project dan panduan penggunaan |

## Alur Analisis

1. Business Understanding.
2. Setup dan input dataset.
3. Data Understanding.
4. Data Cleaning dan pemeriksaan kualitas.
5. Exploratory Data Analysis dan visualisasi.
6. SQL serta pengecekan hasil terhadap pandas.
7. Business insights dan rekomendasi.
8. Machine learning ringan dan evaluasi.
9. Limitations dan conclusion.
10. Export hasil dan persiapan GitHub.

## Data Cleaning

Data mentah dipertahankan dan cleaning dilakukan pada salinan.

Pemeriksaan mencakup missing values, duplikat, keunikan ID, rentang kategori ordinal, serta konsistensi durasi kerja. Versi dataset yang digunakan tidak memiliki missing values atau duplikat seluruh baris.

Empat kolom dibuang:

- `EmployeeCount`, `Over18`, dan `StandardHours`: nilainya konstan.
- `EmployeeNumber`: merupakan ID observasi.

Data bersih memiliki **1.470 baris dan 31 kolom**. Nilai ekstrem tidak otomatis dihapus karena dapat merupakan observasi yang valid.

## Temuan Utama

| Segmen | Proporsi attrition | Jumlah observasi |
|---|---:|---:|
| Keseluruhan | 16,12% | 1.470 |
| OverTime = Yes | 30,53% | 416 |
| OverTime = No | 10,44% | 1.054 |
| Sales Representative | 39,76% | 83 |
| Masa kerja 0–2 tahun | 29,82% | 342 |

Kelompok dengan status lembur memiliki proporsi attrition **20,09 poin persentase lebih tinggi** daripada kelompok tanpa lembur.

Sales Representative memiliki proporsi tertinggi di antara peran pekerjaan dengan setidaknya 50 observasi. Temuan ini perlu dibaca bersama ukuran kelompok dan kemungkinan perbedaan karakteristik pekerjaan.

Perbandingan tersebut belum mengendalikan semua faktor lain dan tidak membuktikan penyebab attrition.

## Rekomendasi Bisnis

- **Audit beban kerja dan jadwal lembur:** gunakan wawancara sukarela serta data operasional untuk memahami konteks.
- **Tinjau pengalaman kerja pada peran yang menonjol:** investigasi workload, jenjang karier, dan kompensasi.
- **Uji dukungan onboarding dan mentoring:** evaluasi melalui cohort bertanggal, baseline, serta kelompok pembanding jika memungkinkan.

Rekomendasi ini merupakan hipotesis untuk diuji. Dataset belum dapat membuktikan efektivitas program atau menghitung ROI.

## Machine Learning dan Evaluasi

Model yang digunakan:

- **DummyClassifier:** baseline yang selalu memprediksi kelas mayoritas.
- **Logistic Regression:** model klasifikasi dengan `class_weight='balanced'`.

Data dibagi secara stratified menjadi **60% training, 20% validation, dan 20% test**, dengan random seed 42. Preprocessing berada dalam pipeline; cross-validation dilakukan pada training, dan threshold dipilih dari validation menggunakan F2.

| Model | Precision | Recall | F1 | ROC-AUC | Average Precision |
|---|---:|---:|---:|---:|---:|
| Dummy majority | 0,000 | 0,000 | 0,000 | 0,500 | 0,160 |
| Logistic Regression, threshold 0,50 | 0,420 | 0,723 | 0,531 | 0,835 | 0,622 |
| Logistic Regression, threshold 0,27 | 0,287 | 0,787 | 0,420 | 0,835 | 0,622 |

Threshold 0,27 dipilih berdasarkan validation. Pada test, hasilnya mencakup **92 false positive dan 10 false negative**.

Threshold tersebut meningkatkan recall dibanding 0,50, tetapi menurunkan precision dan F1. Pemilihan threshold operasional memerlukan informasi biaya kesalahan serta kapasitas tindak lanjut.

Model ini merupakan latihan pembelajaran dan **belum layak digunakan untuk keputusan HR individual**.

## Cara Menjalankan

### Google Colab

1. Klik [Buka notebook di Google Colab](https://colab.research.google.com/github/michaelmunthe123/employee-attrition-analysis/blob/main/Employee_Attrition_Analysis_Final.ipynb).
2. Pilih **Runtime → Run all**.
3. Saat diminta, upload satu CSV asli atau ZIP berisi satu CSV dari sumber dataset.
4. Alternatifnya, pilih `INPUT_MODE = 'drive'` dan sesuaikan lokasi CSV di Google Drive.
5. Jalankan sampai bagian export.

Notebook menghasilkan cleaned CSV, tabel analisis, hasil evaluasi model, query SQL, dan metadata validasi. Untuk mengunduh ZIP hasil di Colab, ubah `DOWNLOAD_RESULTS = True` pada cell terakhir dan jalankan cell tersebut.

### Jupyter Lokal

Install library:

```bash
pip install -r requirements.txt
```

Buka notebook, ubah `INPUT_MODE = 'local'`, sesuaikan `LOCAL_CSV` dengan lokasi dataset, lalu jalankan cell secara berurutan.

Query dalam `analysis.sql` menggunakan tabel `employees`, yang dibuat oleh bagian SQL di notebook.

## Validasi

- Seluruh 16 cell kode berhasil dieksekusi secara lokal tanpa error.
- Hasil SQL diperiksa terhadap pandas.
- Tujuh output grafik diperiksa secara visual.
- Jalur input CSV dan ZIP diuji melalui simulasi upload.
- Interaksi upload dan mount Google Drive langsung di Colab belum diuji.

## Limitations

- Dataset fiktif dan berukuran terbatas; temuan bukan benchmark industri.
- Tidak tersedia tanggal, horizon prediksi, atau alasan karyawan keluar.
- Pola dapat dipengaruhi confounding, selection bias, dan banyaknya perbandingan.
- EDA menggunakan keseluruhan data, sehingga evaluasi test merupakan evaluasi internal pembelajaran, bukan validasi eksternal yang sepenuhnya buta.
- Waktu tersedianya fitur sebelum attrition belum dapat dikonfirmasi.
- Belum dilakukan audit fairness, kalibrasi, drift, atau pengukuran dampak bisnis.

## Kesimpulan

Project ini menunjukkan alur analisis dari data mentah hingga insight, SQL, visualisasi, dan evaluasi model. Pola lembur, peran pekerjaan, dan masa kerja memberikan arah investigasi, tetapi pengujian hipotesis retensi memerlukan data riil bertanggal serta desain evaluasi yang sesuai.

## Author

**Michael Munthe**  
[GitHub — michaelmunthe123](https://github.com/michaelmunthe123)
