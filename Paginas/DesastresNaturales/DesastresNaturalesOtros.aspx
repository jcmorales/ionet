﻿<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ Page Language="C#" %>
<%@ Register tagprefix="SharePoint" namespace="Microsoft.SharePoint.WebControls" assembly="Microsoft.SharePoint, Version = 15.0.0.0, Culture = neutral, PublicKeyToken = 71e9bce111e9429c" %>
<html dir="ltr" xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<!--Documento generado de manera dinámica por SPFormsEasy -->
<!--Nombre del documento: DesastresNaturalesOtros -->
<!--Creado por: Luis Alonso Escalona Morales -->
<!--Creado el: 13/03/2018 -->
<SharePoint:ScriptLink Name="MicrosoftAjax.js" runat="server" Defer="False" Localizable="false"/>
<SharePoint:ScriptLink Name="SP.core.js" runat="server" Defer="False" Localizable="false"/>
<SharePoint:ScriptLink Name="SP.js" runat="server" Defer="False" Localizable="false"/>
<SharePoint:ScriptLink Name="SP.runtime.js" runat="server" Defer="False" Localizable="false"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=10" />
<SharePoint:CssRegistration Name="default" runat="server"/>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css"/>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.17.45/css/bootstrap-datetimepicker.css"/>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.17.45/css/bootstrap-datetimepicker.min.css"/>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.17.1/moment.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.17.45/js/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript" src="https://cocacolafemsa.sharepoint.com/sites/SWPP/_layouts/15/SP.Runtime.js"></script>
<script type="text/javascript" src="https://cocacolafemsa.sharepoint.com/sites/SWPP/_layouts/15/SP.js"></script>
<script type="text/javascript" src="https://cocacolafemsa.sharepoint.com/sites/SWPP/_layouts/15/SP.UserProfiles.js"></script>
<link rel="stylesheet" href="../../Styles/reportes.css"/>
<script type="text/javascript" src="../../Scripts/Sitios/Alarma.js"></script>
<script type="text/javascript" src="../../Scripts/Sitios/combo_min.js"></script>
<script type="text/javascript" src="../../Scripts/Traduccion.js"></script>
<script type="text/javascript" src="../../Scripts/jquery.priceformat.min.js"></script>
<script type="text/javascript" src="../../Scripts/jquery.number.min.js"></script>

<link rel="stylesheet" href="../../Styles/inputmask.css"/>
<script type="text/javascript" src="../../Scripts/dist/jquery.inputmask.bundle.js"></script>

