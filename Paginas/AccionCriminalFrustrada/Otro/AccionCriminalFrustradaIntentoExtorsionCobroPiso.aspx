<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ Page Language="C#" %>
<%@ Register tagprefix="SharePoint" namespace="Microsoft.SharePoint.WebControls" assembly="Microsoft.SharePoint, Version = 15.0.0.0, Culture = neutral, PublicKeyToken = 71e9bce111e9429c" %>
<html dir="ltr" xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<!--Documento generado de manera dinámica por SPFormsEasy -->
<!--Nombre del documento: AccionCriminalFrustradaIntentoExtorsionCobroPiso -->
<!--Creado por: Luis Alonso Escalona Morales -->
<!--Creado el: 14/01/2018 -->
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
<link rel="stylesheet" href="../../../Styles/reportes.css"/>
<script type="text/javascript" src="../../../Scripts/Sitios/Alarma.js"></script>
<script type="text/javascript" src="../../../Scripts/Sitios/combo_min.js"></script>
<script type="text/javascript" src="../../../Scripts/Traduccion.js"></script>
<script type="text/javascript" src="../../../Scripts/jquery.priceformat.min.js"></script>
<!--JS Operación-->
<script type ="text/javascript">
	var cont_PersonasInvolucradas = 0;
	var cont_Delincuentes = 0;
	var personProperties;
	var clientContext;
	var etiquetascontroles = [];
	var pais;
	var URL = "https://cocacolafemsa.sharepoint.com/sites/SWPP";
	$(document).ready(function () {
		SP.SOD.executeOrDelayUntilScriptLoaded(getCurrentUser, 'SP.UserProfiles.js');
		$('#NumeroPersonasInvolucradas').on('click', contarPersonasInvolucradas);
		$('#NumeroDelincuentes').on('click', contarDelincuentes);
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
EliminarDatosDelincuentes($('#hdnidentificador').val(), $('#hdnnumero').val());
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
			url: URL + "/_api/web/lists/getbytitle('TR_AccionCriminalFrustrada')/Items?$select=ID&$filter=Title eq '" + encodeURIComponent(folio) + "' and NumeroReporte eq '" + encodeURIComponent(reporte) + "'", 
			type: "GET", 
			async: false,
			headers:{"accept":"application/json;odata=verbose"}, 
			success: function (data) { 
				if (data.d.results) { 
					EliminarDatos('TR_AccionCriminalFrustrada', data.d.results[0].ID, clientContext);
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



	function EliminarDatosDelincuentes(folio, reporte){
		$.ajax({ 
			url: URL + "/_api/web/lists/getbytitle('DN_Delincuentes')/Items?$select=ID&$filter=Folio eq '"+encodeURIComponent(folio)+"' and NoReporte eq '"+encodeURIComponent(reporte)+"'", 
			type: "GET", 
			async: false,
			headers:{"accept":"application/json;odata=verbose"}, 
			success: function (data) {
				if (data.d.results) {
					for(var i = 0; i < data.d.results.length;i++){
						EliminarDatos('DN_Delincuentes', data.d.results[i].ID, clientContext);
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
		guardarReporteDelincuentesB(datos[2][i], info.Identificador, info.NumeroReporte, info.Estatus, clientContext);
		}

	}

	function guardarReporteB(d, clientContext) {
		try {
			var datos = JSON.parse(d);
			var oList = clientContext.get_web().get_lists().getByTitle('TR_AccionCriminalFrustrada');
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
			oListItemDatos.set_item('NoAveriguacionPrevia', datos.NoAveriguacionPrevia);
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

	function guardarReporteDelincuentesB(d, padre, numero, estatus, clientContext) { 
		try {
			var datos = JSON.parse(d);
			var oList = clientContext.get_web().get_lists().getByTitle('DN_Delincuentes');
			var itemCreateInfo = new SP.ListItemCreationInformation();
			this.oListItemDatos = oList.addItem(itemCreateInfo);

			oListItemDatos.set_item('Folio', padre );
			oListItemDatos.set_item('NoReporte', numero );
			oListItemDatos.set_item('Estatus', estatus);
			oListItemDatos.set_item('Estatura', datos.Estatura);
			oListItemDatos.set_item('Complexion', datos.Complexion);
			oListItemDatos.set_item('Vestimenta', datos.Vestimenta);
			oListItemDatos.set_item('Edad', datos.Edad);
			oListItemDatos.set_item('Cabello', datos.Cabello);
			oListItemDatos.set_item('TamCabello', datos.TamCabello);
			oListItemDatos.set_item('ColCabello', datos.ColCabello);
			oListItemDatos.set_item('Senas', datos.Senas);
			oListItemDatos.set_item('ColPiel', datos.ColPiel);
			oListItemDatos.set_item('Rasgos', datos.Rasgos);
			oListItemDatos.set_item('GenDelincuente', datos.GenDelincuente);
			oListItemDatos.set_item('TpoArma', datos.TpoArma);

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

		comboComplexion("selComplexion", pais);
		comboTipocabello("selCabello", pais);
		comboTamaniocabello("selTamanodelCabello", pais);
		comboColorcabello("selColordelcabello", pais);
		comboColorpiel("selColordePiel", pais);
		comboGenerodelincuente("selGeneroDelincuente", pais);
		comboArma("selTipodeArma", pais);

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

				llenarDatosDelincuentes(id, numero);

				$('#hdngua').val(false);
			}
			if(estado == 'Ver') {
				llenarDatos(id, numero);

				llenarDatosPersonasInvolucradas(id, numero);

				llenarDatosDelincuentes(id, numero);

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
	function llenarDatosDelincuentes(folio, reporte){
		$.ajax({
			url:URL + "/_api/web/lists/getbytitle('DN_Delincuentes')/Items?$select=ID&$filter=Folio eq '" + encodeURIComponent(folio) + "' and NoReporte eq '" + encodeURIComponent(reporte) + "'",
			type: "GET",
async: false,
			headers: {"accept": "application/json;odata=verbose"},
			success: function(data) {
				if(data.d.results) {
					for(var i = 0; i < data.d.results.length; i++) {
						$('#NumeroDelincuentes').click();
					}
					for(var i = 0; i < data.d.results.length; i++) {
						obtenerDelincuentes(data.d.results[i].ID, i + 1);
					}
				}
			},
			error: function (xhr) {
				alert('llenar Datos Delincuentes ' + xhr.status + ': ' + xhr.statusText);
			}
		});
	}

	function obtenerDelincuentes(identificador, campo) {
		$.ajax({
			url:URL + "/_api/web/lists/getbytitle('DN_Delincuentes')/Items?$select= Estatura,Complexion,Vestimenta,Edad,Cabello,TamCabello,ColCabello,Senas,ColPiel,Rasgos,GenDelincuente,TpoArma&$orderby=ID &$filter=ID eq '" + encodeURIComponent(identificador) + "'",
			type: "GET",
async: false,
			headers: {"accept": "application/json;odata=verbose"},
			success: function (data) {
				if (data.d.results) {
					$('#txtEstatura' + campo).val(data.d.results[0].Estatura);
					$('#selComplexion' + campo).val(data.d.results[0].Complexion);
					$('#txtVestimenta' + campo).val(data.d.results[0].Vestimenta);
					$('#txtEdad' + campo).val(data.d.results[0].Edad);
					$('#selCabello' + campo).val(data.d.results[0].Cabello);
					$('#selTamanodelCabello' + campo).val(data.d.results[0].TamCabello);
					$('#selColordelcabello' + campo).val(data.d.results[0].ColCabello);
					$('#txtSenasParticulares' + campo).val(data.d.results[0].Senas);
					$('#selColordePiel' + campo).val(data.d.results[0].ColPiel);
					$('#txtMasrasgos' + campo).val(data.d.results[0].Rasgos);
					$('#selGeneroDelincuente' + campo).val(data.d.results[0].GenDelincuente);
					$('#selTipodeArma' + campo).val(data.d.results[0].TpoArma);
					if($.get('EDO') == 'Ver') {
						$('#txtEstatura' + campo).prop('disabled', true);
						$('#selComplexion' + campo).prop('disabled', true);
						$('#txtVestimenta' + campo).prop('disabled', true);
						$('#txtEdad' + campo).prop('disabled', true);
						$('#selCabello' + campo).prop('disabled', true);
						$('#selTamanodelCabello' + campo).prop('disabled', true);
						$('#selColordelcabello' + campo).prop('disabled', true);
						$('#txtSenasParticulares' + campo).prop('disabled', true);
						$('#selColordePiel' + campo).prop('disabled', true);
						$('#txtMasrasgos' + campo).prop('disabled', true);
						$('#selGeneroDelincuente' + campo).prop('disabled', true);
						$('#selTipodeArma' + campo).prop('disabled', true);
					}
				}
			},
			error: function (xhr) {
				alert('obtenerDelincuentes ' + xhr.status + ': ' + xhr.statusText);
			}
		});
	}

	function llenarDatos(folio, reporte){
		$.ajax({
			url:URL + "/_api/web/lists/getbytitle('TR_AccionCriminalFrustrada')/Items?$select=ID&$filter=Title eq '" + encodeURIComponent(folio) + "' and NumeroReporte eq '" + encodeURIComponent(reporte) + "'",
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
			url:URL + "/_api/web/lists/getbytitle('TR_AccionCriminalFrustrada')/Items?$select= HoraOcurre,HoraFinaliza,HoraReportanProteccion,NombrePersonaReportaProteccion,PuestoPersonaReportaProteccion,NoAveriguacionPrevia,ObservacionesInformacionAdiciona,NombreReporte,NumeroReporte,Title&$orderby = ID &$filter=ID eq '" + encodeURIComponent(identificador) + "'",
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
			$('#txtEstatura' + i).prop('disabled', true);
		}
		for(var i = 0; i <= can_equi; i++) {
			$('#selComplexion' + i).prop('disabled', true);
		}
		for(var i = 0; i <= can_equi; i++) {
			$('#txtVestimenta' + i).prop('disabled', true);
		}
		for(var i = 0; i <= can_equi; i++) {
			$('#txtEdad' + i).prop('disabled', true);
		}
		for(var i = 0; i <= can_equi; i++) {
			$('#selCabello' + i).prop('disabled', true);
		}
		for(var i = 0; i <= can_equi; i++) {
			$('#selTamanodelCabello' + i).prop('disabled', true);
		}
		for(var i = 0; i <= can_equi; i++) {
			$('#selColordelcabello' + i).prop('disabled', true);
		}
		for(var i = 0; i <= can_equi; i++) {
			$('#tarSenasParticulares' + i).prop('disabled', true);
		}
		for(var i = 0; i <= can_equi; i++) {
			$('#selColordePiel' + i).prop('disabled', true);
		}
		for(var i = 0; i <= can_equi; i++) {
			$('#tarMasrasgos' + i).prop('disabled', true);
		}
		for(var i = 0; i <= can_equi; i++) {
			$('#selGeneroDelincuente' + i).prop('disabled', true);
		}
		for(var i = 0; i <= can_equi; i++) {
			$('#selTipodeArma' + i).prop('disabled', true);
		}
		$('#txtNumerodeAveriguacionPrevia').prop('disabled', true);
		$('#tarObservacionesInformacionAdicional').prop('disabled', true);
	}

	function contarPersonasInvolucradas() {
		cont_PersonasInvolucradas++;
		$('#hdncontador_PersonasInvolucradas').val(cont_PersonasInvolucradas);
	}
	function contarDelincuentes() {
		cont_Delincuentes++;
		$('#hdncontador_Delincuentes').val(cont_Delincuentes);
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
		for(var i = 1; i<= $('#hdncontador_Delincuentes').val(); i++){
			if($('#txtEstatura' + i).val() === ''){
				$('#txtEstatura' + i).css('border-color', 'red');
				return false;
			}else{
				$('#txtEstatura' + i).css('border-color', '#D8D8D8');
			}
		if($('#selComplexion').val() == '') {
			$('#selComplexion').css('border-color', 'red');
			return false;
		}else{
			$('#selComplexion').css('border-color', '#D8D8D8');
		}
			if($('#txtVestimenta' + i).val() === ''){
				$('#txtVestimenta' + i).css('border-color', 'red');
				return false;
			}else{
				$('#txtVestimenta' + i).css('border-color', '#D8D8D8');
			}
			if($('#txtEdad' + i).val() === ''){
				$('#txtEdad' + i).css('border-color', 'red');
				return false;
			}else{
				$('#txtEdad' + i).css('border-color', '#D8D8D8');
			}
		if($('#selCabello').val() == '') {
			$('#selCabello').css('border-color', 'red');
			return false;
		}else{
			$('#selCabello').css('border-color', '#D8D8D8');
		}
		if($('#selTamanodelCabello').val() == '') {
			$('#selTamanodelCabello').css('border-color', 'red');
			return false;
		}else{
			$('#selTamanodelCabello').css('border-color', '#D8D8D8');
		}
		if($('#selColordelcabello').val() == '') {
			$('#selColordelcabello').css('border-color', 'red');
			return false;
		}else{
			$('#selColordelcabello').css('border-color', '#D8D8D8');
		}
			if($('#tarSenasParticulares' + i).val() === ''){
				$('#tarSenasParticulares' + i).css('border-color', 'red');
				return false;
			}else{
				$('#tarSenasParticulares' + i).css('border-color', '#D8D8D8');
			}
		if($('#selColordePiel').val() == '') {
			$('#selColordePiel').css('border-color', 'red');
			return false;
		}else{
			$('#selColordePiel').css('border-color', '#D8D8D8');
		}
			if($('#tarMasrasgos' + i).val() === ''){
				$('#tarMasrasgos' + i).css('border-color', 'red');
				return false;
			}else{
				$('#tarMasrasgos' + i).css('border-color', '#D8D8D8');
			}
		if($('#selGeneroDelincuente').val() == '') {
			$('#selGeneroDelincuente').css('border-color', 'red');
			return false;
		}else{
			$('#selGeneroDelincuente').css('border-color', '#D8D8D8');
		}
		if($('#selTipodeArma').val() == '') {
			$('#selTipodeArma').css('border-color', 'red');
			return false;
		}else{
			$('#selTipodeArma').css('border-color', '#D8D8D8');
		}
		}
		if($('#txtNumerodeAveriguacionPrevia').val() === ''){
			$('#txtNumerodeAveriguacionPrevia').css('border-color', 'red');
			return false;
		}else{
			$('#txtNumerodeAveriguacionPrevia').css('border-color', '#D8D8D8');
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
			'NoAveriguacionPrevia': $('#txtNumerodeAveriguacionPrevia').val(),
			'ObservacionesInformacionAdiciona': $('#tarObservacionesInformacionAdicional').val(),
			'Identificador':$('#hdnidentificador').val(),
			'Estatus':$('#hdnestatus').val(),
			'NumeroReporte':$('#hdnnumero').val(),
			'NombreReporte':'AccionCriminalFrustradaIntentoExtorsionCobroPiso'
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
		var varDelincuentes = {};
		var varDelincuentess = [];
		for(var i = 1; i <= $('#hdncontador_Delincuentes').val(); i++) {
			if($('#txtEstatura' + i).length){
				varDelincuentes.Estatura = $('#txtEstatura' + i).val();
				varDelincuentes.Complexion = $('#selComplexion' + i).val();
				varDelincuentes.Vestimenta = $('#txtVestimenta' + i).val();
				varDelincuentes.Edad = $('#txtEdad' + i).val();
				varDelincuentes.Cabello = $('#selCabello' + i).val();
				varDelincuentes.TamCabello = $('#selTamanodelCabello' + i).val();
				varDelincuentes.ColCabello = $('#selColordelcabello' + i).val();
				varDelincuentes.Senas = $('#tarSenasParticulares' + i).val();
				varDelincuentes.ColPiel = $('#selColordePiel' + i).val();
				varDelincuentes.Rasgos = $('#tarMasrasgos' + i).val();
				varDelincuentes.GenDelincuente = $('#selGeneroDelincuente' + i).val();
				varDelincuentes.TpoArma = $('#selTipodeArma' + i).val();
				varDelincuentess.push(JSON.stringify(varDelincuentes));
			}
		}
		datos.push(JSON.stringify(e));
		datos.push(varPersonasInvolucradass);
		datos.push(varDelincuentess);
		return datos;
	}

	function colocar(datos) {
		$('#txtHoraOcurre').val(datos.HoraOcurre),
		$('#txtHoraFinaliza').val(datos.HoraFinaliza),
		$('#txtHoraAvisanProteccion').val(datos.HoraReportanProteccion),
		$('#txtNombredelapersonaquereportaaproteccion').val(datos.NombrePersonaReportaProteccion),
		$('#txtPuestodelapersonaquereportaaproteccion').val(datos.PuestoPersonaReportaProteccion),
		$('#txtNumerodeAveriguacionPrevia').val(datos.NoAveriguacionPrevia),
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
		                        lbl1.setAttribute("id", "lbl"+ elementselect.id + totalListaDuplicacion);
		                        lbl1.innerHTML = elementlabel.innerHTML;
	
		                        var txb1 = document.createElement('select');
		                        
		                        for(c=0;c<elementselect.options.length;c++){
		                        	var ops = document.createElement('option');
		                        	ops.value = elementselect.options[c].value;
		                        	ops.text = elementselect.options[c].text;
		                        	txb1.appendChild(ops);
		                        }
		                        
		                        txb1.setAttribute("id", elementselect.id + totalListaDuplicacion);
		                        txb1.setAttribute("class", elementselect.className);
		                        
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
<h3 id="lblAccionCriminalFrustradaIntentoExtorsionCobroPiso">AccionCriminalFrustradaIntentoExtorsionCobroPiso</h3>
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
				<input type='button' onclick='javascript:DuplicarGrupo("DPersonasInvolucradas", this);' id='NumeroPersonasInvolucradas' value='Agregar personas involucradas'/>
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
	<div id="Delincuentes" class='container'>
		<div class='col-xs-12 col-lg-12 col-md-12 col-xl-12'>
			<div class='col-xs-6 col-md-4 col-lg-3 col-xl-3 form-group' unselectable='on'>
				<input type='button' onclick='javascript:DuplicarGrupo("DDelincuentes", this);' id='NumeroDelincuentes' value='Agregar delincuentes'/>
			</div>
		</div>
	</div>
	<section class="DelincuentesD">
		<div class='container DDelincuentes' style="visibility:hidden; display:none">
			<div class='col-xs-12 col-lg-12 col-md-12 col-xl-12'>

	<div class='col-xs-6 col-md-4 col-lg-3 col-xl-3 form-group'>
		<label class='control-label' id= 'lblEstatura'>* Estatura (metros)</label>
		<input class='form-control text' idvariabledepende ='Estatura' maxlength='100' id='txtEstatura' type='text'/>
	</div>

	<div class='col-xs-6 col-md-4 col-lg-3 col-xl-3 form-group'>
		<label class='control-label' id= 'lblComplexion'>* Complexión</label>
		<select class='form-control select' id='selComplexion' >
			<option></option>
		</select>
	</div>

	<div class='col-xs-6 col-md-4 col-lg-3 col-xl-3 form-group'>
		<label class='control-label' id= 'lblVestimenta'>* Vestimenta</label>
		<input class='form-control text' idvariabledepende ='Vestimenta' maxlength='100' id='txtVestimenta' type='text'/>
	</div>

	<div class='col-xs-6 col-md-4 col-lg-3 col-xl-3 form-group'>
		<label class='control-label' id= 'lblEdad'>* Edad (años)</label>
		<input class='form-control text' idvariabledepende ='Edad' maxlength='100' id='txtEdad' type='text'/>
	</div>

	<div class='col-xs-6 col-md-4 col-lg-3 col-xl-3 form-group'>
		<label class='control-label' id= 'lblCabello'>* Cabello</label>
		<select class='form-control select' id='selCabello' >
			<option></option>
		</select>
	</div>

	<div class='col-xs-6 col-md-4 col-lg-3 col-xl-3 form-group'>
		<label class='control-label' id= 'lblTamanodelCabello'>* Tamaño del cabello</label>
		<select class='form-control select' id='selTamanodelCabello' >
			<option></option>
		</select>
	</div>

	<div class='col-xs-6 col-md-4 col-lg-3 col-xl-3 form-group'>
		<label class='control-label' id= 'lblColordelcabello'>* Color del cabello</label>
		<select class='form-control select' id='selColordelcabello' >
			<option></option>
		</select>
	</div>

	<div class='col-xs-12 col-md-12 col-lg-12 col-xl-12 form-group'>
		<label class='obligatorio etiquetaM control-label'>* Señas particulares</label>
		<textarea maxlength='1000' id='tarSenasParticulares' class='form-control area' rows='5'></textarea>
	</div>

	<div class='col-xs-6 col-md-4 col-lg-3 col-xl-3 form-group'>
		<label class='control-label' id= 'lblColordePiel'>* Color de piel</label>
		<select class='form-control select' id='selColordePiel' >
			<option></option>
		</select>
	</div>

	<div class='col-xs-12 col-md-12 col-lg-12 col-xl-12 form-group'>
		<label class='obligatorio etiquetaM control-label'>* Más rasgos</label>
		<textarea maxlength='1000' id='tarMasrasgos' class='form-control area' rows='5'></textarea>
	</div>

	<div class='col-xs-6 col-md-4 col-lg-3 col-xl-3 form-group'>
		<label class='control-label' id= 'lblGeneroDelincuente'>* Género del delincuente</label>
		<select class='form-control select' id='selGeneroDelincuente' >
			<option></option>
		</select>
	</div>

	<div class='col-xs-6 col-md-4 col-lg-3 col-xl-3 form-group'>
		<label class='control-label' id= 'lblTipodeArma'>* Tipo de arma</label>
		<select class='form-control select' id='selTipodeArma' >
			<option></option>
		</select>
	</div>
			</div>
		</div>
	</section>
	<div id="ctHoraEvento" class='container'>
		<div class='col-xs-12 col-sm-12 col-md-12 col-lg-12'>
			<div class='col-xs-6 col-md-4 col-lg-3 col-xl-3 form-group'>
				<label class='control-label' id= 'lblNumerodeAveriguacionPrevia'>* Número de averiguación previa</label>
				<input class='form-control' idvariabledepende ='NumerodeAveriguacionPrevia' maxlength='100' id='txtNumerodeAveriguacionPrevia' type='text'/>
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
	<input type="hidden" id="hdncontador_Delincuentes" value="0"/>
	<span id="lblCamposFaltantes" style="display:none">Faltan campos por llenar</span>
	<span id="lblAgregarExito" style="display:none">El reporte se ha agregado con éxito</span>
	<span id="lblAgregarAviso" style="display:none">El reporte capturado se va a agregar el reporte principal</span>
</body>
</html>
