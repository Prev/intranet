<?php
	function bbcode_format($str){
		$str = htmlspecialchars($str);
		$str = join('&nbsp;', explode(' ', $str));
		$str = join('<br>', explode("\r\n", $str));
		$str = join('<br>', explode("\n", $str));
		$str = join('<br>', explode("\r", $str));
		
		$format_search =  array(
		  '#\[b\](.*?)\[/b\]#is', 
		  '#\[bold\](.*?)\[/bold\]#is', 
		  '#\[i\](.*?)\[/i\]#is', 
		  '#\[u\](.*?)\[/u\]#is', 
		  '#\[s\](.*?)\[/s\]#is', 
		  '#\[quote\](.*?)\[/quote\]#is', 
		  '#\[code\](.*?)\[/code\]#is', 
		  '#\[size=([1-9]|1[0-9]|20)\](.*?)\[/size\]#is', 
		  //'#\[color=\#?([A-F0-9]{3}|[A-F0-9]{6})\](.*?)\[/color\]#is', 
		  '#\[color=(.*)\](.*?)\[/color\]#is', 
		  '#\[url=((?:ftp|https?)://.*?)\](.*?)\[/url\]#i',
		  '#\[url\]((?:ftp|https?)://.*?)\[/url\]#i',
		  '#\[img\](https?://.*?\.(?:jpg|jpeg|gif|png|bmp))\[/img\]#i'
		);
	   
		$format_replace = array(
		  '<strong>$1</strong>',
		  '<strong>$1</strong>',
		  '<em>$1</em>',
		  '<span style="text-decoration: underline;">$1</span>',
		  '<span style="text-decoration: line-through;">$1</span>',
		  '<blockquote>$1</blockquote>',
		  '<pre>$1</'.'pre>',
		  '<span style="font-size: $1px;">$2</span>',
		  '<span style="color:$1;">$2</span>',
		  '<a href="$1">$2</a>',
		  '<a href="$1">$1</a>',
		  '<img src="$1" alt="" />'
		);
		$str = preg_replace($format_search, $format_replace, $str);
		$str = nl2br($str);
		return $str;
	}
?>