<!--JS Operación-->
<script type ="text/javascript">
	var personProperties;
	var clientContext;
	var etiquetascontroles = [];
	var pais;
	var URL = "https://cocacolafemsa.sharepoint.com/sites/SWPP";
	$(document).ready(function () {
		SP.SOD.executeOrDelayUntilScriptLoaded(getCurrentUser, 'SP.UserProfiles.js');
		$('#btnAgregar').on('click', agregar);
		$('#HNBR').text($.get('NBR'));


		$('.time').on('focus blur', validaHora);
		$('.time').datetimepicker({
			format: 'HH:mm'
		});

		$('.date').datetimepicker({
			format: 'DD/MM/YYYY'
		});

		$('.moneda').inputmask('currency');

		$('.numero').inputmask('numeric');

	});

	function validaHora(){
		var h1 = $('#txtHoraOcurre').val();
		var h2 = $('#txtHoraFinaliza').val();
		if (!compararHoras(h1, h2))
		{
			$('#txtHoraOcurre').css('border-color', 'red');
			$('#txtHoraFinaliza').css('border-color', 'red');
		}
		else
		{
			$('#txtHoraOcurre').css('border-color', '#D8D8D8');
			$('#txtHoraFinaliza').css('border-color', '#D8D8D8');
		}
	}

	function agregar(){
		if (validarCampos())
		{
			if ($('#hdngua').val() == 'true'){
				if (confirm($('#lblAgregarAviso').text()))
				{
				guardarDatosB(obtener(), clientContext);
				clientContext.executeQueryAsync(Function.createDelegate(this, this.onGuardarExitoB), Function.createDelegate(this, this.onGuardarErrorB));
					setTimeout('window.close()', 5000);
				}
			}else{
				console.log('Editar');
				EliminarReporte($('#hdnidentificador').val(), $('#hdnnumero').val());
				guardarDatosB(obtener(), clientContext);
				clientContext.executeQueryAsync(Function.createDelegate(this, this.onGuardarExitoB), Function.createDelegate(this, this.onGuardarErrorB));
				setTimeout('window.close()', 5000);
			}
		}
		else
		{
			alert($('#lblCamposFaltantes').text());
		}
	}

	function EliminarDatos(lista, id, clientContext){
		var oList = clientContext.get_web().get_lists().getByTitle(lista);
		this.oListItem = oList.getItemById(id);
		oListItem.deleteObject();
	}
	function EliminarReporte(folio, reporte) {
		$.ajax({
			url: URL + "/_api/web/lists/getbytitle('TR_DesastresNaturales')/Items?$select=ID&$filter=Title eq '" + encodeURIComponent(folio) + "' and NumeroReporte eq '" + encodeURIComponent(reporte) + "'", 
			type: "GET", 
			async: false,
			headers:{"accept":"application/json;odata=verbose"}, 
			success: function (data) { 
				if (data.d.results) { 
					EliminarDatos('TR_DesastresNaturales', data.d.results[0].ID, clientContext);
				} 
			}, 
			error: function (xhr) { 
				alert('EliminarReporte ' + xhr.status + ': ' + xhr.statusText); 
			}
		});
	}
	function guardarDatosB(datos, clientContext) {
		guardarReporteB(datos[0], clientContext);
		var info = JSON.parse(datos[0]);
	}

	function guardarReporteB(d, clientContext) {
		try {
			var datos = JSON.parse(d);
			var oList = clientContext.get_web().get_lists().getByTitle('TR_DesastresNaturales');
			var itemCreateInfo = new SP.ListItemCreationInformation();
			this.oListItemDatos = oList.addItem(itemCreateInfo);

			oListItemDatos.set_item('Title', datos.Identificador);
			oListItemDatos.set_item('NombreReporte', datos.NombreReporte );
			oListItemDatos.set_item('NumeroReporte', datos.NumeroReporte );
			oListItemDatos.set_item('Estatus', datos.Estatus );
			oListItemDatos.set_item('HoraOcurre', datos.HoraOcurre);
			oListItemDatos.set_item('HoraFinaliza', datos.HoraFinaliza);
			oListItemDatos.set_item('HoraReportanProteccion', datos.HoraReportanProteccion);
			oListItemDatos.set_item('NombrePersonaReportaProteccion', datos.NombrePersonaReportaProteccion);
			oListItemDatos.set_item('PuestoPersonaReportaProteccion', datos.PuestoPersonaReportaProteccion);
			oListItemDatos.set_item('Tipo1', datos.Tipo1);
			oListItemDatos.set_item('Calle', datos.Calle);
			oListItemDatos.set_item('Numero', datos.Numero);
			oListItemDatos.set_item('Colonia', datos.Colonia);
			oListItemDatos.set_item('MunicipioDelegacion', datos.MunicipioDelegacion);
			oListItemDatos.set_item('Estado', datos.Estado);
			oListItemDatos.set_item('CodigoPostal', datos.CodigoPostal);
			oListItemDatos.set_item('ObservacionesInformacionAdiciona', datos.ObservacionesInformacionAdiciona);

			oListItemDatos.update();
			clientContext.load(oListItemDatos);
		}catch (e) {
			alert(e);
		}
	}

	function onGuardarExitoB() {
		console.log('Guardado');
	}

	function onGuardarErrorB(sender, args) {
		alert('Request failed. ' + args.get_message() + '\n' + args.get_stackTrace());
}

	function getCurrentUser() {
		clientContext = new SP.ClientContext.get_current();
		personProperties = new SP.UserProfiles.PeopleManager(clientContext).getMyProperties();
		clientContext.load(personProperties);
		clientContext.executeQueryAsync(gotAccount, requestFailed);
	}

	function gotAccount(sender, args) {
		var id = $.get('ID');
		var estado = $.get('EDO');
		var numero = $.get('NUM');
		var cuenta = personProperties.get_accountName().split('|')[2];
		pais = obtenerPaisUsuario(cuenta);


		var URLSitio = "https://cocacolafemsa.sharepoint.com/sites/SWPP"; 
		if (pais == "BR") {
			TraducirIdiomaNP("Portugu&#233;s", URLSitio, "Incidencias.aspx");
		}else{
			if (pais == "PH") {
				TraducirIdiomaNP("Inglés", URLSitio, "Incidencias.aspx");
			}else {
				TraducirIdiomaNP("Español", URLSitio, "Incidencias.aspx");
			}
		}
		if(id != null && numero != null && estado != null) {
			$('#hdnidentificador').val(id);
			$('#hdnnumero').val(numero);

			if(estado == 'Edit') {
				llenarDatos(id, numero);

				$('#hdngua').val(false);
			}
			if(estado == 'Ver') {
				llenarDatos(id, numero);

				bloquear();
				$('#hdngua').val(false);
			}
		}
	}

	function llenarDatos(folio, reporte){
		$.ajax({
			url:URL + "/_api/web/lists/getbytitle('TR_DesastresNaturales')/Items?$select=ID&$filter=Title eq '" + encodeURIComponent(folio) + "' and NumeroReporte eq '" + encodeURIComponent(reporte) + "'",
			type: "GET",
async: false,
			headers: {"accept": "application/json;odata=verbose"},
			success: function(data) {
				if(data.d.results) {
					obtenerDatos(data.d.results[0].ID);
				}
			},
			error: function (xhr) {
				alert('llenarDato ' + xhr.status + ': ' + xhr.statusText);
			}
		});
	}

	function obtenerDatos(identificador) {
		$.ajax({
			url:URL + "/_api/web/lists/getbytitle('TR_DesastresNaturales')/Items?$select= HoraOcurre,HoraFinaliza,HoraReportanProteccion,NombrePersonaReportaProteccion,PuestoPersonaReportaProteccion,Tipo1,Calle,Numero,Colonia,MunicipioDelegacion,Estado,CodigoPostal,ObservacionesInformacionAdiciona,NombreReporte,NumeroReporte,Title&$orderby = ID &$filter=ID eq '" + encodeURIComponent(identificador) + "'",
			type: "GET",
async: false,
			headers: {"accept": "application/json;odata=verbose"},
			success: function (data) {
				if (data.d.results) {
					colocar(data.d.results[0]);
				}
			},
			error: function (xhr) {
				alert('obtenerDatos ' + xhr.status + ': ' + xhr.statusText);
			}
		});
	}

	function requestFailed(sender, args) {
		alert('Cannot get user account information: ' + args.get_message());
	}

	function bloquear(can_ubi, can_equi, can_per) {
		$('#txtHoraOcurre').prop('disabled', true);
		$('#txtHoraFinaliza').prop('disabled', true);
		$('#txtHoraAvisanProteccion').prop('disabled', true);
		$('#txtNombredelapersonaquereportaaproteccion').prop('disabled', true);
		$('#txtPuestodelapersonaquereportaaproteccion').prop('disabled', true);
		$('#txtTipo1').prop('disabled', true);
		$('#txtCalle').prop('disabled', true);
		$('#txtNumeroDireccion').prop('disabled', true);
		$('#txtColonia').prop('disabled', true);
		$('#txtMunicipio').prop('disabled', true);
		$('#txtEstado').prop('disabled', true);
		$('#txtCodigoPostal').prop('disabled', true);
		$('#tarObservacionesInformacionAdicional').prop('disabled', true);
		$('.bDinamico').prop('disabled', true);
	}


	function validarCampos() {
		if($('#txtHoraOcurre').val() === ''){
			$('#txtHoraOcurre').css('border-color', 'red');
	alert('No se puede continuar porque el campo * Hora en que ocurre está vacío');
			return false;
		}else{
			$('#txtHoraOcurre').css('border-color', '#D8D8D8');
		}
		if($('#txtHoraFinaliza').val() === ''){
			$('#txtHoraFinaliza').css('border-color', 'red');
	alert('No se puede continuar porque el campo * Hora en que finaliza está vacío');
			return false;
		}else{
			$('#txtHoraFinaliza').css('border-color', '#D8D8D8');
		}
		if($('#txtHoraAvisanProteccion').val() === ''){
			$('#txtHoraAvisanProteccion').css('border-color', 'red');
	alert('No se puede continuar porque el campo * Hora en que reportan a protección está vacío');
			return false;
		}else{
			$('#txtHoraAvisanProteccion').css('border-color', '#D8D8D8');
		}
		if($('#txtNombredelapersonaquereportaaproteccion').val() === ''){
			$('#txtNombredelapersonaquereportaaproteccion').css('border-color', 'red');
	alert('No se puede continuar porque el campo * Nombre de la persona que reporta a protección está vacío');
			return false;
		}else{
			$('#txtNombredelapersonaquereportaaproteccion').css('border-color', '#D8D8D8');
		}
		if($('#txtPuestodelapersonaquereportaaproteccion').val() === ''){
			$('#txtPuestodelapersonaquereportaaproteccion').css('border-color', 'red');
	alert('No se puede continuar porque el campo * Puesto de la persona que reporta a protección está vacío');
			return false;
		}else{
			$('#txtPuestodelapersonaquereportaaproteccion').css('border-color', '#D8D8D8');
		}
		if($('#txtTipo1').val() === ''){
			$('#txtTipo1').css('border-color', 'red');
	alert('No se puede continuar porque el campo * Tipo está vacío');
			return false;
		}else{
			$('#txtTipo1').css('border-color', '#D8D8D8');
		}
		if($('#txtCalle').val() === ''){
			$('#txtCalle').css('border-color', 'red');
	alert('No se puede continuar porque el campo * Calle está vacío');
			return false;
		}else{
			$('#txtCalle').css('border-color', '#D8D8D8');
		}
		if($('#txtNumeroDireccion').val() === ''){
			$('#txtNumeroDireccion').css('border-color', 'red');
	alert('No se puede continuar porque el campo * Número está vacío');
			return false;
		}else{
			$('#txtNumeroDireccion').css('border-color', '#D8D8D8');
		}
		if($('#txtColonia').val() === ''){
			$('#txtColonia').css('border-color', 'red');
	alert('No se puede continuar porque el campo * Colonia está vacío');
			return false;
		}else{
			$('#txtColonia').css('border-color', '#D8D8D8');
		}
		if($('#txtMunicipio').val() === ''){
			$('#txtMunicipio').css('border-color', 'red');
	alert('No se puede continuar porque el campo * Municipio/Delegación está vacío');
			return false;
		}else{
			$('#txtMunicipio').css('border-color', '#D8D8D8');
		}
		if($('#txtEstado').val() === ''){
			$('#txtEstado').css('border-color', 'red');
	alert('No se puede continuar porque el campo * Estado  está vacío');
			return false;
		}else{
			$('#txtEstado').css('border-color', '#D8D8D8');
		}
		if($('#txtCodigoPostal').val() === ''){
			$('#txtCodigoPostal').css('border-color', 'red');
	alert('No se puede continuar porque el campo * Código postal está vacío');
			return false;
		}else{
			$('#txtCodigoPostal').css('border-color', '#D8D8D8');
		}
		if($('#tarObservacionesInformacionAdicional').val() === ''){
			$('#tarObservacionesInformacionAdicional').css('border-color', 'red');
	alert('No se puede continuar porque el campo * Observaciones/Información adicional está vacío');
			return false;
		}else{
			$('#tarObservacionesInformacionAdicional').css('border-color', '#D8D8D8');
		}
		return true;
	}

	function obtener() {
		var datos = [];
		var e = {
			'HoraOcurre': $('#txtHoraOcurre').val(),
			'HoraFinaliza': $('#txtHoraFinaliza').val(),
			'HoraReportanProteccion': $('#txtHoraAvisanProteccion').val(),
			'NombrePersonaReportaProteccion': $('#txtNombredelapersonaquereportaaproteccion').val(),
			'PuestoPersonaReportaProteccion': $('#txtPuestodelapersonaquereportaaproteccion').val(),
			'Tipo1': $('#txtTipo1').val(),
			'Calle': $('#txtCalle').val(),
			'Numero': $('#txtNumeroDireccion').val(),
			'Colonia': $('#txtColonia').val(),
			'MunicipioDelegacion': $('#txtMunicipio').val(),
			'Estado': $('#txtEstado').val(),
			'CodigoPostal': $('#txtCodigoPostal').val(),
			'ObservacionesInformacionAdiciona': $('#tarObservacionesInformacionAdicional').val(),
			'Identificador':$('#hdnidentificador').val(),
			'Estatus':$('#hdnestatus').val(),
			'NumeroReporte':$('#hdnnumero').val(),
			'NombreReporte':'DesastresNaturalesOtros'
		};
		datos.push(JSON.stringify(e));
		return datos;
	}

	function colocar(datos) {
		$('#txtHoraOcurre').val(datos.HoraOcurre),
		$('#txtHoraFinaliza').val(datos.HoraFinaliza),
		$('#txtHoraAvisanProteccion').val(datos.HoraReportanProteccion),
		$('#txtNombredelapersonaquereportaaproteccion').val(datos.NombrePersonaReportaProteccion),
		$('#txtPuestodelapersonaquereportaaproteccion').val(datos.PuestoPersonaReportaProteccion),
		$('#txtTipo1').val(datos.Tipo1),
		$('#txtCalle').val(datos.Calle),
		$('#txtNumeroDireccion').val(datos.Numero),
		$('#txtColonia').val(datos.Colonia),
		$('#txtMunicipio').val(datos.MunicipioDelegacion),
		$('#txtEstado').val(datos.Estado),
		$('#txtCodigoPostal').val(datos.CodigoPostal),
		$('#tarObservacionesInformacionAdicional').val(datos.ObservacionesInformacionAdiciona),
		$('#hdnidenficador').val(datos.Title),
		$('#hdnstatus').val(datos.Estatus),
		$('#hdnnuevo').val(datos.Nuevo),
		$('#hdnnumero').val(datos.NumeroReporte)
	}


	function DuplicarGrupo(claseDuplicados, elementChild) {
	    padreBoton = elementChild.parentNode;
	    padrePadreBoton = padreBoton.parentNode;
	    padrePadrePadreBoton = padrePadreBoton.parentNode;
	    padrePadrePadrePadreBoton = padrePadrePadreBoton.parentNode;
	    nombrePadre = padrePadrePadrePadreBoton.id;
	    
	    listaReportes = document.getElementsByClassName("BloqueReportesDinamicos");
	    for (i = 0; i < listaReportes.length; i++) {
	        if (listaReportes[i].id == nombrePadre) {
	            var totalListaDuplicacion = listaReportes[i].getElementsByClassName(claseDuplicados).length;
	            var listaDuplicacion = listaReportes[i].getElementsByClassName(claseDuplicados)[0];
	            break;
	        }
	    }
	
	    elementosDuplicar = listaDuplicacion.getElementsByTagName("div");
	    padreAnexar = listaDuplicacion.parentNode;
	
	    //contenedor de bloque
	    var divfinalcontenedor = document.createElement("div");
	    divfinalcontenedor.setAttribute("class", elementosDuplicar[0].className);
	
	    //contenedor clase
	    var divfinalcontenedorclase = document.createElement("div");
	    divfinalcontenedorclase.setAttribute("class", listaDuplicacion.className);
	    divfinalcontenedorclase.setAttribute("id", totalListaDuplicacion);
	
	    var inputeliminar = document.createElement("input");
	    inputeliminar.type = "button";
	    inputeliminar.setAttribute("onclick", 'EliminarBloqueDuplicacion(this);');
	    inputeliminar.setAttribute("class", 'bDinamico');
	    inputeliminar.value = "X";
	
	    divfinalcontenedorclase.appendChild(inputeliminar);
	    
	
	    for (i = 1; i < elementosDuplicar.length; i++) {
	        elementlabel = elementosDuplicar[i].getElementsByTagName("label")[0];
			elementText = elementosDuplicar[i].getElementsByClassName("text")[0];
			elementDate = elementosDuplicar[i].getElementsByClassName("date")[0];
			elementTime = elementosDuplicar[i].getElementsByClassName("tiempo")[0];
			elementNumero = elementosDuplicar[i].getElementsByClassName("numero")[0];
			elementoMoneda = elementosDuplicar[i].getElementsByClassName("moneda")[0];
			elementoArea = elementosDuplicar[i].getElementsByClassName("area")[0];
			elementoSelect = elementosDuplicar[i].getElementsByClassName("select")[0];
			
			
		var divfinal1 = document.createElement("div");
		divfinal1.setAttribute("class", elementosDuplicar[i].className);
	
	
			if(elementText === undefined || elementText === null) {
				if(elementNumero === undefined || elementNumero === null) {
					if(elementoMoneda === undefined || elementoMoneda === null) {
						if(elementoArea === undefined || elementoArea === null) {
							if(elementoSelect === undefined || elementoSelect === null) {
								if(elementDate === undefined || elementDate === null) {
									if(elementTime === undefined || elementTime === null) {
									}
									else {
					                    var lbl1 = document.createElement('label');
					                    lbl1.setAttribute("id", "lbl"+elementTime.id + totalListaDuplicacion);
					                    lbl1.innerHTML = elementlabel.innerHTML;
					
					                    var txb1 = document.createElement('input');
					                    txb1.type = "text";
					                    txb1.setAttribute("id", elementTime.id + totalListaDuplicacion);
					                    txb1.setAttribute("maxlength", elementTime.maxlength);
					                    txb1.setAttribute("class", elementTime.className);
					                    
					                    divfinal1.appendChild(lbl1);
					                    divfinal1.appendChild(txb1);
				                    }		
				                }					
								else {								
									console.log('Fecha');
				                    var lbl1 = document.createElement('label');
				                    lbl1.setAttribute("id", "lbl"+elementDate.id + totalListaDuplicacion);
				                    lbl1.innerHTML = elementlabel.innerHTML;
				
				                    var txb1 = document.createElement('input');
				                    txb1.type = "text";
				                    txb1.setAttribute("id", elementDate.id + totalListaDuplicacion);
				                    txb1.setAttribute("maxlength", elementDate.maxlength);
				                    txb1.setAttribute("class", elementDate.className);
				                    
				                    divfinal1.appendChild(lbl1);
				                    divfinal1.appendChild(txb1);
									
								}								
							}
							else {
								console.log('Select');
		                        var lbl1 = document.createElement('label');
		                        lbl1.setAttribute("id", "lbl"+ elementoSelect.id + totalListaDuplicacion);
		                        lbl1.innerHTML = elementlabel.innerHTML;
	
		                        var txb1 = document.createElement('select');
		                        /*
		                        for(c=0;c<elementoSelect.options.length;c++){
		                        	var ops = document.createElement('option');
		                        	ops.value = elementoSelect.options[c].value;
		                        	ops.text = elementoSelect.options[c].text;
		                        	txb1.appendChild(ops);
		                        }
		                        */
		                        txb1.setAttribute("id", elementoSelect.id + totalListaDuplicacion);
		                        txb1.setAttribute("class", elementoSelect.className);
		                        llenarObjSelect(txb1);

			                    divfinal1.appendChild(lbl1);
			                    divfinal1.appendChild(txb1);
		                        
							}
	                    }
	                    else {
							console.log('Text Area');
							var lbl1 = document.createElement('label');
	                        lbl1.setAttribute("id", "lbl"+ elementoArea .id + totalListaDuplicacion);
	                        lbl1.innerHTML = elementlabel.innerHTML;
	
	                        var txb1 = document.createElement('textarea');
	                        txb1.setAttribute("id", elementoArea .id + totalListaDuplicacion);
							txb1.setAttribute("maxlength", elementoArea .maxLength);
	                        txb1.setAttribute("class", elementoArea .className);
	                        
		                    divfinal1.appendChild(lbl1);
		                    divfinal1.appendChild(txb1);
	                        
	                    }
					}
					else {
						console.log('Moneda');							
						var lbl1 = document.createElement('label');
	                    lbl1.setAttribute("id", "lbl"+elementoMoneda .id + totalListaDuplicacion);
	                    lbl1.innerHTML = elementlabel.innerHTML;
	
	                    var txb1 = document.createElement('input');
	                    txb1.type = "text";
	                    txb1.setAttribute("id", elementoMoneda .id + totalListaDuplicacion);
	                    txb1.setAttribute("maxlength", elementoMoneda .maxlength);
	                    txb1.setAttribute("class", elementoMoneda .className);
	                    
	                    divfinal1.appendChild(lbl1);
	                    divfinal1.appendChild(txb1);
	                    
	                }
				}
				else {
					console.log('Numero');						
					var lbl1 = document.createElement('label');
	                lbl1.setAttribute("id", "lbl"+elementNumero .id + totalListaDuplicacion);
	                lbl1.innerHTML = elementlabel.innerHTML;
	
	                var txb1 = document.createElement('input');
	                txb1.type = "text";
	                txb1.setAttribute("id", elementNumero .id + totalListaDuplicacion);
	                txb1.setAttribute("maxlength", elementNumero .maxLength);
	                txb1.setAttribute("class", elementNumero .className);
	                
	                divfinal1.appendChild(lbl1);
	                divfinal1.appendChild(txb1);
	                
				}
			}
			else {
				console.log('Texto');	
				var lbl1 = document.createElement('label');
	            lbl1.setAttribute("id", "lbl"+elementText .id + totalListaDuplicacion);
	            lbl1.innerHTML = elementlabel.innerHTML;
	
	            var txb1 = document.createElement('input');
	            txb1.type = "text";
	            txb1.setAttribute("id", elementText .id + totalListaDuplicacion);
	            txb1.setAttribute("maxlength", elementText.maxLength);
	            txb1.setAttribute("class", elementText.className);
	            
	            divfinal1.appendChild(lbl1);
	            divfinal1.appendChild(txb1);
	
			}	
	        divfinalcontenedor.appendChild(divfinal1);
	    }	    
		console.log('cierra grupo');  	   
	    divfinalcontenedorclase.appendChild(divfinalcontenedor);
	    padreAnexar.appendChild(divfinalcontenedorclase);

		console.log('aplica jqueries');  	   	    

		$('.fecha').inputmask('datetime', {inputFormat:'dd/mm/yyyy'});
		$('.tiempo').inputmask('datetime', {inputFormat:'HH:MM'});
		$('.moneda').inputmask('currency');
		$('.numero').inputmask('numeric');


	    return;	    
	}

	function EliminarBloqueDuplicacion(element) {
		//console.log(element.id);
        elementParent = element.parentNode;
        elementParent.parentNode.removeChild(elementParent);
    }

	//Función llenar los selects
	function llenarObjSelect(objCombo, selectValue)
	{
		var cuenta = personProperties.get_accountName().split('|')[2];
		pais = obtenerPaisUsuario(cuenta);
		console.log(pais);

		console.log('objCombo.id = ' + objCombo.id);
		var stnames = objCombo.id.split('_');		
		console.log(stnames);
		var lstname = stnames[0];
		console.log(lstname);
		//console.log(objCombo, combo);
		var optionx = document.createElement("option");
		optionx.text = "...";
		optionx.value = null;
		objCombo.add(optionx);

		$.ajax({ 
			url: URL + "/_api/web/lists/getbytitle('" + lstname + "')/Items?$select=Title&$filter=Pa_x00ed_s eq '" + encodeURIComponent(pais) + "'",  
			type: "GET", 
			headers: {"accept": "application/json;odata=verbose"}, 
			success: function (data) 
			{
				if (data.d.results.length > 0) 
				{
					for (i = 0; i < data.d.results.length; i++) 
					{
		  				optionx = document.createElement("option");
		  				optionx.text = data.d.results[i].Title;
		  				optionx.value = data.d.results[i].Title;
		  				objCombo.add(optionx);
		 			}
		 			console.log("Seleccionando elemento: " +selectValue);
		 			$('#'+objCombo.id).val(selectValue);

				}
			}, 
			error: function (xhr) 
			{ 
				console.log(xhr.status + ': ' + xhr.statusText);
			} 
		}); 
	}
    function onExitoCargaEstados(sender, args) 
    {
        try 
        {
            var listItemEnumerator = this.collListItemEstados.getEnumerator();

            // Borra las opciones previas
            var myselect = document.getElementById("dtlEstado");

            while (listItemEnumerator.moveNext()) 
            {		
                        var existe = false;
                var oListItem = listItemEnumerator.get_current();

                if(oListItem.get_item('ClavePais').toUpperCase() != pais.toUpperCase())
                    continue;
                
                var txt = oListItem.get_item('NombreEstado');
                for(i = 0; i < myselect.options.length; i++)
                {
                	if(myselect.options[i].value == txt)
	                {
	                	existe = true;	                
	                }
                }
                if(existe)
                continue;
                newoption = document.createElement("option");
                newoption.text = txt;
                newoption.value = txt;
                myselect.appendChild(newoption);
            }
        }
        catch (e) 
        {
            console.log('onExitoCargaEstados', e);
        }
    }

    function onExitoCargaMun(sender, args) {
        try {
            var listItemEnumerator = this.collListItemMun.getEnumerator();

            // Borra las opciones previas
            var myselect = document.getElementById("dtlMun");
			var selected = document.getElementById("dtlEstado");
			console.log(selected);
			var tselected = document.getElementById("txtEstado");
			console.log(tselected.value);
            while (listItemEnumerator.moveNext()) 
            {		
                var oListItem = listItemEnumerator.get_current();
                if(oListItem.get_item('ClavePais').toUpperCase() != pais.toUpperCase())
                    continue;
                    
                newoption = document.createElement("option");
                newoption.text = oListItem.get_item('NombreMunicipio');
                newoption.value = oListItem.get_item('NombreMunicipio');
                myselect.appendChild(newoption);
            }
        }
        catch (e) {
            console.log('onExitoCargaMun', e);
        }
    }

    function onCargaError(sender, args) {
        console.log('Request failed. ' + args.get_message() + '\n' + args.get_stackTrace());
    }

    function getEstados()
   	{
		var URL = "https://cocacolafemsa.sharepoint.com/sites/SWPP";   	
		var clientContext = new SP.ClientContext(URL);
		var oListEstados = clientContext.get_web().get_lists().getByTitle('LstUbicacionEstado');
		
		var camlQuery = new SP.CamlQuery();
		camlQuery.set_viewXml('');
		this.collListItemEstados = oListEstados.getItems(camlQuery);
		
		clientContext.load(this.collListItemEstados);
		clientContext.executeQueryAsync(Function.createDelegate(this, this.onExitoCargaEstados), Function.createDelegate(this, this.onCargaError));
   	}
	function getMun()
	{
		var URL = "https://cocacolafemsa.sharepoint.com/sites/SWPP";        
        var clientContextMun = new SP.ClientContext(URL);
        var oListMun = clientContextMun.get_web().get_lists().getByTitle('LstUbicacionMunicipio');
        
        var camlQueryMun = new SP.CamlQuery();
        camlQueryMun.set_viewXml('');
        this.collListItemMun = oListMun.getItems(camlQueryMun);

        clientContextMun.load(this.collListItemMun);
        clientContextMun.executeQueryAsync(Function.createDelegate(this, this.onExitoCargaMun), Function.createDelegate(this, this.onCargaError));
	}
	function getLugarTraslado()
	{	
		var lbl = document.getElementById('lblLugardeTraslado');
		var txt = document.getElementById('txtLugardeTraslado');
		var ops = $('#LstOcupaTraslado_ option:selected').text();
		if(ops.toUpperCase() != 'SI')
		{
			lbl.style.visibility = 'hidden';
			txt.style.visibility = 'hidden';
		}
		else
		{
			lbl.style.visibility = 'visible';
			txt.style.visibility = 'visible';
		}
	}
	function getLugarTraslado2(opc)
	{
		var lbl = document.getElementById('lblLugardeTraslado');
		var txt = document.getElementById('txtLugardeTraslado');
		if(opc.toUpperCase() != 'SI')
		{
			lbl.style.visibility = 'hidden';
			txt.style.visibility = 'hidden';
		}
		else
		{
			lbl.style.visibility = 'visible';
			txt.style.visibility = 'visible';
		}
	}
	function getEspecificaArma()
	{
		var lbl = document.getElementById('lblEspecificaArma');
		var txt = document.getElementById('txtEspecificaArma');
		var ops = $('#LstTipoArma_ option:selected').text();
		if(ops.toUpperCase() != 'OTROS')
		{
			lbl.style.visibility = 'hidden';
			txt.style.visibility = 'hidden';
		}
		else
		{
			lbl.style.visibility = 'visible';
			txt.style.visibility = 'visible';
		}
	}
	function getEspecificaArma2(opc)
	{
		console.log('entro EspecificaArma');
		var lbl = document.getElementById('lblEspecificaArma');		
		var txt = document.getElementById('txtEspecificaArma');
		console.log(opc.toUpperCase());
		if(opc.toUpperCase() != 'OTROS')
		{
			lbl.style.visibility = 'hidden';
			txt.style.visibility = 'hidden';
		}
		else
		{
			lbl.style.visibility = 'visible';
			txt.style.visibility = 'visible';
		}
	}
	function getRespaldo()
	{
		var lbld = document.getElementById('lblDesRespaldo');
		var txtd = document.getElementById('txtDesRespaldo');

		var lblm = document.getElementById('lblMontoRespaldo');
		var txtm = document.getElementById('txtMontoRespaldo');
		var ops = $('#LstRespaldo_ option:selected').text();
		if(ops.toUpperCase() != 'SI')
		{
	
			lbld.style.visibility = 'hidden';
			txtd.style.visibility = 'hidden';
			lblm.style.visibility = 'visible';
			txtm.style.visibility = 'visible';
		}
		else
		{
			lbld.style.visibility = 'visible';
			txtd.style.visibility = 'visible';
			lblm.style.visibility = 'hidden';
			txtm.style.visibility = 'hidden';
		}
	}
	function getRespaldo2(ops)
	{
		var lbld = document.getElementById('lblDesRespaldo');
		var txtd = document.getElementById('txtDesRespaldo');

		var lblm = document.getElementById('lblMontoRespaldo');
		var txtm = document.getElementById('txtMontoRespaldo');

		if(ops.toUpperCase() != 'SI')
		{
	
			lbld.style.visibility = 'hidden';
			txtd.style.visibility = 'hidden';
			lblm.style.visibility = 'visible';
			txtm.style.visibility = 'visible';
		}
		else
		{
			lbld.style.visibility = 'visible';
			txtd.style.visibility = 'visible';
			lblm.style.visibility = 'hidden';
			txtm.style.visibility = 'hidden';
		}
	}
