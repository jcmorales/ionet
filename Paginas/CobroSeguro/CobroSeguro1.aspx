<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ Page Language="C#" %>
<%@ Register tagprefix="SharePoint" namespace="Microsoft.SharePoint.WebControls" assembly="Microsoft.SharePoint, Version = 15.0.0.0, Culture = neutral, PublicKeyToken = 71e9bce111e9429c" %>
<html dir="ltr" xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<!--Documento generado de manera dinámica por SPFormsEasy -->
<!--Nombre del documento: CobroSeguro -->
<!--Creado por: Luis Alonso Escalona Morales -->
<!--Creado el: 23/01/2018 -->
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
<!--JS Operación-->
<script type ="text/javascript">
	var cont_PersonasInvolucradas = 0;
	var cont_Equipos = 0;
	var cont_Clientes = 0;
	var cont_Vehiculo = 0;
	var cont_Rutas = 0;
	var personProperties;
	var clientContext;
	var etiquetascontroles = [];
	var pais;
	var URL = "https://cocacolafemsa.sharepoint.com/sites/SWPP";
	$(document).ready(function () {
		SP.SOD.executeOrDelayUntilScriptLoaded(getCurrentUser, 'SP.UserProfiles.js');
		$('#NumeroPersonasInvolucradas').on('click', contarPersonasInvolucradas);
		$('#NumeroEquipos').on('click', contarEquipos);
		$('#NumeroClientes').on('click', contarClientes);
		$('#NumeroVehiculo').on('click', contarVehiculo);
		$('#NumeroRutas').on('click', contarRutas);
		$('#btnAgregar').on('click', agregar);
		$('#HNBR').text($.get('NBR'));


		$('.time').on('focus blur', validaHora);
		$('.time').datetimepicker({
			format: 'HH:mm'
		});

		$('.date').datetimepicker({
			format: 'DD/MM/YYYY'
		});

		$('.moneda').priceFormat({
			prefix: '$ ',
			centsSeparator: '.', 
			thousandsSeparator: ','
		});

		$('.numero').priceFormat({
			prefix: '',
			centsSeparator: '.', 
			thousandsSeparator: ','
		});

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
EliminarDatosPersonasInvolucradas($('#hdnidentificador').val(), $('#hdnnumero').val());
EliminarDatosEquipos($('#hdnidentificador').val(), $('#hdnnumero').val());
EliminarDatosClientes($('#hdnidentificador').val(), $('#hdnnumero').val());
EliminarDatosVehiculo($('#hdnidentificador').val(), $('#hdnnumero').val());
EliminarDatosRutas($('#hdnidentificador').val(), $('#hdnnumero').val());
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
			url: URL + "/_api/web/lists/getbytitle('TR_CobroSeguro')/Items?$select=ID&$filter=Title eq '" + encodeURIComponent(folio) + "' and NumeroReporte eq '" + encodeURIComponent(reporte) + "'", 
			type: "GET", 
			async: false,
			headers:{"accept":"application/json;odata=verbose"}, 
			success: function (data) { 
				if (data.d.results) { 
					EliminarDatos('TR_CobroSeguro', data.d.results[0].ID, clientContext);
				} 
			}, 
			error: function (xhr) { 
				alert('EliminarReporte ' + xhr.status + ': ' + xhr.statusText); 
			}
		});
	}
	function EliminarDatosPersonasInvolucradas(folio, reporte){
		$.ajax({ 
			url: URL + "/_api/web/lists/getbytitle('DN_PersonasInvolucradas')/Items?$select=ID&$filter=Folio eq '"+encodeURIComponent(folio)+"' and NoReporte eq '"+encodeURIComponent(reporte)+"'", 
			type: "GET", 
			async: false,
			headers:{"accept":"application/json;odata=verbose"}, 
			success: function (data) {
				if (data.d.results) {
					for(var i = 0; i < data.d.results.length;i++){
						EliminarDatos('DN_PersonasInvolucradas', data.d.results[i].ID, clientContext);
					} 
				} 
			},
			error: function (xhr) { 
				alert('Eliminar Datos ' + xhr.status + ': ' + xhr.statusText); 
			} 
		}); 
	}



	function EliminarDatosEquipos(folio, reporte){
		$.ajax({ 
			url: URL + "/_api/web/lists/getbytitle('DN_Equipo')/Items?$select=ID&$filter=Folio eq '"+encodeURIComponent(folio)+"' and NoReporte eq '"+encodeURIComponent(reporte)+"'", 
			type: "GET", 
			async: false,
			headers:{"accept":"application/json;odata=verbose"}, 
			success: function (data) {
				if (data.d.results) {
					for(var i = 0; i < data.d.results.length;i++){
						EliminarDatos('DN_Equipo', data.d.results[i].ID, clientContext);
					} 
				} 
			},
			error: function (xhr) { 
				alert('Eliminar Datos ' + xhr.status + ': ' + xhr.statusText); 
			} 
		}); 
	}



	function EliminarDatosClientes(folio, reporte){
		$.ajax({ 
			url: URL + "/_api/web/lists/getbytitle('DN_Cliente')/Items?$select=ID&$filter=Folio eq '"+encodeURIComponent(folio)+"' and NoReporte eq '"+encodeURIComponent(reporte)+"'", 
			type: "GET", 
			async: false,
			headers:{"accept":"application/json;odata=verbose"}, 
			success: function (data) {
				if (data.d.results) {
					for(var i = 0; i < data.d.results.length;i++){
						EliminarDatos('DN_Cliente', data.d.results[i].ID, clientContext);
					} 
				} 
			},
			error: function (xhr) { 
				alert('Eliminar Datos ' + xhr.status + ': ' + xhr.statusText); 
			} 
		}); 
	}



	function EliminarDatosVehiculo(folio, reporte){
		$.ajax({ 
			url: URL + "/_api/web/lists/getbytitle('DN_Vehiculo')/Items?$select=ID&$filter=Folio eq '"+encodeURIComponent(folio)+"' and NoReporte eq '"+encodeURIComponent(reporte)+"'", 
			type: "GET", 
			async: false,
			headers:{"accept":"application/json;odata=verbose"}, 
			success: function (data) {
				if (data.d.results) {
					for(var i = 0; i < data.d.results.length;i++){
						EliminarDatos('DN_Vehiculo', data.d.results[i].ID, clientContext);
					} 
				} 
			},
			error: function (xhr) { 
				alert('Eliminar Datos ' + xhr.status + ': ' + xhr.statusText); 
			} 
		}); 
	}



	function EliminarDatosRutas(folio, reporte){
		$.ajax({ 
			url: URL + "/_api/web/lists/getbytitle('DN_Ruta')/Items?$select=ID&$filter=Folio eq '"+encodeURIComponent(folio)+"' and NoReporte eq '"+encodeURIComponent(reporte)+"'", 
			type: "GET", 
			async: false,
			headers:{"accept":"application/json;odata=verbose"}, 
			success: function (data) {
				if (data.d.results) {
					for(var i = 0; i < data.d.results.length;i++){
						EliminarDatos('DN_Ruta', data.d.results[i].ID, clientContext);
					} 
				} 
			},
			error: function (xhr) { 
				alert('Eliminar Datos ' + xhr.status + ': ' + xhr.statusText); 
			} 
		}); 
	}



	function guardarDatosB(datos, clientContext) {
		guardarReporteB(datos[0], clientContext);
		var info = JSON.parse(datos[0]);
		for(var i = 0; i<datos[1].length; i++) {
		guardarReportePersonasInvolucradasB(datos[1][i], info.Identificador, info.NumeroReporte, info.Estatus, clientContext);
		}

		for(var i = 0; i<datos[2].length; i++) {
		guardarReporteEquiposB(datos[2][i], info.Identificador, info.NumeroReporte, info.Estatus, clientContext);
		}

		for(var i = 0; i<datos[3].length; i++) {
		guardarReporteClientesB(datos[3][i], info.Identificador, info.NumeroReporte, info.Estatus, clientContext);
		}

		for(var i = 0; i<datos[4].length; i++) {
		guardarReporteVehiculoB(datos[4][i], info.Identificador, info.NumeroReporte, info.Estatus, clientContext);
		}

		for(var i = 0; i<datos[5].length; i++) {
		guardarReporteRutasB(datos[5][i], info.Identificador, info.NumeroReporte, info.Estatus, clientContext);
		}

	}

	function guardarReporteB(d, clientContext) {
		try {
			var datos = JSON.parse(d);
			var oList = clientContext.get_web().get_lists().getByTitle('TR_CobroSeguro');
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
			oListItemDatos.set_item('Calle', datos.Calle);
			oListItemDatos.set_item('Colonia', datos.Colonia);
			oListItemDatos.set_item('MunicipioDelegacion', datos.MunicipioDelegacion);
			oListItemDatos.set_item('Estado', datos.Estado);
			oListItemDatos.set_item('CodigoPostal', datos.CodigoPostal);
			oListItemDatos.set_item('Reincidente', datos.Reincidente);
			oListItemDatos.set_item('CumplePolitica', datos.CumplePolitica);
			oListItemDatos.set_item('AcumulacionMonto', datos.AcumulacionMonto);
			oListItemDatos.set_item('MontoEfectivo', datos.MontoEfectivo);
			oListItemDatos.set_item('Respaldo', datos.Respaldo);
			oListItemDatos.set_item('descrpcionderespaldo', datos.descrpcionderespaldo);
			oListItemDatos.set_item('ObservacionesInformacionAdiciona', datos.ObservacionesInformacionAdiciona);

			oListItemDatos.update();
			clientContext.load(oListItemDatos);
		}catch (e) {
			alert(e);
		}
	}

	function guardarReportePersonasInvolucradasB(d, padre, numero, estatus, clientContext) { 
		try {
			var datos = JSON.parse(d);
			var oList = clientContext.get_web().get_lists().getByTitle('DN_PersonasInvolucradas');
			var itemCreateInfo = new SP.ListItemCreationInformation();
			this.oListItemDatos = oList.addItem(itemCreateInfo);

			oListItemDatos.set_item('Folio', padre );
			oListItemDatos.set_item('NoReporte', numero );
			oListItemDatos.set_item('Estatus', estatus);
			oListItemDatos.set_item('NombrePersona', datos.NombrePersona);
			oListItemDatos.set_item('Area', datos.Area);
			oListItemDatos.set_item('NoEmpleado', datos.NoEmpleado);
			oListItemDatos.set_item('Empresa', datos.Empresa);

			oListItemDatos.update();
			clientContext.load(oListItemDatos);
		}catch (e) {
			alert(e);
		}
	}

	function guardarReporteEquiposB(d, padre, numero, estatus, clientContext) { 
		try {
			var datos = JSON.parse(d);
			var oList = clientContext.get_web().get_lists().getByTitle('DN_Equipo');
			var itemCreateInfo = new SP.ListItemCreationInformation();
			this.oListItemDatos = oList.addItem(itemCreateInfo);

			oListItemDatos.set_item('Folio', padre );
			oListItemDatos.set_item('NoReporte', numero );
			oListItemDatos.set_item('Estatus', estatus);
			oListItemDatos.set_item('Numero', datos.Numero);

			oListItemDatos.update();
			clientContext.load(oListItemDatos);
		}catch (e) {
			alert(e);
		}
	}

	function guardarReporteClientesB(d, padre, numero, estatus, clientContext) { 
		try {
			var datos = JSON.parse(d);
			var oList = clientContext.get_web().get_lists().getByTitle('DN_Cliente');
			var itemCreateInfo = new SP.ListItemCreationInformation();
			this.oListItemDatos = oList.addItem(itemCreateInfo);

			oListItemDatos.set_item('Folio', padre );
			oListItemDatos.set_item('NoReporte', numero );
			oListItemDatos.set_item('Estatus', estatus);
			oListItemDatos.set_item('Cliente', datos.Cliente);
			oListItemDatos.set_item('HorarioPresentoConCliente', datos.HorarioPresentoConCliente);
			oListItemDatos.set_item('MontoCliente', datos.MontoCliente);

			oListItemDatos.update();
			clientContext.load(oListItemDatos);
		}catch (e) {
			alert(e);
		}
	}

	function guardarReporteVehiculoB(d, padre, numero, estatus, clientContext) { 
		try {
			var datos = JSON.parse(d);
			var oList = clientContext.get_web().get_lists().getByTitle('DN_Vehiculo');
			var itemCreateInfo = new SP.ListItemCreationInformation();
			this.oListItemDatos = oList.addItem(itemCreateInfo);

			oListItemDatos.set_item('Folio', padre );
			oListItemDatos.set_item('NoReporte', numero );
			oListItemDatos.set_item('Estatus', estatus);
			oListItemDatos.set_item('Ruta', datos.Ruta);
			oListItemDatos.set_item('Placas', datos.Placas);
			oListItemDatos.set_item('Economico', datos.Economico);

			oListItemDatos.update();
			clientContext.load(oListItemDatos);
		}catch (e) {
			alert(e);
		}
	}

	function guardarReporteRutasB(d, padre, numero, estatus, clientContext) { 
		try {
			var datos = JSON.parse(d);
			var oList = clientContext.get_web().get_lists().getByTitle('DN_Ruta');
			var itemCreateInfo = new SP.ListItemCreationInformation();
			this.oListItemDatos = oList.addItem(itemCreateInfo);

			oListItemDatos.set_item('Folio', padre );
			oListItemDatos.set_item('NoReporte', numero );
			oListItemDatos.set_item('Estatus', estatus);
			oListItemDatos.set_item('numeroderutas', datos.numeroderutas);

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

		comboReincidente("selReincidente", pais);
		comboCumplepolitica("selCumpleconlapolitica", pais);

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

				llenarDatosPersonasInvolucradas(id, numero);

				llenarDatosEquipos(id, numero);

				llenarDatosClientes(id, numero);

				llenarDatosVehiculo(id, numero);

				llenarDatosRutas(id, numero);

				$('#hdngua').val(false);
			}
			if(estado == 'Ver') {
				llenarDatos(id, numero);

				llenarDatosPersonasInvolucradas(id, numero);

				llenarDatosEquipos(id, numero);

				llenarDatosClientes(id, numero);

				llenarDatosVehiculo(id, numero);

				llenarDatosRutas(id, numero);

				bloquear();
			}
		}
	}
	function llenarDatosPersonasInvolucradas(folio, reporte){
		$.ajax({
			url:URL + "/_api/web/lists/getbytitle('DN_PersonasInvolucradas')/Items?$select=ID&$filter=Folio eq '" + encodeURIComponent(folio) + "' and NoReporte eq '" + encodeURIComponent(reporte) + "'",
			type: "GET",
async: false,
			headers: {"accept": "application/json;odata=verbose"},
			success: function(data) {
				if(data.d.results) {
					for(var i = 0; i < data.d.results.length; i++) {
						$('#NumeroPersonasInvolucradas').click();
					}
					for(var i = 0; i < data.d.results.length; i++) {
						obtenerPersonasInvolucradas(data.d.results[i].ID, i + 1);
					}
				}
			},
			error: function (xhr) {
				alert('llenar Datos PersonasInvolucradas ' + xhr.status + ': ' + xhr.statusText);
			}
		});
	}

	function obtenerPersonasInvolucradas(identificador, campo) {
		$.ajax({
			url:URL + "/_api/web/lists/getbytitle('DN_PersonasInvolucradas')/Items?$select= NombrePersona,Area,NoEmpleado,Empresa&$orderby=ID &$filter=ID eq '" + encodeURIComponent(identificador) + "'",
			type: "GET",
async: false,
			headers: {"accept": "application/json;odata=verbose"},
			success: function (data) {
				if (data.d.results) {
					$('#txtNombrePersonasInvolucradas' + campo).val(data.d.results[0].NombrePersona);
					$('#txtAreaPersonasInvolucradas' + campo).val(data.d.results[0].Area);
					$('#txtNumeroEmpleadoPersonasInvolucradas' + campo).val(data.d.results[0].NoEmpleado);
					$('#txtEmpresaPersonasInvolucradas' + campo).val(data.d.results[0].Empresa);
					if($.get('EDO') == 'Ver') {
						$('#txtNombrePersonasInvolucradas' + campo).prop('disabled', true);
						$('#txtAreaPersonasInvolucradas' + campo).prop('disabled', true);
						$('#txtNumeroEmpleadoPersonasInvolucradas' + campo).prop('disabled', true);
						$('#txtEmpresaPersonasInvolucradas' + campo).prop('disabled', true);
					}
				}
			},
			error: function (xhr) {
				alert('obtenerPersonasInvolucradas ' + xhr.status + ': ' + xhr.statusText);
			}
		});
	}
	function llenarDatosEquipos(folio, reporte){
		$.ajax({
			url:URL + "/_api/web/lists/getbytitle('DN_Equipo')/Items?$select=ID&$filter=Folio eq '" + encodeURIComponent(folio) + "' and NoReporte eq '" + encodeURIComponent(reporte) + "'",
			type: "GET",
async: false,
			headers: {"accept": "application/json;odata=verbose"},
			success: function(data) {
				if(data.d.results) {
					for(var i = 0; i < data.d.results.length; i++) {
						$('#NumeroEquipos').click();
					}
					for(var i = 0; i < data.d.results.length; i++) {
						obtenerEquipos(data.d.results[i].ID, i + 1);
					}
				}
			},
			error: function (xhr) {
				alert('llenar Datos Equipos ' + xhr.status + ': ' + xhr.statusText);
			}
		});
	}

	function obtenerEquipos(identificador, campo) {
		$.ajax({
			url:URL + "/_api/web/lists/getbytitle('DN_Equipo')/Items?$select= Numero&$orderby=ID &$filter=ID eq '" + encodeURIComponent(identificador) + "'",
			type: "GET",
async: false,
			headers: {"accept": "application/json;odata=verbose"},
			success: function (data) {
				if (data.d.results) {
					$('#txtNumero' + campo).val(data.d.results[0].Numero);
					if($.get('EDO') == 'Ver') {
						$('#txtNumero' + campo).prop('disabled', true);
					}
				}
			},
			error: function (xhr) {
				alert('obtenerEquipos ' + xhr.status + ': ' + xhr.statusText);
			}
		});
	}
	function llenarDatosClientes(folio, reporte){
		$.ajax({
			url:URL + "/_api/web/lists/getbytitle('DN_Cliente')/Items?$select=ID&$filter=Folio eq '" + encodeURIComponent(folio) + "' and NoReporte eq '" + encodeURIComponent(reporte) + "'",
			type: "GET",
async: false,
			headers: {"accept": "application/json;odata=verbose"},
			success: function(data) {
				if(data.d.results) {
					for(var i = 0; i < data.d.results.length; i++) {
						$('#NumeroClientes').click();
					}
					for(var i = 0; i < data.d.results.length; i++) {
						obtenerClientes(data.d.results[i].ID, i + 1);
					}
				}
			},
			error: function (xhr) {
				alert('llenar Datos Clientes ' + xhr.status + ': ' + xhr.statusText);
			}
		});
	}

	function obtenerClientes(identificador, campo) {
		$.ajax({
			url:URL + "/_api/web/lists/getbytitle('DN_Cliente')/Items?$select= Cliente,HorarioPresentoConCliente,MontoCliente&$orderby=ID &$filter=ID eq '" + encodeURIComponent(identificador) + "'",
			type: "GET",
async: false,
			headers: {"accept": "application/json;odata=verbose"},
			success: function (data) {
				if (data.d.results) {
					$('#txtCliente' + campo).val(data.d.results[0].Cliente);
					$('#txtHorarioPresentoCliente' + campo).val(data.d.results[0].HorarioPresentoConCliente);
					$('#txtMontoCliente' + campo).val(data.d.results[0].MontoCliente);
					if($.get('EDO') == 'Ver') {
						$('#txtCliente' + campo).prop('disabled', true);
						$('#txtHorarioPresentoCliente' + campo).prop('disabled', true);
						$('#txtMontoCliente' + campo).prop('disabled', true);
					}
				}
			},
			error: function (xhr) {
				alert('obtenerClientes ' + xhr.status + ': ' + xhr.statusText);
			}
		});
	}
	function llenarDatosVehiculo(folio, reporte){
		$.ajax({
			url:URL + "/_api/web/lists/getbytitle('DN_Vehiculo')/Items?$select=ID&$filter=Folio eq '" + encodeURIComponent(folio) + "' and NoReporte eq '" + encodeURIComponent(reporte) + "'",
			type: "GET",
async: false,
			headers: {"accept": "application/json;odata=verbose"},
			success: function(data) {
				if(data.d.results) {
					for(var i = 0; i < data.d.results.length; i++) {
						$('#NumeroVehiculo').click();
					}
					for(var i = 0; i < data.d.results.length; i++) {
						obtenerVehiculo(data.d.results[i].ID, i + 1);
					}
				}
			},
			error: function (xhr) {
				alert('llenar Datos Vehiculo ' + xhr.status + ': ' + xhr.statusText);
			}
		});
	}

	function obtenerVehiculo(identificador, campo) {
		$.ajax({
			url:URL + "/_api/web/lists/getbytitle('DN_Vehiculo')/Items?$select= Ruta,Placas,Economico&$orderby=ID &$filter=ID eq '" + encodeURIComponent(identificador) + "'",
			type: "GET",
async: false,
			headers: {"accept": "application/json;odata=verbose"},
			success: function (data) {
				if (data.d.results) {
					$('#txtRuta' + campo).val(data.d.results[0].Ruta);
					$('#txtPlacas' + campo).val(data.d.results[0].Placas);
					$('#txtEconomico' + campo).val(data.d.results[0].Economico);
					if($.get('EDO') == 'Ver') {
						$('#txtRuta' + campo).prop('disabled', true);
						$('#txtPlacas' + campo).prop('disabled', true);
						$('#txtEconomico' + campo).prop('disabled', true);
					}
				}
			},
			error: function (xhr) {
				alert('obtenerVehiculo ' + xhr.status + ': ' + xhr.statusText);
			}
		});
	}
	function llenarDatosRutas(folio, reporte){
		$.ajax({
			url:URL + "/_api/web/lists/getbytitle('DN_Ruta')/Items?$select=ID&$filter=Folio eq '" + encodeURIComponent(folio) + "' and NoReporte eq '" + encodeURIComponent(reporte) + "'",
			type: "GET",
async: false,
			headers: {"accept": "application/json;odata=verbose"},
			success: function(data) {
				if(data.d.results) {
					for(var i = 0; i < data.d.results.length; i++) {
						$('#NumeroRutas').click();
					}
					for(var i = 0; i < data.d.results.length; i++) {
						obtenerRutas(data.d.results[i].ID, i + 1);
					}
				}
			},
			error: function (xhr) {
				alert('llenar Datos Rutas ' + xhr.status + ': ' + xhr.statusText);
			}
		});
	}

	function obtenerRutas(identificador, campo) {
		$.ajax({
			url:URL + "/_api/web/lists/getbytitle('DN_Ruta')/Items?$select= numeroderutas&$orderby=ID &$filter=ID eq '" + encodeURIComponent(identificador) + "'",
			type: "GET",
async: false,
			headers: {"accept": "application/json;odata=verbose"},
			success: function (data) {
				if (data.d.results) {
					$('#txtnumeroderutas' + campo).val(data.d.results[0].numeroderutas);
					if($.get('EDO') == 'Ver') {
						$('#txtnumeroderutas' + campo).prop('disabled', true);
					}
				}
			},
			error: function (xhr) {
				alert('obtenerRutas ' + xhr.status + ': ' + xhr.statusText);
			}
		});
	}

	function llenarDatos(folio, reporte){
		$.ajax({
			url:URL + "/_api/web/lists/getbytitle('TR_CobroSeguro')/Items?$select=ID&$filter=Title eq '" + encodeURIComponent(folio) + "' and NumeroReporte eq '" + encodeURIComponent(reporte) + "'",
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
			url:URL + "/_api/web/lists/getbytitle('TR_CobroSeguro')/Items?$select= HoraOcurre,HoraFinaliza,HoraReportanProteccion,NombrePersonaReportaProteccion,PuestoPersonaReportaProteccion,Calle,Colonia,MunicipioDelegacion,Estado,CodigoPostal,Reincidente,CumplePolitica,AcumulacionMonto,MontoEfectivo,Respaldo,descrpcionderespaldo,ObservacionesInformacionAdiciona,NombreReporte,NumeroReporte,Title&$orderby = ID &$filter=ID eq '" + encodeURIComponent(identificador) + "'",
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
		for(var i = 0; i <= can_equi; i++) {
			$('#txtNombrePersonasInvolucradas' + i).prop('disabled', true);
		}
		for(var i = 0; i <= can_equi; i++) {
			$('#txtAreaPersonasInvolucradas' + i).prop('disabled', true);
		}
		for(var i = 0; i <= can_equi; i++) {
			$('#txtNumeroEmpleadoPersonasInvolucradas' + i).prop('disabled', true);
		}
		for(var i = 0; i <= can_equi; i++) {
			$('#txtEmpresaPersonasInvolucradas' + i).prop('disabled', true);
		}
		for(var i = 0; i <= can_equi; i++) {
			$('#txtNumero' + i).prop('disabled', true);
		}
		for(var i = 0; i <= can_equi; i++) {
			$('#txtCliente' + i).prop('disabled', true);
		}
		for(var i = 0; i <= can_equi; i++) {
			$('#txtHorarioPresentoCliente' + i).prop('disabled', true);
		}
		for(var i = 0; i <= can_equi; i++) {
			$('#txtMontoCliente' + i).prop('disabled', true);
		}
		for(var i = 0; i <= can_equi; i++) {
			$('#txtRuta' + i).prop('disabled', true);
		}
		for(var i = 0; i <= can_equi; i++) {
			$('#txtPlacas' + i).prop('disabled', true);
		}
		for(var i = 0; i <= can_equi; i++) {
			$('#txtEconomico' + i).prop('disabled', true);
		}
		for(var i = 0; i <= can_equi; i++) {
			$('#txtnumeroderutas' + i).prop('disabled', true);
		}
		$('#txtCalle').prop('disabled', true);
		$('#txtColonia').prop('disabled', true);
		$('#txtMunicipio').prop('disabled', true);
		$('#txtEstado').prop('disabled', true);
		$('#txtCodigoPostal').prop('disabled', true);
		$('#selReincidente').prop('disabled', true);
		$('#selCumpleconlapolitica').prop('disabled', true);
		$('#txtAcumulacionMonto').prop('disabled', true);
		$('#txtMontodeEfectivo').prop('disabled', true);
		$('#txtRespaldo').prop('disabled', true);
		$('#txtdescrpcionderespaldo').prop('disabled', true);
		$('#tarObservacionesInformacionAdicional').prop('disabled', true);
		$('.bDinamico').prop('disabled', true);
	}

	function contarPersonasInvolucradas() {
		cont_PersonasInvolucradas++;
		$('#hdncontador_PersonasInvolucradas').val(cont_PersonasInvolucradas);
	}
	function contarEquipos() {
		cont_Equipos++;
		$('#hdncontador_Equipos').val(cont_Equipos);
	}
	function contarClientes() {
		cont_Clientes++;
		$('#hdncontador_Clientes').val(cont_Clientes);
	}
	function contarVehiculo() {
		cont_Vehiculo++;
		$('#hdncontador_Vehiculo').val(cont_Vehiculo);
	}
	function contarRutas() {
		cont_Rutas++;
		$('#hdncontador_Rutas').val(cont_Rutas);
	}

	function validarCampos() {
		if($('#txtHoraOcurre').val() === ''){
			$('#txtHoraOcurre').css('border-color', 'red');
			return false;
		}else{
			$('#txtHoraOcurre').css('border-color', '#D8D8D8');
		}
		if($('#txtHoraFinaliza').val() === ''){
			$('#txtHoraFinaliza').css('border-color', 'red');
			return false;
		}else{
			$('#txtHoraFinaliza').css('border-color', '#D8D8D8');
		}
		if($('#txtHoraAvisanProteccion').val() === ''){
			$('#txtHoraAvisanProteccion').css('border-color', 'red');
			return false;
		}else{
			$('#txtHoraAvisanProteccion').css('border-color', '#D8D8D8');
		}
		if($('#txtNombredelapersonaquereportaaproteccion').val() === ''){
			$('#txtNombredelapersonaquereportaaproteccion').css('border-color', 'red');
			return false;
		}else{
			$('#txtNombredelapersonaquereportaaproteccion').css('border-color', '#D8D8D8');
		}
		if($('#txtPuestodelapersonaquereportaaproteccion').val() === ''){
			$('#txtPuestodelapersonaquereportaaproteccion').css('border-color', 'red');
			return false;
		}else{
			$('#txtPuestodelapersonaquereportaaproteccion').css('border-color', '#D8D8D8');
		}
		for(var i = 1; i<= $('#hdncontador_PersonasInvolucradas').val(); i++){
			if($('#txtNombrePersonasInvolucradas' + i).val() === ''){
				$('#txtNombrePersonasInvolucradas' + i).css('border-color', 'red');
				return false;
			}else{
				$('#txtNombrePersonasInvolucradas' + i).css('border-color', '#D8D8D8');
			}
			if($('#txtAreaPersonasInvolucradas' + i).val() === ''){
				$('#txtAreaPersonasInvolucradas' + i).css('border-color', 'red');
				return false;
			}else{
				$('#txtAreaPersonasInvolucradas' + i).css('border-color', '#D8D8D8');
			}
			if($('#txtNumeroEmpleadoPersonasInvolucradas' + i).val() === ''){
				$('#txtNumeroEmpleadoPersonasInvolucradas' + i).css('border-color', 'red');
				return false;
			}else{
				$('#txtNumeroEmpleadoPersonasInvolucradas' + i).css('border-color', '#D8D8D8');
			}
			if($('#txtEmpresaPersonasInvolucradas' + i).val() === ''){
				$('#txtEmpresaPersonasInvolucradas' + i).css('border-color', 'red');
				return false;
			}else{
				$('#txtEmpresaPersonasInvolucradas' + i).css('border-color', '#D8D8D8');
			}
		}
		for(var i = 1; i<= $('#hdncontador_Equipos').val(); i++){
			if($('#txtNumero' + i).val() === ''){
				$('#txtNumero' + i).css('border-color', 'red');
				return false;
			}else{
				$('#txtNumero' + i).css('border-color', '#D8D8D8');
			}
		}
		for(var i = 1; i<= $('#hdncontador_Clientes').val(); i++){
			if($('#txtCliente' + i).val() === ''){
				$('#txtCliente' + i).css('border-color', 'red');
				return false;
			}else{
				$('#txtCliente' + i).css('border-color', '#D8D8D8');
			}
			if($('#txtHorarioPresentoCliente' + i).val() === ''){
				$('#txtHorarioPresentoCliente' + i).css('border-color', 'red');
				return false;
			}else{
				$('#txtHorarioPresentoCliente' + i).css('border-color', '#D8D8D8');
			}
			if($('#txtMontoCliente' + i).val() === ''){
				$('#txtMontoCliente' + i).css('border-color', 'red');
				return false;
			}else{
				$('#txtMontoCliente' + i).css('border-color', '#D8D8D8');
			}
		}
		for(var i = 1; i<= $('#hdncontador_Vehiculo').val(); i++){
			if($('#txtRuta' + i).val() === ''){
				$('#txtRuta' + i).css('border-color', 'red');
				return false;
			}else{
				$('#txtRuta' + i).css('border-color', '#D8D8D8');
			}
			if($('#txtPlacas' + i).val() === ''){
				$('#txtPlacas' + i).css('border-color', 'red');
				return false;
			}else{
				$('#txtPlacas' + i).css('border-color', '#D8D8D8');
			}
			if($('#txtEconomico' + i).val() === ''){
				$('#txtEconomico' + i).css('border-color', 'red');
				return false;
			}else{
				$('#txtEconomico' + i).css('border-color', '#D8D8D8');
			}
		}
		for(var i = 1; i<= $('#hdncontador_Rutas').val(); i++){
			if($('#txtnumeroderutas' + i).val() === ''){
				$('#txtnumeroderutas' + i).css('border-color', 'red');
				return false;
			}else{
				$('#txtnumeroderutas' + i).css('border-color', '#D8D8D8');
			}
		}
		if($('#txtCalle').val() === ''){
			$('#txtCalle').css('border-color', 'red');
			return false;
		}else{
			$('#txtCalle').css('border-color', '#D8D8D8');
		}
		if($('#txtColonia').val() === ''){
			$('#txtColonia').css('border-color', 'red');
			return false;
		}else{
			$('#txtColonia').css('border-color', '#D8D8D8');
		}
		if($('#txtMunicipio').val() === ''){
			$('#txtMunicipio').css('border-color', 'red');
			return false;
		}else{
			$('#txtMunicipio').css('border-color', '#D8D8D8');
		}
		if($('#txtEstado').val() === ''){
			$('#txtEstado').css('border-color', 'red');
			return false;
		}else{
			$('#txtEstado').css('border-color', '#D8D8D8');
		}
		if($('#txtCodigoPostal').val() === ''){
			$('#txtCodigoPostal').css('border-color', 'red');
			return false;
		}else{
			$('#txtCodigoPostal').css('border-color', '#D8D8D8');
		}
		if($('#selReincidente option:selected').text() === '...') {
			$('#selReincidente').css('border-color', 'red');
			return false;
		}else{
			$('#selReincidente').css('border-color', '#D8D8D8');
		}
		if($('#selCumpleconlapolitica option:selected').text() === '...') {
			$('#selCumpleconlapolitica').css('border-color', 'red');
			return false;
		}else{
			$('#selCumpleconlapolitica').css('border-color', '#D8D8D8');
		}
		if($('#txtAcumulacionMonto').val() === ''){
			$('#txtAcumulacionMonto').css('border-color', 'red');
			return false;
		}else{
			$('#txtAcumulacionMonto').css('border-color', '#D8D8D8');
		}
		if($('#txtMontodeEfectivo').val() === ''){
			$('#txtMontodeEfectivo').css('border-color', 'red');
			return false;
		}else{
			$('#txtMontodeEfectivo').css('border-color', '#D8D8D8');
		}
		if($('#txtRespaldo').val() === ''){
			$('#txtRespaldo').css('border-color', 'red');
			return false;
		}else{
			$('#txtRespaldo').css('border-color', '#D8D8D8');
		}
		if($('#txtdescrpcionderespaldo').val() === ''){
			$('#txtdescrpcionderespaldo').css('border-color', 'red');
			return false;
		}else{
			$('#txtdescrpcionderespaldo').css('border-color', '#D8D8D8');
		}
		if($('#tarObservacionesInformacionAdicional').val() === ''){
			$('#tarObservacionesInformacionAdicional').css('border-color', 'red');
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
			'Calle': $('#txtCalle').val(),
			'Colonia': $('#txtColonia').val(),
			'MunicipioDelegacion': $('#txtMunicipio').val(),
			'Estado': $('#txtEstado').val(),
			'CodigoPostal': $('#txtCodigoPostal').val(),
			'Reincidente': $('#selReincidente').val(),
			'CumplePolitica': $('#selCumpleconlapolitica').val(),
			'AcumulacionMonto': $('#txtAcumulacionMonto').val(),
			'MontoEfectivo': $('#txtMontodeEfectivo').val(),
			'Respaldo': $('#txtRespaldo').val(),
			'descrpcionderespaldo': $('#txtdescrpcionderespaldo').val(),
			'ObservacionesInformacionAdiciona': $('#tarObservacionesInformacionAdicional').val(),
			'Identificador':$('#hdnidentificador').val(),
			'Estatus':$('#hdnestatus').val(),
			'NumeroReporte':$('#hdnnumero').val(),
			'NombreReporte':'CobroSeguro'
		};
		var varPersonasInvolucradas = {};
		var varPersonasInvolucradass = [];
		for(var i = 1; i <= $('#hdncontador_PersonasInvolucradas').val(); i++) {
			if($('#txtNombrePersonasInvolucradas' + i).length){
				varPersonasInvolucradas.NombrePersona = $('#txtNombrePersonasInvolucradas' + i).val();
				varPersonasInvolucradas.Area = $('#txtAreaPersonasInvolucradas' + i).val();
				varPersonasInvolucradas.NoEmpleado = $('#txtNumeroEmpleadoPersonasInvolucradas' + i).val();
				varPersonasInvolucradas.Empresa = $('#txtEmpresaPersonasInvolucradas' + i).val();
				varPersonasInvolucradass.push(JSON.stringify(varPersonasInvolucradas));
			}
		}
		var varEquipos = {};
		var varEquiposs = [];
		for(var i = 1; i <= $('#hdncontador_Equipos').val(); i++) {
			if($('#txtNumero' + i).length){
				varEquipos.Numero = $('#txtNumero' + i).val();
				varEquiposs.push(JSON.stringify(varEquipos));
			}
		}
		var varClientes = {};
		var varClientess = [];
		for(var i = 1; i <= $('#hdncontador_Clientes').val(); i++) {
			if($('#txtCliente' + i).length){
				varClientes.Cliente = $('#txtCliente' + i).val();
				varClientes.HorarioPresentoConCliente = $('#txtHorarioPresentoCliente' + i).val();
				varClientes.MontoCliente = $('#txtMontoCliente' + i).val();
				varClientess.push(JSON.stringify(varClientes));
			}
		}
		var varVehiculo = {};
		var varVehiculos = [];
		for(var i = 1; i <= $('#hdncontador_Vehiculo').val(); i++) {
			if($('#txtRuta' + i).length){
				varVehiculo.Ruta = $('#txtRuta' + i).val();
				varVehiculo.Placas = $('#txtPlacas' + i).val();
				varVehiculo.Economico = $('#txtEconomico' + i).val();
				varVehiculos.push(JSON.stringify(varVehiculo));
			}
		}
		var varRutas = {};
		var varRutass = [];
		for(var i = 1; i <= $('#hdncontador_Rutas').val(); i++) {
			if($('#txtnumeroderutas' + i).length){
				varRutas.numeroderutas = $('#txtnumeroderutas' + i).val();
				varRutass.push(JSON.stringify(varRutas));
			}
		}
		datos.push(JSON.stringify(e));
		datos.push(varPersonasInvolucradass);
		datos.push(varEquiposs);
		datos.push(varClientess);
		datos.push(varVehiculos);
		datos.push(varRutass);
		return datos;
	}

	function colocar(datos) {
		$('#txtHoraOcurre').val(datos.HoraOcurre),
		$('#txtHoraFinaliza').val(datos.HoraFinaliza),
		$('#txtHoraAvisanProteccion').val(datos.HoraReportanProteccion),
		$('#txtNombredelapersonaquereportaaproteccion').val(datos.NombrePersonaReportaProteccion),
		$('#txtPuestodelapersonaquereportaaproteccion').val(datos.PuestoPersonaReportaProteccion),
		$('#txtCalle').val(datos.Calle),
		$('#txtColonia').val(datos.Colonia),
		$('#txtMunicipio').val(datos.MunicipioDelegacion),
		$('#txtEstado').val(datos.Estado),
		$('#txtCodigoPostal').val(datos.CodigoPostal),
		$('#selReincidente option').text(datos.Reincidente),
		$('#selCumpleconlapolitica option').text(datos.CumplePolitica),
		$('#txtAcumulacionMonto').val(datos.AcumulacionMonto),
		$('#txtMontodeEfectivo').val(datos.MontoEfectivo),
		$('#txtRespaldo').val(datos.Respaldo),
		$('#txtdescrpcionderespaldo').val(datos.descrpcionderespaldo),
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
			elementTime = elementosDuplicar[i].getElementsByClassName("time")[0];
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
									
										console.log('Tiempo');
				                        var lblt = document.createElement('label');
				                        lblt.setAttribute("id", "lbl"+ elementTime .id + totalListaDuplicacion);
				                        lblt.innerHTML = elementlabel.innerHTML;
									
										var divbt = document.createElement('div');
										divbt.setAttribute("id", "div" + elementTime .id + totalListaDuplicacion);
										divbt.setAttribute("class", "input-group time");	
										
					                    var txbt = document.createElement('input');
				                        txbt.type = "text";
				                        txbt.setAttribute("id", "txt" + elementTime .id + totalListaDuplicacion);
				                        txbt.setAttribute("class", "form-control");
				                        
				                        var spbt = document.createElement('span');
				                        spbt.setAttribute("class", "input-group-addon");
		
				                        var spbtb = document.createElement('span');
				                        spbtb.setAttribute("class", "glyphicon glyphicon-time");
				                        spbt.appendChild(spbtb);
				                        
				                        divbt.appendChild(txbt);
				                        divbt.appendChild(spbt);
				                        
				                        divfinal1.appendChild(lblt);
					                    divfinal1.appendChild(divbt);	
				                    }		
				                }					
								else {								
									console.log('Fecha');
			                        var lblf = document.createElement('label');
			                        lblf.setAttribute("id", "lbl"+ elementDate .id + totalListaDuplicacion);
			                        lblf.innerHTML = elementlabel.innerHTML;
								
									var divbf = document.createElement('div');
									divbf.setAttribute("id", "div" + elementDate .id + totalListaDuplicacion);
									divbf.setAttribute("class", "input-group date");	
									
				                    var txbf = document.createElement('input');
			                        txbf.type = "text";
			                        txbf.setAttribute("id", "txt" + elementDate .id + totalListaDuplicacion);
			                        txbf.setAttribute("class", "form-control");
			                        
			                        var spbf = document.createElement('span');
			                        spbf.setAttribute("class", "input-group-addon");
	
			                        var spbfb = document.createElement('span');
			                        spbfb.setAttribute("class", "glyphicon glyphicon-time");
			                        spbf.appendChild(spbfb);
			                        
			                        divbf.appendChild(txbf);
			                        divbf.appendChild(spbf);
			                        
			                        divfinal1.appendChild(lblf);
				                    divfinal1.appendChild(divbf);									
								}								
							}
							else {
								console.log('Select');
		                        var lbl1 = document.createElement('label');
		                        lbl1.setAttribute("id", "lbl"+ elementoSelect.id + totalListaDuplicacion);
		                        lbl1.innerHTML = elementlabel.innerHTML;
	
		                        var txb1 = document.createElement('select');
		                        
		                        for(c=0;c<elementoSelect.options.length;c++){
		                        	var ops = document.createElement('option');
		                        	ops.value = elementoSelect.options[c].value;
		                        	ops.text = elementoSelect.options[c].text;
		                        	txb1.appendChild(ops);
		                        }
		                        
		                        txb1.setAttribute("id", elementoSelect.id + totalListaDuplicacion);
		                        txb1.setAttribute("class", elementoSelect.className);
		                        
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
							txb1.setAttribute("maxlength", elementoArea .maxlength);
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
	                txb1.setAttribute("maxlength", elementNumero .maxlength);
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
	            txb1.setAttribute("maxlength", elementText.maxlength);
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
		$('.time').datetimepicker({
			format: 'HH:mm'
		});
		
		$('.date').datetimepicker({
			format: 'HH:mm'
		});

		$('.moneda').priceFormat({
			prefix: '$ ',
			centsSeparator: '.', 
			thousandsSeparator: ','
		});

	    $('.numero').priceFormat({
			prefix: '',
			centsSeparator: '.', 
			thousandsSeparator: ','
		});

	    return;	    
	}

	function EliminarBloqueDuplicacion(element) {
		//console.log(element.id);
        elementParent = element.parentNode;
        elementParent.parentNode.removeChild(elementParent);
    }

