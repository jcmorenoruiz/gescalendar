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
//= require dataTables/jquery.dataTables
//= require dataTables/bootstrap/3/jquery.dataTables.bootstrap
//= require turbolinks
//= require jquery.turbolinks
//= require bootstrap-sprockets
//= require bootstrap-datepicker/core
//= require bootstrap-datepicker/locales/bootstrap-datepicker.es
//= require jquery.minicolors
//= require jsapi
//= require chartkick
//= require app
//= require_tree .



var ready = function() {
    // do stuff here.
    $('.datepicker').datepicker({
		format: "dd/mm/yyyy",
		todayBtn: "linked",
		language: "es",
		todayHighlight: true,
		autoclose: true,
		startDate: '-1y',
		endDate: '+1y',
		weekStart: 1
	});
};

$(document).ready(ready);
$(document).on('page:load', ready);

var language =
 {
        "lengthMenu": "Mostrar _MENU_ registros por página",
              "zeroRecords": "No se encontraron resultados",
              "info": "Mostrando página _PAGE_ de _PAGES_  con _TOTAL_ registros ",
              "infoEmpty": "No hay registros disponibles",
              "infoFiltered": "(filtrados de _MAX_  registros totales)",
              "paginate": {
                  "first":      "Primera",
                  "previous":   "Anterior",
                  "next":       "Siguiente",
                  "last":       "Última"
                },
                "search": "Buscar:",
                "emptyTable": "No hay datos que coincidan con la búsqueda en la tabla"
}