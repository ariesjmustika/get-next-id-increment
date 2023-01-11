
// mendapatkan tangggal yang belum ada 2022-11-28 sampai sekarang
SELECT DATE(checktime) as tanggal FROM checkinout WHERE DATE(checktime) BETWEEN '2022-11-28' AND CURDATE() GROUP BY tanggal

// untuk checking userid checktype nya double 0 atau 1 
SELECT userid, checktime, checktype FROM `checkinout` WHERE DATE(checktime)='2022-11-28' 
ORDER BY `checkinout`.`userid`  ASC

// buat nge cek siapa saja yang absen pada hari tertentu
SELECT userid, checktime, checktype FROM `checkinout` WHERE DATE(checktime)='2022-11-28' GROUP BY userid
ORDER BY `checkinout`.`userid`  ASC 


// asumsi kalau alat bener (2022-11-28 ganti sesuai tanggal yang di perlukan untuk di posting ke absensi_ho)
INSERT INTO absensi_ho (id_user, date_absen, in_time, in_ket, in_ip, in_loc, rest_time, rest_ket, rest_ip, rest_loc, done_rest_time, done_rest_ket, done_rest_ip, done_rest_loc, gohome_time, gohome_ket, gohome_ip, gohome_loc, mesin, ket)
SELECT c.userid as id_user, DATE(c.checktime) AS date_absen, c.checktime AS in_time,
CONCAT('hadir') AS in_ket, CONCAT('') AS in_ip, CONCAT('') AS in_loc, CONCAT('0000-00-00 00:00:00') AS rest_time, CONCAT('') AS rest_ket, CONCAT('') AS rest_ip, 
CONCAT('') AS rest_loc, CONCAT('0000-00-00 00:00:00') AS done_time,  CONCAT('') AS done_rest_ket, CONCAT('') AS done_rest_ip,CONCAT('') AS done_rest_loc,
(SELECT cc.checktime FROM checkinout cc  WHERE cc.userid=c.userid AND DATE(cc.checktime)='2022-11-28' AND cc.checktype=1 ORDER BY cc.userid) AS gohome_time,
CASE 
WHEN (SELECT cc.checktime FROM checkinout cc  WHERE cc.userid=c.userid AND DATE(cc.checktime)='2022-11-28' AND cc.checktype=1 ORDER BY cc.userid) IS NULL THEN ''
ELSE 'pulang' 
END as gohome_ket, CONCAT('') AS gohome_ip, CONCAT('') AS gohome_loc, CONCAT('1') AS mesin, CONCAT('WFO') AS ket

FROM checkinout c
WHERE DATE(c.checktime)='2022-11-28' AND c.checktype=0 
GROUP BY c.userid
ORDER BY in_time ASC


// UNTUK KASUS SUBQUERY error (2022-11-28 ganti sesuai tanggal yang di perlukan untuk di posting ke absensi_ho)
INSERT INTO absensi_ho (id_user, date_absen, in_time, in_ket, in_ip, in_loc, rest_time, rest_ket, rest_ip, rest_loc, done_rest_time, done_rest_ket, done_rest_ip, done_rest_loc, gohome_time, gohome_ket, gohome_ip, gohome_loc, mesin, ket)
SELECT c.userid as id_user, DATE(c.checktime) AS date_absen, c.checktime AS in_time,
CONCAT('hadir') AS in_ket, CONCAT('') AS in_ip, CONCAT('') AS in_loc, CONCAT('0000-00-00 00:00:00') AS rest_time, CONCAT('') AS rest_ket, CONCAT('') AS rest_ip, 
CONCAT('') AS rest_loc, CONCAT('0000-00-00 00:00:00') AS done_time,  CONCAT('') AS done_rest_ket, CONCAT('') AS done_rest_ip,CONCAT('') AS done_rest_loc,
(SELECT cc.checktime FROM checkinout cc  WHERE cc.userid=c.userid AND DATE(cc.checktime)='2022-11-28' AND cc.checktype=1 ORDER BY cc.id DESC LIMIT 1) AS gohome_time,
CASE 
WHEN (SELECT cc.checktime FROM checkinout cc  WHERE cc.userid=c.userid AND DATE(cc.checktime)='2022-11-28' AND cc.checktype=1 ORDER BY cc.id DESC LIMIT 1) IS NULL THEN ''
ELSE 'pulang' 
END as gohome_ket, CONCAT('') AS gohome_ip, CONCAT('') AS gohome_loc, CONCAT('1') AS mesin, CONCAT('WFO') AS ket

FROM checkinout c
WHERE DATE(c.checktime)='2022-11-28' AND c.checktype=0  ORDER BY in_time ASC



// STATUS DATA YANG SUDAH DI TRANSFER DARI checkinout ke absensi_ho
2022-11-28 68 row added (aman)
2022-11-29 76 row added
2022-11-30 72 row added
2022-12-01 73 row added
2022-12-02 74 row added
2022-12-04 1 row added Sugiyo
2022-12-05 82 row added
2022-12-06 82 row added
2022-12-07 81 row added
2022-12-08 109 row ada yang pulang checktype nya 0
2022-12-08 aman
2022-12-11 1 row aman sugiyo doang
2022-12-12 ada subquery double (udah di handle udah masuk ke database)
2022-12-13 82 row aman gada yang double
2022-12-14 84 row  aman gada double datas
2022-12-15 82 row aman gada double
2022-12-16 75 row aman gada double
2022-12-18 0 row 87 2022-12-18 17:51:12 checktype 1  || gagal ke create(data cuman satu)
2022-12-19 81 row  double 96 2022-12-19 08:24:12  2022-12-19 14:32:35 //  65 double  2022-12-19 08:22:16   2022-12-19 17:30:09
2022-12-20 79 row added  double 50 double(0),  42 single(1), 34 single(1),  // 80 masuk 
2022-12-21 79 row belum di cek
2022-12-22 78 row added
2022-12-23 75 row added
2022-12-26 68 row added aman
2022-12-27 68 row added aman

TRIGGER udah di update ke absensi_ho (bukan ke absensi_ho_testing lagi)



// UNTUK INSERT data absensi yang hanya absen pulang aja
INSERT INTO absensi_ho (id_user, date_absen, in_time, in_ket, in_ip, in_loc, rest_time, rest_ket, rest_ip, rest_loc, done_rest_time, done_rest_ket, done_rest_ip, done_rest_loc, gohome_time, gohome_ket, gohome_ip, gohome_loc, mesin, ket)
SELECT c.userid as id_user, DATE(c.checktime) AS date_absen, CONCAT('0000-00-00 00:00:00') AS in_time,
CONCAT('hadir') AS in_ket, CONCAT('') AS in_ip, CONCAT('') AS in_loc, CONCAT('0000-00-00 00:00:00') AS rest_time, CONCAT('') AS rest_ket, CONCAT('') AS rest_ip, 
CONCAT('') AS rest_loc, CONCAT('0000-00-00 00:00:00') AS done_time,  CONCAT('') AS done_rest_ket, CONCAT('') AS done_rest_ip,CONCAT('') AS done_rest_loc,
c.checktime AS gohome_time,
CONCAT('pulang') as gohome_ket, CONCAT('') AS gohome_ip, CONCAT('') AS gohome_loc, CONCAT('1') AS mesin, CONCAT('WFO') AS ket

FROM checkinout c
WHERE DATE(c.checktime)='2023-01-10' AND c.checktype=1 AND c.userid IN (52, 118, 116)





