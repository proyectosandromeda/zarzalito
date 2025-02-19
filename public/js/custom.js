function msj(titulo, tipo_msj, promp = 0, redirect = 0, close_modal = 0, redireccionar_url = 0) {
    if (promp == 0) {
        // swal("Mensaje", titulo, tipo_msj)
        Swal.fire({
            title: 'Mensaje',
            backdrop: true,
            text: titulo,
            icon: tipo_msj
        }
        ).then(function () {
            if (redirect == 0) {
                location.reload();
            }

            if (redireccionar_url != '0') {
                //console.log('dddd' + redireccionar_url);
                window.location.href = redireccionar_url;
            }

        });

        if (close_modal != 0) {
            $(close_modal).modal('hide')
        }

    } else {

        if (close_modal != 0) {
            $(close_modal).modal('hide')
        }

        const Toast = Swal.mixin({
            toast: true,
            // position: 'center-start',   
            iconColor: 'white',
            timerProgressBar: false,
            customClass: {
                popup: 'my-toast',
                icon: 'icon-center',
                title: 'left-gap',
                content: 'left-gap',
            },
            showConfirmButton: false,
            timer: 1800,
            onOpen: (toast) => {
                toast.addEventListener('mouseenter', Swal.stopTimer)
                toast.addEventListener('mouseleave', Swal.resumeTimer)
            },
            onClose: () => {

                if (redirect == 0) {
                    location.reload();
                }

                if (redireccionar_url != '0') {
                    //console.log('dddd' + redireccionar_url);
                    window.location.href = redireccionar_url;
                }
            }
        })

        Toast.fire({
            icon: tipo_msj,
            title: titulo
        })


    }
}

function capitalizeFirstLetter(str) {
    const capitalized = str.charAt(0).toUpperCase() + str.slice(1);
    return capitalized;
}

Object.defineProperty(String.prototype, 'capitalize', {
    value: function () {
        return this.charAt(0).toUpperCase() + this.slice(1);
    },
    enumerable: false
});

function regenerate() {
    let token = procesa_datos_data('get', BaseUrl.ajaxurl + '/regenerate_token', {});
    token.done(function (r) {

        $('input[name="' + r.keys.name + '"]').each(function () {
            $(this).val(r.keys.value)

        })

        $('input[name="' + r.values.name + '"]').each(function () {
            $(this).val(r.values.value)
        })

        $('.preloader').hide();
        //msj(result.message, result.tipo, result.toast, result.redirect);
    })
}

function download_file(file, name) {
    let a = document.createElement("a");
    a.href = file;
    a.download = name
    a.click();
}

function procesa_datos_data(tipo, url, datos) {
    return $.ajax({
        type: tipo,
        async: true,
        method: tipo,
        dataType: "json",
        restful: true,
        url: url,
        sync: false,
        cache: true,
        data: datos,
        success: function (info) {
            // console.log(datos);
        }
    });
}

if ($('#dropzone-multi').length > 0) {
    "use strict"; !function () {
        var a = `<div class="dz-preview dz-file-preview">
<div class="dz-details">
  <div class="dz-thumbnail">
    <img data-dz-thumbnail>
    <span class="dz-nopreview">No preview</span>
    <div class="dz-success-mark"></div>
    <div class="dz-error-mark"></div>
    <div class="dz-error-message"><span data-dz-errormessage></span></div>
    <div class="progress">
      <div class="progress-bar progress-bar-primary" role="progressbar" aria-valuemin="0" aria-valuemax="100" data-dz-uploadprogress></div>
    </div>
  </div>
  <div class="dz-filename" data-dz-name></div>
  <div class="dz-size" data-dz-size></div>
</div>
</div>`; new Dropzone("#dropzone-multi", { previewTemplate: a, parallelUploads: 1, maxFilesize: 5, addRemoveLinks: !0 })
    }();
}

