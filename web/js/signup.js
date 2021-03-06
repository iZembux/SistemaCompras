/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

//jQuery time
var current_fs, next_fs, previous_fs; //fieldsets
var left, opacity, scale; //fieldset properties which we will animate
var animating; //flag to prevent quick multi-click glitches

$(".next").click(function(){
	if(animating) return false;
	animating = true;
	
	current_fs = $(this).parent();
	next_fs = $(this).parent().next();
	
	//activate next step on progressbar using the index of next_fs
	$("#progressbar li").eq($("fieldset").index(next_fs)).addClass("active");
	
	//show the next fieldset
	next_fs.show(); 
	//hide the current fieldset with style
	current_fs.animate({opacity: 0}, {
		step: function(now, mx) {
			//as the opacity of current_fs reduces to 0 - stored in "now"
			//1. scale current_fs down to 80%
			scale = 1 - (1 - now) * 0.2;
			//2. bring next_fs from the right(50%)
			left = (now * 50)+"%";
			//3. increase opacity of next_fs to 1 as it moves in
			opacity = 1 - now;
			current_fs.css({
        'transform': 'scale('+scale+')',
        'position': 'absolute'
      });
			next_fs.css({'left': left, 'opacity': opacity});
		}, 
		duration: 800, 
		complete: function(){
			current_fs.hide();
			animating = false;
		}, 
		//this comes from the custom easing plugin
		easing: 'easeInOutBack'
	});
});

$(".previous").click(function(){
	if(animating) return false;
	animating = true;
	
	current_fs = $(this).parent();
	previous_fs = $(this).parent().prev();
	
	//de-activate current step on progressbar
	$("#progressbar li").eq($("fieldset").index(current_fs)).removeClass("active");
	
	//show the previous fieldset
	previous_fs.show(); 
	//hide the current fieldset with style
	current_fs.animate({opacity: 0}, {
		step: function(now, mx) {
			//as the opacity of current_fs reduces to 0 - stored in "now"
			//1. scale previous_fs from 80% to 100%
			scale = 0.8 + (1 - now) * 0.2;
			//2. take current_fs to the right(50%) - from 0%
			left = ((1-now) * 50)+"%";
			//3. increase opacity of previous_fs to 1 as it moves in
			opacity = 1 - now;
			current_fs.css({'left': left});
			previous_fs.css({'transform': 'scale('+scale+')', 'opacity': opacity});
		}, 
		duration: 800, 
		complete: function(){
			current_fs.hide();
			animating = false;
		}, 
		//this comes from the custom easing plugin
		easing: 'easeInOutBack'
	});
});

$(".submit").click(function(){
	return true;
})

function validarPassword() {
    var espacios = false;
    var cont = 0;
    var p1 = document.getElementById("pass").value;
    var p2 = document.getElementById("cpass").value;
    if (p1.length == 0 || p2.length == 0) {
        swal("Opps!", "OLVIDASTE INGRESAR UNA CONTRASEÑA!", "warning");
        return false;
    }
    if (p1 != p2) {
        swal("Opps!", "TUS CONTRASEÑAS NO COINCIDEN!", "warning");
        document.getElementById("pass").value = null;
        document.getElementById("cpass").value = null;
        return false;
    }
}

function contraseñaIncorrecta() {
   swal("Opps!", "Tus datos no son correctos!", "warning");
}

function imprimeDiv(nombreDiv) {
     var contenido= document.getElementById(nombreDiv).innerHTML;
     var contenidoOriginal= document.body.innerHTML;

     document.body.innerHTML = contenido;

     window.print();

     document.body.innerHTML = contenidoOriginal;
}


function enviar(form) {
    var persona = new FormData(form);
    var req = ajaxRequest("cargarArchivo.jsp");
    req.send(persona);
}

function ajaxRequest(url) {
    if (window.XMLHttpRequest) {
        var request = new XMLHttpRequest();
    } else if (window.ActiveXObject) {
        var request = new ActiveXObject("Microsoft.XMLHTTP");
    }

    request.onload = function (Event) {
        if (request.status == 200) {
            var response = JSON.parse(request.responseText);
            if (response.success) {
                alert("Persona procesada exitosamente");
                swal("Genial!", "Persona procesada exitosamente", "success");
            } else {
                swal("Opps!", "Algo malo pasó!", "warning");
            }
        }
    };

}