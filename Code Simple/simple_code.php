<!-- Mendapatkan next id auto increment (perfect solution for last record deleted) :) -->
$statement = DB::select("SHOW TABLE STATUS LIKE 'data_jamaah'");
$nextId = $statement[0] -> Auto_increment;