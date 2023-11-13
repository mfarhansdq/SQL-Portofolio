-- Dataset: MySkill SQL for Data Analysis Project 
-- Link Dataset: https://drive.google.com/file/d/1ln9B8f2ryOWUK73eCipoGMKDE5lVTw50/view?usp=drive_link
-- Query used: MySQL Workbench, postgreSQL

select * from umkm_jabar;

select min(jumlah_umkm) as min, max(jumlah_umkm) as max from umkm_jabar;

-- CTE DENGAN MEM-FILTER KETERANGAN UMKM BERDASARKAN JUMLAHNYA
with cte_keterangan_umkm as (
	select *,
		case 
        when jumlah_umkm < 30000 then 'Belum Memenuhi'
        when jumlah_umkm >= 30000 and jumlah_umkm < 80000 then 'Mulai Berkembang'
		when jumlah_umkm >= 80000 and jumlah_umkm < 100000 then 'Sudah Bertumbuh'
		when jumlah_umkm >= 100000 then 'Sudah Terpenuhi'
        end as keterangan_umkm
from umkm_jabar
)
select * from cte_keterangan_umkm where jumlah_umkm <= 20000;

-- CTE MENCARI JUMLAH UMKM BERDASARKAN DAERAH BOGOR PADA TAHUN 2020 DAN 2021
with cte_bogor_detail as (
	select kategori_usaha, sum(jumlah_umkm), tahun 
    from umkm_jabar
    where nama_kabupaten_kota like '%bogor%' and tahun = 2020 OR tahun = 2021
    group by kategori_usaha, tahun
)
select * from cte_bogor_detail;
