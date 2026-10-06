# Employee Attrition Analysis
Portfolio pembelajaran Data Analyst: Python, SQLite, visualisasi, dan logistic regression.

## Tujuan
Memahami proporsi attrition dan asosiasi karakteristik pekerjaan, lalu mengusulkan hipotesis retensi untuk diuji.
Dataset fiktif, bukan tenaga kerja IBM sebenarnya. Hasil tidak membuktikan sebab-akibat.

## Data
Sumber: https://www.kaggle.com/datasets/pavansubhasht/ibm-hr-analytics-attrition-dataset
Validasi menggunakan mirror: https://github.com/b1gvini/ibm-hr-analytics-attrition-dataset
Raw: 1470 rows × 35 columns; cleaned: 1470 × 31.
Drop EmployeeCount, Over18, StandardHours, EmployeeNumber. SHA256 CSV: `a5c31e38bd7fafc9bc333884eb181b06b41b8e5e488e8f7ccb27199fb3be7659`.

## Cara menjalankan
1. Buka `notebooks/Employee_Attrition_Analysis_Final.ipynb` di Google Colab.
2. Runtime Python → Run all → upload satu CSV/ZIP dari sumber; atau pilih opsi Google Drive pada cell input.
3. Jalankan hingga export. Hasil dapat diunduh dalam ZIP pada cell terakhir.
4. Untuk Jupyter lokal: install requirements, pilih INPUT_MODE='local', isi path relatif CSV.

## Temuan dan rekomendasi
### Temuan utama
- **Keseluruhan:** 237/1470 observasi berlabel Yes (16.12%).
- **Lembur:** Yes 30.53% (n=416, exits=127), dibanding No 10.44% (n=1054, exits=110). Selisih 20.09 pp; asosiasi belum mengendalikan semua faktor.
- **Peran pekerjaan:** Sales Representative memiliki proporsi tertinggi di antara peran dengan n ≥ 50: 39.76% (n=83). Batas n ini membantu menghindari prioritas hanya karena kelompok sangat kecil.
- **Masa kerja 0–2 tahun:** 29.82% (n=342). Bandingkan dengan kelompok lain pada tabel; jangan menyimpulkan efek onboarding tanpa data intervensi.

### Rencana tindak lanjut
| Prioritas | Hipotesis / tindakan | Owner | Pengukuran setelah data riil tersedia |
|---|---|---|---|
| 1 | Audit beban kerja dan jadwal lembur; wawancara sukarela untuk memahami konteks | HRBP + manajer | Jam lembur, kepuasan, proporsi keluar dalam periode yang jelas |
| 2 | Tinjau pengalaman kerja pada peran yang menonjol; bedakan workload, jenjang, dan kompensasi | HR analytics | Perbandingan segmen sebanding, ukuran sampel, interval ketidakpastian |
| 3 | Uji dukungan onboarding/mentoring untuk masa kerja awal | Learning & Development | Retensi cohort 6/12 bulan dan feedback; tetapkan baseline sebelum pilot |

Jika layak, evaluasi pilot dengan kelompok pembanding dan desain yang disepakati; dataset saat ini tidak dapat menghitung ROI atau penurunan resign akibat program. Data demografi digunakan untuk audit representasi, bukan pembatasan kesempatan kerja.


## Evaluasi model
Split stratified 60/20/20, seed 42, 5-fold CV pada train, threshold dipilih pada validation.
Baseline Dummy majority; preprocessing berada di pipeline. Ordinal di-one-hot.
**Hasil test:** threshold validation 0.27, precision 0.287, recall 0.787, F1 0.420, ROC-AUC 0.835, AP 0.622 (prevalensi test 0.160).

Pada threshold terpilih terdapat **92 false positive dan 10 false negative**. Dibanding threshold 0.5, recall berubah dari 0.723 menjadi 0.787, tetapi precision dari 0.420 menjadi 0.287 dan F1 dari 0.531 menjadi 0.420. Jadi prioritas F2 pada validation tidak membuat semua metrik test lebih baik; keputusan operasional memerlukan biaya kesalahan dan kapasitas tindak lanjut yang nyata.

Recall yang lebih tinggi perlu dibaca bersama false positive. AP/ROC-AUC mengukur ranking, bukan dampak program retensi. Model belum layak dipakai untuk keputusan HR individual; threshold dan kalibrasi memerlukan validasi pada data nyata serta tujuan yang disepakati.

## Limitations
Tidak ada tanggal/horizon prediksi, data fiktif, sampel kecil, kemungkinan confounding/proxy.
EDA melihat keseluruhan data; test hanya evaluasi internal pembelajaran.
Belum ada validasi eksternal, fairness, kalibrasi atau pengukuran dampak bisnis.

## Struktur
`notebooks/`, `data/processed/`, `reports/`, `sql/`, dan `requirements.txt`.
Pemilik: [isi nama]. Repository: [isi URL]. Tinjau ketentuan sumber sebelum membagikan CSV.
Versi eksekusi: {"python": "3.12.14", "pandas": "3.0.6", "numpy": "2.5.3", "sklearn": "1.9.1"}.
