var ajaxQ;

function getCalendar(year,month,date) { 
    if (!year) year=""; 
    if (!month) month=""; 
    if (!date) date=""; 

    ajaxQ = newXMLHttpRequest(); 
    ajaxQ.onreadystatechange = processReqChange;  
    ajaxQ.open("POST", getUrl("snack", "dispCalendar"), true); 
    ajaxQ.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    ajaxQ.send("year=" + year + "&month="+month+"&date="+date); 
} 

function newXMLHttpRequest() {  
    var xmlreq = false;  
    if (window.XMLHttpRequest) { // 파이어폭스나 맥의 사파리의 경우처리  
        // Create XMLHttpRequest object in non-Microsoft browsers  
        xmlreq = new XMLHttpRequest();  
    }  
    else if (window.ActiveXObject) {    // IE계열의 브라우져의 경우  
        // Create XMLHttpRequest via MS ActiveX  
        try {  
            // Try to create XMLHttpRequest in later versions  
            // of Internet Explorer  
            xmlreq = new ActiveXObject("Msxml2.XMLHTTP");  
        }  
        catch (e1) {  
            // Failed to create required ActiveXObject  
            try {  
                // Try version supported by older versions  
                // of Internet Explorer  
                xmlreq = new ActiveXObject("Microsoft.XMLHTTP");  
            }  
            catch (e2) {  
                // Unable to create an XMLHttpRequest with ActiveX  
            }  
        }  
    } 
    return xmlreq;  
}  

function processReqChange() {  
    if (ajaxQ.readyState == 4) {  
        if (ajaxQ.status == 200) {  
            setCalendar(); 
        }  
    }  
}  

function setCalendar() { 
    document.getElementById("ajax_calendar").innerHTML=ajaxQ.responseText; 
} 

function moveMonth(type) { 
    var obj = document.hiddenForm; 
    var ym=obj.calendar_ym.value; 
    var year = ym.substring(0,4); 
    var month = parseInt(ym.substring(4),10); 
    if (type == "prev") { 
        month--; 
        if (month == 0) { 
            year--; 
            month = 12;
        } 
    } 

    if (type == "next") { 
        month++; 
        if (month == 13) { 
            year++; 
            month = 1;
        }
    } 

    getCalendar(year,month); 
    obj.calendar_ym.value = year + "" + month; 
    document.getElementById("period_caption").innerHTML = '<strong>' + year + '년 ' + month + '월</strong>'; 
}

 /*
function changeTab(tabID) {
	var target_tab = document.getElementById(tabID == "now" ? "tab_a" : "tab_b");
	var t1_button = document.getElementById('tab_a');
	var t2_button = document.getElementById('tab_b');
	var g1_content = document.getElementById('tab_a_content');
	var g2_content = document.getElementById('tab_b_content');

	if(target_tab.className == 'tab_off') {
		if(tabID == 'now') {
			g1_content.className = 'view-on';
			g2_content.className = 'view-off';
			t1_button.className = 'tab_on';
			t2_button.className = 'tab_off';
			
            location.hash = "now";
		}
		else if(tabID == 'list') {
			g1_content.className = 'view-off';
			g2_content.className = 'view-on';
			t1_button.className = 'tab_off';
			t2_button.className = 'tab_on';

            location.hash = "list";
		}
	}
}*/

function showCalendar(className){
	var show_calendar = document.getElementById('calendar');
	show_calendar.className='view-on';
}
/*
function hideCalendar(className){
	var hide_calendar = document.getElementById('calendar');
	hide_calendar.className='view-off';
}*/

function hideCalendar(event) {
    var calendar = document.getElementById('calendar');
    //this is the original element the event handler was assigned to
       var e = event.toElement || event.relatedTarget;

    //check for all children levels (checking from bottom up)
    while(e && e.parentNode && e.parentNode != window) {
        if (e.parentNode == calendar ||  e == calendar) {
            if(e.preventDefault) e.preventDefault();
            return false;
        }
        e = e.parentNode;
    }

    calendar.className='view-off';
}

getCalendar();