</script>
</head>
<body>
	<div id="ReportesDinamicos" class="container">
		<div id="Reporte_2" class="BloqueReportesDinamicos">
<h3 id="lblCobroSeguro">CobroSeguro</h3>
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
				<label  id='lblHoraAvisanProteccion'>* Hora en que avisan a protección</label>
				<div class='input-group time' id='HoraAvisanProteccion'>
					<input type='text' class='form-control' id="txtHoraAvisanProteccion"/>
					<span class='input-group-addon'>
						<span class='glyphicon glyphicon-time'></span>
					</span>
				</div>
			</div>
			<div class='col-xs-6 col-md-4 col-lg-3 col-xl-3 form-group'>
				<label class='control-label' id= 'lblNombredelapersonaquereportaaproteccion'>* Nombre de la persona que reporta  a protección</label>
				<input class='form-control' idvariabledepende ='Nombredelapersonaquereportaaproteccion' maxlength='100' id='txtNombredelapersonaquereportaaproteccion' type='text'/>
			</div>
			<div class='col-xs-6 col-md-4 col-lg-3 col-xl-3 form-group'>
				<label class='control-label' id= 'lblPuestodelapersonaquereportaaproteccion'>* Puesto de la persona que reporta a protección</label>
				<input class='form-control' idvariabledepende ='Puestodelapersonaquereportaaproteccion' maxlength='100' id='txtPuestodelapersonaquereportaaproteccion' type='text'/>
			</div>
		</div>
	</div>
	<div id="PersonasInvolucradas" class='container'>
		<div class='col-xs-12 col-lg-12 col-md-12 col-xl-12'>
			<div class='col-xs-6 col-md-4 col-lg-3 col-xl-3 form-group' unselectable='on'>
				<input type='button' class="bDinamico" onclick='javascript:DuplicarGrupo("DPersonasInvolucradas", this);' id='NumeroPersonasInvolucradas' value='Agregar personas involucradas'/>
			</div>
		</div>
	</div>
	<section class="PersonasInvolucradasD">
		<div class='container DPersonasInvolucradas' style="visibility:hidden; display:none">
			<div class='col-xs-12 col-lg-12 col-md-12 col-xl-12'>

	<div class='col-xs-6 col-md-4 col-lg-3 col-xl-3 form-group'>
		<label class='control-label' id= 'lblNombrePersonasInvolucradas'>* Nombre de la persona involucrada</label>
		<input class='form-control text' idvariabledepende ='NombrePersonasInvolucradas' maxlength='100' id='txtNombrePersonasInvolucradas' type='text'/>
	</div>

	<div class='col-xs-6 col-md-4 col-lg-3 col-xl-3 form-group'>
		<label class='control-label' id= 'lblAreaPersonasInvolucradas'>* Área</label>
		<input class='form-control text' idvariabledepende ='AreaPersonasInvolucradas' maxlength='100' id='txtAreaPersonasInvolucradas' type='text'/>
	</div>

	<div class='col-xs-6 col-md-4 col-lg-3 col-xl-3 form-group'>
		<label class='control-label' id= 'lblNumeroEmpleadoPersonasInvolucradas'>* Número de empleado</label>
		<input class='form-control text' idvariabledepende ='NumeroEmpleadoPersonasInvolucradas' maxlength='100' id='txtNumeroEmpleadoPersonasInvolucradas' type='text'/>
	</div>

	<div class='col-xs-6 col-md-4 col-lg-3 col-xl-3 form-group'>
		<label class='control-label' id= 'lblEmpresaPersonasInvolucradas'>* Empresa</label>
		<input class='form-control text' idvariabledepende ='EmpresaPersonasInvolucradas' maxlength='100' id='txtEmpresaPersonasInvolucradas' type='text'/>
	</div>
			</div>
		</div>
	</section>
	<div id="Equipos" class='container'>
		<div class='col-xs-12 col-lg-12 col-md-12 col-xl-12'>
			<div class='col-xs-6 col-md-4 col-lg-3 col-xl-3 form-group' unselectable='on'>
				<input type='button' class="bDinamico" onclick='javascript:DuplicarGrupo("DEquipos", this);' id='NumeroEquipos' value='Agregar equipos'/>
			</div>
		</div>
	</div>
	<section class="EquiposD">
		<div class='container DEquipos' style="visibility:hidden; display:none">
			<div class='col-xs-12 col-lg-12 col-md-12 col-xl-12'>

	<div class='col-xs-6 col-md-4 col-lg-3 col-xl-3 form-group'>
		<label class='control-label' id= 'lblNumero'>* Numero</label>
		<input class='form-control numero' idvariabledepende ='Numero' maxlength='100' id='txtNumero' type='text'/>
	</div>
			</div>
		</div>
	</section>
	<div id="Clientes" class='container'>
		<div class='col-xs-12 col-lg-12 col-md-12 col-xl-12'>
			<div class='col-xs-6 col-md-4 col-lg-3 col-xl-3 form-group' unselectable='on'>
				<input type='button' class="bDinamico" onclick='javascript:DuplicarGrupo("DClientes", this);' id='NumeroClientes' value='Agregar clientes'/>
			</div>
		</div>
	</div>
	<section class="ClientesD">
		<div class='container DClientes' style="visibility:hidden; display:none">
			<div class='col-xs-12 col-lg-12 col-md-12 col-xl-12'>

	<div class='col-xs-6 col-md-4 col-lg-3 col-xl-3 form-group'>
		<label class='control-label' id= 'lblCliente'>* Cliente</label>
		<input class='form-control text' idvariabledepende ='Cliente' maxlength='100' id='txtCliente' type='text'/>
	</div>

	<div class='col-xs-6 col-md-4 col-lg-3 col-xl-3 form-group'>
		<label  id='lblHorarioPresentoCliente'>* Horario en el que se presento con el cliente</label>
		<div class='input-group time' id='HorarioPresentoCliente'>
			<input type='text' class='form-control' id="txtHorarioPresentoCliente"/>
			<span class='input-group-addon'>
				<span class='glyphicon glyphicon-time'></span>
			</span>
		</div>
	</div>

	<div class='col-xs-6 col-md-4 col-lg-3 col-xl-3 form-group'>
		<label class='control-label' id= 'lblMontoCliente'>* Monto por cliente</label>
		<input class='form-control numero' idvariabledepende ='MontoCliente' maxlength='25' id='txtMontoCliente' type='text'/>
	</div>
			</div>
		</div>
	</section>
	<div id="Vehiculo" class='container'>
		<div class='col-xs-12 col-lg-12 col-md-12 col-xl-12'>
			<div class='col-xs-6 col-md-4 col-lg-3 col-xl-3 form-group' unselectable='on'>
				<input type='button' class="bDinamico" onclick='javascript:DuplicarGrupo("DVehiculo", this);' id='NumeroVehiculo' value='Agregar vehículos'/>
			</div>
		</div>
	</div>
	<section class="VehiculoD">
		<div class='container DVehiculo' style="visibility:hidden; display:none">
			<div class='col-xs-12 col-lg-12 col-md-12 col-xl-12'>

	<div class='col-xs-6 col-md-4 col-lg-3 col-xl-3 form-group'>
		<label class='control-label' id= 'lblRuta'>* Ruta</label>
		<input class='form-control text' idvariabledepende ='Ruta' maxlength='100' id='txtRuta' type='text'/>
	</div>

	<div class='col-xs-6 col-md-4 col-lg-3 col-xl-3 form-group'>
		<label class='control-label' id= 'lblPlacas'>* Placas</label>
		<input class='form-control text' idvariabledepende ='Placas' maxlength='100' id='txtPlacas' type='text'/>
	</div>

	<div class='col-xs-6 col-md-4 col-lg-3 col-xl-3 form-group'>
		<label class='control-label' id= 'lblEconomico'>* Económico</label>
		<input class='form-control text' idvariabledepende ='Economico' maxlength='100' id='txtEconomico' type='text'/>
	</div>
			</div>
		</div>
	</section>
	<div id="Rutas" class='container'>
		<div class='col-xs-12 col-lg-12 col-md-12 col-xl-12'>
			<div class='col-xs-6 col-md-4 col-lg-3 col-xl-3 form-group' unselectable='on'>
				<input type='button' class="bDinamico" onclick='javascript:DuplicarGrupo("DRutas", this);' id='NumeroRutas' value='Agregar rutas'/>
			</div>
		</div>
	</div>
	<section class="RutasD">
		<div class='container DRutas' style="visibility:hidden; display:none">
			<div class='col-xs-12 col-lg-12 col-md-12 col-xl-12'>

	<div class='col-xs-6 col-md-4 col-lg-3 col-xl-3 form-group'>
		<label class='control-label' id= 'lblnumeroderutas'>* Numero de rutas</label>
		<input class='form-control numero' idvariabledepende ='numeroderutas' maxlength='100' id='txtnumeroderutas' type='text'/>
	</div>
			</div>
		</div>
	</section>
	<div id="ctHoraEvento" class='container'>
		<div class='col-xs-12 col-sm-12 col-md-12 col-lg-12'>
			<div class='col-xs-6 col-md-4 col-lg-3 col-xl-3 form-group'>
				<label class='control-label' id= 'lblCalle'>* Calle</label>
				<input class='form-control' idvariabledepende ='Calle' maxlength='100' id='txtCalle' type='text'/>
			</div>
			<div class='col-xs-6 col-md-4 col-lg-3 col-xl-3 form-group'>
				<label class='control-label' id= 'lblColonia'>* Colonia</label>
				<input class='form-control' idvariabledepende ='Colonia' maxlength='100' id='txtColonia' type='text'/>
			</div>
			<div class='col-xs-6 col-md-4 col-lg-3 col-xl-3 form-group'>
				<label class='control-label' id= 'lblMunicipio'>* Municipio/Delegación</label>
				<input class='form-control' idvariabledepende ='Municipio' maxlength='100' id='txtMunicipio' type='text'/>
			</div>
			<div class='col-xs-6 col-md-4 col-lg-3 col-xl-3 form-group'>
				<label class='control-label' id= 'lblEstado'>* Estado </label>
				<input class='form-control' idvariabledepende ='Estado' maxlength='100' id='txtEstado' type='text'/>
			</div>
			<div class='col-xs-6 col-md-4 col-lg-3 col-xl-3 form-group'>
				<label class='control-label' id= 'lblCodigoPostal'>* Código postal</label>
				<input class='form-control' idvariabledepende ='CodigoPostal' maxlength='100' id='txtCodigoPostal' type='text'/>
			</div>
		</div>
	</div>
	<div id="ctHoraEvento" class='container'>
		<div class='col-xs-12 col-sm-12 col-md-12 col-lg-12'>
			<div class='col-xs-6 col-md-4 col-lg-3 col-xl-3 form-group'>
				<label class='control-label' id= 'lblReincidente'>* Reincidente</label>
				<select class='form-control' id='selReincidente' >
					<option></option>
				</select>
			</div>
		</div>
	</div>
	<div id="ctHoraEvento" class='container'>
		<div class='col-xs-12 col-sm-12 col-md-12 col-lg-12'>
			<div class='col-xs-6 col-md-4 col-lg-3 col-xl-3 form-group'>
				<label class='control-label' id= 'lblCumpleconlapolitica'>* ¿Cumple con la política?</label>
				<select class='form-control' id='selCumpleconlapolitica' >
					<option></option>
				</select>
			</div>
		</div>
	</div>
	<div id="ctHoraEvento" class='container'>
		<div class='col-xs-12 col-sm-12 col-md-12 col-lg-12'>
			<div class='col-xs-6 col-md-4 col-lg-3 col-xl-3 form-group'>
				<label class='control-label' id= 'lblAcumulacionMonto'>* Acumulación de monto</label>
				<input class='form-control moneda' idvariabledepende ='AcumulacionMonto' maxlength='25' id='txtAcumulacionMonto' type='text'/>
			</div>
			<div class='col-xs-6 col-md-4 col-lg-3 col-xl-3 form-group'>
				<label class='control-label' id= 'lblMontodeEfectivo'>* Monto de efectivo</label>
				<input class='form-control moneda' idvariabledepende ='MontodeEfectivo' maxlength='25' id='txtMontodeEfectivo' type='text'/>
			</div>
		</div>
	</div>
	<div id="ctHoraEvento" class='container'>
		<div class='col-xs-12 col-sm-12 col-md-12 col-lg-12'>
			<div class='col-xs-6 col-md-4 col-lg-3 col-xl-3 form-group'>
				<label class='control-label' id= 'lblRespaldo'>* Respaldo</label>
				<input class='form-control' idvariabledepende ='Respaldo' maxlength='100' id='txtRespaldo' type='text'/>
			</div>
			<div class='col-xs-6 col-md-4 col-lg-3 col-xl-3 form-group'>
				<label class='control-label' id= 'lbldescrpcionderespaldo'>* Descripcion de Respaldo</label>
				<input class='form-control' idvariabledepende ='descrpcionderespaldo' maxlength='100' id='txtdescrpcionderespaldo' type='text'/>
			</div>
		</div>
	</div>
	<div id="ctHoraEvento" class='container'>
		<div class='col-xs-12 col-sm-12 col-md-12 col-lg-12'>
			<div class='col-xs-12 col-md-12 col-lg-12 col-xl-12 form-group'>
				<label class='obligatorio etiquetaM control-label'>* Observaciones/Información adicional</label>
				<textarea maxlength='5000' id='tarObservacionesInformacionAdicional' class='form-control' rows='5'></textarea>
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
	<input type="hidden" id="hdncontador_PersonasInvolucradas" value="0"/>
	<input type="hidden" id="hdncontador_Equipos" value="0"/>
	<input type="hidden" id="hdncontador_Clientes" value="0"/>
	<input type="hidden" id="hdncontador_Vehiculo" value="0"/>
	<input type="hidden" id="hdncontador_Rutas" value="0"/>
	<span id="lblCamposFaltantes" style="display:none">Faltan campos por llenar</span>
	<span id="lblAgregarExito" style="display:none">El reporte se ha agregado con éxito</span>
	<span id="lblAgregarAviso" style="display:none">El reporte capturado se va a agregar el reporte principal</span>
</body>
</html>
