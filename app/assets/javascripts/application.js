// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

function ready(){
	$('#one').text("");
    $('#two').text("R");
    $('#three').text("eady")
    $('#play').prop("disabled", false);
    $('#search-input').val("");
}

function menu_maker_wiki(data){
   $('#menu').remove();
   $('#menu-box').append("<ul id='menu'>");
   console.log(data.outline);
   console.log(data.broker);
   	for (var i = 0; i < data.outline.length; i++) {
      	if(i == 0){
        	$('#menu').append("<li><button class='menu-button' art="+i+">" + data.outline[i].replace("[edit]", "") + "</button></li><br>");
      	}
      	else{
        	if(data.broker[i+1] != null){
            	$('#menu').append("<li><button class='menu-button' art=" + (i + 1) + ">" + data.outline[i].replace("[edit]", "") + "</button></li><br>");
         	}
      	}
   	};
   	
   	$('#menu-box').append("</ul");
   	$('#menu-box').hide()
};



function menu_maker_reddit(data_titles, data_sources, data_links){
   $('#menu').remove();
   $('#menu-box').append("<ul id='menu'>");
   
   for (var i = 0; i < 20; i++) {
      	$('#menu').append("<li art-src='" + data_links[i] + "'><button class='menu-button-reddit'><b>" + (i+1) + ") " + data_titles[i] + "</b> " + data_sources[i] + "</button></li><br>");
   	};
   	
   	$('#menu-box').append("</ul>");
   	$('#menu-box').hide()
}


function changeup(words, counter){
   	var word = words[counter];
   	var part1 = '';
   	var part2 = '';
   	var redlet = '';
   	console.log(words.length, counter);

   	if(word.length == 0){
      	part1 = ' ';
 		part2 = ' ';
 		redlet = ' ';
 	}
   
   	else if(word.length == 1){
      	redlet = word;
   	}
   
   	else if(word.length == 2){;
      	part1 = word[0];
      	redlet = word[1];
   	}
   
   	else if(word[1] == 'h'){
      	part1 = word[0];
      	redlet = word[1];
      	for (var i = 2; i < word.length; i++) {
        	part2 = part2 + word[i];
      	}; 
   	}
   
   	else{
     
      	for (var i = 0; i < word.length; i++) {
        	if(i < word.length / 4){
            	part1 += word[i];
        	}
        	else{
            	part2 += word[i];
        	}
    	};
     
	    redlet = part2[0];
	    part2 = part2.slice(1, part2.length);
  
   	}

   	$('#one').text(part1);
   	$('#two').text(redlet);
   	$('#three').text(part2);
  	
  	if(counter === words.length){
    	console.log('DONE!');
  	}

}//END OF CHANGEUP   
