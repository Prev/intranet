<?php

	class SnackCalendarView extends View {

		public function dispCalendar() {
			echo 	'<style>
					.calendar_period{background-color:#fff; clear:both;padding:11px 0 23px}
					.calendar_period a{display:inline-block;margin:-1px -1px 0;padding:1px;vertical-align:middle}
					.calendar_period strong{display:inline-block;width:83px;font-family:verdana;font-size:13px;color:#333;line-height:15px;text-align:center}
					.calendar_period a.close{display:inline-block;}
					table{width:168px;padding:0px 0px 11px 0px;border:0}
					table caption,table thead{display:none}
					table td{padding:0;border:0;width:18px; background:#fff;border:0;border-bottom:3px solid #fff;font-family:verdana,tahoma;font-size:10px;line-height:12px}
					table td.selectable a{background:#fffcb2}
					table td.selected a{background:#e5f2ff}
					table td.today a{background:#7f7f7f;color:#fff}
					table td a{text-decoration:none;display:block;width:24px;height:13px;color:#000;text-align:center;letter-spacing:-1px}
					table td.sun a{color:#f00}
					table td.sat a{color:#00f}
					table td.weekday {font-size:13px;}
					</style>
					<table>';

			$year = $_POST['year'];
			$month = $_POST['month'];
			$date = $_POST['date'];
			$todayMonth = date("m");

		    if (!$year)
		    	$year = date("Y");

		    if (!$month)
		    	$month = date("m");

		    if (!$date)
		    	$date = date("d");

			$total_day = date("t", time());
			$first_day = date("w", strtotime($year.'-'.$month."-01"));
			$total_week = (int)ceil(($total_day + $first_day) / 7);
			$last_day = (int)date('w', strtotime($year.'-'.$month."-".$total_day));

			$day = 1;
			for ($i=1; $i <= $total_week; $i++) {
				echo '<tr>';
				for ($j=0; $j<7; $j++) {

					if($i == 1 && $j < $first_day || ($i == $total_week && $j > ($last_day+1)))
						echo '<td>';

					if(!($i == 1 && $j < $first_day) || ($i == $total_week && $j > $last_day)) {
						
						if($day > 31)
							break;

						if($j == 0)
							echo '<td class="sun">';

						if($j == 6)
							echo'<td class="sat">';

						if($j != 0 && $j != 6 && $day >= $period_str[2] && $day <= $period_end[2])
				        	echo '<td class="selected">';

						if($j != 0 && $j != 6 && !($day >= $period_str[2] && $day <= $period_end[2]))
							echo '<td>';

						if($day == date('j') && $todayMonth == $month) {
							echo "<strong><a href=\"#\">$day</a></strong>";
						} else {
							echo "<a href=\"#\">$day</a>";
						}

						$day++;
					}
					echo '</td>';
				}
				echo '</tr>';
			}
			echo '</table>';
		}

	}

?>