$(document).ready(function () {

    $('[data-toggle="tooltip"]').tooltip()
    /*==================================================================
   [ Validate ]*/
    var input = $('.validate-input .input100');

    $('.validate-form').on('submit', function () {
        var check = true;

        for (var i = 0; i < input.length; i++) {
            if (validate(input[i]) == false) {
                showValidate(input[i]);
                check = false;
            }
        }

        return check;
    });


    $('.validate-form .input100').each(function () {
        $(this).focus(function () {
            hideValidate(this);
        });
    });

    function validate(input) {
        if ($(input).attr('type') == 'email' || $(input).attr('name') == 'email') {
            if ($(input).val().trim().match(/^([a-zA-Z0-9_\-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\.)+))([a-zA-Z]{1,5}|[0-9]{1,3})(\]?)$/) == null) {
                return false;
            }
        }
        else {
            if ($(input).val().trim() == '') {
                return false;
            }
        }
    }

    function showValidate(input) {
        var thisAlert = $(input).parent();

        $(thisAlert).addClass('alert-validate');
    }

    function hideValidate(input) {
        var thisAlert = $(input).parent();

        $(thisAlert).removeClass('alert-validate');
    }

    /************fin validedate */

    $(document).on('change', '.form-switch', function (e) {
        var checked = $('input', this).is(':checked');
        $('.lblcheck', this).html(checked ? 'Activo' : 'Inactivo');

        if (checked == true) {
            $('input', this).val(1)
            // console.log('ingr acti');
        } else {
            $('input', this).val(2)
            // console.log('ingr desact');
        }
    })

    //set de active menu
    var activeurl = window.location;
    $('a[href="' + activeurl.pathname + '"]').parent('li').addClass('active');
    if ($('a[href="' + activeurl.pathname + '"]').closest('ul').hasClass('menu-sub')) {
        $('a[href="' + activeurl.pathname + '"]').parents('li').addClass('open');
        //this is a parent element
    } else {
        $('a[href="' + activeurl.pathname + '"]').addClass('active');
    }

    $(function () {
        $(".preloader").fadeOut();
    });

    if ($('.select-filter').length > 0) {
        let modal = $('.select-filter').data('modal')

        if (modal) {
            $('.select-filter').select2({
                dropdownParent: $('#' + modal)
            });
        } else {
            $('.select-filter').select2();
        }

    }

    setTimeout(function () {
        var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
        var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
            return new bootstrap.Tooltip(tooltipTriggerEl)
        })
    }, 2000);



    $(document).on("submit", "form", function (event) {
        event.preventDefault();
        $('.preloader').show();
        $.ajax({
            url: $(this).attr("action"),
            type: $(this).attr("method"),
            dataType: "JSON",
            data: new FormData(this),
            processData: false,
            contentType: false,
            beforeSend: function () {
                //$('.loader-wrapper').show();
            },
            success: function (result, status) {
                $('.preloader').hide();

                if (result.succes === true) {

                    if (result.close_modal) {
                        $('#' + result.close_modal + '').modal('hide');
                    }

                    regenerate();
                    msj(result.message, result.tipo, result.promp, result.redirect, result.close_modal, result.url_redirect);

                } else {

                    $('#' + result.close_modal + '').modal('hide');
                    let token = procesa_datos_data('get', BaseUrl.ajaxurl + '/regenerate_token', {});
                    token.done(function (r) {

                        $('input[name="' + r.keys.name + '"]').each(function () {
                            $(this).val(r.keys.value)
                        })

                        $('input[name="' + r.values.name + '"]').each(function () {
                            $(this).val(r.values.value)
                        })
                    })

                    $('.loader-wrapper').hide();
                    msj(result.message, result.tipo, result.promp, result.redirect, result.close_modal, result.url_redirect);

                }
            },
            error: function (xhr, desc, err) {
                alert(desc + ' ' + err)
            }
        });
    });


    $('.tab-button').click(function () {

        // Verificar si el botón clicado ya tiene la clase 'active'
        if (!$(this).hasClass('active')) {
            // Remover la clase 'active' de todos los botones
            $('.tab-button').removeClass('active btn-primary');
            // Añadir la clase 'active' al botón que se ha clicado
            $(this).addClass('active btn-primary');

            // Ocultar todos los contenidos de las pestañas
            //$('.tab-content').hide();
            // Mostrar el contenido correspondiente al botón clicado
            let ventana1 = $(this).data('ventana1')
            let ventana2 = $(this).data('ventana2')

            if ($('#' + ventana1).hasClass('show')) {
                $('#' + ventana1).fadeIn("slow").removeClass('show')
                $('#' + ventana2).addClass('show')
            } else {
                $('#' + ventana2).fadeIn("slow").removeClass('show')
                $('#' + ventana1).addClass('show')
            }
        }
    });


    if ($('#table_user')) {
        $('#table_user').DataTable({
            "bDestroy": true,
            "search": true,
            "bFilter": true,
            "info": false,
            "paging": true,
            "cache": false,
            "processing": true,
            "serverSide": false,
            "responsive": true,
            "ordering": false,
            "dom": 'Brtips',
            "buttons": [
                {
                    extend: 'excel',
                    text: 'Exportar',
                    className: 'btn btn-primary'
                },
                {
                    text: 'Agregar usuario',
                    className: 'btn btn-primary',
                    action: function (e, dt, node, config) {
                        $('#modal_edit_usuarios').modal('show')
                    }
                }
            ],
            "language": {
                "url": BaseUrl.ajaxurl + "/js/Spanish.json"
            }
        })
    }

    $('.edit_user').click(function () {
        let user = $(this).data('iduser')
        let apellido = $(this).data('apellido')
        let nombre = $(this).data('nombre')
        let idrol = $(this).data('role')
        let email = $(this).data('email')

        $('input[name="idusuario"]').val(user)
        $('input[name="nombre"]').val(nombre)
        $('input[name="apellido"]').val(apellido)
        $('input[name="email"]').val(email)
        $('select[name="rol"]').val(idrol)
        $('#modal_edit_usuarios').modal('show')
    })


    if ($('#table_configuration')) {
        $('#table_configuration').DataTable({
            "bDestroy": true,
            "search": true,
            "bFilter": true,
            "info": false,
            "paging": true,
            "cache": false,
            "processing": true,
            "serverSide": false,
            "responsive": true,
            "ordering": false,
            "dom": 'rtips',
            "language": {
                "url": BaseUrl.ajaxurl + "/js/Spanish.json"
            }
        })
    }

    $('.edit_bot').click(function () {
        let idconfig = $(this).data('idconfig')
        let text_info = $(this).data('textinfo')

        $('input[name="idconfig"]').val(idconfig)
        $('textarea[name="text_info"]').val(text_info)

        $('#modal_edit_bot').modal('show')
    })




    if ($('#table_tickets')) {
       let tickets = $('#table_tickets').DataTable({
            "ajax": `${BaseUrl.ajaxurl}/tickets/all`,
            "bDestroy": true,
            "search": true,
            "bFilter": true,
            "info": false,
            "paging": true,
            "cache": false,
            "processing": true,
            "serverSide": true,
            "responsive": true,
            "ordering": false,
            "columns": [
                { "data": "name" },
                { "data": "area" },
                { "data": "phone" },
                { "data": "problem" },
                { "data": "fecha" },
                { "data": "estado" },
                { "data": "responsable" },
                {
                    "data": null, render: function (Data) {
                        return `<a href="javascript:void(0)" class="edit_ticket" data-id="${Data.id}"><svg width="41" height="36" viewBox="0 0 41 36" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M23.804 10.5L27.9707 14.6667L17.1374 25.5H12.9707V21.3333L23.804 10.5Z" stroke="#3918D9" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
                        </a>`
                    }
                }
            ],
            "dom": 'Brtips',
            "buttons": [
                {
                    extend: 'excel',
                    text: 'Exportar',
                    className: 'btn btn-primary'
                }
            ],
            "language": {
                "url": BaseUrl.ajaxurl + "/js/Spanish.json"
            }
        })

        /**
         * aplico filtros de busqueda a la tabla
         */
        $('#table_tickets thead tr').clone(true).appendTo('#table_tickets thead');
        $('#table_tickets thead tr:eq(1) th').each(function (i) {
            var title = $(this).text();
            
            if (title !== "Acción") {
                $(this).html('<input type="text" class="form-control" placeholder="Buscar ' + title + '" />');
            }
            $('input', this).on('keyup change', function () {
                if (tickets.column(i).search() !== this.value) {
                    tickets.column(i)
                        .search(this.value)
                        .draw();
                }
            });
        });
    }



    $(document).on('click', '.edit_ticket', function (e) {
        let idtext = $(this).data('id')
        $('input[name="idtickets"]').val(idtext)
        
        let datos = procesa_datos_data('get', `${BaseUrl.ajaxurl}/tickets/get_ticket/${idtext}`, {})
        datos.done(function (r) {
            $('textarea[name="textinfo"]').text(r.problem)
            $('textarea[name="textcoment"]').text(r.comments)
            
        })
        $('#modal_edit_tickets').modal('show')
    })




})

function calc_days(fechaInicio, fechaFin) {

    // Convertir las fechas a objetos Date
    let fechaInicioObj = new Date(fechaInicio);
    let fechaFinObj = new Date(fechaFin);

    // Calcular la diferencia en milisegundos
    let diferenciaMilisegundos = fechaFinObj - fechaInicioObj;

    // Convertir la diferencia a días
    let dias = diferenciaMilisegundos / (1000 * 60 * 60 * 24);

    $('input[name="num_dias"]').val(Math.round(dias) + 1)
    // Redondear el resultado a un número entero
}

function pad(n) {
    return n < 10 ? '0' + n : n;
}