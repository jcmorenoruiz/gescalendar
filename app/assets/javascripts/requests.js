
$(function() { 
	  var Chartkick = {"language": "es"};

	  
	  $('.anterior').on('click',function(e){
	    $(this).off(e); // Avoid Multiple clicks

	  	mes=$('#date_month').val();
	  	anio=$('#date_year').val();

	  	if(mes>1){
	  		$('#date_month').val(parseInt(mes)-parseInt(1));
	  	}else{
	  		if($('#date_year').previous().val()){
	  			$('#date_month').val(12);
	  			$('#date_year').val(parseInt(anio)-parseInt(1));
	  		}else return false;
	  	}

	  	document.forms[0].submit();
	  });


	  $('.siguiente').on('click',function(e){
	    $(this).off(e); // Avoid Multiple clicks

	  	mes=$('#date_month').val();
	  	anio=$('#date_year').val();

	  	if(mes<12){
	  		$('#date_month').val(parseInt(mes)+parseInt(1));
	  	}else{
	  		if($('#date_year').next().val()){
	  			$('#date_month').val(1);
	  			$('#date_year').val(parseInt(anio)+parseInt(1)); 
	  		}else return false;
	  	}
	  	document.forms[0].submit();
	  });


	
	
});