var SelectedItem;





</script>
</head>
<body>
	<div id="ReportesDinamicos" class="container">
		<div id="Reporte_2" class="BloqueReportesDinamicos">
<h3 id="lblDesastresNaturalesOtros">DesastresNaturalesOtros</h3>
	<div id="ctHoraEvento" class='container'>
		<div class='col-xs-12 col-sm-12 col-md-12 col-lg-12'>
			<div class='col-xs-6 col-md-4 col-lg-3 col-xl-3 form-group'>
				<label  id='lblHoraOcurre'>* Hora en que ocurre</label>
				<div class='input-group time' id='HoraOcurre'>
					<input type='text' class='form-control' id="txtHoraOcurre"/>
					<span class='input-group-addon'>
						<span class='glyphicon glyphicon-time'></span>
					</span>
				</div>
			</div>
			<div class='col-xs-6 col-md-4 col-lg-3 col-xl-3 form-group'>
				<label  id='lblHoraFinaliza'>* Hora en que finaliza</label>
				<div class='input-group time' id='HoraFinaliza'>
					<input type='text' class='form-control' id="txtHoraFinaliza"/>
					<span class='input-group-addon'>
						<span class='glyphicon glyphicon-time'></span>
					</span>
				</div>
			</div>
		</div>
	</div>
	<div id="ctHoraEvento" class='container'>
		<div class='col-xs-12 col-sm-12 col-md-12 col-lg-12'>
			<div class='col-xs-6 col-md-4 col-lg-3 col-xl-3 form-group'>
				<label  id='lblHoraAvisanProteccion'>* Hora en que reportan a protección</label>
				<div class='input-group time' id='HoraAvisanProteccion'>
					<input type='text' class='form-control' id="txtHoraAvisanProteccion"/>
					<span class='input-group-addon'>
						<span class='glyphicon glyphicon-time'></span>
					</span>
				</div>
			</div>
			<div class='col-xs-6 col-md-4 col-lg-3 col-xl-3 form-group'>
				<label class='control-label' id= 'lblNombredelapersonaquereportaaproteccion'  >* Nombre de la persona que reporta a protección</label>
				<input class='form-control' idvariabledepende ='Nombredelapersonaquereportaaproteccion' maxlength='50' id='txtNombredelapersonaquereportaaproteccion' type='text'  />
			</div>
			<div class='col-xs-6 col-md-4 col-lg-3 col-xl-3 form-group'>
				<label class='control-label' id= 'lblPuestodelapersonaquereportaaproteccion'  >* Puesto de la persona que reporta a protección</label>
				<input class='form-control' idvariabledepende ='Puestodelapersonaquereportaaproteccion' maxlength='50' id='txtPuestodelapersonaquereportaaproteccion' type='text'  />
			</div>
		</div>
	</div>
	<div id="ctHoraEvento" class='container'>
		<div class='col-xs-12 col-sm-12 col-md-12 col-lg-12'>
			<div class='col-xs-6 col-md-4 col-lg-3 col-xl-3 form-group'>
				<label class='control-label' id= 'lblTipo1'  >* Tipo</label>
				<input class='form-control' idvariabledepende ='Tipo1' maxlength='100' id='txtTipo1' type='text'  />
			</div>
		</div>
	</div>
	<div id="ctHoraEvento" class='container'>
		<div class='col-xs-12 col-sm-12 col-md-12 col-lg-12'>
			<div class='col-xs-6 col-md-4 col-lg-3 col-xl-3 form-group'>
				<label class='control-label' id= 'lblCalle'  >* Calle</label>
				<input class='form-control' idvariabledepende ='Calle' maxlength='100' id='txtCalle' type='text'  />
			</div>
			<div class='col-xs-6 col-md-4 col-lg-3 col-xl-3 form-group'>
				<label class='control-label' id= 'lblNumeroDireccion'  >* Número</label>
				<input class='form-control numero' idvariabledepende ='NumeroDireccion' maxlength='100' id='txtNumeroDireccion' type='text'  />
			</div>
			<div class='col-xs-6 col-md-4 col-lg-3 col-xl-3 form-group'>
				<label class='control-label' id= 'lblColonia'  >* Colonia</label>
				<input class='form-control' idvariabledepende ='Colonia' maxlength='100' id='txtColonia' type='text'  />
			</div>
			<div class='col-xs-6 col-md-4 col-lg-3 col-xl-3 form-group'>
				<label class='control-label' id= 'lblMunicipio'  list='dtlMun' onfocus='getMun();'>* Municipio/Delegación</label>
				<input class='form-control' idvariabledepende ='Municipio' maxlength='100' id='txtMunicipio' type='text'  list='dtlMun' onfocus='getMun();'/>
				<datalist id='dtlMun'></datalist>
			</div>
			<div class='col-xs-6 col-md-4 col-lg-3 col-xl-3 form-group'>
				<label class='control-label' id= 'lblEstado'  list='dtlEstado' onfocus='getEstados();'>* Estado </label>
				<input class='form-control' idvariabledepende ='Estado' maxlength='50' id='txtEstado' type='text'  list='dtlEstado' onfocus='getEstados();'/>
				<datalist id='dtlEstado'></datalist>
			</div>
			<div class='col-xs-6 col-md-4 col-lg-3 col-xl-3 form-group'>
				<label class='control-label' id= 'lblCodigoPostal'  >* Código postal</label>
				<input class='form-control numero' idvariabledepende ='CodigoPostal' maxlength='100' id='txtCodigoPostal' type='text'  />
			</div>
		</div>
	</div>
	<div id="ctHoraEvento" class='container'>
		<div class='col-xs-12 col-sm-12 col-md-12 col-lg-12'>
			<div class='col-xs-12 col-md-12 col-lg-12 col-xl-12 form-group'>
				<label class='obligatorio etiquetaM control-label'  >* Observaciones/Información adicional</label>
				<textarea maxlength='5000' id='tarObservacionesInformacionAdicional' class='form-control' rows='5'  ></textarea>
			</div>
		</div>
	</div>

			<input type='button' id='btnAgregar' value='Agregar'/>
		</div>
	</div>
	<input type="hidden" id="hdnidentificador" value=""/>
	<input type="hidden" id="hdnnumero" value=""/>
	<input type="hidden" id="hdnestatus" value="Espera"/>
	<input type="hidden" id="hdngua" value="true"/>
	<span id="lblCamposFaltantes" style="display:none">Faltan campos por llenar</span>
	<span id="lblAgregarExito" style="display:none">El reporte se ha agregado con éxito</span>
	<span id="lblAgregarAviso" style="display:none">El reporte capturado se va a agregar el reporte principal</span>
</body>
</html>
