var year, month, captionTitle, calendar;
var dayLists;
var grade;
$(document).ready(function() {
    initCalendar();
	$('.stay-manage-deadline-date').keyup(function(){
		if($(this).val().length == 8)
			convertToDate(this);
	});
});
function initCalendar(){
	var date = new Date();
	year = date.getFullYear();
	month = date.getMonth();
	captionTitle = document.getElementById("calendar-caption-title");
	calendar = document.getElementById("calendar");
	dayLists = new Array('일','월','화','수','목','금','토');
	
	makeCalendar();
}
function changeCalendar(target){
	
	if(captionTitle == null)
		initCalendar();
		
	var firstDate, lastDate, tbody, row, cell;
	
	if(target == 'prev'){
		if(month - 1 < 0){
			year--;
			month=11;	
		}else
			month--;			
	}else{
		if(month + 1 > 11){
			year++;
			month=0;	
		}else
			month++;
	}
	
	makeCalendar();
}

function makeCalendar(){
	var span;
	captionTitle.innerHTML = year + '년 ' + appendZeroMonth(month + 1) + '월';
	firstDate = new Date(year, month, 1);
	lastDate = new Date(year, month + 1, 0);
	
				
	start_day = firstDate.getDay();
	line = Math.ceil((lastDate.getDate() + start_day) / 7)-1;
	
	calendar_data = '';
	
	tbody = document.getElementById("calendar-table").getElementsByTagName("tbody")[0];
	
	while(tbody.hasChildNodes()){
		tbody.removeChild(tbody.lastChild);
	}
	
	for(var i=0;i<=line;i++){
		row = document.createElement('tr');
		
		for(var j=1;j<=7;j++){
			num = 7*i+j-start_day;
			cell = document.createElement('td');
			
			if(num > 0 && num <= lastDate.getDate()){
				span = document.createElement('span');
				span.innerHTML = num;
				cell.id = 'date-' + num;
				cell.onclick = function(){getDateinfo(this);}
				cell.appendChild(span);
			}
		
			row.appendChild(cell);
		}
		tbody.appendChild(row);
	}				
}

function appendZeroMonth(m){
	if(m < 10)
		m = '0'+m;
	return m;
}

function closeCalendar(){
	calendar.style.display = 'none';
}

function showCalendar(target, id){
	var e = window.event;
	
	calendar.style.display = 'block';
	
	calendar.style.top = (target.offsetTop + 14) + "px";
	
	if(id < 3)
		calendar.style.left = (target.offsetLeft - (calendar.offsetWidth / 2)) + "px";
	else
		calendar.style.left = (target.offsetLeft - (calendar.offsetWidth / 1.5)) + "px";
		
	grade = id;
		
}

function getDateinfo(target){
	var day = target.id.split('-')[1];
	// var date = new Date(year, month,);
	if($('#stay-manage-deadline-grade-1').val()=='' && $('#stay-manage-deadline-grade-2').val()=='' && $('#stay-manage-deadline-grade-3').val()==''){
		
		for(var i=1;i<=3;i++){
			if(i==3)
				date = new Date(Date.parse(new Date(year, month, day)) - 86400);
			else
				date = new Date(year, month, day);
				
			$('#stay-manage-deadline-grade-'+i).val(date.getFullYear() + '.' + fillZero(date.getMonth()+1) + '.' + fillZero(date.getDate()) + '('+ dayLists[date.getDay()] + ')');
			
		}
	}else{
		date = new Date(year, month, day);
		$('#stay-manage-deadline-grade-'+grade).val(date.getFullYear() + '.' + fillZero(date.getMonth() + 1) + '.' + fillZero(date.getDate()) + '('+ dayLists[date.getDay()] + ')');
	}
	closeCalendar();
}

function clearDeadline(target){
	$('#stay-manage-deadline-grade-'+target).val('');
	$('#stay-manage-deadline-time'+target+'_hour').val('');
	$('#stay-manage-deadline-time'+target+'_min').val('');
}

function convertToDate(target){
	var regexp = /[0-9]/;
	var dateStr = $(target).val();
	var year,month,day,date;
	if(regexp.test(dateStr)){
		year = dateStr.substring(0, 4);
		month = dateStr.substring(4,6);
		day = dateStr.substring(6,8);
		date = new Date(year,month - 1,day);
		$(target).val(year+'.'+month+'.'+day+'('+ dayLists[date.getDay()] + ')').change();
		
	}
}
function fillZero(val){
	if(val<10)return "0"+val;
	return val;
}