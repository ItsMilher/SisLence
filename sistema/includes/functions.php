<?php
	date_default_timezone_set('America/Lima');

	function fechaPeru(){
		$mes = array("","Enero",
					  "Febrero",
					  "Marzo",
					  "Abril",
					  "Mayo",
					  "Junio",
					  "Julio",
					  "Agosto",
					  "Septiembre",
					  "Octubre",
					  "Noviembre",
					  "Diciembre");

		// $dia=array("Lunes",
		// 			  "Martes",
		// 			  "Miércoles",
		// 			  "Jueves",
		// 			  "Viernes",
		// 			  "Sábado",
		// 			  "Domingo");
					 return // $dia[date('w')]."  ".
					date('d')." de ". $mes[date('n')] . " de " . date('Y');
					}

 ?>
