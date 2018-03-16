<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ Page Language="C#" %>
<%@ Register tagprefix="SharePoint" namespace="Microsoft.SharePoint.WebControls" assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<html dir="ltr" xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" x-undefined="" />
<title>Sin título 1</title>
<meta http-equiv="X-UA-Compatible" content="IE=10" />
<SharePoint:CssRegistration Name="default" runat="server"/>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css"/>
<link rel="stylesheet" href="../../Styles/reportes.css"/>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.17.45/css/bootstrap-datetimepicker.css"/>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.17.45/css/bootstrap-datetimepicker.min.css"/>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
<script type="text/javascript" src="http://ajax.aspnetcdn.com/ajax/4.0/1/MicrosoftAjax.js"></script>

<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.17.1/moment.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.17.45/js/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript" src="../../Scripts/Sitios/Alarma.js"></script>
<script type="text/javascript" src="../../Scripts/Sitios/combo_min.js"></script>
<script type="text/javascript" src="https://cocacolafemsa.sharepoint.com/sites/SWPP/_layouts/15/SP.Runtime.js"></script>
<script type="text/javascript" src="https://cocacolafemsa.sharepoint.com/sites/SWPP/_layouts/15/SP.js"></script>
<script type="text/javascript" src="https://cocacolafemsa.sharepoint.com/sites/SWPP/_layouts/15/SP.UserProfiles.js"></script>
<script type="text/javascript" src="../../Scripts/Traduccion.js"></script>
<script type="text/javascript" src="/_layouts/15/clientforms.js">  </script>
<script type="text/javascript" src="/_layouts/15/clientpeoplepicker.js"></script>
<script type="text/javascript" src="/_layouts/15/autofill.js"></script>
<script type="text/javascript" src="/_layouts/15/clienttemplates.js"></script>

    <style>
        .BloqueReportesDinamicos {
            padding: 20px;
            border-radius: 25px;
            border: 2px solid #ff0000;
            width: max-content;
        }

        section:before {
            width: 17em;
            height: 6px;
            background: none;
            display: inline-block;
            content: "";
            margin-top: -30px;
            position: absolute;
            left: 0;
        }

        .container div {
            max-width: 100% !important;
        }

        label:before {
            color: red !important;
        }

        label {
            color: red !important;
			height:40px !important;
			vertical-align: text-bottom !important;
        }

        .DuplicacionTieneConocimiento {
            padding: 10px;
            border-radius: 25px;
            border: 1px solid #cc0000;
        }
    </style>
</head>

<body>

<span id="lblCamposFaltantes" style="display:none">Faltan campos por llenar</span>
    <span id="lblAsuntoCorreo" style="display:none">Reporte de incidencia</span>
    <div id="FormEst">
        <div class="container">
            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                <h2 id="lblFormEstNuevoReporte" style="color:red">Nuevo reporte</h2>
                <h3 id="lblFormEstUnidadReporta" style="color:red">Unidad que reporta</h3>
                <div class="col-xs-12 col-sm-6 col-md-3 col-lg-3 form-group">
                    <label class="control-label" id="lblFormEstPaisReporta" style="color:red">País</label>
                    <select class="form-control" id="cbPaisUnidadReporta" onchange="javascript: UbicacionEstadoUnidadReporta(this);" disabled><option></option></select>
                </div>
                <div class="col-xs-12 col-sm-6 col-md-3 col-lg-3 form-group">
                    <label class="control-label" id="lblFormEstEstadoReporta" style="color:red">Estado</label>
                    <select class="form-control" id="cbEstadoUnidadReporta" onchange="javascript: UbicacionMunicipioUnidadReporta(this);"><option></option></select>
                </div>
                <div class="col-xs-12 col-sm-6 col-md-3 col-lg-3 form-group">
                    <label class="control-label" id="lblFormEstMunicipioReporta" style="color:red">Municipio</label>
                    <select class="form-control" id="cbMunicipioUnidadReporta" onchange="javascript: UbicacionUnidadOperativaUnidadReporta(this);"><option></option></select>
                </div>
                <div class="col-xs-12 col-sm-6 col-md-3 col-lg-3 form-group">
                    <label class="control-label" id="lblFormEstUnidadOperativaReporta" style="color:red">Unidad Operativa</label>
                    <select class="form-control" id="cbUnidadOperativaReporta" onchange="javascript: UbicacionTipoUnidadOperativaUnidadReporta(this);"><option></option></select>
                </div>
            </div>
            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                <div class="col-xs-12 col-sm-6 col-md-3 col-lg-3 form-group">
                    <label class="control-label" id="lblFormEstTipoUnidadOperativaReporta" style="color:red">Tipo de unidad operativa</label>
                    <select class="form-control" id="cbTipoUnidadOperativaReporta"><option></option></select>
                </div>
                <div class="col-xs-12 col-sm-6 col-md-3 col-lg-3 form-group">
                    <label class="control-label" id="lblFormEstCreadoPor" style="color:red">Creado por</label>
                    <select class="form-control" id="cbUsuarioCreacion"><option></option></select>
                </div>
                <div class="col-xs-12 col-sm-6 col-md-3 col-lg-3 form-group">
                    <label class="control-label" id="lblFormEstFechaCreacion" style="color:red">Fecha de creación</label>
                    <input class="form-control" id="iptFechaCreacion" readonly />
                </div>
            </div>
            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                <div class="col-xs-12 col-sm-6 col-md-3 col-lg-3 form-group">
                    <label class="control-label" id="lblFormEstUsuarioCreacion" style="color:red">Usuario</label>
                    <input class="form-control" id="iptCreadoPor" readonly />
                </div>
                <div class="col-xs-12 col-sm-6 col-md-3 col-lg-3 form-group">
                    <label class="control-label" id="lblFormEstPuestoProteccion" style="color:red">Puesto de protección</label>
                    <select class="form-control" id="cbPuestoProteccion"><option></option></select>
                </div>
            </div>
        </div>
        <div class="container">
            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                <h3 id="lblFormEstUnidadAfectada" style="color:red">Unidad afectada</h3>
                <div class="col-xs-12 col-sm-6 col-md-3 col-lg-3 form-group">
                    <label class="control-label" id="lblFormEstPaisAfectado" style="color:red">País</label>
                    <select class="form-control" id="cbPaisUnidadAfectado" onchange="javascript: UbicacionTerritorioUnidadAfectada(this);" disabled><option></option></select>
                </div>
                <div class="col-xs-12 col-sm-6 col-md-3 col-lg-3 form-group">
                    <label class="control-label" id="lblFormEstTerritorioAfectado" style="color:red">Territorio</label>
                    <select class="form-control" id="cbTerritorioUnidadAfectado" onchange="javascript: UbicacionZonaUnidadAfectada(this);"><option></option></select>
                </div>
                <div class="col-xs-12 col-sm-6 col-md-3 col-lg-3 form-group">
                    <label class="control-label" id="lblFormEstZonaAfectada" style="color:red">Zona</label>
                    <select class="form-control" id="cbZonaUnidadAfectada" onchange="javascript: UbicacionEstadoUnidadAfectada(this);"></select>
                </div>
                <div class="col-xs-12 col-sm-6 col-md-3 col-lg-3 form-group">
                    <label class="control-label" id="lblFormEstEstadoAfectado" style="color:red">Estado</label>
                    <select class="form-control" id="cbEstadoUnidadAfectado" onchange="javascript: UbicacionMunicipioUnidadAfectada(this);"></select>
                </div>
                <div class="col-xs-12 col-sm-6 col-md-3 col-lg-3 form-group">
                    <label class="control-label" id="lblFormEstMunicipioAfectado" style="color:red">Municipio</label>
                    <select class="form-control" id="cbMunicipioUnidadAfectado" onchange="javascript: UbicacionUnidadOperativaUnidadAfectada(this);"><option></option></select>
                </div>
                <div class="col-xs-12 col-sm-6 col-md-3 col-lg-3 form-group">
                    <label class="control-label" id="lblFormEstNegocioAfectado" style="color:red">Negocio</label>
                    <select class="form-control" id="cbNegocioAfectado"><option></option></select>
                </div>
                <div class="col-xs-12 col-sm-6 col-md-3 col-lg-3 form-group">
                    <label class="control-label" id="lblFormEstUnidadOperativaAfectada" style="color:red">Unidad operativa</label>
                    <select class="form-control" id="cbUnidadOperativaUnidadAfectada" onchange="javascript: UbicacionResponsableEjecutivoUnidadAfectada(this);"><option></option></select>
                </div>
                <div class="col-xs-12 col-sm-6 col-md-3 col-lg-3 form-group">
                    <label class="control-label" id="lblFormEstGerenciaEstatal" style="color:red">Gerencia estatal</label>
                    <select class="form-control" id="cbGerenciaEstatal"><option></option></select>
                </div>
                <div class="col-xs-12 col-sm-6 col-md-3 col-lg-3 form-group">
                    <label class="control-label" id="lblFormEstImportancia" style="color:red">Importancia</label>
                    <select class="form-control" id="cbImportancia"><option></option></select>
                </div>
                <div class="col-xs-12 col-sm-6 col-md-3 col-lg-3 form-group">
                    <label class="control-label" id="lblFormEstResponsableEjecutivo" style="color:red">Responsable ejecutivo</label>
                    <select class="form-control" id="cbResponsableEjecutivo"><option></option></select>
                </div>
            </div>
        </div>
        <div class="container">
            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                <div class="col-xs-12 col-sm-6 col-md-3 col-lg-3 form-group">
                    <label class="control-label" id="lblFormEstTipoReporte" style="color:red">Tipo de reporte</label>
                    <select class="form-control" id="cbTipoReporte" onchange="javascript: LlenarSubNivelUno('cbSubNivelUno', this);"><option></option></select>
                </div>
                <div class="col-xs-12 col-sm-6 col-md-3 col-lg-3 form-group" id="subNivelUnoDiv">
                    <label class="control-label" id="lblFormEstSubNivelUno" style="color:red">SubNivel 1</label>
                    <select class="form-control" id="cbSubNivelUno" onchange="javascript: LlenarSubNivelDos('cbTipoReporte', 'cbSubNivelDos', this);"><option></option></select>
                </div>
                <div class="col-xs-12 col-sm-6 col-md-3 col-lg-3 form-group" id="subNivelDosDiv">
                    <label class="control-label" id="lblFormEstSubNivelDos" style="color:red">SubNivel 2</label>
                    <select class="form-control" id="cbSubNivelDos" onchange="javascript: LLenarSubNivelTres('cbTipoReporte', 'cbSubNivelUno', 'cbSubNivelTres', this);"><option></option></select>
                </div>
                <div class="col-xs-12 col-sm-6 col-md-3 col-lg-3 form-group" id="subNivelTresDiv">
                    <label class="control-label" id="lblFormEstSubNivelTres" style="color:red">SubNivel 3</label>
                    <select class="form-control" id="cbSubNivelTres" onchange="javascript: LlenarSubNivelCuatro('cbTipoReporte', 'cbSubNivelUno', 'cbSubNivelDos', 'cbSubNivelCuatro', this)"><option></option></select>
                </div>
                <div class="col-xs-12 col-sm-6 col-md-3 col-lg-3 form-group" id="subNivelCuatroDiv">
                    <label class="control-label" id="lblFormEstSubNivelCuatro" style="color:red">SubNivel 4</label>
                    <select class="form-control" id="cbSubNivelCuatro" onchange="javascript: AgregarReporteBase()"><option></option></select>
                </div>
            </div>
        </div>
        <br />
        <div id="ReportesDinamicos" class="container">

        </div>
        <br />
        <div class="container" id="BloqueSeguimiento" style="visibility:hidden; display:none;">
            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                    <label class="control-label" id="lblSeguimiento" style="color:red;">Seguimiento</label>
                    <textarea maxlength="5000" id="Seguimiento" class="form-control" rows="5"></textarea>
                </div>
            </div>
        </div>
        <br />
        <div class="container">
            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6 form-group">
                    <label class="control-label" id="lblad" style="color:red">Correos / Destinatarios</label>
                    <div id="peoplePickerDiv" class="col-xs-12 col-md-12 col-lg-12 col-xl-12 form-group"></div>
                </div>
            </div>
        </div>
        <br />
        <div class="container">
            <div class="col-xs-12 col-lg-12 col-md-12 col-xl-12">
                <div class="col-xs-6 col-md-4 col-lg-3 col-xl-3 form-group" unselectable="on">
                    <input type="button" onclick="javascript:DuplicarTieneConocimiento();" id="NumeroTieneConocimiento" value="+">
                </div>
            </div>
        </div>
        <div class="container">
            <section id="TieneConocimientoDuplicadas">
                <div class="container">
                    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                        <div class="col-xs-12 col-md-3 col-lg-3 col-xl-3 form-group">
                            <label class="control-label" id="lblTieneConocimiento" style="color:red">* Tiene conocimiento</label>
                        </div>
                        <div class="col-xs-12 col-md-3 col-lg-3 col-xl-3 form-group">
                            <label class="control-label" id="lblPuestoTieneConocimiento" style="color:red">* Puesto</label>
                        </div>
                    </div>
                </div>
                <div class="container DuplicacionTieneConocimiento" style="visibility:hidden; display:none">
                    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                        <div class="col-xs-12 col-md-3 col-lg-3 col-xl-3 form-group">
                            <input class="form-control" maxlength="50" id="TieneConocimiento" type="text">
                        </div>
                        <div class="col-xs-12 col-md-3 col-lg-3 col-xl-3 form-group">
                            <select class="form-control" id="PuestoTieneConocimiento"><option></option></select>
                        </div>
                    </div>
                </div>
            </section>
        </div>
        <br />
        <div class="container">
            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                <div class="col-xs-4 col-sm-4 col-md-4 col-lg-4" id="ArchivosAdjuntos">
                </div>
            </div>
        </div>
        <br />
        <div class="container">
            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                <div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">
                    <input type="button" id="btnAdjuntar" value="Adjuntar archivo(s)" onclick="AdjuntarArchivo();" />
                </div>
                <div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">
                    <input type="button" id="btnGuardarAbiertoAnalista" value="Guardar y enviar abierto" onclick="ValidarCamposGuardar('Abierto', true);" />
                </div>
                <div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">
                    <input type="button" id="btnGuardarCerradoAnalista" value="Guardar y enviar cerrado" onclick="ValidarCamposGuardar('Cerrado', true);" />
                </div>
                <div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">
                    <input type="button" id="btnGuardarAbiertoCar" value="Guardar y enviar abierto" onclick="ValidarCamposGuardar('Abierto Car', true);" />
                </div>
                <div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">
                    <input type="button" id="btnGuardarCerradoCar" value="Guardar y enviar cerrado" onclick="ValidarCamposGuardar('Cerrado Car', true);" />
                </div>
            </div>
        </div>
        <br />
        <div class="container">
            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                <div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">

                </div>
                <div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">

                </div>
                <div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">
                    <input type="button" id="btnReporteAdicional" value="Reporte adicional" onclick="ReporteAdicional();" />
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="modalReporteAdicional" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-body">
                    <div class="row">
                        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                            <div class="col-xs-6 col-sm-6 col-md-4 col-lg-3 form-group">
                                <label class="control-label" id="lblFormEstTipoReporte">Tipo de reporte</label>
                                <select class="form-control" id="cbTipoReporteAdicional" onchange="javascript: LlenarSubNivelUno('cbSubNivelUnoAdicional', this);"><option></option></select>
                            </div>
                            <div class="col-xs-6 col-sm-6 col-md-4 col-lg-3 form-group" id="subNivelUnoAdicionalDiv">
                                <label class="control-label" id="lblFormEstSubNivelUno">SubNivel 1</label>
                                <select class="form-control" id="cbSubNivelUnoAdicional" onchange="javascript: LlenarSubNivelDos('cbTipoReporteAdicional', 'cbSubNivelDosAdicional', this);"><option></option></select>
                            </div>
                            <div class="col-xs-6 col-sm-6 col-md-4 col-lg-3 form-group" id="subNivelDosAdicionalDiv">
                                <label class="control-label" id="lblFormEstSubNivelDos">SubNivel 2</label>
                                <select class="form-control" id="cbSubNivelDosAdicional" onchange="javascript: LLenarSubNivelTres('cbTipoReporteAdicional', 'cbSubNivelUnoAdicional', 'cbSubNivelTresAdicional', this);"><option></option></select>
                            </div>
                            <div class="col-xs-6 col-sm-6 col-md-4 col-lg-3 form-group" id="subNivelTresAdicionalDiv">
                                <label class="control-label" id="lblFormEstSubNivelTres">SubNivel 3</label>
                                <select class="form-control" id="cbSubNivelTresAdicional" onchange="javascript: LlenarSubNivelCuatro('cbTipoReporteAdicional', 'cbSubNivelUnoAdicional', 'cbSubNivelDosAdicional', 'cbSubNivelCuatroAdicional', this)"><option></option></select>
                            </div>
                            <div class="col-xs-6 col-sm-6 col-md-4 col-lg-3 form-group" id="subNivelCuatroAdicionalDiv">
                                <label class="control-label" id="lblFormEstSubNivelCuatro">SubNivel 4</label>
                                <select class="form-control" id="cbSubNivelCuatroAdicional"><option></option></select>
                            </div>
                        </div>
                        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                            <div class="col-xs-6 col-sm-6 col-md-4 col-lg-3">

                            </div>
                            <div class="col-xs-6 col-sm-6 col-md-4 col-lg-3">
                                <input type="button" id="btnAgregarReporteAdicional" value="Agregar" onclick="AgregarReporteAdicional();" />
                            </div>
                            <div class="col-xs-6 col-sm-6 col-md-4 col-lg-3">
                                <input type="button" id="btnSalirReporteAdicional" value="Salir" onclick="SalirReporteAdicional();" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="modalGuardado" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-body">
                    <div class="row">
                        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                            <img src="https://cocacolafemsa.sharepoint.com/sites/SWPP/SiteAssets/spinner.gif"/>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</body>

</html>
<script type="text/javascript">

    if (!String.prototype.includes) {
        String.prototype.includes = function () {
            'use strict';
            return String.prototype.indexOf.apply(this, arguments) !== -1;
        };
    }

    IdAdjuntos = [];
    pais = "";
    usuario = "";
    usuarioRed = "";
    numeroIncidencia = 0;
    urlGuardado = "";

    globallistaElementos = [];
    globallistaElementos2 = [];
    globallistaElementos3 = [];
    globallistaElementos4 = [];
    globallistaColorCabello = [];
    globallistaColorPiel = [];
    globallistaComplexion = [];
    globallistaCumplePolitica = [];
    globallistaEspecialidad = [];
    globallistaEstatusCaja = [];
    globallistaGeneroDelincuente = [];
    globallistaMedidaVoz = [];
    globallistaOcupaTraslado = [];
    globallistaReincidente = [];
    globallistaRespaldo = [];
    globallistaRetiroValores = [];
    globallistaTamanioCabello = [];
    globallistaTesituraVoz = [];
    globallistaTipoArma = [];
    globallistaTipoCabello = [];
    globallistaTipoLesion = [];
    globallistaVoz = [];
    globallistaAcumulacionMonto = [];

    function initializePeoplePicker() {
    	SP.SOD.loadMultiple(['sp.js', 'clienttemplates.js','clientforms.js','clientpeoplepicker.js','autofill.js'], function(){
		var schema = {};
        schema['PrincipalAccountType'] = 'User,DL,SecGroup,SPGroup';
        schema['SearchPrincipalSource'] = 15;
        schema['ResolvePrincipalSource'] = 15;
        schema['AllowMultipleValues'] = true;
        schema['MaximumEntitySuggestions'] = 50;


		this.SPClientPeoplePicker_InitStandaloneControlWrapper("peoplePickerDiv", null, schema);
	});		
        
			
        
    }

    $(function () {
    	//ExecuteOrDelayUntilScriptLoaded(, "sp.js");
        SP.SOD.executeFunc("sp.js", initializePeoplePicker());

        $('.date').datetimepicker({
            format: 'LT'
        });

        urlGuardado = _spPageContextInfo.webAbsoluteUrl;

        var d = new Date();
        var fechaCreacion = ("00" + (d.getDate())).slice(-2) + "/" + ("00" + (d.getMonth() + 1)).slice(-2) + "/" + d.getFullYear() + " " + ("00" + d.getHours()).slice(-2) + ":" + ("00" + d.getMinutes()).slice(-2) + ":" + ("00" + d.getSeconds()).slice(-2);
        document.getElementById("iptFechaCreacion").value = fechaCreacion;

        usuario = _spPageContextInfo.userLoginName;
        usuarioRed = usuario.split("@")[0];

        if (usuario.substring(0, 3).toUpperCase().includes("BR")) {
            pais = "BR";
        }
        else if (usuario.substring(0, 3).toUpperCase().includes("PH")) {
            pais = "PH";
        }
        else if (usuario.substring(0, 3).toUpperCase().includes("VE")) {
            pais = "VE";
        }
        else if (usuario.substring(0, 3).toUpperCase().includes("CO")) {
            pais = "CO";
        }
        else if (usuario.substring(0, 3).toUpperCase().includes("PA")) {
            pais = "PA";
        }
        else if (usuario.substring(0, 3).toUpperCase().includes("NI")) {
            pais = "NI";
        }
        else if (usuario.substring(0, 3).toUpperCase().includes("GU")) {
            pais = "GU";
        }
        else if (usuario.substring(0, 3).toUpperCase().includes("CR")) {
            pais = "CR";
        }
        else if (usuario.substring(0, 3).toUpperCase().includes("CA")) {
            pais = "CA";
        }
        else if (usuario.substring(0, 3).toUpperCase().includes("AR")) {
            pais = "AR";
        }
        else if (usuario.substring(0, 3).toUpperCase().includes("MX")) {
            pais = "MX";
        }
        else {
            pais = "MX";
        }

        CargarListaReportesDinamicos();

        CargarIdiomaUsuario(pais);
        CargarReportes("cbTipoReporteAdicional");
        CargarReportes("cbTipoReporte");

        UbicacionPais();
        UbicacionTerritorioUnidadAfectada(document.getElementById("cbPaisUnidadAfectado"));
        UbicacionZonaUnidadAfectada(document.getElementById("cbTerritorioUnidadAfectado"));
        UbicacionEstadoUnidadAfectada(document.getElementById("cbZonaUnidadAfectada"));
        UbicacionMunicipioUnidadAfectada(document.getElementById("cbEstadoUnidadAfectado"));
        UbicacionUnidadOperativaUnidadAfectada(document.getElementById("cbMunicipioUnidadAfectado"));
        UbicacionResponsableEjecutivoUnidadAfectada(document.getElementById("cbUnidadOperativaUnidadAfectada"));
        Negocio();
        Importancia();
        PuestoProteccion();
        UsuarioLogueado();
        UbicacionEstadoUnidadReporta(document.getElementById("cbPaisUnidadReporta"));
        UbicacionMunicipioUnidadReporta(document.getElementById("cbEstadoUnidadReporta"));
        UbicacionUnidadOperativaUnidadReporta(document.getElementById("cbMunicipioUnidadReporta"));
        UbicacionTipoUnidadOperativaUnidadReporta(document.getElementById("cbUnidadOperativaReporta"));

        CargarResponsableEjecutivo();
        MostrarBotonesCar();

        document.getElementById("peoplePickerDiv_TopSpan_AutoFillDiv").style["zIndex"] = "3";
        document.getElementById("peoplePickerDiv_TopSpan").style["height"] = "34px";
    });

    function CargarIdiomaEtiqueta(etiqueta) {
        traduccionetiqueta = "";
        switch (pais) {
            case "PH":
                $.ajax({
                    url: _spPageContextInfo.webAbsoluteUrl + "/_api/web/lists/getbytitle('Idioma Inglés')/Items?$select=Title,IdControl,Valor&$filter=Title eq 'pm7.aspx' and IdControl eq '" + etiqueta + "'&$top=10",
                    type: "GET",
                    async: false,
                    headers: { "accept": "application/json;odata=verbose" },
                    success: function (data) {
                        if (data.d.results) {
                            for (var i = 0; i < data.d.results.length; i++) {
                                traduccionetiqueta = data.d.results[i].Valor;
                            }
                        }
                    },
                    error: function (xhr) {
                        alert(xhr.status + ': ' + xhr.statusText);
                    }
                });
                break;
            case "BR":
                $.ajax({
                    url: _spPageContextInfo.webAbsoluteUrl + "/_api/web/lists/getbytitle('Idioma Portugués')/Items?$select=Title,IdControl,Valor&$filter=Title eq 'pm7.aspx' and IdControl eq '" + etiqueta + "'&$top=1000",
                    type: "GET",
                    async: false,
                    headers: { "accept": "application/json;odata=verbose" },
                    success: function (data) {
                        if (data.d.results) {
                            for (var i = 0; i < data.d.results.length; i++) {
                                traduccionetiqueta = data.d.results[i].Valor;
                            }
                        }
                    },
                    error: function (xhr) {
                        alert(xhr.status + ': ' + xhr.statusText);
                    }
                });
                break;
            default:
                $.ajax({
                    url: _spPageContextInfo.webAbsoluteUrl + "/_api/web/lists/getbytitle('Idioma Español')/Items?$select=IdControl,Title,Valor&$filter=Title eq 'pm7.aspx' and IdControl eq '" + etiqueta + "'&$top=1000",
                    type: "GET",
                    async: false,
                    headers: { "accept": "application/json;odata=verbose" },
                    success: function (data) {
                        if (data.d.results) {
                            for (var i = 0; i < data.d.results.length; i++) {
                                traduccionetiqueta = data.d.results[i].Valor;
                            }
                        }
                    },
                    error: function (xhr) {
                        alert(xhr.status + ': ' + xhr.statusText);
                    }
                });
        }
        return traduccionetiqueta;
    }

    function CargarIdiomaUsuario(nomenclaturaPais) {
        switch (nomenclaturaPais) {
            case "PH":
                $.ajax({
                    url: _spPageContextInfo.webAbsoluteUrl + "/_api/web/lists/getbytitle('Idioma Inglés')/Items?$select=Title,IdControl,Valor&$filter=Title eq 'pm7.aspx'&$top=1000",
                    type: "GET",
                    async: false,
                    headers: { "accept": "application/json;odata=verbose" },
                    success: function (data) {
                        if (data.d.results) {
                            for (var i = 0; i < data.d.results.length; i++) {
                                var elementoEtiqueta = document.getElementById(data.d.results[i].IdControl);
                                if (typeof (elementoEtiqueta) != 'undefined' && elementoEtiqueta != null) {
                                    elementoEtiqueta.innerHTML = data.d.results[i].Valor;
                                }
                            }
                        }
                    },
                    error: function (xhr) {
                        alert(xhr.status + ': ' + xhr.statusText);
                    }
                });
                break;
            case "BR":
                $.ajax({
                    url: _spPageContextInfo.webAbsoluteUrl + "/_api/web/lists/getbytitle('Idioma Portugués')/Items?$select=Title,IdControl,Valor&$filter=Title eq 'pm7.aspx'&$top=1000",
                    type: "GET",
                    async: false,
                    headers: { "accept": "application/json;odata=verbose" },
                    success: function (data) {
                        if (data.d.results) {
                            for (var i = 0; i < data.d.results.length; i++) {
                                var elementoEtiqueta = document.getElementById(data.d.results[i].IdControl);
                                if (typeof (elementoEtiqueta) != 'undefined' && elementoEtiqueta != null) {
                                    elementoEtiqueta.innerHTML = data.d.results[i].Valor;
                                }
                            }
                        }
                    },
                    error: function (xhr) {
                        alert(xhr.status + ': ' + xhr.statusText);
                    }
                });
                break;
            default:
                $.ajax({
                    url: _spPageContextInfo.webAbsoluteUrl + "/_api/web/lists/getbytitle('Idioma Español')/Items?$select=IdControl,Title,Valor&$filter=Title eq 'pm7.aspx'&$top=1000",
                    type: "GET",
                    async: false,
                    headers: { "accept": "application/json;odata=verbose" },
                    success: function (data) {
                        if (data.d.results) {
                            for (var i = 0; i < data.d.results.length; i++) {
                                var elementoEtiqueta = document.getElementById(data.d.results[i].IdControl);
                                if (typeof (elementoEtiqueta) != 'undefined' && elementoEtiqueta != null) {
                                    elementoEtiqueta.innerHTML = data.d.results[i].Valor;
                                }
                            }
                        }
                    },
                    error: function (xhr) {
                        alert(xhr.status + ': ' + xhr.statusText);
                    }
                });
        }
    }

    function MostrarBotonesCar() {
        if (BanderaCar) {
            $("#btnGuardarAbiertoCar").show();
            $("#btnGuardarCerradoCar").show();
            $("#btnGuardarAbiertoAnalista").hide();
            $("#btnGuardarCerradoAnalista").hide();
        }
        else {
            $("#btnGuardarAbiertoCar").hide();
            $("#btnGuardarCerradoCar").hide();
            $("#btnGuardarAbiertoAnalista").show();
            $("#btnGuardarCerradoAnalista").show();
        }

    }

    var BanderaCar = false;

    function CargarResponsableEjecutivo() {
        try {
            tipoPuestoProteccion = "";

            var x = document.getElementById("cbResponsableEjecutivo");

            x.innerHTML = "";



            $.ajax({

                url: _spPageContextInfo.webAbsoluteUrl + "/_api/web/lists/getbytitle('LstUsuarioAnalista')/Items?$select=Title,UsuarioCentralAlerta&$filter=Title eq '" + encodeURIComponent(usuario) + "'  or Title eq '" + encodeURIComponent(usuarioRed) + "'&$top=100",

                type: "GET",

                async: false,

                headers: { "accept": "application/json;odata=verbose" },

                success: function (data) {

                    if (data.d.results.length > 0) {

                        tipoPuestoProteccion = data.d.results[0].UsuarioCentralAlerta;

                        for (var i = 0; i < data.d.results.length; i++) {

                            option = document.createElement("option");

                            option.text = data.d.results[i].UsuarioCentralAlerta;

                            option.value = data.d.results[i].UsuarioCentralAlerta;

                            x.add(option);

                        }

                        $("#cbResponsableEjecutivo").val(tipoPuestoProteccion);

                        return;

                    }

                },

                error: function (xhr) {

                    console.log(xhr.status + ': ' + xhr.statusText);

                }

            });



            $.ajax({

                url: _spPageContextInfo.webAbsoluteUrl + "/_api/web/lists/getbytitle('LstUsuarioCoordinadorZona')/Items?$select=Title,UsuarioCentralAlerta&$filter=Title eq '" + encodeURIComponent(usuario) + "' or Title eq '" + encodeURIComponent(usuarioRed) + "'&$top=100",

                type: "GET",

                async: false,

                headers: { "accept": "application/json;odata=verbose" },

                success: function (data) {

                    if (data.d.results.length > 0) {

                        tipoPuestoProteccion = data.d.results[0].UsuarioCentralAlerta;

                        for (var i = 0; i < data.d.results.length; i++) {

                            option = document.createElement("option");

                            option.text = data.d.results[i].UsuarioCentralAlerta;

                            option.value = data.d.results[i].UsuarioCentralAlerta;

                            x.add(option);

                        }

                        $("#cbResponsableEjecutivo").val(tipoPuestoProteccion);

                        return;

                    }

                },

                error: function (xhr) {

                    console.log(xhr.status + ': ' + xhr.statusText);

                }

            });



            $.ajax({

                url: _spPageContextInfo.webAbsoluteUrl + "/_api/web/lists/getbytitle('LstUsuarioCoordinadorRegional')/Items?$select=Title,UsuarioCentralAlerta&$filter=Title eq '" + encodeURIComponent(usuario) + "' or Title eq '" + encodeURIComponent(usuarioRed) + "'&$top=100",

                type: "GET",

                async: false,

                headers: { "accept": "application/json;odata=verbose" },

                success: function (data) {

                    if (data.d.results.length > 0) {

                        tipoPuestoProteccion = data.d.results[0].UsuarioCentralAlerta;

                        for (var i = 0; i < data.d.results.length; i++) {

                            option = document.createElement("option");

                            option.text = data.d.results[i].UsuarioCentralAlerta;

                            option.value = data.d.results[i].UsuarioCentralAlerta;

                            x.add(option);

                        }

                        $("#cbResponsableEjecutivo").val(tipoPuestoProteccion);

                        return;

                    }

                },

                error: function (xhr) {

                    console.log(xhr.status + ': ' + xhr.statusText);

                }

            });



            $.ajax({

                url: _spPageContextInfo.webAbsoluteUrl + "/_api/web/lists/getbytitle('LstUsuarioEjecutivoProteccion')/Items?$select=Title,UsuarioCentralAlerta&$filter=Title eq '" + encodeURIComponent(usuario) + "' or Title eq '" + encodeURIComponent(usuarioRed) + "'&$top=100",

                type: "GET",

                async: false,

                headers: { "accept": "application/json;odata=verbose" },

                success: function (data) {

                    if (data.d.results.length > 0) {

                        tipoPuestoProteccion = data.d.results[0].UsuarioCentralAlerta;

                        for (var i = 0; i < data.d.results.length; i++) {

                            option = document.createElement("option");

                            option.text = data.d.results[i].UsuarioCentralAlerta;

                            option.value = data.d.results[i].UsuarioCentralAlerta;

                            x.add(option);

                        }

                        $("#cbResponsableEjecutivo").val(tipoPuestoProteccion);

                        return;

                    }

                },

                error: function (xhr) {

                    console.log(xhr.status + ': ' + xhr.statusText);

                }

            });



            $.ajax({

                url: _spPageContextInfo.webAbsoluteUrl + "/_api/web/lists/getbytitle('LstUsuarioCECO')/Items?$select=Title,UsuarioCentralAlerta&$filter=Title eq '" + encodeURIComponent(usuario) + "' or Title eq '" + encodeURIComponent(usuarioRed) + "'&$top=100",

                type: "GET",

                async: false,

                headers: { "accept": "application/json;odata=verbose" },

                success: function (data) {

                    if (data.d.results.length > 0) {

                        tipoPuestoProteccion = data.d.results[0].UsuarioCentralAlerta;

                        for (var i = 0; i < data.d.results.length; i++) {

                            option = document.createElement("option");

                            option.text = data.d.results[i].UsuarioCentralAlerta;

                            option.value = data.d.results[i].UsuarioCentralAlerta;

                            x.add(option);

                        }

                        $("#cbResponsableEjecutivo").val(tipoPuestoProteccion);

                        return;

                    }

                },

                error: function (xhr) {

                    console.log(xhr.status + ': ' + xhr.statusText);

                }

            });



            $.ajax({

                url: _spPageContextInfo.webAbsoluteUrl + "/_api/web/lists/getbytitle('LstUsuarioCentralAlerta')/Items?$select=Title&$filter=Title eq '" + encodeURIComponent(usuario) + "' or Title eq '" + encodeURIComponent(usuarioRed) + "'&$top=100",

                type: "GET",

                async: false,

                headers: { "accept": "application/json;odata=verbose" },

                success: function (data) {

                    if (data.d.results.length > 0) {

                        tipoPuestoProteccion = data.d.results[0].Title;

                        for (var i = 0; i < data.d.results.length; i++) {

                            option = document.createElement("option");

                            option.text = data.d.results[i].Title;

                            option.value = data.d.results[i].Title;

                            x.add(option);

                        }

                        $("#cbResponsableEjecutivo").val(tipoPuestoProteccion);
                        //Se asigna la bandera Car
                        BanderaCar = true;
                        return;

                    }

                },

                error: function (xhr) {

                    console.log(xhr.status + ': ' + xhr.statusText);

                }

            });

        }
        catch (err) { console.log(err.message); }
        //return tipoPuestoProteccion;
    }

    function AdjuntarArchivo() {
        var folioP = 0;

        var currentTime = new Date();
        var year = currentTime.getFullYear().toString();
        var str1 = (currentTime.getMonth() + 1).toString();
        var pad1 = "00";
        var ans1 = pad1.substring(0, pad1.length - str1.length) + str1;
        var str2 = currentTime.getDate().toString();
        var pad2 = "00";
        var ans2 = pad2.substring(0, pad2.length - str2.length) + str2;
        var fecha = ans2 + "/" + ans1 + "/" + year;

        $.ajax({
            url: _spPageContextInfo.webAbsoluteUrl + "/_api/web/lists/getbytitle('LstArchivosInc')/Items?$select=Title,ID,IdFolio&$orderby=ID desc&$top=1",
            type: "GET",
            async: false,
            headers: { "accept": "application/json;odata=verbose" },
            success: function (data) {
                if (data.d.results) {
                    var info = data.d.results;
                    folioP = info[0].ID;
                    var folioN = Number(folioP) + 1;
                    var data = {
                        __metadata: { 'type': 'SP.Data.LstArchivosIncListItem' },
                        Title: "",
                        IdFolio: folioN.toString(),
                        IdFecha: fecha,
                        IdFolioIncidencia: ""
                    };
                    try {
                        IdAdjuntos.push(folioN);
                        $.ajax({
                            url: _spPageContextInfo.webAbsoluteUrl + "/_api/Web/Lists/GetByTitle('LstArchivosInc')/Items",
                            type: "POST",
                            async: false,
                            data: JSON.stringify(data),
                            headers: {
                                "accept": "application/json;odata=verbose",
                                "content-type": "application/json;odata=verbose",
                                "X-RequestDigest": $("#__REQUESTDIGEST").val()
                            },
                            success: function (d) {
                                var url = _spPageContextInfo.webAbsoluteUrl + "/_layouts/Attachfile.aspx?ListId={37703f87-c860-4790-bcee-f7868bddb7a7}&ItemId=" + folioN + "";
                                var options = {
                                    url: url,
                                    dialogReturnValueCallback: function (result, fileAdded) {
                                        if (result == SP.UI.DialogResult.OK) {
                                            obtenerArchivos(folioN)
                                        }
                                    }
                                };
                                SP.UI.ModalDialog.showModalDialog(options);
                            },
                            error: function (exc) {
                                console.log(exc);
                            }
                        });
                    } catch (err) {
                        console.log("");
                    }
                }
            },
            error: function (xhr) {
                alert(xhr.status + ': ' + xhr.statusText);
            }
        });
    }

    function obtenerArchivos(Id) {
        $.ajax({
            url: _spPageContextInfo.webAbsoluteUrl + "/_api/web/lists/getbytitle('LstArchivosInc')/Items?$select=AttachmentFiles,Attachments,ID&$expand=AttachmentFiles&$filter=ID eq '" + Id + "'",
            type: "GET",
            headers: {
                "accept": "application/json;odata=verbose"
            },
            success: function (data) {
                if (data.d.results) {
                    for (var i = 0; i < data.d.results.length; i++) {
                        var arregloarchivos = data.d.results[i].AttachmentFiles.results.length;
                        for (var x = 0; x < arregloarchivos; x++) {
                            console.log(data.d.results[i].AttachmentFiles.results[x].FileName);
                            console.log(data.d.results[i].AttachmentFiles.results[x].ServerRelativeUrl);
                            aux = data.d.results[i].AttachmentFiles.results[x].FileName.replace(".", "↕");
                            var numf = "";
                            numf = "onclick=\"javascript:deleteAttachmentFile(\'" + data.d.results[i].ID.toString() + "\',\'" + aux.toString() + "\')\"'"
                            console.log(numf);
                            varhtml = "<div class='col-xs-12 col-sm-12 col-md-12 col-lg-12'><div class='col-xs-4 col-sm-4 col-md-4 col-lg-4' id='FileAdjuntos" + data.d.results[i].ID + "'><div class='col-xs-4 col-sm-4 col-md-4 col-lg-4'><a target='_blank' href='" + _spPageContextInfo.webAbsoluteUrl + "/Lists/LstArchivosInc/Attachments/" + data.d.results[i].ID + "/" + data.d.results[i].AttachmentFiles.results[x].FileName + "'>" + data.d.results[i].AttachmentFiles.results[x].FileName + " </a></div>";
                            varhtml += "<div class='col-xs-4 col-sm-4 col-md-4 col-lg-4' ><input  type='button' value='Borrar' " + numf + "  ></div></div></div>";
                            $("#ArchivosAdjuntos").before(varhtml);
                        }
                    }
                }
            },
            error: function (xhr) {
                alert(xhr.status + ': ' + xhr.statusText);
            }
        });
    }

    function deleteAttachmentFile(itemId, fileName) {
        console.log("antes:" + fileName);
        fileName = fileName.replace("↕", ".");
        console.log("despues:" + fileName);
        var response = $.ajax({
            url: _spPageContextInfo.webAbsoluteUrl + "/_api/web/lists/getByTitle('LstArchivosInc')/getItemById(" + itemId + ")/AttachmentFiles/getByFileName('" + fileName + "')",
            method: 'POST',
            contentType: 'application/json;odata=verbose',
            headers: {
                'X-RequestDigest': $('#__REQUESTDIGEST').val(),
                'X-HTTP-Method': 'DELETE',
                'Accept': 'application/json;odata=verbose'
            }

        });
        $("#FileAdjuntos" + itemId).remove();
        for (var i = IdAdjuntos.length; i--;) {
            if (IdAdjuntos[i] === item) {
                IdAdjuntos.splice(i, 1);
            }
        }
    }

    function guardarArchivosInc(FolioInc) {
        console.log("" + IdAdjuntos.length);
        for (var i = 0; i < IdAdjuntos.length; i++) {
            console.log("Archivo a adjuntar " + IdAdjuntos[i]);
            var dataUpdate = {
                __metadata: { 'type': 'SP.Data.LstArchivosIncListItem' },
                IdFolioIncidencia: FolioInc
            };
            var idListItem = "";
            $.ajax({
                async: false,
                url: _spPageContextInfo.webAbsoluteUrl + "/_api/web/lists/getbytitle('LstArchivosInc')/Items?$select=ID&$filter=ID eq '" + IdAdjuntos[i] + "' &$top=1",
                type: "GET",
                headers: { "accept": "application/json;odata=verbose" },
                success: function (data) {
                    if (data.d.results) {
                        for (var i = 0; i < data.d.results.length; i++) {
                            guardarArchivosIncComplemento(dataUpdate, data.d.results[i]);
                        }
                    }
                },
                error: function (xhr) {
                    console.log(xhr.status + ': ' + xhr.statusText);
                }
            });
        }
    }

    function guardarArchivosIncComplemento(data, item) {
        $.ajax({
            async: false,
            url: _spPageContextInfo.webAbsoluteUrl + "/_api/Web/Lists/GetByTitle('LstArchivosInc')/Items(" + item.ID + ")",
            type: "POST",
            data: JSON.stringify(data),
            headers: {
                Accept: "application/json;odata=verbose",
                "Content-Type": "application/json;odata=verbose",
                "X-RequestDigest": $("#__REQUESTDIGEST").val(),
                "IF-MATCH": item.__metadata.etag,
                "X-Http-Method": "PATCH"
            },
            success: function (d) {
                console.log("guardo bien los archivos");
            },
            error: function (exc) {
                console.log(exc);
            }
        });
    }

    function ReporteAdicional() {
        $('#modalReporteAdicional').modal('show');
        CargarReportes("cbTipoReporteAdicional");
    }

    function CargarReportes(elementName) {
        var x = document.getElementById(elementName);
        x.innerHTML = "";
        var option = document.createElement("option");
        option.text = "...";
        option.value = null;
        x.add(option);

        if (elementName.substr(-9) == "Adicional") {
            document.getElementById("subNivelUnoAdicionalDiv").style.display = "none";
            document.getElementById("subNivelDosAdicionalDiv").style.display = "none";
            document.getElementById("subNivelTresAdicionalDiv").style.display = "none";
            document.getElementById("subNivelCuatroAdicionalDiv").style.display = "none";

            var y = document.getElementById("cbSubNivelUnoAdicional");
            y.innerHTML = "";
            var optiony = document.createElement("option");
            optiony.text = "...";
            optiony.value = null;
            y.add(optiony);

            y = document.getElementById("cbSubNivelDosAdicional");
            y.innerHTML = "";
            optiony = document.createElement("option");
            optiony.text = "...";
            optiony.value = null;
            y.add(optiony);

            y = document.getElementById("cbSubNivelTresAdicional");
            y.innerHTML = "";
            optiony = document.createElement("option");
            optiony.text = "...";
            optiony.value = null;
            y.add(optiony);

            y = document.getElementById("cbSubNivelCuatroAdicional");
            y.innerHTML = "";
            optiony = document.createElement("option");
            optiony.text = "...";
            optiony.value = null;
            y.add(optiony);

        } else {
            document.getElementById("subNivelUnoDiv").style.display = "none";
            document.getElementById("subNivelDosDiv").style.display = "none";
            document.getElementById("subNivelTresDiv").style.display = "none";
            document.getElementById("subNivelCuatroDiv").style.display = "none";

            var y = document.getElementById("cbSubNivelUno");
            y.innerHTML = "";
            var optiony = document.createElement("option");
            optiony.text = "...";
            optiony.value = null;
            y.add(optiony);

            y = document.getElementById("cbSubNivelDos");
            y.innerHTML = "";
            optiony = document.createElement("option");
            optiony.text = "...";
            optiony.value = null;
            y.add(optiony);

            y = document.getElementById("cbSubNivelTres");
            y.innerHTML = "";
            optiony = document.createElement("option");
            optiony.text = "...";
            optiony.value = null;
            y.add(optiony);

            y = document.getElementById("cbSubNivelCuatro");
            y.innerHTML = "";
            optiony = document.createElement("option");
            optiony.text = "...";
            optiony.value = null;
            y.add(optiony);
        }

        $.ajax({
            url: _spPageContextInfo.webAbsoluteUrl + "/_api/web/lists/getbytitle('TipoReporte')/Items?$select=Title,NombreTipoReporte,Pais,Tooltip&$filter=Pais eq '" + encodeURIComponent(pais) + "'&$top=1000",
            type: "GET",
            async: false,
            headers: { "accept": "application/json;odata=verbose" },
            success: function (data) {
                if (data.d.results) {
                    for (var i = 0; i < data.d.results.length; i++) {
                        option = document.createElement("option");
                        option.text = data.d.results[i].NombreTipoReporte;
                        option.value = data.d.results[i].Title;
                        if (data.d.results[i].Tooltip != null) {
                            option.title = data.d.results[i].Tooltip;
                        }
                        x.add(option);
                    }
                }
            },
            error: function (xhr) {
                console.log(xhr.status + ': ' + xhr.statusText);
            }
        });
    }

    function LlenarSubNivelUno(elementName, element) {
        var x = document.getElementById(elementName);
        x.innerHTML = "";
        var option = document.createElement("option");
        option.text = "...";
        option.value = null;
        x.add(option);
        if (elementName.substr(-9) == "Adicional") {
            document.getElementById("subNivelUnoAdicionalDiv").style.display = "none";
            document.getElementById("subNivelDosAdicionalDiv").style.display = "none";
            document.getElementById("subNivelTresAdicionalDiv").style.display = "none";
            document.getElementById("subNivelCuatroAdicionalDiv").style.display = "none";

            var y = document.getElementById("cbSubNivelDosAdicional");
            y.innerHTML = "";
            var optiony = document.createElement("option");
            optiony.text = "...";
            optiony.value = null;
            y.add(optiony);

            y = document.getElementById("cbSubNivelTresAdicional");
            y.innerHTML = "";
            optiony = document.createElement("option");
            optiony.text = "...";
            optiony.value = null;
            y.add(optiony);

            y = document.getElementById("cbSubNivelCuatroAdicional");
            y.innerHTML = "";
            optiony = document.createElement("option");
            optiony.text = "...";
            optiony.value = null;
            y.add(optiony);

        } else {
            document.getElementById("subNivelUnoDiv").style.display = "none";
            document.getElementById("subNivelDosDiv").style.display = "none";
            document.getElementById("subNivelTresDiv").style.display = "none";
            document.getElementById("subNivelCuatroDiv").style.display = "none";

            var y = document.getElementById("cbSubNivelDos");
            y.innerHTML = "";
            var optiony = document.createElement("option");
            optiony.text = "...";
            optiony.value = null;
            y.add(optiony);

            y = document.getElementById("cbSubNivelTres");
            y.innerHTML = "";
            optiony = document.createElement("option");
            optiony.text = "...";
            optiony.value = null;
            y.add(optiony);

            y = document.getElementById("cbSubNivelCuatro");
            y.innerHTML = "";
            optiony = document.createElement("option");
            optiony.text = "...";
            optiony.value = null;
            y.add(optiony);
        }

        $.ajax({
            url: _spPageContextInfo.webAbsoluteUrl + "/_api/web/lists/getbytitle('SubNivel1')/Items?$select=Title,TipoReporte,NombreSubNivel,Pais,Tooltip&$filter=Pais eq '" + encodeURIComponent(pais) + "' and TipoReporte eq '" + encodeURIComponent(element.value) + "'&$top=1000",
            type: "GET",
            async: false,
            headers: { "accept": "application/json;odata=verbose" },
            success: function (data) {
                if (data.d.results.length > 0) {
                    for (var i = 0; i < data.d.results.length; i++) {
                        option = document.createElement("option");
                        option.text = data.d.results[i].NombreSubNivel;
                        option.value = data.d.results[i].Title;
                        if (data.d.results[i].Tooltip != null) {
                            option.title = data.d.results[i].Tooltip;
                        }
                        x.add(option);
                    }
                    if (elementName.substr(-9) == "Adicional") {
                        document.getElementById("subNivelUnoAdicionalDiv").style.display = "block";
                    } else {
                        document.getElementById("subNivelUnoDiv").style.display = "block";
                    }
                }
                else {
                    if (elementName.substr(-9) == "Adicional") {
                        console.log("no debe entrar aquí")
                    } else {
                        AgregarReporteBase();
                    }
                }
            },
            error: function (xhr) {
                console.log(xhr.status + ': ' + xhr.statusText);
            }
        });
    }

    function LlenarSubNivelDos(elementTR, elementName, element) {
        var x = document.getElementById(elementName);
        x.innerHTML = "";
        var option = document.createElement("option");
        option.text = "...";
        option.value = null;
        x.add(option);
        if (elementName.substr(-9) == "Adicional") {
            document.getElementById("subNivelDosAdicionalDiv").style.display = "none";
            document.getElementById("subNivelTresAdicionalDiv").style.display = "none";
            document.getElementById("subNivelCuatroAdicionalDiv").style.display = "none";

            var y = document.getElementById("cbSubNivelTresAdicional");
            y.innerHTML = "";
            var optiony = document.createElement("option");
            optiony.text = "...";
            optiony.value = null;
            y.add(optiony);

            y = document.getElementById("cbSubNivelCuatroAdicional");
            y.innerHTML = "";
            optiony = document.createElement("option");
            optiony.text = "...";
            optiony.value = null;
            y.add(optiony);
        } else {
            document.getElementById("subNivelDosDiv").style.display = "none";
            document.getElementById("subNivelTresDiv").style.display = "none";
            document.getElementById("subNivelCuatroDiv").style.display = "none";

            var y = document.getElementById("cbSubNivelTres");
            y.innerHTML = "";
            var optiony = document.createElement("option");
            optiony.text = "...";
            optiony.value = null;
            y.add(optiony);

            y = document.getElementById("cbSubNivelCuatro");
            y.innerHTML = "";
            optiony = document.createElement("option");
            optiony.text = "...";
            optiony.value = null;
            y.add(optiony);
        }

        var tR = document.getElementById(elementTR);

        $.ajax({
            url: _spPageContextInfo.webAbsoluteUrl + "/_api/web/lists/getbytitle('SubNivel2')/Items?$select=Title,TipoReporte,SubNivel1,NombreSubNivel,Pais,Tooltip&$filter=TipoReporte eq '" + encodeURIComponent(tR.value) + "' and SubNivel1 eq '" + encodeURIComponent(element.value) + "' and Pais eq '" + encodeURIComponent(pais) + "'&$top=1000",
            type: "GET",
            async: false,
            headers: { "accept": "application/json;odata=verbose" },
            success: function (data) {
                if (data.d.results.length > 0) {
                    for (var i = 0; i < data.d.results.length; i++) {
                        option = document.createElement("option");
                        option.text = data.d.results[i].NombreSubNivel;
                        option.value = data.d.results[i].Title;
                        if (data.d.results[i].Tooltip != null) {
                            option.title = data.d.results[i].Tooltip;
                        }
                        x.add(option);
                    }
                    if (elementName.substr(-9) == "Adicional") {
                        document.getElementById("subNivelDosAdicionalDiv").style.display = "block";
                    } else {
                        document.getElementById("subNivelDosDiv").style.display = "block";
                    }
                }
                else {
                    if (elementName.substr(-9) == "Adicional") {
                        console.log("no debe entrar aquí")
                    } else {
                        AgregarReporteBase();
                    }
                }
            },
            error: function (xhr) {
                console.log(xhr.status + ': ' + xhr.statusText);
            }
        });
    }

    function LLenarSubNivelTres(elementTR, elementSU, elementName, element) {
        var x = document.getElementById(elementName);
        x.innerHTML = "";
        var option = document.createElement("option");
        option.text = "...";
        option.value = null;
        x.add(option);
        if (elementName.substr(-9) == "Adicional") {
            document.getElementById("subNivelTresAdicionalDiv").style.display = "none";
            document.getElementById("subNivelCuatroAdicionalDiv").style.display = "none";

            var y = document.getElementById("cbSubNivelCuatroAdicional");
            y.innerHTML = "";
            var optiony = document.createElement("option");
            optiony.text = "...";
            optiony.value = null;
            y.add(optiony);
        } else {
            document.getElementById("subNivelTresDiv").style.display = "none";
            document.getElementById("subNivelCuatroDiv").style.display = "none";

            var y = document.getElementById("cbSubNivelCuatro");
            y.innerHTML = "";
            var optiony = document.createElement("option");
            optiony.text = "...";
            optiony.value = null;
            y.add(optiony);

        }

        var tR = document.getElementById(elementTR);
        var sU = document.getElementById(elementSU);

        $.ajax({
            url: _spPageContextInfo.webAbsoluteUrl + "/_api/web/lists/getbytitle('SubNivel3')/Items?$select=Title,TipoReporte,SubNivel1,SubNivel2,NombreSubNivel,Tooltip,Pais&$filter=TipoReporte eq '" + encodeURIComponent(tR.value) + "' and SubNivel1 eq '" + encodeURIComponent(sU.value) + "' and SubNivel2 eq '" + encodeURIComponent(element.value) + "' and Pais eq '" + encodeURIComponent(pais) + "'&$top=1000",
            type: "GET",
            async: false,
            headers: { "accept": "application/json;odata=verbose" },
            success: function (data) {
                if (data.d.results.length > 0) {
                    for (var i = 0; i < data.d.results.length; i++) {
                        option = document.createElement("option");
                        option.text = data.d.results[i].NombreSubNivel;
                        option.value = data.d.results[i].Title;
                        if (data.d.results[i].Tooltip != null) {
                            option.title = data.d.results[i].Tooltip;
                        }
                        x.add(option);
                    }
                    if (elementName.substr(-9) == "Adicional") {
                        document.getElementById("subNivelTresAdicionalDiv").style.display = "block";
                    } else {
                        document.getElementById("subNivelTresDiv").style.display = "block";
                    }
                }
                else {
                    if (elementName.substr(-9) == "Adicional") {
                        console.log("no debe entrar aquí")
                    } else {
                        AgregarReporteBase();
                    }
                }
            },
            error: function (xhr) {
                console.log(xhr.status + ': ' + xhr.statusText);
            }
        });
    }

    function LlenarSubNivelCuatro(elementTR, elementSU, elementSD, elementName, element) {
        var x = document.getElementById(elementName);
        x.innerHTML = "";
        var option = document.createElement("option");
        option.text = "...";
        option.value = null;
        x.add(option);
        if (elementName.substr(-9) == "Adicional") {
            document.getElementById("subNivelCuatroAdicionalDiv").style.display = "none";
        } else {
            document.getElementById("subNivelCuatroDiv").style.display = "none";
        }

        var tR = document.getElementById(elementTR);
        var sU = document.getElementById(elementSU);
        var sD = document.getElementById(elementSD);

        $.ajax({
            url: _spPageContextInfo.webAbsoluteUrl + "/_api/web/lists/getbytitle('SubNivel4')/Items?$select=Title,TipoReporte,SubNivel1,SubNivel2,SubNivel3,NombreSubNivel,Pais,Tooltip&$filter=TipoReporte eq '" + encodeURIComponent(tR.value) + "' and SubNivel1 eq '" + encodeURIComponent(sU.value) + "' and SubNivel2 eq '" + encodeURIComponent(sD.value) + "' and SubNivel3 eq '" + encodeURIComponent(element.value) + "' and Pais eq '" + encodeURIComponent(pais) + "'&$top=1000",
            type: "GET",
            async: false,
            headers: { "accept": "application/json;odata=verbose" },
            success: function (data) {
                if (data.d.results.length > 0) {
                    for (var i = 0; i < data.d.results.length; i++) {
                        option = document.createElement("option");
                        option.text = data.d.results[i].NombreSubNivel;
                        option.value = data.d.results[i].Title;
                        if (data.d.results[i].Tooltip != null) {
                            option.title = data.d.results[i].Tooltip;
                        }
                        x.add(option);
                    }
                    if (elementName.substr(-9) == "Adicional") {
                        document.getElementById("subNivelCuatroAdicionalDiv").style.display = "block";
                    } else {
                        document.getElementById("subNivelCuatroDiv").style.display = "block";
                    }
                }
                else {
                    if (elementName.substr(-9) == "Adicional") {
                        console.log("no debe entrar aquí")
                    } else {
                        AgregarReporteBase();
                    }
                }
            },
            error: function (xhr) {
                console.log(xhr.status + ': ' + xhr.statusText);
            }
        });

    }

    function Negocio() {
        var x = document.getElementById("cbNegocioAfectado");
        x.innerHTML = "";

        $.ajax({
            url: _spPageContextInfo.webAbsoluteUrl + "/_api/web/lists/getbytitle('LstNegocio')/Items?$select=Title&$top=100",
            type: "GET",
            async: false,
            headers: { "accept": "application/json;odata=verbose" },
            success: function (data) {
                if (data.d.results.length > 0) {
                    for (i = 0; i < data.d.results.length; i++) {
                        optionx = document.createElement("option");
                        optionx.text = data.d.results[i].Title;
                        optionx.value = data.d.results[i].Title;
                        x.add(optionx);
                    }
                }
            },
            error: function (xhr) {
                console.log(xhr.status + ': ' + xhr.statusText);
            }
        });
    }

    function Importancia() {
        var x = document.getElementById("cbImportancia");
        x.innerHTML = "";

        var optionx = document.createElement("option");
        optionx.text = "...";
        optionx.value = null;
        x.add(optionx);

        $.ajax({
            url: _spPageContextInfo.webAbsoluteUrl + "/_api/web/lists/getbytitle('LstImportancia')/Items?$select=Title&$filter=Pa_x00ed_s eq '" + encodeURIComponent(pais) + "'&$top=100",
            type: "GET",
            async: false,
            headers: { "accept": "application/json;odata=verbose" },
            success: function (data) {
                if (data.d.results.length > 0) {
                    for (i = 0; i < data.d.results.length; i++) {
                        optionx = document.createElement("option");
                        optionx.text = data.d.results[i].Title;
                        optionx.value = data.d.results[i].Title;
                        x.add(optionx);
                    }
                }
            },
            error: function (xhr) {
                console.log(xhr.status + ': ' + xhr.statusText);
            }
        });

    }

    function PuestoProteccion() {
        var x = document.getElementById("cbPuestoProteccion");
        x.innerHTML = "";

        var optionx = document.createElement("option");
        optionx.text = "...";
        optionx.value = null;
        x.add(optionx);

        var y = document.getElementById("PuestoTieneConocimiento");
        y.innerHTML = "";

        var optiony = document.createElement("option");
        optiony.text = "...";
        optiony.value = null;
        y.add(optiony);

        $.ajax({
            url: _spPageContextInfo.webAbsoluteUrl + "/_api/web/lists/getbytitle('LstPuestoProteccion')/Items?$select=Title,Pa_x00ed_s&$filter=Pa_x00ed_s eq '" + encodeURIComponent(pais) + "'&$top=100",
            type: "GET",
            async: false,
            headers: { "accept": "application/json;odata=verbose" },
            success: function (data) {
                if (data.d.results.length > 0) {
                    for (i = 0; i < data.d.results.length; i++) {
                        optionx = document.createElement("option");
                        optionx.text = data.d.results[i].Title;
                        optionx.value = data.d.results[i].Title;
                        x.add(optionx);

                        optiony = document.createElement("option");
                        optiony.text = data.d.results[i].Title;
                        optiony.value = data.d.results[i].Title;
                        y.add(optiony);
                    }
                }
            },
            error: function (xhr) {
                console.log(xhr.status + ': ' + xhr.statusText);
            }
        });

    }

    function UsuarioLogueado() {
        $.ajax({
            async: false,
            type: "GET",
            url: "https://cocacolafemsa.sharepoint.com/sites/SWPP/_api/SP.UserProfiles.PeopleManager/GetMyProperties",
            headers: { "accept": "application/json;odata=verbose" },
            success: function (data) {
                document.getElementById("iptCreadoPor").value = data.d.DisplayName;
            },
            error: function (e) {
                console.log(e);
            }
        });

        var x = document.getElementById("cbUsuarioCreacion");
        x.innerHTML = "";

        $.ajax({
            url: _spPageContextInfo.webAbsoluteUrl + "/_api/web/lists/getbytitle('LstUsuarioGenerico')/Items?$select=Title,Perfil,NombrePersona&$filter=Title eq '" + encodeURIComponent(usuario) + "'&$top=100",
            type: "GET",
            headers: { "accept": "application/json;odata=verbose" },
            success: function (data) {
                if (data.d.results.length > 0) {
                    for (i = 0; i < data.d.results.length; i++) {
                        optionx = document.createElement("option");
                        optionx.text = data.d.results[i].NombrePersona;
                        optionx.value = data.d.results[i].Title;
                        x.add(optionx);
                    }
                }
                else {
                    optionx = document.createElement("option");
                    optionx.text = document.getElementById("iptCreadoPor").value;
                    optionx.value = usuario;
                    x.add(optionx);
                }
            },
            error: function (xhr) {
                console.log(xhr.status + ': ' + xhr.statusText);
            }
        });
    }

    function UbicacionPais() {
        var x = document.getElementById("cbPaisUnidadReporta");
        var y = document.getElementById("cbPaisUnidadAfectado");
        x.innerHTML = "";
        y.innerHTML = "";
        var optionx = document.createElement("option");
        optionx.text = "...";
        optionx.value = null;
        x.add(optionx);
        var optiony = document.createElement("option");
        optiony.text = "...";
        optiony.value = null;
        y.add(optiony);

        $.ajax({
            url: _spPageContextInfo.webAbsoluteUrl + "/_api/web/lists/getbytitle('LstUbicacionPais')/Items?$select=Title,NombrePais&$top=1000",
            type: "GET",
            async: false,
            headers: { "accept": "application/json;odata=verbose" },
            success: function (data) {
                if (data.d.results.length > 0) {
                    for (i = 0; i < data.d.results.length; i++) {
                        optionx = document.createElement("option");
                        optionx.text = data.d.results[i].NombrePais;
                        optionx.value = data.d.results[i].Title;
                        x.add(optionx);

                        optiony = document.createElement("option");
                        optiony.text = data.d.results[i].NombrePais;
                        optiony.value = data.d.results[i].Title;
                        y.add(optiony);
                    }
                }
            },
            error: function (xhr) {
                console.log(xhr.status + ': ' + xhr.statusText);
            }
        });

        $.ajax({
            url: _spPageContextInfo.webAbsoluteUrl + "/_api/web/lists/getbytitle('LstUsuarioPais')/Items?$select=Title,ClavePais&$filter=Title eq '" + encodeURIComponent(usuario) + "'&$top=1000",
            type: "GET",
            async: false,
            headers: { "accept": "application/json;odata=verbose" },
            success: function (data) {
                if (data.d.results.length > 0) {
                    $("#cbPaisUnidadReporta").val(data.d.results[0].ClavePais);
                    $("#cbPaisUnidadAfectado").val(data.d.results[0].ClavePais);
                }
            },
            error: function (xhr) {
                console.log(xhr.status + ': ' + xhr.statusText);
            }
        });

    }

    function UbicacionTerritorioUnidadAfectada(paisClave) {
        var x = document.getElementById("cbTerritorioUnidadAfectado");
        x.innerHTML = "";
        var optionx = document.createElement("option");
        optionx.text = "...";
        optionx.value = null;
        x.add(optionx);

        var y = document.getElementById("cbZonaUnidadAfectada");
        y.innerHTML = "";
        var optiony = document.createElement("option");
        optiony.text = "...";
        optiony.value = null;
        y.add(optiony);

        y = document.getElementById("cbEstadoUnidadAfectado");
        y.innerHTML = "";
        optiony = document.createElement("option");
        optiony.text = "...";
        optiony.value = null;
        y.add(optiony);

        y = document.getElementById("cbMunicipioUnidadAfectado");
        y.innerHTML = "";
        optiony = document.createElement("option");
        optiony.text = "...";
        optiony.value = null;
        y.add(optiony);

        y = document.getElementById("cbUnidadOperativaUnidadAfectada");
        y.innerHTML = "";
        optiony = document.createElement("option");
        optiony.text = "...";
        optiony.value = null;
        y.add(optiony);

        y = document.getElementById("cbGerenciaEstatal");
        y.innerHTML = "";
        optiony = document.createElement("option");
        optiony.text = "...";
        optiony.value = null;
        y.add(optiony);

        $.ajax({
            url: _spPageContextInfo.webAbsoluteUrl + "/_api/web/lists/getbytitle('LstUbicacionTerritorio')/Items?$select=Title,ClavePais,NombreTerritorio&$filter=ClavePais eq '" + encodeURIComponent(paisClave.value) + "'&$top=1000",
            type: "GET",
            async: false,
            headers: { "accept": "application/json;odata=verbose" },
            success: function (data) {
                if (data.d.results.length > 0) {
                    for (i = 0; i < data.d.results.length; i++) {
                        optionx = document.createElement("option");
                        optionx.text = data.d.results[i].NombreTerritorio;
                        optionx.value = data.d.results[i].Title;
                        x.add(optionx);
                    }
                }
            },
            error: function (xhr) {
                console.log(xhr.status + ': ' + xhr.statusText);
            }
        });

        $.ajax({
            url: _spPageContextInfo.webAbsoluteUrl + "/_api/web/lists/getbytitle('LstUsuarioTerritorio')/Items?$select=Title,ClavePais,ClaveTerritorio&$filter=ClavePais eq '" + encodeURIComponent(paisClave.value) + "' and Title eq '" + encodeURIComponent(usuario) + "'&$top=1000",
            type: "GET",
            async: false,
            headers: { "accept": "application/json;odata=verbose" },
            success: function (data) {
                if (data.d.results.length > 0) {
                    $("#cbTerritorioUnidadAfectado").val(data.d.results[0].ClaveTerritorio);
                }
            },
            error: function (xhr) {
                console.log(xhr.status + ': ' + xhr.statusText);
            }
        });
    }

    function UbicacionZonaUnidadAfectada(territorioClave) {

        var x = document.getElementById("cbZonaUnidadAfectada");
        x.innerHTML = "";
        var optionx = document.createElement("option");
        optionx.text = "...";
        optionx.value = null;
        x.add(optionx);

        var y = document.getElementById("cbEstadoUnidadAfectado");
        y.innerHTML = "";
        var optiony = document.createElement("option");
        optiony.text = "...";
        optiony.value = null;
        y.add(optiony);

        y = document.getElementById("cbMunicipioUnidadAfectado");
        y.innerHTML = "";
        optiony = document.createElement("option");
        optiony.text = "...";
        optiony.value = null;
        y.add(optiony);

        y = document.getElementById("cbUnidadOperativaUnidadAfectada");
        y.innerHTML = "";
        optiony = document.createElement("option");
        optiony.text = "...";
        optiony.value = null;
        y.add(optiony);

        y = document.getElementById("cbGerenciaEstatal");
        y.innerHTML = "";
        optiony = document.createElement("option");
        optiony.text = "...";
        optiony.value = null;
        y.add(optiony);

        paisClave = document.getElementById("cbPaisUnidadAfectado").value;

        $.ajax({
            url: _spPageContextInfo.webAbsoluteUrl + "/_api/web/lists/getbytitle('LstUbicacionZona')/Items?$select=Title,ClavePais,ClaveTerritorio,NombreZona&$filter=ClavePais eq '" + encodeURIComponent(paisClave) + "' and ClaveTerritorio eq '" + encodeURIComponent(territorioClave.value) + "'&$top=1000",
            type: "GET",
            async: false,
            headers: { "accept": "application/json;odata=verbose" },
            success: function (data) {
                if (data.d.results.length > 0) {
                    for (i = 0; i < data.d.results.length; i++) {
                        optionx = document.createElement("option");
                        optionx.text = data.d.results[i].NombreZona;
                        optionx.value = data.d.results[i].Title;
                        x.add(optionx);
                    }
                }
            },
            error: function (xhr) {
                console.log(xhr.status + ': ' + xhr.statusText);
            }
        });

        $.ajax({
            url: _spPageContextInfo.webAbsoluteUrl + "/_api/web/lists/getbytitle('LstUsuarioZona')/Items?$select=Title,ClavePais,ClaveTerritorio,ClaveZona&$filter=ClavePais eq '" + encodeURIComponent(paisClave) + "' and ClaveTerritorio eq '" + encodeURIComponent(territorioClave.value) + "' and Title eq '" + encodeURIComponent(usuario) + "'&$top=1000",
            type: "GET",
            async: false,
            headers: { "accept": "application/json;odata=verbose" },
            success: function (data) {
                if (data.d.results.length > 0) {
                    $("#cbZonaUnidadAfectada").val(data.d.results[0].ClaveZona);
                }
            },
            error: function (xhr) {
                console.log(xhr.status + ': ' + xhr.statusText);
            }
        });
    }

    function UbicacionEstadoUnidadAfectada(zonaClave) {
        var x = document.getElementById("cbEstadoUnidadAfectado");
        x.innerHTML = "";
        var optionx = document.createElement("option");
        optionx.text = "...";
        optionx.value = null;
        x.add(optionx);

        var y = document.getElementById("cbMunicipioUnidadAfectado");
        y.innerHTML = "";
        var optiony = document.createElement("option");
        optiony.text = "...";
        optiony.value = null;
        y.add(optiony);

        y = document.getElementById("cbUnidadOperativaUnidadAfectada");
        y.innerHTML = "";
        optiony = document.createElement("option");
        optiony.text = "...";
        optiony.value = null;
        y.add(optiony);

        y = document.getElementById("cbGerenciaEstatal");
        y.innerHTML = "";
        optiony = document.createElement("option");
        optiony.text = "...";
        optiony.value = null;
        y.add(optiony);

        paisClave = document.getElementById("cbPaisUnidadAfectado").value;
        territorioClave = document.getElementById("cbTerritorioUnidadAfectado").value;

        $.ajax({
            url: _spPageContextInfo.webAbsoluteUrl + "/_api/web/lists/getbytitle('LstUbicacionEstado')/Items?$select=Title,ClavePais,ClaveTerritorio,ClaveZona,NombreEstado&$filter=ClavePais eq '" + encodeURIComponent(paisClave) + "' and ClaveTerritorio eq '" + encodeURIComponent(territorioClave) + "' and ClaveZona eq '" + encodeURIComponent(zonaClave.value) + "'&$top=1000",
            type: "GET",
            async: false,
            headers: { "accept": "application/json;odata=verbose" },
            success: function (data) {
                if (data.d.results.length > 0) {
                    for (i = 0; i < data.d.results.length; i++) {
                        optionx = document.createElement("option");
                        optionx.text = data.d.results[i].NombreEstado;
                        optionx.value = data.d.results[i].Title;
                        x.add(optionx);
                    }
                }
            },
            error: function (xhr) {
                console.log(xhr.status + ': ' + xhr.statusText);
            }
        });

        $.ajax({
            url: _spPageContextInfo.webAbsoluteUrl + "/_api/web/lists/getbytitle('LstUsuarioEstado')/Items?$select=Title,ClavePais,ClaveTerritorio,ClaveZona,ClaveEstado&$filter=ClavePais eq '" + encodeURIComponent(paisClave) + "' and ClaveTerritorio eq '" + encodeURIComponent(territorioClave) + "' and ClaveZona eq '" + encodeURIComponent(zonaClave.value) + "' and Title eq '" + encodeURIComponent(usuario) + "'&$top=1000",
            type: "GET",
            async: false,
            headers: { "accept": "application/json;odata=verbose" },
            success: function (data) {
                if (data.d.results.length > 0) {
                    $("#cbEstadoUnidadAfectado").val(data.d.results[0].ClaveEstado);
                }
            },
            error: function (xhr) {
                console.log(xhr.status + ': ' + xhr.statusText);
            }
        });
    }

    function UbicacionMunicipioUnidadAfectada(estadoClave) {
        var x = document.getElementById("cbMunicipioUnidadAfectado");
        x.innerHTML = "";
        var optionx = document.createElement("option");
        optionx.text = "...";
        optionx.value = null;
        x.add(optionx);

        var y = document.getElementById("cbUnidadOperativaUnidadAfectada");
        y.innerHTML = "";
        var optiony = document.createElement("option");
        optiony.text = "...";
        optiony.value = null;
        y.add(optiony);

        y = document.getElementById("cbGerenciaEstatal");
        y.innerHTML = "";
        optiony = document.createElement("option");
        optiony.text = "...";
        optiony.value = null;
        y.add(optiony);

        paisClave = document.getElementById("cbPaisUnidadAfectado").value;
        territorioClave = document.getElementById("cbTerritorioUnidadAfectado").value;
        zonaClave = document.getElementById("cbZonaUnidadAfectada").value;

        $.ajax({
            url: _spPageContextInfo.webAbsoluteUrl + "/_api/web/lists/getbytitle('LstUbicacionMunicipio')/Items?$select=Title,ClavePais,ClaveTerritorio,ClaveZona,ClaveEstado,NombreMunicipio&$filter=ClavePais eq '" + encodeURIComponent(paisClave) + "' and ClaveTerritorio eq '" + encodeURIComponent(territorioClave) + "' and ClaveZona eq '" + encodeURIComponent(zonaClave) + "' and ClaveEstado eq '" + encodeURIComponent(estadoClave.value) + "'&$top=1000",
            type: "GET",
            async: false,
            headers: { "accept": "application/json;odata=verbose" },
            success: function (data) {
                if (data.d.results.length > 0) {
                    for (i = 0; i < data.d.results.length; i++) {
                        optionx = document.createElement("option");
                        optionx.text = data.d.results[i].NombreMunicipio;
                        optionx.value = data.d.results[i].Title;
                        x.add(optionx);
                    }
                }
            },
            error: function (xhr) {
                console.log(xhr.status + ': ' + xhr.statusText);
            }
        });

        $.ajax({
            url: _spPageContextInfo.webAbsoluteUrl + "/_api/web/lists/getbytitle('LstUsuarioMunicipio')/Items?$select=Title,ClavePais,ClaveTerritorio,ClaveEstado,ClaveZona,ClaveMunicipio&$filter=ClavePais eq '" + encodeURIComponent(paisClave) + "' and ClaveTerritorio eq '" + encodeURIComponent(territorioClave) + "' and ClaveZona eq '" + encodeURIComponent(zonaClave) + "' and ClaveEstado eq '" + encodeURIComponent(estadoClave.value) + "' and Title eq '" + encodeURIComponent(usuario) + "'&$top=1000",
            type: "GET",
            async: false,
            headers: { "accept": "application/json;odata=verbose" },
            success: function (data) {
                if (data.d.results.length > 0) {
                    $("#cbMunicipioUnidadAfectado").val(data.d.results[0].ClaveMunicipio);
                }
            },
            error: function (xhr) {
                console.log(xhr.status + ': ' + xhr.statusText);
            }
        });
    }

    function UbicacionUnidadOperativaUnidadAfectada(municipioClave) {
        var x = document.getElementById("cbUnidadOperativaUnidadAfectada");
        x.innerHTML = "";
        var optionx = document.createElement("option");
        optionx.text = "...";
        optionx.value = null;
        x.add(optionx);

        var z = document.getElementById("cbGerenciaEstatal");
        z.innerHTML = "";
        optionz = document.createElement("option");
        optionz.text = "...";
        optionz.value = null;
        z.add(optionz);

        paisClave = document.getElementById("cbPaisUnidadAfectado").value;
        territorioClave = document.getElementById("cbTerritorioUnidadAfectado").value;
        zonaClave = document.getElementById("cbZonaUnidadAfectada").value;
        estadoClave = document.getElementById("cbEstadoUnidadAfectado").value;

        $.ajax({
            url: _spPageContextInfo.webAbsoluteUrl + "/_api/web/lists/getbytitle('LstUbicacionUnidadOperativa')/Items?$select=ClavePais,ClaveTerritorio,ClaveZona,ClaveEstado,ClaveMunicipio,Title,NombreUnidadOperativa,UnidadGeneraReporteUnidadOperati,TipoUnidadUnidadOperativa,GerenciaEstatalUnidadOperativa&$filter=ClavePais eq '" + encodeURIComponent(paisClave) + "' and ClaveTerritorio eq '" + encodeURIComponent(territorioClave) + "' and ClaveZona eq '" + encodeURIComponent(zonaClave) + "' and ClaveEstado eq '" + encodeURIComponent(estadoClave) + "' and ClaveMunicipio eq '" + encodeURIComponent(municipioClave.value) + "'&$top=1000",
            type: "GET",
            async: false,
            headers: { "accept": "application/json;odata=verbose" },
            success: function (data) {
                if (data.d.results.length > 0) {
                    for (i = 0; i < data.d.results.length; i++) {
                        optionx = document.createElement("option");
                        optionx.text = data.d.results[i].NombreUnidadOperativa;
                        optionx.value = data.d.results[i].Title;
                        x.add(optionx);
                    }
                }
            },
            error: function (xhr) {
                console.log(xhr.status + ': ' + xhr.statusText);
            }
        });

        $.ajax({
            url: _spPageContextInfo.webAbsoluteUrl + "/_api/web/lists/getbytitle('LstUsuarioUnidadOperativa')/Items?$select=ClaveUnidadOperativa&$filter=Title eq '" + encodeURIComponent(usuario) + "' and ClavePais eq '" + encodeURIComponent(paisClave) + "' and ClaveTerritorio eq '" + encodeURIComponent(territorioClave) + "' and ClaveZona eq '" + encodeURIComponent(zonaClave) + "' and ClaveEstado eq '" + encodeURIComponent(estadoClave) + "' and ClaveMunicipio eq '" + encodeURIComponent(municipioClave.value) + "'&$top=100",
            type: "GET",
            async: false,
            headers: { "accept": "application/json;odata=verbose" },
            success: function (data) {
                if (data.d.results.length > 0) {
                    $("#cbUnidadOperativaUnidadAfectada").val(data.d.results[0].ClaveUnidadOperativa);
                }
            },
            error: function (xhr) {
                console.log(xhr.status + ': ' + xhr.statusText);
            }
        });
    }

    function UbicacionResponsableEjecutivoUnidadAfectada(unidadOperativaClave) {
        var x = document.getElementById("cbGerenciaEstatal");
        x.innerHTML = "";
        optionx = document.createElement("option");
        optionx.text = "...";
        optionx.value = null;
        x.add(optionx);

        paisClave = document.getElementById("cbPaisUnidadAfectado").value;
        territorioClave = document.getElementById("cbTerritorioUnidadAfectado").value;
        zonaClave = document.getElementById("cbZonaUnidadAfectada").value;
        estadoClave = document.getElementById("cbEstadoUnidadAfectado").value;
        municipioClave = document.getElementById("cbMunicipioUnidadAfectado").value;

        $.ajax({
            url: _spPageContextInfo.webAbsoluteUrl + "/_api/web/lists/getbytitle('LstUbicacionUnidadOperativa')/Items?$select=Title,GerenciaEstatalUnidadOperativa&$filter=ClavePais eq '" + encodeURIComponent(paisClave) + "' and ClaveTerritorio eq '" + encodeURIComponent(territorioClave) + "' and ClaveZona eq '" + encodeURIComponent(zonaClave) + "' and ClaveEstado eq '" + encodeURIComponent(estadoClave) + "' and ClaveMunicipio eq '" + encodeURIComponent(municipioClave) + "' and Title eq '" + encodeURIComponent(unidadOperativaClave.value) + "'&$top=100",
            type: "GET",
            async: false,
            headers: { "accept": "application/json;odata=verbose" },
            success: function (data) {
                if (data.d.results.length > 0) {
                    for (i = 0; i < data.d.results.length; i++) {
                        optionx = document.createElement("option");
                        optionx.text = data.d.results[i].GerenciaEstatalUnidadOperativa;
                        optionx.value = data.d.results[i].Title;
                        x.add(optionx);
                    }
                    $("#cbGerenciaEstatal").val(unidadOperativaClave.value);
                }
            },
            error: function (xhr) {
                console.log(xhr.status + ': ' + xhr.statusText);
            }
        });
    }

    function UbicacionEstadoUnidadReporta(paisClave) {
        var x = document.getElementById("cbEstadoUnidadReporta");
        x.innerHTML = "";
        var optionx = document.createElement("option");
        optionx.text = "...";
        optionx.value = null;
        x.add(optionx);

        var y = document.getElementById("cbMunicipioUnidadReporta");
        y.innerHTML = "";
        var optiony = document.createElement("option");
        optiony.text = "...";
        optiony.value = null;
        y.add(optiony);

        y = document.getElementById("cbUnidadOperativaReporta");
        y.innerHTML = "";
        optiony = document.createElement("option");
        optiony.text = "...";
        optiony.value = null;
        y.add(optiony);

        y = document.getElementById("cbTipoUnidadOperativaReporta");
        y.innerHTML = "";
        optiony = document.createElement("option");
        optiony.text = "...";
        optiony.value = null;
        y.add(optiony);

        $.ajax({
            url: _spPageContextInfo.webAbsoluteUrl + "/_api/web/lists/getbytitle('LstUbicacionEstado')/Items?$select=Title,NombreEstado,ClavePais,ClaveTerritorio,ClaveZona&$filter=ClavePais eq '" + encodeURIComponent(paisClave.value) + "'&$top=100",
            type: "GET",
            async: false,
            headers: { "accept": "application/json;odata=verbose" },
            success: function (data) {
                if (data.d.results.length > 0) {
                    unicos = [];
                    for (i = 0; i < data.d.results.length; i++) {
                        unicos.push([data.d.results[i].Title, data.d.results[i].NombreEstado]);
                    }
                    listaUnicos = RegistrosUnicos(unicos);
                    for (j = 0; j < listaUnicos.length; j++) {
                        optionx = document.createElement("option");
                        optionx.text = listaUnicos[j][1];
                        optionx.value = listaUnicos[j][0];
                        x.add(optionx);
                    }
                }
            },
            error: function (xhr) {
                console.log(xhr.status + ': ' + xhr.statusText);
            }
        });

        $.ajax({
            url: _spPageContextInfo.webAbsoluteUrl + "/_api/web/lists/getbytitle('LstUsuarioEstado')/Items?$select=Title,ClavePais,ClaveTerritorio,ClaveZona,ClaveEstado&$filter=ClavePais eq '" + encodeURIComponent(paisClave.value) + "' and Title eq '" + encodeURIComponent(usuario) + "'&$top=100",
            type: "GET",
            async: false,
            headers: { "accept": "application/json;odata=verbose" },
            success: function (data) {
                if (data.d.results.length > 0) {
                    $("#cbEstadoUnidadReporta").val(data.d.results[0].ClaveEstado);
                }
            },
            error: function (xhr) {
                console.log(xhr.status + ': ' + xhr.statusText);
            }
        });
    }

    function UbicacionMunicipioUnidadReporta(estadoClave) {
        var x = document.getElementById("cbMunicipioUnidadReporta");
        x.innerHTML = "";
        var optionx = document.createElement("option");
        optionx.text = "...";
        optionx.value = null;
        x.add(optionx);

        var y = document.getElementById("cbUnidadOperativaReporta");
        y.innerHTML = "";
        var optiony = document.createElement("option");
        optiony.text = "...";
        optiony.value = null;
        y.add(optiony);

        y = document.getElementById("cbTipoUnidadOperativaReporta");
        y.innerHTML = "";
        optiony = document.createElement("option");
        optiony.text = "...";
        optiony.value = null;
        y.add(optiony);

        paisClave = document.getElementById("cbPaisUnidadReporta").value;

        $.ajax({
            url: _spPageContextInfo.webAbsoluteUrl + "/_api/web/lists/getbytitle('LstUbicacionMunicipio')/Items?$select=Title,ClavePais,ClaveTerritorio,ClaveZona,ClaveEstado,NombreMunicipio&$filter=ClavePais eq '" + encodeURIComponent(paisClave) + "' and ClaveEstado eq '" + encodeURIComponent(estadoClave.value) + "'&$top=100",
            type: "GET",
            async: false,
            headers: { "accept": "application/json;odata=verbose" },
            success: function (data) {
                if (data.d.results.length > 0) {
                    unicos = [];
                    for (i = 0; i < data.d.results.length; i++) {
                        unicos.push([data.d.results[i].Title, data.d.results[i].NombreMunicipio]);
                    }
                    listaUnicos = RegistrosUnicos(unicos);
                    for (j = 0; j < listaUnicos.length; j++) {
                        optionx = document.createElement("option");
                        optionx.text = listaUnicos[j][1];
                        optionx.value = listaUnicos[j][0];
                        x.add(optionx);
                    }
                }
            },
            error: function (xhr) {
                console.log(xhr.status + ': ' + xhr.statusText);
            }
        });

        $.ajax({
            url: _spPageContextInfo.webAbsoluteUrl + "/_api/web/lists/getbytitle('LstUsuarioMunicipio')/Items?$select=Title,ClavePais,ClaveEstado,ClaveMunicipio&$filter=Title eq '" + encodeURIComponent(usuario) + "' and ClavePais eq '" + encodeURIComponent(paisClave) + "' and ClaveEstado eq '" + encodeURIComponent(estadoClave.value) + "'&$top=100",
            type: "GET",
            async: false,
            headers: { "accept": "application/json;odata=verbose" },
            success: function (data) {
                if (data.d.results.length > 0) {
                    $("#cbMunicipioUnidadReporta").val(data.d.results[0].ClaveMunicipio);
                }
            },
            error: function (xhr) {
                console.log(xhr.status + ': ' + xhr.statusText);
            }
        });
    }

    function UbicacionUnidadOperativaUnidadReporta(municipioClave) {
        var x = document.getElementById("cbUnidadOperativaReporta");
        x.innerHTML = "";
        var optionx = document.createElement("option");
        optionx.text = "...";
        optionx.value = null;
        x.add(optionx);

        var y = document.getElementById("cbTipoUnidadOperativaReporta");
        y.innerHTML = "";
        var optiony = document.createElement("option");
        optiony.text = "...";
        optiony.value = null;
        y.add(optiony);

        paisClave = document.getElementById("cbPaisUnidadReporta").value;
        estadoClave = document.getElementById("cbEstadoUnidadReporta").value;

        $.ajax({
            url: _spPageContextInfo.webAbsoluteUrl + "/_api/web/lists/getbytitle('LstUbicacionUnidadOperativa')/Items?$select=ClavePais,ClaveEstado,ClaveMunicipio,Title,UnidadGeneraReporteUnidadOperati&$filter=ClavePais eq '" + encodeURIComponent(paisClave) + "' and ClaveEstado eq '" + encodeURIComponent(estadoClave) + "' and ClaveMunicipio eq '" + encodeURIComponent(municipioClave.value) + "'&$top=100",
            type: "GET",
            async: false,
            headers: { "accept": "application/json;odata=verbose" },
            success: function (data) {
                if (data.d.results.length > 0) {
                    unicos = [];
                    for (i = 0; i < data.d.results.length; i++) {
                        unicos.push([data.d.results[i].Title, data.d.results[i].UnidadGeneraReporteUnidadOperati]);
                    }
                    listaUnicos = RegistrosUnicos(unicos);
                    for (j = 0; j < listaUnicos.length; j++) {
                        optionx = document.createElement("option");
                        optionx.text = listaUnicos[j][1];
                        optionx.value = listaUnicos[j][0];
                        x.add(optionx);
                    }
                }
            },
            error: function (xhr) {
                console.log(xhr.status + ': ' + xhr.statusText);
            }
        });

        $.ajax({
            url: _spPageContextInfo.webAbsoluteUrl + "/_api/web/lists/getbytitle('LstUsuarioUnidadOperativa')/Items?$select=ClaveUnidadOperativa&$filter=Title eq '" + encodeURIComponent(usuario) + "' and ClavePais eq '" + encodeURIComponent(paisClave) + "' and ClaveEstado eq '" + encodeURIComponent(estadoClave) + "' and ClaveMunicipio eq '" + encodeURIComponent(municipioClave.value) + "'&$top=100",
            type: "GET",
            async: false,
            headers: { "accept": "application/json;odata=verbose" },
            success: function (data) {
                if (data.d.results.length > 0) {
                    $("#cbUnidadOperativaReporta").val(data.d.results[0].ClaveUnidadOperativa);
                }
            },
            error: function (xhr) {
                console.log(xhr.status + ': ' + xhr.statusText);
            }
        });
    }

    function UbicacionTipoUnidadOperativaUnidadReporta(unidadOperativaClave) {
        var x = document.getElementById("cbTipoUnidadOperativaReporta");
        x.innerHTML = "";
        var optionx = document.createElement("option");
        optionx.text = "...";
        optionx.value = null;
        x.add(optionx);

        paisClave = document.getElementById("cbPaisUnidadReporta").value;
        estadoClave = document.getElementById("cbEstadoUnidadReporta").value;
        municipioClave = document.getElementById("cbMunicipioUnidadReporta").value;

        $.ajax({
            url: _spPageContextInfo.webAbsoluteUrl + "/_api/web/lists/getbytitle('LstUbicacionUnidadOperativa')/Items?$select=Title,TipoUnidadUnidadOperativa,NombreUnidadOperativa&$filter=ClavePais eq '" + encodeURIComponent(paisClave) + "' and ClaveEstado eq '" + encodeURIComponent(estadoClave) + "' and ClaveMunicipio eq '" + encodeURIComponent(municipioClave) + "' and Title eq '" + encodeURIComponent(unidadOperativaClave.value) + "'&$top=100",
            type: "GET",
            async: false,
            headers: { "accept": "application/json;odata=verbose" },
            success: function (data) {
                if (data.d.results.length > 0) {
                    unicos = [];
                    for (i = 0; i < data.d.results.length; i++) {
                        unicos.push([data.d.results[i].Title, data.d.results[i].TipoUnidadUnidadOperativa]);
                    }
                    listaUnicos = RegistrosUnicos(unicos);
                    for (j = 0; j < listaUnicos.length; j++) {
                        optionx = document.createElement("option");
                        optionx.text = listaUnicos[j][1];
                        optionx.value = listaUnicos[j][0];
                        x.add(optionx);
                    }
                    $("#cbTipoUnidadOperativaReporta").val(unidadOperativaClave.value);
                }
            },
            error: function (xhr) {
                console.log(xhr.status + ': ' + xhr.statusText);
            }
        });
    }

    function createList(nombreLista) {
        var clientContext = new SP.ClientContext("https://cocacolafemsa.sharepoint.com/sites/SWPP/");
        var oWebsite = clientContext.get_web();

        var listCreationInfo = new SP.ListCreationInformation();
        var olist = nombreLista;
        listCreationInfo.set_title(olist);
        listCreationInfo.set_templateType(SP.ListTemplateType.genericList);

        this.oList = oWebsite.get_lists().add(listCreationInfo);

        clientContext.load(oList);
        clientContext.executeQueryAsync(
            Function.createDelegate(this, this.onQuerySucceeded),
            Function.createDelegate(this, this.onQueryFailed)
        );
    }

    function onQuerySucceeded() {
        var result = oList.get_title() + ' created.';
        console.log(result);
    }

    function onQueryFailed(sender, args) {
        console.log('Request failed. ' + args.get_message() + '\n' + args.get_stackTrace());
    }

    function createColumn(listTitle, fieldTitle, type, options) {
        var clientContext = new SP.ClientContext(_spPageContextInfo.webServerRelativeUrl);
        var myList = clientContext.get_web().get_lists().getByTitle(listTitle);
        var newField = myList.get_fields().addFieldAsXml("<Field DisplayName=\'" + fieldTitle + "\' Type=\'" + type + "\' " + options + " />", true, SP.AddFieldOptions.defaultValue);
        newField.update();
        clientContext.executeQueryAsync(function () {
            console.log("Field <" + fieldTitle + "> created!");
        }, function (sender, args) {
            console.log("Error:\n" + args.get_message());
        });
    }

    function sleep(milliseconds) {
        var start = new Date().getTime();
        for (var i = 0; i < 1e7; i++) {
            if ((new Date().getTime() - start) > milliseconds) {
                break;
            }
        }
    }

    function crear(nombreLista) {
        createList(nombreLista);
        sleep(10000);
        createColumn(nombreLista, 'Anio', 'DateTime', '');
        sleep(10000);
    }

    function ObtenerValoresGuardar() {
        var listaReportes = [];
        var reportesList = document.getElementsByClassName("BloqueReportesDinamicos");
        for (i = 0; i < reportesList.length; i++) {
            var listaReporteConfiguracion = [];
            valoresreporte = reportesList[i].id.split("_");
            for (l = 1; l < valoresreporte.length; l++) {
                listaReporteConfiguracion.push(valoresreporte[l]);
            }
            var listaGuardar = [];
            var variablesList = [];
            var contenedoresList = reportesList[i].getElementsByClassName("container");
            for (j = 0; j < contenedoresList.length; j++) {
                var gruposList = contenedoresList[j].getElementsByClassName("form-group");
                for (k = 0; k < gruposList.length; k++) {
                    variablesList.push(gruposList[k]);
                }
            }
            for (l = 0; l < variablesList.length; l++) {
                elementinput = variablesList[l].getElementsByTagName("input")[0];
                elementselect = variablesList[l].getElementsByTagName("select")[0];
                elementdiv = variablesList[l].getElementsByTagName("div")[0];
                elementtextarea = variablesList[l].getElementsByTagName("textarea")[0];

                if (elementdiv === undefined || elementdiv === null) {
                    if (elementinput !== undefined && elementinput !== null) {
                        if (elementinput.type === "text") {
                            if (elementinput.id === "") {
                                listaGuardar.push(["AreaPersonasInvolucradas", elementinput.value, "text"])
                            } else if (elementinput.id.length < 3) {
                                listaGuardar.push(["AreaPersonasInvolucradas" + elementinput.id, elementinput.value, "text"])
                            } else {
                                listaGuardar.push([elementinput.id, elementinput.value, "text"]);
                            }
                        } else if (elementinput.type === "checkbox") {
                            listaGuardar.push([elementinput.id, elementinput.checked, "checkbox"]);
                        } else if (elementinput.type === "number") {
                            listaGuardar.push([elementinput.id, elementinput.value, "text"]);
                        }
                        else {
                            console.log("no se puede leer el valor");
                        }
                    } else if (elementselect !== undefined && elementselect !== null) {
                        listaGuardar.push([elementselect.id, elementselect.value, "select"]);
                    } else if (elementtextarea !== undefined && elementtextarea !== null) {
                        listaGuardar.push([elementtextarea.id, elementtextarea.value, "textarea"]);
                    } else {
                        console.log("no se puede leer el valor");
                    }
                } else {
                    listaGuardar.push([elementdiv.id, elementdiv.children[0].value, "datetime"]);
                }
            }
            listaReportes.push([i, listaGuardar, listaReporteConfiguracion]);
        }
        return listaReportes;
    }

    function ObtenerValoresGuardarTieneConocimiento() {
        var listaGuardado = [];
        var listaConocimiento = document.getElementsByClassName("DuplicacionTieneConocimiento");
        for (i = 1; i < listaConocimiento.length; i++) {
            listaContenedorConocimiento = listaConocimiento[i].getElementsByClassName("form-group");
            listaBloque = [];
            for (j = 0; j < listaContenedorConocimiento.length; j++) {
                elementinput = listaContenedorConocimiento[j].getElementsByTagName("input")[0];
                elementselect = listaContenedorConocimiento[j].getElementsByTagName("select")[0];
                if (elementinput === undefined || elementinput === null) {
                    listaBloque.push([elementselect.id, elementselect.value]);
                } else {
                    listaBloque.push([elementinput.id, elementinput.value]);
                }
            }
            listaGuardado.push(listaBloque);
        }
        console.log(listaGuardado);
        return listaGuardado;
    }

    function ObtenerValoresGuardarDinamicos(lista) {
        listaBloques = [];
        listaDelincuentes = [];
        listaPersonas = [];
        listaAreas = [];
        listaEquipo = [];
        listaNormales = [];
        listaCliente = [];
        for (i = 0; i < lista.length; i++) {
            if (lista[i][0].includes("NombrePersonasInvolucradas")) {
                listaPersonas.push(lista[i]);
            }
            else if (lista[i][0].includes("AreaPersonasInvolucradas") || lista[i][0] === "") {
                listaPersonas.push(lista[i]);
            }
            else if (lista[i][0].includes("EmpresaPersonasInvolucradas")) {
                listaPersonas.push(lista[i]);
            }
            else if (lista[i][0].includes("NumeroEmpleadoPersonasInvolucradas")) {
                listaPersonas.push(lista[i]);
            }
            else if (lista[i][0].includes("Ubicacion")) {
                listaAreas.push(lista[i]);
            }
            else if (lista[i][0].includes("Motivo")) {
                listaAreas.push(lista[i]);
            }
            else if (lista[i][0].includes("EquipoNumeroEquipos")) {
                listaEquipo.push(lista[i]);
            }
            else if (lista[i][0].includes("TipoArma")) {
                listaDelincuentes.push(lista[i]);
            }
            else if (lista[i][0].includes("GeneroDelincuente")) {
                listaDelincuentes.push(lista[i]);
            }
            else if (lista[i][0].includes("Edad")) {
                listaDelincuentes.push(lista[i]);
            }
            else if (lista[i][0].includes("Estatura")) {
                listaDelincuentes.push(lista[i]);
            }
            else if (lista[i][0].includes("Complexion")) {
                listaDelincuentes.push(lista[i]);
            }
            else if (lista[i][0].includes("Vestimenta")) {
                listaDelincuentes.push(lista[i]);
            }
            else if (lista[i][0].includes("SeniasParticulares")) {
                listaDelincuentes.push(lista[i]);
            }
            else if (lista[i][0].includes("Cabello")) {
                listaDelincuentes.push(lista[i]);
            }
            else if (lista[i][0].includes("TamanioCabello")) {
                listaDelincuentes.push(lista[i]);
            }
            else if (lista[i][0].includes("ColorCabello")) {
                listaDelincuentes.push(lista[i]);
            }
            else if (lista[i][0].includes("ColorPiel")) {
                listaDelincuentes.push(lista[i]);
            }
            else if (lista[i][0].includes("MasRasgos")) {
                listaDelincuentes.push(lista[i]);
            }
            else if (lista[i][0].includes("Otros")) {
                listaDelincuentes.push(lista[i]);
            }
            else if (lista[i][0].includes("Cliente")) {
                listaCliente.push(lista[i]);
            }
            else if (lista[i][0].includes("HorarioPresentoConCliente")) {
                listaCliente.push(lista[i]);
            }
            else if (lista[i][0].includes("MontoCliente")) {
                listaCliente.push(lista[i]);
            }
            else {
                listaNormales.push(lista[i]);
            }
        }
        listaPersonasBloque = [];
        listaEquipoBloque = [];
        listaAreasBloque = [];
        listaDelincuentesBloque = [];
        listaClienteBloque = [];
        if (listaPersonas.length > 4) {
            if (listaPersonas.length % 4 == 0) {
                if (listaPersonas[3][0].includes("NombrePersonasInvolucradas")) {
                    for (i = 3; i < listaPersonas.length; i += 3) {
                        listaPersonasBloque.push([listaPersonas[i], listaPersonas[i + 1], listaPersonas[i + 2]]);
                    }
                    listaBloques.push(listaPersonasBloque);
                }
                else {
                    for (i = 4; i < listaPersonas.length; i += 4) {
                        listaPersonasBloque.push([listaPersonas[i], listaPersonas[i + 1], listaPersonas[i + 2], listaPersonas[i + 3]]);
                    }
                    listaBloques.push(listaPersonasBloque);
                }
            } else {
                for (i = 3; i < listaPersonas.length; i += 3) {
                    listaPersonasBloque.push([listaPersonas[i], listaPersonas[i + 1], listaPersonas[i + 2]]);
                }
                listaBloques.push(listaPersonasBloque);
            }
        }
        else {
            listaBloques.push([]);
        }
        if (listaEquipo.length > 1) {
            for (i = 1; i < listaEquipo.length; i++) {
                listaEquipoBloque.push([listaEquipo[i]]);
            }
            listaBloques.push(listaEquipoBloque);
        }
        else {
            listaBloques.push([]);
        }
        if (listaAreas.length > 2) {
            for (i = 2; i < listaAreas.length; i += 2) {
                listaAreasBloque.push([listaAreas[i], listaAreas[i + 1]]);
            }
            listaBloques.push(listaAreasBloque);
        }
        else {
            listaBloques.push([]);
        }
        if (listaCliente.length > 3) {
            if (listaCliente.length % 2 == 0) {
                for (i = 2; i < listaCliente.length; i += 2) {
                    listaClienteBloque.push([listaCliente[i], listaCliente[i + 1]]);
                }
                listaBloques.push(listaClienteBloque);
            }
            else {
                for (i = 3; i < listaCliente.length; i += 3) {
                    listaClienteBloque.push([listaCliente[i], listaCliente[i + 1], listaCliente[i + 2]]);
                }
                listaBloques.push(listaClienteBloque);
            }
        } else {
            listaBloques.push([]);
        }
        if (listaDelincuentes.length > 13) {
            for (i = 13; i < listaDelincuentes.length; i += 13) {
                listaDelincuentesBloque.push([listaDelincuentes[i], listaDelincuentes[i + 1], listaDelincuentes[i + 2], listaDelincuentes[i + 3], listaDelincuentes[i + 4], listaDelincuentes[i + 5], listaDelincuentes[i + 6], listaDelincuentes[i + 7], listaDelincuentes[i + 8], listaDelincuentes[i + 9], listaDelincuentes[i + 10], listaDelincuentes[i + 11], listaDelincuentes[i + 12]]);
            }
            listaBloques.push(listaDelincuentesBloque);
        }
        else {
            for (i = 0; i < listaDelincuentes.length; i++) {
                listaNormales.push(listaDelincuentes[i]);
            }
            listaBloques.push([]);
        }
        listaBloques.push(listaNormales);

        return listaBloques;
    }

    function ValidarCamposGuardar(estatus, bandera) {
        //$('#modalGuardado').modal('show');
        CamposGuardar(estatus, bandera);
    }

    function CamposGuardar(estatus, bandera) {
        paisUnidadReporta = document.getElementById("cbPaisUnidadReporta");
        estadoUnidadReporta = document.getElementById("cbEstadoUnidadReporta");
        municipioUnidadReporta = document.getElementById("cbMunicipioUnidadReporta");
        unidadOperativaUnidadReporta = document.getElementById("cbUnidadOperativaReporta");
        tipoUnidadOperativaReporta = document.getElementById("cbTipoUnidadOperativaReporta");
        puestoProteccion = document.getElementById("cbPuestoProteccion");
        creadoPor = document.getElementById("iptCreadoPor");

        var fechaCreacion = new Date();

        usuarioCreacion = document.getElementById("cbUsuarioCreacion");
        paisUnidadAfectada = document.getElementById("cbPaisUnidadAfectado");
        territorioUnidadAfectada = document.getElementById("cbTerritorioUnidadAfectado");
        zonaUnidadAfectada = document.getElementById("cbZonaUnidadAfectada");
        estadoUnidadAfectada = document.getElementById("cbEstadoUnidadAfectado");
        municipioUnidadAfectada = document.getElementById("cbMunicipioUnidadAfectado");
        negocioUnidadAfectada = document.getElementById("cbNegocioAfectado");
        unidadOperativaUnidadAfectada = document.getElementById("cbUnidadOperativaUnidadAfectada");
        gerenciaEstatalUnidadAfectada = document.getElementById("cbGerenciaEstatal");
        importanciaUnidadAfectada = document.getElementById("cbImportancia");
        responsableEjecutivoUnidadAfectada = document.getElementById("cbResponsableEjecutivo");
        var listadestinatarios = getUserInfo();
        var listaCorreos = "";
        for (var icor = 0; icor < listadestinatarios.length; icor++) {
            listaCorreos += listadestinatarios[icor] + ";";
        }
        listaCorreos = listaCorreos.substring(0, (listaCorreos.length - 1));
        listaCamposEstaticos = [];
        seguimiento = document.getElementById("Seguimiento");

        tipoReporte = document.getElementById("cbTipoReporte");
        subnivelUno = document.getElementById("cbSubNivelUno");
        subnivelDos = document.getElementById("cbSubNivelDos");
        subnivelTres = document.getElementById("cbSubNivelTres");
        subnivelCuatro = document.getElementById("cbSubNivelCuatro");
        var i = 0;

        if (paisUnidadReporta.value === "" || paisUnidadReporta.value === null) {
            alert(document.getElementById("lblCamposFaltantes").innerHTML);
            $('#modalGuardado').modal('hide');
            return;
        }
        listaCamposEstaticos.push([paisUnidadReporta.value, "lblFormEstPaisReporta"]);
        if (estadoUnidadReporta.value === "" || estadoUnidadReporta.value === null) {
            alert(document.getElementById("lblCamposFaltantes").innerHTML);
            $('#modalGuardado').modal('hide');
            return;
        }
        listaCamposEstaticos.push([estadoUnidadReporta.value, "lblFormEstEstadoReporta"]);
        if (municipioUnidadReporta.value === "" || municipioUnidadReporta.value === null) {
            alert(document.getElementById("lblCamposFaltantes").innerHTML);
            $('#modalGuardado').modal('hide');
            return;
        }
        listaCamposEstaticos.push([municipioUnidadReporta.value, "lblFormEstMunicipioReporta"]);
        if (unidadOperativaUnidadReporta.value === "" || unidadOperativaUnidadReporta.value === null) {
            alert(document.getElementById("lblCamposFaltantes").innerHTML);
            $('#modalGuardado').modal('hide');
            return;
        }
        listaCamposEstaticos.push([unidadOperativaUnidadReporta.value, "lblFormEstUnidadOperativaReporta"]);
        if (tipoUnidadOperativaReporta.value === "" || tipoUnidadOperativaReporta.value === null) {
            alert(document.getElementById("lblCamposFaltantes").innerHTML);
            $('#modalGuardado').modal('hide');
            return;
        }
        listaCamposEstaticos.push([tipoUnidadOperativaReporta.value, "lblFormEstTipoUnidadOperativaReporta"]);
        if (puestoProteccion.value === "" || puestoProteccion.value === null) {
            alert(document.getElementById("lblCamposFaltantes").innerHTML);
            $('#modalGuardado').modal('hide');
            return;
        }
        listaCamposEstaticos.push([puestoProteccion.value, "lblFormEstPuestoProteccion"]);
        if (creadoPor.value === "" || creadoPor.value === null) {
            alert(document.getElementById("lblCamposFaltantes").innerHTML);
            $('#modalGuardado').modal('hide');
            return;
        }
        listaCamposEstaticos.push([creadoPor.value, "lblFormEstCreadoPor"]);
        if (fechaCreacion.value === "" || fechaCreacion.value === null) {
            alert(document.getElementById("lblCamposFaltantes").innerHTML);
            $('#modalGuardado').modal('hide');
            return;
        }
        listaCamposEstaticos.push([fechaCreacion.value, "lblFormEstFechaCreacion"]);
        if (usuarioCreacion.value === "" || usuarioCreacion.value === null) {
            alert(document.getElementById("lblCamposFaltantes").innerHTML);
            $('#modalGuardado').modal('hide');
            return;
        }
        listaCamposEstaticos.push([usuarioCreacion.value, "lblFormEstUsuarioCreacion"]);
        if (paisUnidadAfectada.value === "" || paisUnidadAfectada.value === null) {
            alert(document.getElementById("lblCamposFaltantes").innerHTML);
            $('#modalGuardado').modal('hide');
            return;
        }
        listaCamposEstaticos.push([paisUnidadAfectada.value, "lblFormEstPaisAfectado"]);
        if (territorioUnidadAfectada.value === "" || territorioUnidadAfectada.value === null) {
            alert(document.getElementById("lblCamposFaltantes").innerHTML);
            $('#modalGuardado').modal('hide');
            return;
        }
        listaCamposEstaticos.push([territorioUnidadAfectada.value, "lblFormEstTerritorioAfectado"]);
        if (zonaUnidadAfectada.value === "" || zonaUnidadAfectada.value === null) {
            alert(document.getElementById("lblCamposFaltantes").innerHTML);
            $('#modalGuardado').modal('hide');
            return;
        }
        listaCamposEstaticos.push([zonaUnidadAfectada.value, "lblFormEstZonaAfectada"]);
        if (estadoUnidadAfectada.value === "" || estadoUnidadAfectada.value === null) {
            alert(document.getElementById("lblCamposFaltantes").innerHTML);
            $('#modalGuardado').modal('hide');
            return;
        }
        listaCamposEstaticos.push([estadoUnidadAfectada.value, "lblFormEstEstadoAfectado"]);
        if (municipioUnidadAfectada.value === "" || municipioUnidadAfectada.value === null) {
            alert(document.getElementById("lblCamposFaltantes").innerHTML);
            $('#modalGuardado').modal('hide');
            return;
        }
        listaCamposEstaticos.push([municipioUnidadAfectada.value, "lblFormEstMunicipioAfectado"]);
        if (negocioUnidadAfectada.value === "" || negocioUnidadAfectada.value === null) {
            alert(document.getElementById("lblCamposFaltantes").innerHTML);
            $('#modalGuardado').modal('hide');
            return;
        }
        listaCamposEstaticos.push([negocioUnidadAfectada.value, "lblFormEstNegocioAfectado"]);
        if (unidadOperativaUnidadAfectada.value === "" || unidadOperativaUnidadAfectada.value === null) {
            alert(document.getElementById("lblCamposFaltantes").innerHTML);
            $('#modalGuardado').modal('hide');
            return;
        }
        listaCamposEstaticos.push([unidadOperativaUnidadAfectada.value, "lblFormEstUnidadOperativaAfectada"]);
        if (gerenciaEstatalUnidadAfectada.value === "" || gerenciaEstatalUnidadAfectada.value === null) {
            alert(document.getElementById("lblCamposFaltantes").innerHTML);
            $('#modalGuardado').modal('hide');
            return;
        }
        listaCamposEstaticos.push([gerenciaEstatalUnidadAfectada.value, "lblFormEstGerenciaEstatal"]);
        if (importanciaUnidadAfectada.value === "" || importanciaUnidadAfectada.value === null) {
            alert(document.getElementById("lblCamposFaltantes").innerHTML);
            $('#modalGuardado').modal('hide');
            return;
        }
        listaCamposEstaticos.push([importanciaUnidadAfectada.value, "lblFormEstImportancia"]);
        if (responsableEjecutivoUnidadAfectada.value === "" || responsableEjecutivoUnidadAfectada.value === null) {
            alert(document.getElementById("lblCamposFaltantes").innerHTML);
            $('#modalGuardado').modal('hide');
            return;
        }
        listaCamposEstaticos.push([responsableEjecutivoUnidadAfectada.value, "lblFormEstResponsableEjecutivo"]);
        if (listaCorreos.value === "" || listaCorreos.value === null) {
            alert(document.getElementById("lblCamposFaltantes").innerHTML);
            $('#modalGuardado').modal('hide');
            return;
        }
        listaCamposEstaticos.push([listaCorreos.value, "lblad"]);

        listaCampos = ObtenerValoresGuardar();
        if (listaCampos.length == 0) {
            alert(document.getElementById("lblCamposFaltantes").innerHTML);
            $('#modalGuardado').modal('hide');
            return;
        }

        banderaGuardado = ValidarCamposObligatorios(listaCampos);
        if (banderaGuardado == true) {
            alert(document.getElementById("lblCamposFaltantes").innerHTML);
            $('#modalGuardado').modal('hide');
            return;
        }

        $("#btnGuardarAbiertoAnalista").prop("disabled", true);
        $("#btnGuardarCerradoAnalista").prop("disabled", true);
        $("#btnGuardarAbiertoCar").prop("disabled", true);
        $("#btnGuardarCerradoCar").prop("disabled", true);

        listaTieneConocimiento = ObtenerValoresGuardarTieneConocimiento();

        folioGenerado = PedirFolioF(pais, 'INC');

        guardarArchivosInc(folioGenerado);

        var clientContext = new SP.ClientContext(urlGuardado);
        console.log(urlGuardado);
        var oList = clientContext.get_web().get_lists().getByTitle('LstNovedadesIncidencias');

        for (i = 0; i < listaCampos.length; i++) {
            var itemCreateInfo = new SP.ListItemCreationInformation();
            oListItem = oList.addItem(itemCreateInfo);
            if (i == 0) {
                oListItem.set_item("TipodeReporte", tipoReporte.value);
                oListItem.set_item("Subnivel1", subnivelUno.value);
                oListItem.set_item("Subnivel2", subnivelDos.value);
                oListItem.set_item("Subnivel3", subnivelTres.value);
                oListItem.set_item("Subnivel4", subnivelCuatro.value);
            } else {
                oListItem.set_item("TipodeReporte", listaCampos[i][2][0]);
                oListItem.set_item("Subnivel1", listaCampos[i][2][1]);
                oListItem.set_item("Subnivel2", listaCampos[i][2][2]);
                oListItem.set_item("Subnivel3", listaCampos[i][2][3]);
                oListItem.set_item("Subnivel4", listaCampos[i][2][4]);
            }
            oListItem.set_item("PaisUR", paisUnidadReporta.value);
            oListItem.set_item("EstadoUR", estadoUnidadReporta.value);
            oListItem.set_item("MunicipioUR", municipioUnidadReporta.value);
            oListItem.set_item("TipoUOUR", tipoUnidadOperativaReporta.value);
            oListItem.set_item("PredioUR", unidadOperativaUnidadReporta.value);
            oListItem.set_item("PuestodeproteccionUR", puestoProteccion.value);
            oListItem.set_item("CreadoporUR", creadoPor.value);
            oListItem.set_item("UsuarioUR", usuarioCreacion.value);
            oListItem.set_item("FechaCreacion", fechaCreacion);
            oListItem.set_item("PaisUA", paisUnidadAfectada.value);
            oListItem.set_item("EstadoUA", estadoUnidadAfectada.value);
            oListItem.set_item("MunicipioUA", municipioUnidadAfectada.value);
            oListItem.set_item("TerritorioUA", territorioUnidadAfectada.value);
            oListItem.set_item("ZonaUA", zonaUnidadAfectada.value);
            oListItem.set_item("NegocioUA", negocioUnidadAfectada.value);
            oListItem.set_item("GerenciaEstatalUA", gerenciaEstatalUnidadAfectada.value);
            oListItem.set_item("ResponsableEjecutivo", responsableEjecutivoUnidadAfectada.value);
            oListItem.set_item("UOUA", unidadOperativaUnidadAfectada.value);
            oListItem.set_item("ImportanciaUA", importanciaUnidadAfectada.value);
            oListItem.set_item("Folio", folioGenerado);
            oListItem.set_item("Title", folioGenerado);
            oListItem.set_item("EstatusRegistro", estatus);
            oListItem.set_item("NumeroReporte", listaCampos[i][0]);
            oListItem.set_item("Correos", listaCorreos);
            listaBloques = ObtenerValoresGuardarDinamicos(listaCampos[i][1]);
            listaEstaticos = listaBloques[5];
            for (z = 0; z < listaEstaticos.length; z++) {
                if (listaEstaticos[z][0] == "ObservacionesInformacionAdicional") {
                    oListItem.set_item("ObservacionesInformacionAdiciona", listaEstaticos[z][1]);
                } else {
                    oListItem.set_item(listaEstaticos[z][0], listaEstaticos[z][1]);
                }
            }
            oListItem.update();
            clientContext.load(oListItem);
        }
        clientContext.executeQueryAsync(Function.createDelegate(this, this.onInsercionExitosa), Function.createDelegate(this, this.onInsercionError));

        var clientContext = new SP.ClientContext(_spPageContextInfo.webAbsoluteUrl);
        var oList = clientContext.get_web().get_lists().getByTitle('LstNovedadesIncidenciasPersonasInvolucradas');

        for (i = 0; i < listaCampos.length; i++) {
            listaBloques = ObtenerValoresGuardarDinamicos(listaCampos[i][1]);
            listaEstaticos = listaBloques[0];
            if (listaEstaticos.length > 0) {
                if (listaEstaticos[0].length == 4) {
                    for (l = 0; l < listaEstaticos.length; l++) {
                        itemCreateInfo = new SP.ListItemCreationInformation();
                        oListItem = oList.addItem(itemCreateInfo);
                        oListItem.set_item("NumeroReporte", i);
                        oListItem.set_item("Title", folioGenerado);
                        oListItem.set_item("NombrePersonaInvolucrada", listaEstaticos[l][0][1]);
                        oListItem.set_item("AreaPersonaInvolucrada", listaEstaticos[l][1][1]);
                        oListItem.set_item("EmpresaPersonaInvolucrada", listaEstaticos[l][2][1]);
                        oListItem.set_item("NumeroEmpleadoPersonaInvolucrada", listaEstaticos[l][3][1]);
                        oListItem.update();
                        clientContext.load(oListItem);
                    }
                } else {
                    for (l = 0; l < listaEstaticos.length; l++) {
                        itemCreateInfo = new SP.ListItemCreationInformation();
                        oListItem = oList.addItem(itemCreateInfo);
                        oListItem.set_item("NumeroReporte", i);
                        oListItem.set_item("Title", folioGenerado);
                        oListItem.set_item("NombrePersonaInvolucrada", listaEstaticos[l][0][1]);
                        oListItem.set_item("AreaPersonaInvolucrada", listaEstaticos[l][1][1]);
                        oListItem.set_item("EmpresaPersonaInvolucrada", listaEstaticos[l][2][1]);
                        oListItem.update();
                        clientContext.load(oListItem);
                    }
                }
            }
        }
        clientContext.executeQueryAsync(Function.createDelegate(this, this.onInsercionExitosa), Function.createDelegate(this, this.onInsercionError));

        var clientContext = new SP.ClientContext(_spPageContextInfo.webAbsoluteUrl);
        var oList = clientContext.get_web().get_lists().getByTitle('LstNovedadesIncidenciasEquipo');

        for (i = 0; i < listaCampos.length; i++) {
            listaBloques = ObtenerValoresGuardarDinamicos(listaCampos[i][1]);
            listaEstaticos = listaBloques[1];
            if (listaEstaticos.length > 0) {
                for (n = 0; n < listaEstaticos.length; n++) {
                    itemCreateInfo = new SP.ListItemCreationInformation();
                    oListItem = oList.addItem(itemCreateInfo);
                    oListItem.set_item("NumeroReporte", i);
                    oListItem.set_item("Title", folioGenerado);
                    oListItem.set_item("Cliente", listaEstaticos[n][0][1]);
                    oListItem.update();
                    clientContext.load(oListItem);
                }
            }
        }
        clientContext.executeQueryAsync(Function.createDelegate(this, this.onInsercionExitosa), Function.createDelegate(this, this.onInsercionError));

        var clientContext = new SP.ClientContext(_spPageContextInfo.webAbsoluteUrl);
        var oList = clientContext.get_web().get_lists().getByTitle('LstNovedadesIncidenciasAreasInvolucradas');
        for (i = 0; i < listaCampos.length; i++) {
            listaBloques = ObtenerValoresGuardarDinamicos(listaCampos[i][1]);
            listaEstaticos = listaBloques[2];
            if (listaEstaticos.length > 0) {
                for (n = 0; n < listaEstaticos.length; n++) {
                    itemCreateInfo = new SP.ListItemCreationInformation();
                    oListItem = oList.addItem(itemCreateInfo);
                    oListItem.set_item("NumeroReporte", i);
                    oListItem.set_item("Title", folioGenerado);
                    oListItem.set_item("UbicacionAreaInvolucrada", listaEstaticos[n][0][1]);
                    oListItem.set_item("NombreAreaInvolucrada", listaEstaticos[n][1][1]);
                    oListItem.update();
                    clientContext.load(oListItem);
                }
            }
        }
        clientContext.executeQueryAsync(Function.createDelegate(this, this.onInsercionExitosa), Function.createDelegate(this, this.onInsercionError));

        var clientContext = new SP.ClientContext(_spPageContextInfo.webAbsoluteUrl);
        var oList = clientContext.get_web().get_lists().getByTitle('LstNovedadesIncidenciasClientesInvolucrados');
        for (i = 0; i < listaCampos.length; i++) {
            listaBloques = ObtenerValoresGuardarDinamicos(listaCampos[i][1]);
            listaEstaticos = listaBloques[3];
            if (listaEstaticos.length > 0) {
                if (listaEstaticos[0].length == 3) {
                    for (n = 0; n < listaEstaticos.length; n++) {
                        itemCreateInfo = new SP.ListItemCreationInformation();
                        oListItem = oList.addItem(itemCreateInfo);
                        oListItem.set_item("NumeroReporte", i);
                        oListItem.set_item("Title", folioGenerado);
                        oListItem.set_item("NombreClienteInvolucrado", listaEstaticos[n][0][1]);
                        oListItem.set_item("HorarioPresentoConCliente", listaEstaticos[n][1][1]);
                        oListItem.set_item("MontoCliente", listaEstaticos[n][2][1]);
                        oListItem.update();
                        clientContext.load(oListItem);
                    }
                } else {
                    for (n = 0; n < listaEstaticos.length; n++) {
                        itemCreateInfo = new SP.ListItemCreationInformation();
                        oListItem = oList.addItem(itemCreateInfo);
                        oListItem.set_item("NumeroReporte", i);
                        oListItem.set_item("Title", folioGenerado);
                        oListItem.set_item("NombreClienteInvolucrado", listaEstaticos[n][0][1]);
                        oListItem.set_item("HorarioPresentoConCliente", listaEstaticos[n][1][1]);
                        oListItem.update();
                        clientContext.load(oListItem);
                    }
                }
            }
        }
        clientContext.executeQueryAsync(Function.createDelegate(this, this.onInsercionExitosa), Function.createDelegate(this, this.onInsercionError));

        var clientContext = new SP.ClientContext(_spPageContextInfo.webAbsoluteUrl);
        var oList = clientContext.get_web().get_lists().getByTitle('LstNovedadesIncidenciasDelincuentesInvolucrados');
        for (i = 0; i < listaCampos.length; i++) {
            listaBloques = ObtenerValoresGuardarDinamicos(listaCampos[i][1]);
            listaEstaticos = listaBloques[4];
            if (listaEstaticos.length > 0) {
                for (n = 0; n < listaEstaticos.length; n++) {
                    if (listaEstaticos[n][12] !== undefined) {
                        itemCreateInfo = new SP.ListItemCreationInformation();
                        oListItem = oList.addItem(itemCreateInfo);
                        oListItem.set_item("NumeroReporte", i);
                        oListItem.set_item("Title", folioGenerado);
                        oListItem.set_item("TipoArmaDelincuenteInvolucrado", listaEstaticos[n][0][1]);
                        oListItem.set_item("GeneroDelincuenteInvolucrado", listaEstaticos[n][1][1]);
                        oListItem.set_item("EdadDelincuenteInvolucrado", listaEstaticos[n][2][1]);
                        oListItem.set_item("EstaturaDelincuenteInvolucrado", listaEstaticos[n][3][1]);
                        oListItem.set_item("ComplexionDelincuenteInvolucrado", listaEstaticos[n][4][1]);
                        oListItem.set_item("VestimentaDelincuenteInvolucrado", listaEstaticos[n][5][1]);
                        oListItem.set_item("SeniasParticularesDelincuenteInv", listaEstaticos[n][6][1]);
                        oListItem.set_item("CabelloDelincuenteInvolucrado", listaEstaticos[n][7][1]);
                        oListItem.set_item("TamanioCabelloDelincuenteInvoluc", listaEstaticos[n][8][1]);
                        oListItem.set_item("ColorCabelloDelincuenteInvolucra", listaEstaticos[n][9][1]);
                        oListItem.set_item("ColorPielDelincuenteInvolucrado", listaEstaticos[n][10][1]);
                        oListItem.set_item("MasRasgosDelincuenteInvolucrado", listaEstaticos[n][11][1]);
                        oListItem.set_item("OtrosDelincuenteInvolucrado", listaEstaticos[n][12][1]);
                        oListItem.update();
                        clientContext.load(oListItem);
                    }
                    else {
                        itemCreateInfo = new SP.ListItemCreationInformation();
                        oListItem = oList.addItem(itemCreateInfo);
                        oListItem.set_item("NumeroReporte", i);
                        oListItem.set_item("Title", folioGenerado);
                        oListItem.set_item("GeneroDelincuenteInvolucrado", listaEstaticos[n][0][1]);
                        oListItem.set_item("EdadDelincuenteInvolucrado", listaEstaticos[n][1][1]);
                        oListItem.set_item("EstaturaDelincuenteInvolucrado", listaEstaticos[n][2][1]);
                        oListItem.set_item("ComplexionDelincuenteInvolucrado", listaEstaticos[n][3][1]);
                        oListItem.set_item("VestimentaDelincuenteInvolucrado", listaEstaticos[n][4][1]);
                        oListItem.set_item("SeniasParticularesDelincuenteInv", listaEstaticos[n][5][1]);
                        oListItem.set_item("CabelloDelincuenteInvolucrado", listaEstaticos[n][6][1]);
                        oListItem.set_item("TamanioCabelloDelincuenteInvoluc", listaEstaticos[n][7][1]);
                        oListItem.set_item("ColorCabelloDelincuenteInvolucra", listaEstaticos[n][8][1]);
                        oListItem.set_item("ColorPielDelincuenteInvolucrado", listaEstaticos[n][9][1]);
                        oListItem.set_item("MasRasgosDelincuenteInvolucrado", listaEstaticos[n][10][1]);
                        oListItem.set_item("OtrosDelincuenteInvolucrado", listaEstaticos[n][11][1]);
                        oListItem.update();
                        clientContext.load(oListItem);
                    }
                }
            }
        }
        clientContext.executeQueryAsync(Function.createDelegate(this, this.onInsercionExitosa), Function.createDelegate(this, this.onInsercionError));

        var clientContext = new SP.ClientContext(_spPageContextInfo.webAbsoluteUrl);
        var oList = clientContext.get_web().get_lists().getByTitle('LstNovedadesIncidenciasTieneConocimiento');
        for (i = 0; i < listaTieneConocimiento.length; i++) {
            itemCreateInfo = new SP.ListItemCreationInformation();
            oListItem = oList.addItem(itemCreateInfo);
            console.log(listaTieneConocimiento[i][0][1]);
            console.log(listaTieneConocimiento[i][1][1]);
            oListItem.set_item("Title", folioGenerado);
            oListItem.set_item("TieneConocimiento", listaTieneConocimiento[i][0][1]);
            oListItem.set_item("Puesto", listaTieneConocimiento[i][1][1]);
            oListItem.update();
            clientContext.load(oListItem);
        }
        clientContext.executeQueryAsync(Function.createDelegate(this, this.onInsercionExitosa), Function.createDelegate(this, this.onInsercionError));

        var remitente = _spPageContextInfo.userLoginName.toString();
        var tablaEnviar = CrearTablaEnvio(folioGenerado, listaCamposEstaticos, listaCampos);
        var asuntoCorreo = document.getElementById("lblAsuntoCorreo").innerHTML;

        sendEmail(remitente, listaCorreos, tablaEnviar.outerHTML, asuntoCorreo);

        var siteRedirect = window.location.protocol + "//" + window.location.host + _spPageContextInfo.webServerRelativeUrl + "/SitePages/Default.aspx";
        window.location = siteRedirect;
    }

    function onInsercionExitosa() {
        console.log("guardo");
        return;
    }

    function onInsercionError(sender, args) {
        console.log(args.get_message() + '\n' + args.get_stackTrace());
    }

    function sendEmail(senderfrom, to, body, subject) {
        var siteurl = _spPageContextInfo.webServerRelativeUrl;
        var urlTemplate = siteurl + "/_api/SP.Utilities.Utility.SendEmail";
        $.ajax({
            async: false,
            contentType: 'application/json',
            url: urlTemplate,
            type: "POST",
            data: JSON.stringify({
                'properties': {
                    '__metadata': {
                        'type': 'SP.Utilities.EmailProperties'
                    },
                    'From': senderfrom,
                    'To': {
                        'results': [to]
                    },
                    'Subject': subject,
                    'Body': body,
                    'AdditionalHeaders':
                    {
                        '__metadata': { 'type': 'Collection(SP.KeyValue)' },
                        'results':
                        [
                            {
                                '__metadata': {
                                    'type': 'SP.KeyValue'
                                },
                                'Key': 'content-type',
                                'Value': 'text/html',
                                'ValueType': 'Edm.String'
                            }
                        ]
                    }

                }
            }),
            headers: {
                "Accept": "application/json;odata=verbose",
                "content-type": "application/json;odata=verbose",
                "X-RequestDigest": jQuery("#__REQUESTDIGEST").val()
            },
            success: function (data) {
                console.log("enviado");
            },
            error: function (err) {
                console.log(err);
            }
        });
    }

    function DuplicarTieneConocimiento() {
        totalelementos = document.getElementsByClassName("DuplicacionTieneConocimiento").length;

        divpadre = document.getElementById("TieneConocimientoDuplicadas");

        divcontenedor = document.createElement("div");
        divcontenedor.setAttribute("class", "container DuplicacionTieneConocimiento");

        var inputeliminar = document.createElement("input");
        inputeliminar.type = "button";
        inputeliminar.setAttribute("onclick", 'EliminarBloqueDuplicacion(this);');
        inputeliminar.value = "X";
        divcontenedor.appendChild(inputeliminar);

        divbloque = document.createElement("div");
        divbloque.setAttribute("class", "col-xs-12 col-lg-12 col-md-12 col-xl-12");

        divcontrol = document.createElement("div");
        divcontrol.setAttribute("class", "col-xs-12 col-md-3 col-lg-3 col-xl-3 form-group");
        inputpersona = document.createElement("input");
        inputpersona.type = "text";
        inputpersona.setAttribute("id", "TieneConocimiento" + totalelementos);
        inputpersona.setAttribute("maxlength", "50");
        inputpersona.setAttribute("class", "form-control");
        divcontrol.appendChild(inputpersona);

        divselect = document.createElement("div");
        divselect.setAttribute("class", "col-xs-12 col-md-3 col-lg-3 col-xl-3 form-group");
        selectpuesto = document.createElement("select");
        selectpuesto.setAttribute("id", "PuestoTieneConocimiento" + totalelementos);
        selectpuesto.setAttribute("class", "form-control");
        selectpadre = document.getElementById("PuestoTieneConocimiento");
        for (k = 0; k < selectpadre.options.length; k++) {
            optionselect = document.createElement("option");
            optionselect.text = selectpadre[k].text;
            optionselect.value = selectpadre[k].value;
            selectpuesto.add(optionselect);
        }
        divselect.appendChild(selectpuesto);

        divbloque.appendChild(divcontrol);
        divbloque.appendChild(divselect);
        divcontenedor.appendChild(divbloque);

        divpadre.appendChild(divcontenedor);
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

        //elementosDuplicar = listaDuplicacion.getElementsByTagName("div");
        elementosDuplicar = listaDuplicacion.getElementsByClassName("form-group");
        padreAnexar = listaDuplicacion.parentNode;

        //contenedor de bloque
        var divfinalcontenedor = document.createElement("div");
        divfinalcontenedor.setAttribute("class", elementosDuplicar[0].parentNode.className);

        //contenedor clase
        var divfinalcontenedorclase = document.createElement("div");
        divfinalcontenedorclase.setAttribute("class", listaDuplicacion.className);
        divfinalcontenedorclase.setAttribute("id", totalListaDuplicacion);

        var inputeliminar = document.createElement("input");
        inputeliminar.type = "button";
        inputeliminar.setAttribute("onclick", 'EliminarBloqueDuplicacion(this);');
        inputeliminar.value = "X";

        divfinalcontenedorclase.appendChild(inputeliminar);

        for (i = 0; i < elementosDuplicar.length; i++) {
            elementinput = elementosDuplicar[i].getElementsByTagName("input")[0];
            elementlabel = elementosDuplicar[i].getElementsByTagName("label")[0];
            elementselect = elementosDuplicar[i].getElementsByTagName("select")[0];
            elementdiv = elementosDuplicar[i].getElementsByTagName("div")[0];

            if (elementinput === undefined || elementinput === null) {
                var lbl1 = document.createElement('label');
                lbl1.setAttribute("id", elementlabel.id + totalListaDuplicacion);
                lbl1.setAttribute("class", elementlabel.className);
                lbl1.innerHTML = elementlabel.innerHTML

                var txb1 = document.createElement('select');
                txb1.setAttribute("id", elementselect.id + totalListaDuplicacion);
                txb1.setAttribute("class", elementselect.className);

                for (k = 0; k < elementselect.options.length; k++) {
                    optionselect = document.createElement("option");
                    optionselect.text = elementselect[k].text;
                    optionselect.value = elementselect[k].value;
                    txb1.add(optionselect);
                }

                var divfinal1 = document.createElement("div");
                divfinal1.setAttribute("class", elementosDuplicar[i].className);
                divfinal1.appendChild(lbl1);
                divfinal1.appendChild(txb1);

                divfinalcontenedor.appendChild(divfinal1);
            }
            else {
                if (elementdiv === undefined || elementdiv === null) {
                    var lbl1 = document.createElement('label');
                    lbl1.setAttribute("id", elementlabel.id + totalListaDuplicacion);
                    lbl1.setAttribute("class", elementlabel.className);
                    lbl1.innerHTML = elementlabel.innerHTML;

                    var txb1 = document.createElement('input');
                    txb1.type = "text";
                    txb1.setAttribute("id", elementinput.id + totalListaDuplicacion);
                    txb1.setAttribute("maxlength", elementinput.maxlength);
                    txb1.setAttribute("class", elementinput.className);


                    var divfinal1 = document.createElement("div");
                    divfinal1.setAttribute("class", elementosDuplicar[i].className);
                    divfinal1.appendChild(lbl1);
                    divfinal1.appendChild(txb1);

                    divfinalcontenedor.appendChild(divfinal1);
                }
                else {
                    var lbl1 = document.createElement('label');
                    lbl1.setAttribute("id", elementlabel.id + totalListaDuplicacion);
                    lbl1.setAttribute("class", elementlabel.className);
                    lbl1.innerHTML = elementlabel.innerHTML;

                    var divhora = document.createElement("div");
                    divhora.setAttribute("class", elementdiv.className);
                    divhora.setAttribute("id", elementdiv.id + totalListaDuplicacion);

                    var inphora = document.createElement("input");
                    inphora.type = "text";
                    inphora.setAttribute("class", elementinput.className);

                    var spanhoragrupo = document.createElement("span");
                    spanhoragrupo.setAttribute("class", elementdiv.children[1].className);

                    var spanhora = document.createElement("span");
                    spanhora.setAttribute("class", elementdiv.children[1].children[0].className);

                    spanhoragrupo.appendChild(spanhora);
                    divhora.appendChild(inphora);
                    divhora.appendChild(spanhoragrupo);

                    var divfinal1 = document.createElement("div");
                    divfinal1.setAttribute("class", elementosDuplicar[i].className);
                    divfinal1.appendChild(lbl1);
                    divfinal1.appendChild(divhora);

                    divfinalcontenedor.appendChild(divfinal1);
                }
            }
        }
        divfinalcontenedorclase.appendChild(divfinalcontenedor);
        padreAnexar.appendChild(divfinalcontenedorclase);
        actualizarControlFechaBoton();
        return;
    }

    function CargarListaReportesDinamicos() {
        $.ajax({
            url: _spPageContextInfo.webAbsoluteUrl + "/_api/web/lists/getbytitle('LstPuestoProteccion')/Items?$select=Title,Pa_x00ed_s&$filter=Pa_x00ed_s eq '" + encodeURIComponent(pais) + "'&$top=100",
            type: "GET",
            async: false,
            headers: { "accept": "application/json;odata=verbose" },
            success: function (data) {
                if (data.d.results.length > 0) {
                    for (i = 0; i < data.d.results.length; i++) {
                        optionx = document.createElement("option");
                        optionx.text = data.d.results[i].Title;
                        optionx.value = data.d.results[i].Title;
                        globallistaElementos.push(optionx);

                        optionx = document.createElement("option");
                        optionx.text = data.d.results[i].Title;
                        optionx.value = data.d.results[i].Title;
                        globallistaElementos2.push(optionx);

                        optionx = document.createElement("option");
                        optionx.text = data.d.results[i].Title;
                        optionx.value = data.d.results[i].Title;
                        globallistaElementos3.push(optionx);

                        optionx = document.createElement("option");
                        optionx.text = data.d.results[i].Title;
                        optionx.value = data.d.results[i].Title;
                        globallistaElementos4.push(optionx);
                    }
                }
            },
            error: function (xhr) {
                console.log(xhr.status + ': ' + xhr.statusText);
            }
        });

        $.ajax({
            url: _spPageContextInfo.webAbsoluteUrl + "/_api/web/lists/getbytitle('LstColorCabello')/Items?$select=Title,Pa_x00ed_s&$filter=Pa_x00ed_s eq '" + encodeURIComponent(pais) + "'&$top=100",
            type: "GET",
            async: false,
            headers: { "accept": "application/json;odata=verbose" },
            success: function (data) {
                if (data.d.results.length > 0) {
                    for (i = 0; i < data.d.results.length; i++) {
                        optionx = document.createElement("option");
                        optionx.text = data.d.results[i].Title;
                        optionx.value = data.d.results[i].Title;
                        globallistaColorCabello.push(optionx);
                    }
                }
            },
            error: function (xhr) {
                console.log(xhr.status + ': ' + xhr.statusText);
            }
        });

        $.ajax({
            url: _spPageContextInfo.webAbsoluteUrl + "/_api/web/lists/getbytitle('LstAcumulacionMonto')/Items?$select=Title,Pa_x00ed_s&$filter=Pa_x00ed_s eq '" + encodeURIComponent(pais) + "'&$top=100",
            type: "GET",
            async: false,
            headers: { "accept": "application/json;odata=verbose" },
            success: function (data) {
                if (data.d.results.length > 0) {
                    for (i = 0; i < data.d.results.length; i++) {
                        optionx = document.createElement("option");
                        optionx.text = data.d.results[i].Title;
                        optionx.value = data.d.results[i].Title;
                        globallistaAcumulacionMonto.push(optionx);
                    }
                }
            },
            error: function (xhr) {
                console.log(xhr.status + ': ' + xhr.statusText);
            }
        });

        $.ajax({
            url: _spPageContextInfo.webAbsoluteUrl + "/_api/web/lists/getbytitle('LstColorPiel')/Items?$select=Title,Pa_x00ed_s&$filter=Pa_x00ed_s eq '" + encodeURIComponent(pais) + "'&$top=100",
            type: "GET",
            async: false,
            headers: { "accept": "application/json;odata=verbose" },
            success: function (data) {
                if (data.d.results.length > 0) {
                    for (i = 0; i < data.d.results.length; i++) {
                        optionx = document.createElement("option");
                        optionx.text = data.d.results[i].Title;
                        optionx.value = data.d.results[i].Title;
                        globallistaColorPiel.push(optionx);
                    }
                }
            },
            error: function (xhr) {
                console.log(xhr.status + ': ' + xhr.statusText);
            }
        });

        $.ajax({
            url: _spPageContextInfo.webAbsoluteUrl + "/_api/web/lists/getbytitle('LstComplexion')/Items?$select=Title,Pa_x00ed_s&$filter=Pa_x00ed_s eq '" + encodeURIComponent(pais) + "'&$top=100",
            type: "GET",
            async: false,
            headers: { "accept": "application/json;odata=verbose" },
            success: function (data) {
                if (data.d.results.length > 0) {
                    for (i = 0; i < data.d.results.length; i++) {
                        optionx = document.createElement("option");
                        optionx.text = data.d.results[i].Title;
                        optionx.value = data.d.results[i].Title;
                        globallistaComplexion.push(optionx);
                    }
                }
            },
            error: function (xhr) {
                console.log(xhr.status + ': ' + xhr.statusText);
            }
        });

        $.ajax({
            url: _spPageContextInfo.webAbsoluteUrl + "/_api/web/lists/getbytitle('LstCumplePolitica')/Items?$select=Title,Pa_x00ed_s&$filter=Pa_x00ed_s eq '" + encodeURIComponent(pais) + "'&$top=100",
            type: "GET",
            async: false,
            headers: { "accept": "application/json;odata=verbose" },
            success: function (data) {
                if (data.d.results.length > 0) {
                    for (i = 0; i < data.d.results.length; i++) {
                        optionx = document.createElement("option");
                        optionx.text = data.d.results[i].Title;
                        optionx.value = data.d.results[i].Title;
                        globallistaCumplePolitica.push(optionx);
                    }
                }
            },
            error: function (xhr) {
                console.log(xhr.status + ': ' + xhr.statusText);
            }
        });

        $.ajax({
            url: _spPageContextInfo.webAbsoluteUrl + "/_api/web/lists/getbytitle('LstEspecialidad')/Items?$select=Title,Pa_x00ed_s&$filter=Pa_x00ed_s eq '" + encodeURIComponent(pais) + "'&$top=100",
            type: "GET",
            async: false,
            headers: { "accept": "application/json;odata=verbose" },
            success: function (data) {
                if (data.d.results.length > 0) {
                    for (i = 0; i < data.d.results.length; i++) {
                        optionx = document.createElement("option");
                        optionx.text = data.d.results[i].Title;
                        optionx.value = data.d.results[i].Title;
                        globallistaEspecialidad.push(optionx);
                    }
                }
            },
            error: function (xhr) {
                console.log(xhr.status + ': ' + xhr.statusText);
            }
        });

        $.ajax({
            url: _spPageContextInfo.webAbsoluteUrl + "/_api/web/lists/getbytitle('LstEstatusCaja')/Items?$select=Title,Pa_x00ed_s&$filter=Pa_x00ed_s eq '" + encodeURIComponent(pais) + "'&$top=100",
            type: "GET",
            async: false,
            headers: { "accept": "application/json;odata=verbose" },
            success: function (data) {
                if (data.d.results.length > 0) {
                    for (i = 0; i < data.d.results.length; i++) {
                        optionx = document.createElement("option");
                        optionx.text = data.d.results[i].Title;
                        optionx.value = data.d.results[i].Title;
                        globallistaEstatusCaja.push(optionx);
                    }
                }
            },
            error: function (xhr) {
                console.log(xhr.status + ': ' + xhr.statusText);
            }
        });

        $.ajax({
            url: _spPageContextInfo.webAbsoluteUrl + "/_api/web/lists/getbytitle('LstGeneroDelincuente')/Items?$select=Title,Pa_x00ed_s&$filter=Pa_x00ed_s eq '" + encodeURIComponent(pais) + "'&$top=100",
            type: "GET",
            async: false,
            headers: { "accept": "application/json;odata=verbose" },
            success: function (data) {
                if (data.d.results.length > 0) {
                    for (i = 0; i < data.d.results.length; i++) {
                        optionx = document.createElement("option");
                        optionx.text = data.d.results[i].Title;
                        optionx.value = data.d.results[i].Title;
                        globallistaGeneroDelincuente.push(optionx);
                    }
                }
            },
            error: function (xhr) {
                console.log(xhr.status + ': ' + xhr.statusText);
            }
        });

        $.ajax({
            url: _spPageContextInfo.webAbsoluteUrl + "/_api/web/lists/getbytitle('LstMedidaVoz')/Items?$select=Title,Pa_x00ed_s&$filter=Pa_x00ed_s eq '" + encodeURIComponent(pais) + "'&$top=100",
            type: "GET",
            async: false,
            headers: { "accept": "application/json;odata=verbose" },
            success: function (data) {
                if (data.d.results.length > 0) {
                    for (i = 0; i < data.d.results.length; i++) {
                        optionx = document.createElement("option");
                        optionx.text = data.d.results[i].Title;
                        optionx.value = data.d.results[i].Title;
                        globallistaMedidaVoz.push(optionx);
                    }
                }
            },
            error: function (xhr) {
                console.log(xhr.status + ': ' + xhr.statusText);
            }
        });

        $.ajax({
            url: _spPageContextInfo.webAbsoluteUrl + "/_api/web/lists/getbytitle('LstOcupaTraslado')/Items?$select=Title,Pa_x00ed_s&$filter=Pa_x00ed_s eq '" + encodeURIComponent(pais) + "'&$top=100",
            type: "GET",
            async: false,
            headers: { "accept": "application/json;odata=verbose" },
            success: function (data) {
                if (data.d.results.length > 0) {
                    for (i = 0; i < data.d.results.length; i++) {
                        optionx = document.createElement("option");
                        optionx.text = data.d.results[i].Title;
                        optionx.value = data.d.results[i].Title;
                        globallistaOcupaTraslado.push(optionx);
                    }
                }
            },
            error: function (xhr) {
                console.log(xhr.status + ': ' + xhr.statusText);
            }
        });

        $.ajax({
            url: _spPageContextInfo.webAbsoluteUrl + "/_api/web/lists/getbytitle('LstReincidente')/Items?$select=Title,Pa_x00ed_s&$filter=Pa_x00ed_s eq '" + encodeURIComponent(pais) + "'&$top=100",
            type: "GET",
            async: false,
            headers: { "accept": "application/json;odata=verbose" },
            success: function (data) {
                if (data.d.results.length > 0) {
                    for (i = 0; i < data.d.results.length; i++) {
                        optionx = document.createElement("option");
                        optionx.text = data.d.results[i].Title;
                        optionx.value = data.d.results[i].Title;
                        globallistaReincidente.push(optionx);
                    }
                }
            },
            error: function (xhr) {
                console.log(xhr.status + ': ' + xhr.statusText);
            }
        });

        $.ajax({
            url: _spPageContextInfo.webAbsoluteUrl + "/_api/web/lists/getbytitle('LstRespaldo')/Items?$select=Title,Pa_x00ed_s&$filter=Pa_x00ed_s eq '" + encodeURIComponent(pais) + "'&$top=100",
            type: "GET",
            async: false,
            headers: { "accept": "application/json;odata=verbose" },
            success: function (data) {
                if (data.d.results.length > 0) {
                    for (i = 0; i < data.d.results.length; i++) {
                        optionx = document.createElement("option");
                        optionx.text = data.d.results[i].Title;
                        optionx.value = data.d.results[i].Title;
                        globallistaRespaldo.push(optionx);
                    }
                }
            },
            error: function (xhr) {
                console.log(xhr.status + ': ' + xhr.statusText);
            }
        });

        $.ajax({
            url: _spPageContextInfo.webAbsoluteUrl + "/_api/web/lists/getbytitle('LstRetiroValores')/Items?$select=Title,Pa_x00ed_s&$filter=Pa_x00ed_s eq '" + encodeURIComponent(pais) + "'&$top=100",
            type: "GET",
            async: false,
            headers: { "accept": "application/json;odata=verbose" },
            success: function (data) {
                if (data.d.results.length > 0) {
                    for (i = 0; i < data.d.results.length; i++) {
                        optionx = document.createElement("option");
                        optionx.text = data.d.results[i].Title;
                        optionx.value = data.d.results[i].Title;
                        globallistaRetiroValores.push(optionx);
                    }
                }
            },
            error: function (xhr) {
                console.log(xhr.status + ': ' + xhr.statusText);
            }
        });

        $.ajax({
            url: _spPageContextInfo.webAbsoluteUrl + "/_api/web/lists/getbytitle('LstTamanioCabello')/Items?$select=Title,Pa_x00ed_s&$filter=Pa_x00ed_s eq '" + encodeURIComponent(pais) + "'&$top=100",
            type: "GET",
            async: false,
            headers: { "accept": "application/json;odata=verbose" },
            success: function (data) {
                if (data.d.results.length > 0) {
                    for (i = 0; i < data.d.results.length; i++) {
                        optionx = document.createElement("option");
                        optionx.text = data.d.results[i].Title;
                        optionx.value = data.d.results[i].Title;
                        globallistaTamanioCabello.push(optionx);
                    }
                }
            },
            error: function (xhr) {
                console.log(xhr.status + ': ' + xhr.statusText);
            }
        });

        $.ajax({
            url: _spPageContextInfo.webAbsoluteUrl + "/_api/web/lists/getbytitle('LstTesituraVoz')/Items?$select=Title,Pa_x00ed_s&$filter=Pa_x00ed_s eq '" + encodeURIComponent(pais) + "'&$top=100",
            type: "GET",
            async: false,
            headers: { "accept": "application/json;odata=verbose" },
            success: function (data) {
                if (data.d.results.length > 0) {
                    for (i = 0; i < data.d.results.length; i++) {
                        optionx = document.createElement("option");
                        optionx.text = data.d.results[i].Title;
                        optionx.value = data.d.results[i].Title;
                        globallistaTesituraVoz.push(optionx);
                    }
                }
            },
            error: function (xhr) {
                console.log(xhr.status + ': ' + xhr.statusText);
            }
        });

        $.ajax({
            url: _spPageContextInfo.webAbsoluteUrl + "/_api/web/lists/getbytitle('LstTipoArma')/Items?$select=Title,Pa_x00ed_s&$filter=Pa_x00ed_s eq '" + encodeURIComponent(pais) + "'&$top=100",
            type: "GET",
            async: false,
            headers: { "accept": "application/json;odata=verbose" },
            success: function (data) {
                if (data.d.results.length > 0) {
                    for (i = 0; i < data.d.results.length; i++) {
                        optionx = document.createElement("option");
                        optionx.text = data.d.results[i].Title;
                        optionx.value = data.d.results[i].Title;
                        globallistaTipoArma.push(optionx);
                    }
                }
            },
            error: function (xhr) {
                console.log(xhr.status + ': ' + xhr.statusText);
            }
        });

        $.ajax({
            url: _spPageContextInfo.webAbsoluteUrl + "/_api/web/lists/getbytitle('LstTipoCabello')/Items?$select=Title,Pa_x00ed_s&$filter=Pa_x00ed_s eq '" + encodeURIComponent(pais) + "'&$top=100",
            type: "GET",
            async: false,
            headers: { "accept": "application/json;odata=verbose" },
            success: function (data) {
                if (data.d.results.length > 0) {
                    for (i = 0; i < data.d.results.length; i++) {
                        optionx = document.createElement("option");
                        optionx.text = data.d.results[i].Title;
                        optionx.value = data.d.results[i].Title;
                        globallistaTipoCabello.push(optionx);
                    }
                }
            },
            error: function (xhr) {
                console.log(xhr.status + ': ' + xhr.statusText);
            }
        });

        $.ajax({
            url: _spPageContextInfo.webAbsoluteUrl + "/_api/web/lists/getbytitle('LstTipoLesion')/Items?$select=Title,Pa_x00ed_s&$filter=Pa_x00ed_s eq '" + encodeURIComponent(pais) + "'&$top=100",
            type: "GET",
            async: false,
            headers: { "accept": "application/json;odata=verbose" },
            success: function (data) {
                if (data.d.results.length > 0) {
                    for (i = 0; i < data.d.results.length; i++) {
                        optionx = document.createElement("option");
                        optionx.text = data.d.results[i].Title;
                        optionx.value = data.d.results[i].Title;
                        globallistaTipoLesion.push(optionx);
                    }
                }
            },
            error: function (xhr) {
                console.log(xhr.status + ': ' + xhr.statusText);
            }
        });

        $.ajax({
            url: _spPageContextInfo.webAbsoluteUrl + "/_api/web/lists/getbytitle('LstVoz')/Items?$select=Title,Pa_x00ed_s&$filter=Pa_x00ed_s eq '" + encodeURIComponent(pais) + "'&$top=100",
            type: "GET",
            async: false,
            headers: { "accept": "application/json;odata=verbose" },
            success: function (data) {
                if (data.d.results.length > 0) {
                    for (i = 0; i < data.d.results.length; i++) {
                        optionx = document.createElement("option");
                        optionx.text = data.d.results[i].Title;
                        optionx.value = data.d.results[i].Title;
                        globallistaVoz.push(optionx);
                    }
                }
            },
            error: function (xhr) {
                console.log(xhr.status + ': ' + xhr.statusText);
            }
        });
    }

    function actualizarControlFecha() {
        $('.date').datetimepicker({
            format: 'LT'
        });

        $('.datetimepicker1').datetimepicker({
            format: 'DD/MM/YYYY'
        });

        var listaElementos = globallistaElementos;
        var listaElementos2 = globallistaElementos2;
        var listaElementos3 = globallistaElementos3;
        var listaElementos4 = globallistaElementos4;
        var listaColorCabello = globallistaColorCabello;
        var listaAcumulacionMonto = globallistaAcumulacionMonto;
        var listaColorPiel = globallistaColorPiel;
        var listaComplexion = globallistaComplexion;
        var listaCumplePolitica = globallistaCumplePolitica;
        var listaEspecialidad = globallistaEspecialidad;
        var listaEstatusCaja = globallistaEstatusCaja;
        var listaGeneroDelincuente = globallistaGeneroDelincuente;
        var listaMedidaVoz = globallistaMedidaVoz;
        var listaOcupaTraslado = globallistaOcupaTraslado;
        var listaReincidente = globallistaReincidente;
        var listaRespaldo = globallistaRespaldo;
        var listaRetiroValores = globallistaRetiroValores;
        var listaTamanioCabello = globallistaTamanioCabello;
        var listaTesituraVoz = globallistaTesituraVoz;
        var listaTipoArma = globallistaTipoArma;
        var listaTipoCabello = globallistaTipoCabello;
        var listaTipoLesion = globallistaTipoLesion;
        var listaVoz = globallistaVoz;

        listaReportes = document.getElementsByClassName("BloqueReportesDinamicos");

        for (i = 0; i < listaReportes.length; i++) {
            listaTags = listaReportes[i].getElementsByTagName("select");

            for (j = 0; j < listaTags.length; j++) {
                if (listaTags[j].id == "PuestoPersonaReportaProteccion" && listaTags[j].length == 1) {
                    elementopuesto = document.getElementsByClassName("BloqueReportesDinamicos")[i].getElementsByTagName("select")[j];
                    for (l = 0; l < listaElementos.length; l++) {
                        clonElement = listaElementos[l].cloneNode(true);
                        elementopuesto.add(clonElement);
                    }
                }
                if (listaTags[j].id == "PuestoQuienAutoriza" && listaTags[j].length == 1) {
                    elementopuesto2 = document.getElementsByClassName("BloqueReportesDinamicos")[i].getElementsByTagName("select")[j];
                    for (l = 0; l < listaElementos2.length; l++) {
                        clonElement = listaElementos[l].cloneNode(true);
                        elementopuesto2.add(clonElement);
                    }
                }
                if (listaTags[j].id == "PuestoProporcionaApoyo" && listaTags[j].length == 1) {
                    elementopuesto3 = document.getElementsByClassName("BloqueReportesDinamicos")[i].getElementsByTagName("select")[j];
                    for (l = 0; l < listaElementos3.length; l++) {
                        clonElement = listaElementos3[l].cloneNode(true);
                        elementopuesto3.add(clonElement);
                    }
                }
                if (listaTags[j].id == "PuestoQuienRecibe" && listaTags[j].length == 1) {
                    elementopuesto4 = document.getElementsByClassName("BloqueReportesDinamicos")[i].getElementsByTagName("select")[j];
                    for (l = 0; l < listaElementos4.length; l++) {
                        clonElement = listaElementos4[l].cloneNode(true);
                        elementopuesto4.add(clonElement);
                    }
                }
                if (listaTags[j].id == "GeneroDelincuente" && listaTags[j].length == 1) {
                    elementopuesto11 = document.getElementsByClassName("BloqueReportesDinamicos")[i].getElementsByTagName("select")[j];
                    for (l = 0; l < listaGeneroDelincuente.length; l++) {
                        clonElement = listaGeneroDelincuente[l].cloneNode(true);
                        elementopuesto11.add(clonElement);
                    }
                }
                if (listaTags[j].id == "TipoArma" && listaTags[j].length == 1) {
                    elementopuesto19 = document.getElementsByClassName("BloqueReportesDinamicos")[i].getElementsByTagName("select")[j];
                    for (l = 0; l < listaTipoArma.length; l++) {
                        clonElement = listaTipoArma[l].cloneNode(true);
                        elementopuesto19.add(clonElement);
                    }
                }
                if (listaTags[j].id == "AcumulacionMonto" && listaTags[j].length == 1) {
                    elementopuesto30 = document.getElementsByClassName("BloqueReportesDinamicos")[i].getElementsByTagName("select")[j];
                    for (l = 0; l < listaAcumulacionMonto.length; l++) {
                        clonElement = listaAcumulacionMonto[l].cloneNode(true);
                        elementopuesto30.add(clonElement);
                    }
                }
                if (listaTags[j].id == "TipoLesion" && listaTags[j].length == 1) {
                    elementopuesto21 = document.getElementsByClassName("BloqueReportesDinamicos")[i].getElementsByTagName("select")[j];
                    for (l = 0; l < listaTipoLesion.length; l++) {
                        clonElement = listaTipoLesion[l].cloneNode(true);
                        elementopuesto21.add(clonElement);
                    }
                }
                if (listaTags[j].id == "OcupaTraslado" && listaTags[j].length == 1) {
                    elementopuesto13 = document.getElementsByClassName("BloqueReportesDinamicos")[i].getElementsByTagName("select")[j];
                    for (l = 0; l < listaOcupaTraslado.length; l++) {
                        clonElement = listaOcupaTraslado[l].cloneNode(true);
                        elementopuesto13.add(clonElement);
                    }
                }
                if (listaTags[j].id == "ColorCabello" && listaTags[j].length == 1) {
                    elementopuesto5 = document.getElementsByClassName("BloqueReportesDinamicos")[i].getElementsByTagName("select")[j];
                    for (l = 0; l < listaColorCabello.length; l++) {
                        clonElement = listaColorCabello[l].cloneNode(true);
                        elementopuesto5.add(listaColorCabello[l]);
                    }
                }
                if (listaTags[j].id == "ColorPiel" && listaTags[j].length == 1) {
                    elementopuesto6 = document.getElementsByClassName("BloqueReportesDinamicos")[i].getElementsByTagName("select")[j];
                    for (l = 0; l < listaColorPiel.length; l++) {
                        clonElement = listaColorPiel[l].cloneNode(true);
                        elementopuesto6.add(clonElement);
                    }
                }
                if (listaTags[j].id == "Complexion" && listaTags[j].length == 1) {
                    elementopuesto7 = document.getElementsByClassName("BloqueReportesDinamicos")[i].getElementsByTagName("select")[j];
                    for (l = 0; l < listaComplexion.length; l++) {
                        clonElement = listaComplexion[l].cloneNode(true);
                        elementopuesto7.add(clonElement);
                    }
                }
                if (listaTags[j].id == "CumplePolitica" && listaTags[j].length == 1) {
                    elementopuesto8 = document.getElementsByClassName("BloqueReportesDinamicos")[i].getElementsByTagName("select")[j];
                    for (l = 0; l < listaCumplePolitica.length; l++) {
                        clonElement = listaCumplePolitica[l].cloneNode(true);
                        elementopuesto8.add(clonElement);
                    }
                }
                if (listaTags[j].id == "Especialidad" && listaTags[j].length == 1) {
                    elementopuesto9 = document.getElementsByClassName("BloqueReportesDinamicos")[i].getElementsByTagName("select")[j];
                    for (l = 0; l < listaEspecialidad.length; l++) {
                        clonElement = listaEspecialidad[l].cloneNode(true);
                        elementopuesto9.add(clonElement);
                    }
                }
                if (listaTags[j].id == "StatusCaja" && listaTags[j].length == 1) {
                    elementopuesto10 = document.getElementsByClassName("BloqueReportesDinamicos")[i].getElementsByTagName("select")[j];
                    for (l = 0; l < listaEstatusCaja.length; l++) {
                        clonElement = listaEstatusCaja[l].cloneNode(true);
                        elementopuesto10.add(clonElement);
                    }
                }
                if (listaTags[j].id == "MedidaVoz" && listaTags[j].length == 1) {
                    elementopuesto12 = document.getElementsByClassName("BloqueReportesDinamicos")[i].getElementsByTagName("select")[j];
                    for (l = 0; l < listaMedidaVoz.length; l++) {
                        clonElement = listaMedidaVoz[l].cloneNode(true);
                        elementopuesto12.add(clonElement);
                    }
                }
                if (listaTags[j].id == "Reincidente" && listaTags[j].length == 1) {
                    elementopuesto14 = document.getElementsByClassName("BloqueReportesDinamicos")[i].getElementsByTagName("select")[j];
                    for (l = 0; l < listaReincidente.length; l++) {
                        clonElement = listaReincidente[l].cloneNode(true);
                        elementopuesto14.add(clonElement);
                    }
                }
                if (listaTags[j].id == "Respaldo" && listaTags[j].length == 1) {
                    elementopuesto15 = document.getElementsByClassName("BloqueReportesDinamicos")[i].getElementsByTagName("select")[j];
                    for (l = 0; l < listaRespaldo.length; l++) {
                        clonElement = listaRespaldo[l].cloneNode(true);
                        elementopuesto15.add(clonElement);
                    }
                }
                if (listaTags[j].id == "RetiroValores" && listaTags[j].length == 1) {
                    elementopuesto16 = document.getElementsByClassName("BloqueReportesDinamicos")[i].getElementsByTagName("select")[j];
                    for (l = 0; l < listaRetiroValores.length; l++) {
                        clonElement = listaRetiroValores[l].cloneNode(true);
                        elementopuesto16.add(clonElement);
                    }
                }
                if (listaTags[j].id == "TamanioCabello" && listaTags[j].length == 1) {
                    elementopuesto17 = document.getElementsByClassName("BloqueReportesDinamicos")[i].getElementsByTagName("select")[j];
                    for (l = 0; l < listaTamanioCabello.length; l++) {
                        clonElement = listaTamanioCabello[l].cloneNode(true);
                        elementopuesto17.add(clonElement);
                    }
                }
                if (listaTags[j].id == "TesituraVoz" && listaTags[j].length == 1) {
                    elementopuesto18 = document.getElementsByClassName("BloqueReportesDinamicos")[i].getElementsByTagName("select")[j];
                    for (l = 0; l < listaTesituraVoz.length; l++) {
                        clonElement = listaTesituraVoz[l].cloneNode(true);
                        elementopuesto18.add(clonElement);
                    }
                }
                if (listaTags[j].id == "TipoCabello" && listaTags[j].length == 1) {
                    elementopuesto20 = document.getElementsByClassName("BloqueReportesDinamicos")[i].getElementsByTagName("select")[j];
                    for (l = 0; l < listaTipoCabello.length; l++) {
                        clonElement = listaTipoCabello[l].cloneNode(true);
                        elementopuesto20.add(clonElement);
                    }
                }
                if (listaTags[j].id == "Voz" && listaTags[j].length == 1) {
                    elementopuesto22 = document.getElementsByClassName("BloqueReportesDinamicos")[i].getElementsByTagName("select")[j];
                    for (l = 0; l < listaVoz.length; l++) {
                        clonElement = listaVoz[l].cloneNode(true);
                        elementopuesto22.add(clonElement);
                    }
                }
            }

            listaTags = listaReportes[i].getElementsByTagName("input");
            for (m = 0; m < listaTags.length; m++) {
                if (listaTags[m].id == "NumeroPersonasInvolucradas" || listaTags[m].id == "NumeroEquipos" || listaTags[m].id == "AreaPersonasInvolucradas" || listaTags[m].id == "AreaNumeroEquipos") {
                    listaTags[m].value = CargarIdiomaEtiqueta(listaTags[m].id);
                }
                if (listaTags[m].type == "button") {
                    if (listaTags[m].id !== "" && listaTags[m].id !== undefined) {
                        listaTags[m].value = CargarIdiomaEtiqueta(listaTags[m].id);
                    }
                }
                if (listaTags[m].id == "ColorCabello") {
                    var elementSelect = document.createElement('select');
                    elementSelect.setAttribute("id", listaTags[m].id);
                    elementSelect.setAttribute("class", listaTags[m].className);
                    listaTags[m].parentNode.replaceChild(elementSelect, listaTags[m]);

                    var option = document.createElement("option");
                    option.text = "...";
                    option.value = null;
                    elementSelect.add(option);

                    elementopuesto5 = elementSelect;
                    for (l = 0; l < listaColorCabello.length; l++) {
                        clonElement = listaColorCabello[l].cloneNode(true);
                        elementopuesto5.add(listaColorCabello[l]);
                    }
                }
                if (listaTags[m].id == "ColorPiel") {
                    var elementSelect = document.createElement('select');
                    elementSelect.setAttribute("id", listaTags[m].id);
                    elementSelect.setAttribute("class", listaTags[m].className);
                    listaTags[m].parentNode.replaceChild(elementSelect, listaTags[m]);

                    var option = document.createElement("option");
                    option.text = "...";
                    option.value = null;
                    elementSelect.add(option);

                    elementopuesto6 = elementSelect;
                    for (l = 0; l < listaColorPiel.length; l++) {
                        clonElement = listaColorPiel[l].cloneNode(true);
                        elementopuesto6.add(clonElement);
                    }
                }
                if (listaTags[m].id == "Complexion") {
                    var elementSelect = document.createElement('select');
                    elementSelect.setAttribute("id", listaTags[m].id);
                    elementSelect.setAttribute("class", listaTags[m].className);
                    listaTags[m].parentNode.replaceChild(elementSelect, listaTags[m]);

                    var option = document.createElement("option");
                    option.text = "...";
                    option.value = null;
                    elementSelect.add(option);

                    elementopuesto7 = elementSelect;
                    for (l = 0; l < listaComplexion.length; l++) {
                        clonElement = listaComplexion[l].cloneNode(true);
                        elementopuesto7.add(clonElement);
                    }
                }
                if (listaTags[m].id == "CumplePolitica") {
                    var elementSelect = document.createElement('select');
                    elementSelect.setAttribute("id", listaTags[m].id);
                    elementSelect.setAttribute("class", listaTags[m].className);
                    listaTags[m].parentNode.replaceChild(elementSelect, listaTags[m]);

                    var option = document.createElement("option");
                    option.text = "...";
                    option.value = null;
                    elementSelect.add(option);

                    elementopuesto8 = elementSelect;
                    for (l = 0; l < listaCumplePolitica.length; l++) {
                        clonElement = listaCumplePolitica[l].cloneNode(true);
                        elementopuesto8.add(clonElement);
                    }
                }
                if (listaTags[m].id == "Especialidad") {
                    var elementSelect = document.createElement('select');
                    elementSelect.setAttribute("id", listaTags[m].id);
                    elementSelect.setAttribute("class", listaTags[m].className);
                    listaTags[m].parentNode.replaceChild(elementSelect, listaTags[m]);

                    var option = document.createElement("option");
                    option.text = "...";
                    option.value = null;
                    elementSelect.add(option);

                    elementopuesto9 = elementSelect;
                    for (l = 0; l < listaEspecialidad.length; l++) {
                        clonElement = listaEspecialidad[l].cloneNode(true);
                        elementopuesto9.add(clonElement);
                    }
                }
                if (listaTags[m].id == "StatusCaja") {
                    var elementSelect = document.createElement('select');
                    elementSelect.setAttribute("id", listaTags[m].id);
                    elementSelect.setAttribute("class", listaTags[m].className);
                    listaTags[m].parentNode.replaceChild(elementSelect, listaTags[m]);

                    var option = document.createElement("option");
                    option.text = "...";
                    option.value = null;
                    elementSelect.add(option);

                    elementopuesto10 = elementSelect;
                    for (l = 0; l < listaEstatusCaja.length; l++) {
                        clonElement = listaEstatusCaja[l].cloneNode(true);
                        elementopuesto10.add(clonElement);
                    }
                }
                if (listaTags[m].id == "MedidaVoz") {
                    var elementSelect = document.createElement('select');
                    elementSelect.setAttribute("id", listaTags[m].id);
                    elementSelect.setAttribute("class", listaTags[m].className);
                    listaTags[m].parentNode.replaceChild(elementSelect, listaTags[m]);

                    var option = document.createElement("option");
                    option.text = "...";
                    option.value = null;
                    elementSelect.add(option);

                    elementopuesto12 = elementSelect;
                    for (l = 0; l < listaMedidaVoz.length; l++) {
                        clonElement = listaMedidaVoz[l].cloneNode(true);
                        elementopuesto12.add(clonElement);
                    }
                }
                if (listaTags[m].id == "Reincidente") {
                    var elementSelect = document.createElement('select');
                    elementSelect.setAttribute("id", listaTags[m].id);
                    elementSelect.setAttribute("class", listaTags[m].className);
                    listaTags[m].parentNode.replaceChild(elementSelect, listaTags[m]);

                    var option = document.createElement("option");
                    option.text = "...";
                    option.value = null;
                    elementSelect.add(option);

                    elementopuesto14 = elementSelect;
                    for (l = 0; l < listaReincidente.length; l++) {
                        clonElement = listaReincidente[l].cloneNode(true);
                        elementopuesto14.add(clonElement);
                    }
                }
                if (listaTags[m].id == "Respaldo") {
                    var elementSelect = document.createElement('select');
                    elementSelect.setAttribute("id", listaTags[m].id);
                    elementSelect.setAttribute("class", listaTags[m].className);
                    listaTags[m].parentNode.replaceChild(elementSelect, listaTags[m]);

                    var option = document.createElement("option");
                    option.text = "...";
                    option.value = null;
                    elementSelect.add(option);

                    elementopuesto15 = elementSelect;
                    for (l = 0; l < listaRespaldo.length; l++) {
                        clonElement = listaRespaldo[l].cloneNode(true);
                        elementopuesto15.add(clonElement);
                    }
                }
                if (listaTags[m].id == "RetiroValores") {
                    var elementSelect = document.createElement('select');
                    elementSelect.setAttribute("id", listaTags[m].id);
                    elementSelect.setAttribute("class", listaTags[m].className);
                    listaTags[m].parentNode.replaceChild(elementSelect, listaTags[m]);

                    var option = document.createElement("option");
                    option.text = "...";
                    option.value = null;
                    elementSelect.add(option);

                    elementopuesto16 = elementSelect;
                    for (l = 0; l < listaRetiroValores.length; l++) {
                        clonElement = listaRetiroValores[l].cloneNode(true);
                        elementopuesto16.add(clonElement);
                    }
                }
                if (listaTags[m].id == "TamanioCabello") {
                    var elementSelect = document.createElement('select');
                    elementSelect.setAttribute("id", listaTags[m].id);
                    elementSelect.setAttribute("class", listaTags[m].className);
                    listaTags[m].parentNode.replaceChild(elementSelect, listaTags[m]);

                    var option = document.createElement("option");
                    option.text = "...";
                    option.value = null;
                    elementSelect.add(option);

                    elementopuesto17 = elementSelect;
                    for (l = 0; l < listaTamanioCabello.length; l++) {
                        clonElement = listaTamanioCabello[l].cloneNode(true);
                        elementopuesto17.add(clonElement);
                    }
                }
                if (listaTags[m].id == "TesituraVoz") {
                    var elementSelect = document.createElement('select');
                    elementSelect.setAttribute("id", listaTags[m].id);
                    elementSelect.setAttribute("class", listaTags[m].className);
                    listaTags[m].parentNode.replaceChild(elementSelect, listaTags[m]);

                    var option = document.createElement("option");
                    option.text = "...";
                    option.value = null;
                    elementSelect.add(option);

                    elementopuesto18 = elementSelect;
                    for (l = 0; l < listaTesituraVoz.length; l++) {
                        clonElement = listaTesituraVoz[l].cloneNode(true);
                        elementopuesto18.add(clonElement);
                    }
                }
                if (listaTags[m].id == "TipoCabello") {
                    var elementSelect = document.createElement('select');
                    elementSelect.setAttribute("id", listaTags[m].id);
                    elementSelect.setAttribute("class", listaTags[m].className);
                    listaTags[m].parentNode.replaceChild(elementSelect, listaTags[m]);

                    var option = document.createElement("option");
                    option.text = "...";
                    option.value = null;
                    elementSelect.add(option);

                    elementopuesto20 = elementSelect;
                    for (l = 0; l < listaTipoCabello.length; l++) {
                        clonElement = listaTipoCabello[l].cloneNode(true);
                        elementopuesto20.add(clonElement);
                    }
                }
                if (listaTags[m].id == "Voz") {
                    var elementSelect = document.createElement('select');
                    elementSelect.setAttribute("id", listaTags[m].id);
                    elementSelect.setAttribute("class", listaTags[m].className);
                    listaTags[m].parentNode.replaceChild(elementSelect, listaTags[m]);

                    var option = document.createElement("option");
                    option.text = "...";
                    option.value = null;
                    elementSelect.add(option);

                    elementopuesto22 = elementSelect;
                    for (l = 0; l < listaVoz.length; l++) {
                        clonElement = listaVoz[l].cloneNode(true);
                        elementopuesto22.add(clonElement);
                    }
                }
            }
        }
    }

    function actualizarControlFechaBoton() {

        listaReportes = document.getElementsByClassName("BloqueReportesDinamicos");

        var listaElementos = globallistaElementos;
        var listaElementos2 = globallistaElementos2;
        var listaElementos3 = globallistaElementos3;
        var listaElementos4 = globallistaElementos4;
        var listaColorCabello = globallistaColorCabello;
        var listaAcumulacionMonto = globallistaAcumulacionMonto;
        var listaColorPiel = globallistaColorPiel;
        var listaComplexion = globallistaComplexion;
        var listaCumplePolitica = globallistaCumplePolitica;
        var listaEspecialidad = globallistaEspecialidad;
        var listaEstatusCaja = globallistaEstatusCaja;
        var listaGeneroDelincuente = globallistaGeneroDelincuente;
        var listaMedidaVoz = globallistaMedidaVoz;
        var listaOcupaTraslado = globallistaOcupaTraslado;
        var listaReincidente = globallistaReincidente;
        var listaRespaldo = globallistaRespaldo;
        var listaRetiroValores = globallistaRetiroValores;
        var listaTamanioCabello = globallistaTamanioCabello;
        var listaTesituraVoz = globallistaTesituraVoz;
        var listaTipoArma = globallistaTipoArma;
        var listaTipoCabello = globallistaTipoCabello;
        var listaTipoLesion = globallistaTipoLesion;
        var listaVoz = globallistaVoz;

        for (i = 0; i < listaReportes.length; i++) {
            listaTags = listaReportes[i].getElementsByTagName("select");

            for (j = 0; j < listaTags.length; j++) {
                if (listaTags[j].id == "PuestoPersonaReportaProteccion" && listaTags[j].length == 1) {
                    elementopuesto = document.getElementsByClassName("BloqueReportesDinamicos")[i].getElementsByTagName("select")[j];
                    for (l = 0; l < listaElementos.length; l++) {
                        clonElement = listaElementos[l].cloneNode(true);
                        elementopuesto.add(clonElement);
                    }
                }
                if (listaTags[j].id == "PuestoQuienAutoriza" && listaTags[j].length == 1) {
                    elementopuesto2 = document.getElementsByClassName("BloqueReportesDinamicos")[i].getElementsByTagName("select")[j];
                    for (l = 0; l < listaElementos2.length; l++) {
                        clonElement = listaElementos[l].cloneNode(true);
                        elementopuesto2.add(clonElement);
                    }
                }
                if (listaTags[j].id == "PuestoProporcionaApoyo" && listaTags[j].length == 1) {
                    elementopuesto3 = document.getElementsByClassName("BloqueReportesDinamicos")[i].getElementsByTagName("select")[j];
                    for (l = 0; l < listaElementos3.length; l++) {
                        clonElement = listaElementos3[l].cloneNode(true);
                        elementopuesto3.add(clonElement);
                    }
                }
                if (listaTags[j].id == "PuestoQuienRecibe" && listaTags[j].length == 1) {
                    elementopuesto4 = document.getElementsByClassName("BloqueReportesDinamicos")[i].getElementsByTagName("select")[j];
                    for (l = 0; l < listaElementos4.length; l++) {
                        clonElement = listaElementos4[l].cloneNode(true);
                        elementopuesto4.add(clonElement);
                    }
                }
                if (listaTags[j].id == "GeneroDelincuente" && listaTags[j].length == 1) {
                    elementopuesto11 = document.getElementsByClassName("BloqueReportesDinamicos")[i].getElementsByTagName("select")[j];
                    for (l = 0; l < listaGeneroDelincuente.length; l++) {
                        clonElement = listaGeneroDelincuente[l].cloneNode(true);
                        elementopuesto11.add(clonElement);
                    }
                }
                if (listaTags[j].id == "TipoArma" && listaTags[j].length == 1) {
                    elementopuesto19 = document.getElementsByClassName("BloqueReportesDinamicos")[i].getElementsByTagName("select")[j];
                    for (l = 0; l < listaTipoArma.length; l++) {
                        clonElement = listaTipoArma[l].cloneNode(true);
                        elementopuesto19.add(clonElement);
                    }
                }
                if (listaTags[j].id == "AcumulacionMonto" && listaTags[j].length == 1) {
                    elementopuesto30 = document.getElementsByClassName("BloqueReportesDinamicos")[i].getElementsByTagName("select")[j];
                    for (l = 0; l < listaAcumulacionMonto.length; l++) {
                        clonElement = listaAcumulacionMonto[l].cloneNode(true);
                        elementopuesto30.add(clonElement);
                    }
                }
                if (listaTags[j].id == "TipoLesion" && listaTags[j].length == 1) {
                    elementopuesto21 = document.getElementsByClassName("BloqueReportesDinamicos")[i].getElementsByTagName("select")[j];
                    for (l = 0; l < listaTipoLesion.length; l++) {
                        clonElement = listaTipoLesion[l].cloneNode(true);
                        elementopuesto21.add(clonElement);
                    }
                }
                if (listaTags[j].id == "OcupaTraslado" && listaTags[j].length == 1) {
                    elementopuesto13 = document.getElementsByClassName("BloqueReportesDinamicos")[i].getElementsByTagName("select")[j];
                    for (l = 0; l < listaOcupaTraslado.length; l++) {
                        clonElement = listaOcupaTraslado[l].cloneNode(true);
                        elementopuesto13.add(clonElement);
                    }
                }
                if (listaTags[j].id == "ColorCabello" && listaTags[j].length == 1) {
                    elementopuesto5 = document.getElementsByClassName("BloqueReportesDinamicos")[i].getElementsByTagName("select")[j];
                    for (l = 0; l < listaColorCabello.length; l++) {
                        clonElement = listaColorCabello[l].cloneNode(true);
                        elementopuesto5.add(listaColorCabello[l]);
                    }
                }
                if (listaTags[j].id == "ColorPiel" && listaTags[j].length == 1) {
                    elementopuesto6 = document.getElementsByClassName("BloqueReportesDinamicos")[i].getElementsByTagName("select")[j];
                    for (l = 0; l < listaColorPiel.length; l++) {
                        clonElement = listaColorPiel[l].cloneNode(true);
                        elementopuesto6.add(clonElement);
                    }
                }
                if (listaTags[j].id == "Complexion" && listaTags[j].length == 1) {
                    elementopuesto7 = document.getElementsByClassName("BloqueReportesDinamicos")[i].getElementsByTagName("select")[j];
                    for (l = 0; l < listaComplexion.length; l++) {
                        clonElement = listaComplexion[l].cloneNode(true);
                        elementopuesto7.add(clonElement);
                    }
                }
                if (listaTags[j].id == "CumplePolitica" && listaTags[j].length == 1) {
                    elementopuesto8 = document.getElementsByClassName("BloqueReportesDinamicos")[i].getElementsByTagName("select")[j];
                    for (l = 0; l < listaCumplePolitica.length; l++) {
                        clonElement = listaCumplePolitica[l].cloneNode(true);
                        elementopuesto8.add(clonElement);
                    }
                }
                if (listaTags[j].id == "Especialidad" && listaTags[j].length == 1) {
                    elementopuesto9 = document.getElementsByClassName("BloqueReportesDinamicos")[i].getElementsByTagName("select")[j];
                    for (l = 0; l < listaEspecialidad.length; l++) {
                        clonElement = listaEspecialidad[l].cloneNode(true);
                        elementopuesto9.add(clonElement);
                    }
                }
                if (listaTags[j].id == "StatusCaja" && listaTags[j].length == 1) {
                    elementopuesto10 = document.getElementsByClassName("BloqueReportesDinamicos")[i].getElementsByTagName("select")[j];
                    for (l = 0; l < listaEstatusCaja.length; l++) {
                        clonElement = listaEstatusCaja[l].cloneNode(true);
                        elementopuesto10.add(clonElement);
                    }
                }
                if (listaTags[j].id == "MedidaVoz" && listaTags[j].length == 1) {
                    elementopuesto12 = document.getElementsByClassName("BloqueReportesDinamicos")[i].getElementsByTagName("select")[j];
                    for (l = 0; l < listaMedidaVoz.length; l++) {
                        clonElement = listaMedidaVoz[l].cloneNode(true);
                        elementopuesto12.add(clonElement);
                    }
                }
                if (listaTags[j].id == "Reincidente" && listaTags[j].length == 1) {
                    elementopuesto14 = document.getElementsByClassName("BloqueReportesDinamicos")[i].getElementsByTagName("select")[j];
                    for (l = 0; l < listaReincidente.length; l++) {
                        clonElement = listaReincidente[l].cloneNode(true);
                        elementopuesto14.add(clonElement);
                    }
                }
                if (listaTags[j].id == "Respaldo" && listaTags[j].length == 1) {
                    elementopuesto15 = document.getElementsByClassName("BloqueReportesDinamicos")[i].getElementsByTagName("select")[j];
                    for (l = 0; l < listaRespaldo.length; l++) {
                        clonElement = listaRespaldo[l].cloneNode(true);
                        elementopuesto15.add(clonElement);
                    }
                }
                if (listaTags[j].id == "RetiroValores" && listaTags[j].length == 1) {
                    elementopuesto16 = document.getElementsByClassName("BloqueReportesDinamicos")[i].getElementsByTagName("select")[j];
                    for (l = 0; l < listaRetiroValores.length; l++) {
                        clonElement = listaRetiroValores[l].cloneNode(true);
                        elementopuesto16.add(clonElement);
                    }
                }
                if (listaTags[j].id == "TamanioCabello" && listaTags[j].length == 1) {
                    elementopuesto17 = document.getElementsByClassName("BloqueReportesDinamicos")[i].getElementsByTagName("select")[j];
                    for (l = 0; l < listaTamanioCabello.length; l++) {
                        clonElement = listaTamanioCabello[l].cloneNode(true);
                        elementopuesto17.add(clonElement);
                    }
                }
                if (listaTags[j].id == "TesituraVoz" && listaTags[j].length == 1) {
                    elementopuesto18 = document.getElementsByClassName("BloqueReportesDinamicos")[i].getElementsByTagName("select")[j];
                    for (l = 0; l < listaTesituraVoz.length; l++) {
                        clonElement = listaTesituraVoz[l].cloneNode(true);
                        elementopuesto18.add(clonElement);
                    }
                }
                if (listaTags[j].id == "TipoCabello" && listaTags[j].length == 1) {
                    elementopuesto20 = document.getElementsByClassName("BloqueReportesDinamicos")[i].getElementsByTagName("select")[j];
                    for (l = 0; l < listaTipoCabello.length; l++) {
                        clonElement = listaTipoCabello[l].cloneNode(true);
                        elementopuesto20.add(clonElement);
                    }
                }
                if (listaTags[j].id == "Voz" && listaTags[j].length == 1) {
                    elementopuesto22 = document.getElementsByClassName("BloqueReportesDinamicos")[i].getElementsByTagName("select")[j];
                    for (l = 0; l < listaVoz.length; l++) {
                        clonElement = listaVoz[l].cloneNode(true);
                        elementopuesto22.add(clonElement);
                    }
                }
            }

            listaTags = listaReportes[i].getElementsByTagName("input");
            for (m = 0; m < listaTags.length; m++) {
                if (listaTags[m].id == "NumeroPersonasInvolucradas" || listaTags[m].id == "NumeroEquipos" || listaTags[m].id == "AreaPersonasInvolucradas" || listaTags[m].id == "AreaNumeroEquipos") {
                    listaTags[m].value = CargarIdiomaEtiqueta(listaTags[m].id);
                }
                if (listaTags[m].type == "button") {
                    if (listaTags[m].id !== "" && listaTags[m].id !== undefined) {
                        listaTags[m].value = CargarIdiomaEtiqueta(listaTags[m].id);
                    }
                }
                if (listaTags[m].id == "ColorCabello") {
                    var elementSelect = document.createElement('select');
                    elementSelect.setAttribute("id", listaTags[m].id);
                    elementSelect.setAttribute("class", listaTags[m].className);
                    listaTags[m].parentNode.replaceChild(elementSelect, listaTags[m]);

                    var option = document.createElement("option");
                    option.text = "...";
                    option.value = null;
                    elementSelect.add(option);

                    elementopuesto5 = elementSelect;
                    for (l = 0; l < listaColorCabello.length; l++) {
                        clonElement = listaColorCabello[l].cloneNode(true);
                        elementopuesto5.add(listaColorCabello[l]);
                    }
                }
                if (listaTags[m].id == "ColorPiel") {
                    var elementSelect = document.createElement('select');
                    elementSelect.setAttribute("id", listaTags[m].id);
                    elementSelect.setAttribute("class", listaTags[m].className);
                    listaTags[m].parentNode.replaceChild(elementSelect, listaTags[m]);

                    var option = document.createElement("option");
                    option.text = "...";
                    option.value = null;
                    elementSelect.add(option);

                    elementopuesto6 = elementSelect;
                    for (l = 0; l < listaColorPiel.length; l++) {
                        clonElement = listaColorPiel[l].cloneNode(true);
                        elementopuesto6.add(clonElement);
                    }
                }
                if (listaTags[m].id == "Complexion") {
                    var elementSelect = document.createElement('select');
                    elementSelect.setAttribute("id", listaTags[m].id);
                    elementSelect.setAttribute("class", listaTags[m].className);
                    listaTags[m].parentNode.replaceChild(elementSelect, listaTags[m]);

                    var option = document.createElement("option");
                    option.text = "...";
                    option.value = null;
                    elementSelect.add(option);

                    elementopuesto7 = elementSelect;
                    for (l = 0; l < listaComplexion.length; l++) {
                        clonElement = listaComplexion[l].cloneNode(true);
                        elementopuesto7.add(clonElement);
                    }
                }
                if (listaTags[m].id == "CumplePolitica") {
                    var elementSelect = document.createElement('select');
                    elementSelect.setAttribute("id", listaTags[m].id);
                    elementSelect.setAttribute("class", listaTags[m].className);
                    listaTags[m].parentNode.replaceChild(elementSelect, listaTags[m]);

                    var option = document.createElement("option");
                    option.text = "...";
                    option.value = null;
                    elementSelect.add(option);

                    elementopuesto8 = elementSelect;
                    for (l = 0; l < listaCumplePolitica.length; l++) {
                        clonElement = listaCumplePolitica[l].cloneNode(true);
                        elementopuesto8.add(clonElement);
                    }
                }
                if (listaTags[m].id == "Especialidad") {
                    var elementSelect = document.createElement('select');
                    elementSelect.setAttribute("id", listaTags[m].id);
                    elementSelect.setAttribute("class", listaTags[m].className);
                    listaTags[m].parentNode.replaceChild(elementSelect, listaTags[m]);

                    var option = document.createElement("option");
                    option.text = "...";
                    option.value = null;
                    elementSelect.add(option);

                    elementopuesto9 = elementSelect;
                    for (l = 0; l < listaEspecialidad.length; l++) {
                        clonElement = listaEspecialidad[l].cloneNode(true);
                        elementopuesto9.add(clonElement);
                    }
                }
                if (listaTags[m].id == "StatusCaja") {
                    var elementSelect = document.createElement('select');
                    elementSelect.setAttribute("id", listaTags[m].id);
                    elementSelect.setAttribute("class", listaTags[m].className);
                    listaTags[m].parentNode.replaceChild(elementSelect, listaTags[m]);

                    var option = document.createElement("option");
                    option.text = "...";
                    option.value = null;
                    elementSelect.add(option);

                    elementopuesto10 = elementSelect;
                    for (l = 0; l < listaEstatusCaja.length; l++) {
                        clonElement = listaEstatusCaja[l].cloneNode(true);
                        elementopuesto10.add(clonElement);
                    }
                }
                if (listaTags[m].id == "MedidaVoz") {
                    var elementSelect = document.createElement('select');
                    elementSelect.setAttribute("id", listaTags[m].id);
                    elementSelect.setAttribute("class", listaTags[m].className);
                    listaTags[m].parentNode.replaceChild(elementSelect, listaTags[m]);

                    var option = document.createElement("option");
                    option.text = "...";
                    option.value = null;
                    elementSelect.add(option);

                    elementopuesto12 = elementSelect;
                    for (l = 0; l < listaMedidaVoz.length; l++) {
                        clonElement = listaMedidaVoz[l].cloneNode(true);
                        elementopuesto12.add(clonElement);
                    }
                }
                if (listaTags[m].id == "Reincidente") {
                    var elementSelect = document.createElement('select');
                    elementSelect.setAttribute("id", listaTags[m].id);
                    elementSelect.setAttribute("class", listaTags[m].className);
                    listaTags[m].parentNode.replaceChild(elementSelect, listaTags[m]);

                    var option = document.createElement("option");
                    option.text = "...";
                    option.value = null;
                    elementSelect.add(option);

                    elementopuesto14 = elementSelect;
                    for (l = 0; l < listaReincidente.length; l++) {
                        clonElement = listaReincidente[l].cloneNode(true);
                        elementopuesto14.add(clonElement);
                    }
                }
                if (listaTags[m].id == "Respaldo") {
                    var elementSelect = document.createElement('select');
                    elementSelect.setAttribute("id", listaTags[m].id);
                    elementSelect.setAttribute("class", listaTags[m].className);
                    listaTags[m].parentNode.replaceChild(elementSelect, listaTags[m]);

                    var option = document.createElement("option");
                    option.text = "...";
                    option.value = null;
                    elementSelect.add(option);

                    elementopuesto15 = elementSelect;
                    for (l = 0; l < listaRespaldo.length; l++) {
                        clonElement = listaRespaldo[l].cloneNode(true);
                        elementopuesto15.add(clonElement);
                    }
                }
                if (listaTags[m].id == "RetiroValores") {
                    var elementSelect = document.createElement('select');
                    elementSelect.setAttribute("id", listaTags[m].id);
                    elementSelect.setAttribute("class", listaTags[m].className);
                    listaTags[m].parentNode.replaceChild(elementSelect, listaTags[m]);

                    var option = document.createElement("option");
                    option.text = "...";
                    option.value = null;
                    elementSelect.add(option);

                    elementopuesto16 = elementSelect;
                    for (l = 0; l < listaRetiroValores.length; l++) {
                        clonElement = listaRetiroValores[l].cloneNode(true);
                        elementopuesto16.add(clonElement);
                    }
                }
                if (listaTags[m].id == "TamanioCabello") {
                    var elementSelect = document.createElement('select');
                    elementSelect.setAttribute("id", listaTags[m].id);
                    elementSelect.setAttribute("class", listaTags[m].className);
                    listaTags[m].parentNode.replaceChild(elementSelect, listaTags[m]);

                    var option = document.createElement("option");
                    option.text = "...";
                    option.value = null;
                    elementSelect.add(option);

                    elementopuesto17 = elementSelect;
                    for (l = 0; l < listaTamanioCabello.length; l++) {
                        clonElement = listaTamanioCabello[l].cloneNode(true);
                        elementopuesto17.add(clonElement);
                    }
                }
                if (listaTags[m].id == "TesituraVoz") {
                    var elementSelect = document.createElement('select');
                    elementSelect.setAttribute("id", listaTags[m].id);
                    elementSelect.setAttribute("class", listaTags[m].className);
                    listaTags[m].parentNode.replaceChild(elementSelect, listaTags[m]);

                    var option = document.createElement("option");
                    option.text = "...";
                    option.value = null;
                    elementSelect.add(option);

                    elementopuesto18 = elementSelect;
                    for (l = 0; l < listaTesituraVoz.length; l++) {
                        clonElement = listaTesituraVoz[l].cloneNode(true);
                        elementopuesto18.add(clonElement);
                    }
                }
                if (listaTags[m].id == "TipoCabello") {
                    var elementSelect = document.createElement('select');
                    elementSelect.setAttribute("id", listaTags[m].id);
                    elementSelect.setAttribute("class", listaTags[m].className);
                    listaTags[m].parentNode.replaceChild(elementSelect, listaTags[m]);

                    var option = document.createElement("option");
                    option.text = "...";
                    option.value = null;
                    elementSelect.add(option);

                    elementopuesto20 = elementSelect;
                    for (l = 0; l < listaTipoCabello.length; l++) {
                        clonElement = listaTipoCabello[l].cloneNode(true);
                        elementopuesto20.add(clonElement);
                    }
                }
                if (listaTags[m].id == "Voz") {
                    var elementSelect = document.createElement('select');
                    elementSelect.setAttribute("id", listaTags[m].id);
                    elementSelect.setAttribute("class", listaTags[m].className);
                    listaTags[m].parentNode.replaceChild(elementSelect, listaTags[m]);

                    var option = document.createElement("option");
                    option.text = "...";
                    option.value = null;
                    elementSelect.add(option);

                    elementopuesto22 = elementSelect;
                    for (l = 0; l < listaVoz.length; l++) {
                        clonElement = listaVoz[l].cloneNode(true);
                        elementopuesto22.add(clonElement);
                    }
                }
            }
        }
    }

    function AgregarReporteBase() {
        var tReporter = document.getElementById("cbTipoReporte").value;
        var sNUno = document.getElementById("cbSubNivelUno").value;
        var sNDos = document.getElementById("cbSubNivelDos").value;
        var sNTres = document.getElementById("cbSubNivelTres").value;
        var sNCuatro = document.getElementById("cbSubNivelCuatro").value;
        if (tReporter == "null") {
            tReporter = "";
        }
        if (sNUno == "null") {
            sNUno = "";
        }
        if (sNDos == "null") {
            sNDos = "";
        }
        if (sNTres == "null") {
            sNTres = "";
        }
        if (sNCuatro == "null") {
            sNCuatro = "";
        }

        var SReporte = tReporter.trim() + sNUno.trim() + sNDos.trim() + sNTres.trim() + sNCuatro.trim();
        var cadenaIntegrar = "";

        $.ajax({
            url: _spPageContextInfo.webAbsoluteUrl + "/_api/web/lists/getbytitle('HTMLReportes')/Items?$select=HTML&$filter=Title eq '" + encodeURIComponent(SReporte) + "'&$top=1",
            type: "GET",
            async: false,
            headers: { "accept": "application/json;odata=verbose" },
            success: function (data) {
                if (data.d.results.length > 0) {
                    console.log("Encontro datos");
                    var d = document.getElementById("ReportesDinamicos");
                    while (d.hasChildNodes()) {
                        d.removeChild(d.firstChild);
                    }
                    numeroIncidencia = 0;
                    cadenaId = tReporter.trim() + "_" + sNUno.trim() + "_" + sNDos.trim() + "_" + sNTres.trim() + "_" + sNCuatro.trim();
                    cadenaIntegrar = "<div id='Reporte_0' class='BloqueReportesDinamicos'>";
                    cadenaIntegrar += " <div class='col-xs-12 col-sm-12 col-md-12 col-lg-12'>";
                    cadenaIntegrar += "   <label class='control-label'>";
                    cadenaIntegrar += tReporter.trim() + "/" + sNUno.trim() + "/" + sNDos.trim() + "/" + sNTres.trim() + "/" + sNCuatro.trim();
                    cadenaIntegrar += "   </label>";
                    cadenaIntegrar += "   <br/>";
                    cadenaIntegrar += "  <div class='col-xs-1 col-sm-1 col-md-1 col-lg-1'>";
                    cadenaIntegrar += "   <input id= 'btnEliminarReporteIncidencia' class='form-control' onclick=\"EliminarReporteIncidencia(this)\" value='X' type='button'>";
                    cadenaIntegrar += "  </div>";
                    cadenaIntegrar += " </div>";
                    cadenaIntegrar += "</div>";

                    $("#ReportesDinamicos").append(cadenaIntegrar);
                    $("#Reporte_" + numeroIncidencia + "").append(data.d.results[0].HTML);
                    numeroIncidencia++;
                    CargarIdiomaUsuario(pais);
                    actualizarControlFecha();
                }
            },
            error: function (xhr) {
                console.log(xhr.status + ': ' + xhr.statusText);
            }
        });
    }

    function AgregarReporteAdicional() {
        var tReporter = document.getElementById("cbTipoReporteAdicional").value;
        var sNUno = document.getElementById("cbSubNivelUnoAdicional").value;
        var sNDos = document.getElementById("cbSubNivelDosAdicional").value;
        var sNTres = document.getElementById("cbSubNivelTresAdicional").value;
        var sNCuatro = document.getElementById("cbSubNivelCuatroAdicional").value;
        if (tReporter == "null") {
            tReporter = "";
        }
        if (sNUno == "null") {
            sNUno = "";
        }
        if (sNDos == "null") {
            sNDos = "";
        }
        if (sNTres == "null") {
            sNTres = "";
        }
        if (sNCuatro == "null") {
            sNCuatro = "";
        }

        var SReporte = tReporter.trim() + sNUno.trim() + sNDos.trim() + sNTres.trim() + sNCuatro.trim();
        var cadenaIntegrar = "";

        $.ajax({
            url: _spPageContextInfo.webAbsoluteUrl + "/_api/web/lists/getbytitle('HTMLReportes')/Items?$select=HTML&$filter=Title eq '" + encodeURIComponent(SReporte) + "'&$top=1",
            type: "GET",
            async: false,
            headers: { "accept": "application/json;odata=verbose" },
            success: function (data) {
                if (data.d.results.length > 0) {
                    console.log("Encontro datos");
                    cadenaId = tReporter.trim() + "_" + sNUno.trim() + "_" + sNDos.trim() + "_" + sNTres.trim() + "_" + sNCuatro.trim();
                    cadenaIntegrar = "<div id=Reporte_" + cadenaId + " class='BloqueReportesDinamicos'>";
                    cadenaIntegrar += " <div class='col-xs-12 col-sm-12 col-md-12 col-lg-12'>";
                    cadenaIntegrar += "   <label class='control-label'>";
                    cadenaIntegrar +=       tReporter.trim() + "/" + sNUno.trim() + "/" + sNDos.trim() + "/" + sNTres.trim() + "/" + sNCuatro.trim();
                    cadenaIntegrar += "   </label>";
                    cadenaIntegrar += "   <br/>";
                    cadenaIntegrar += "  <div class='col-xs-1 col-sm-1 col-md-1 col-lg-1'>";
                    cadenaIntegrar += "   <input id='btnEliminarReporteIncidencia' class='form-control' onclick=\"EliminarReporteIncidencia(this)\" value='X' type='button'>";
                    cadenaIntegrar += "  </div>";
                    cadenaIntegrar += " </div>";
                    cadenaIntegrar += "</div>";
                    $("#ReportesDinamicos").append(cadenaIntegrar);
                    $("#Reporte_" + cadenaId + "").append(data.d.results[0].HTML);
                    numeroIncidencia++;
                    CargarIdiomaUsuario(pais);
                    CargarReportes("cbTipoReporteAdicional");
                    $('#modalReporteAdicional').modal('hide');
                    actualizarControlFecha();
                }
            },
            error: function (xhr) {
                console.log(xhr.status + ': ' + xhr.statusText);
            }
        });
    }

    function EliminarReporteIncidencia(nombreElemento) {
        elementoPadre = nombreElemento.parentNode;
        elementoPadrePadre = elementoPadre.parentNode;
        elementoPadrePadrePadre = elementoPadrePadre.parentNode;
        elementoPadrePadrePadre.parentNode.removeChild(elementoPadrePadrePadre);
    }

    function EliminarBloqueDuplicacion(element) {
        elementParent = element.parentNode;
        elementParent.parentNode.removeChild(elementParent);
    }

    function RegistrosUnicos(lista) {
        var unicos = [];
        for (i = 0; i < lista.length; i++) {
            pos = 0;
            bandera = false;
            for (j = 0; j < unicos.length; j++) {
                if (lista[i][0] === unicos[j][0]) {
                    bandera = true;
                    break;
                }
                pos = i;
            }
            if (bandera == false) {
                unicos.push([lista[pos][0], lista[pos][1]]);
            }
        }
        return unicos;
    }

    function getUserInfo() {
        var listaCorreos = [];
        var peoplePicker = this.SPClientPeoplePicker.SPClientPeoplePickerDict.peoplePickerDiv_TopSpan;
        var users = peoplePicker.GetAllUserInfo();
        var userInfo = '';
        for (var i = 0; i < users.length; i++) {
            var user = users[i];
            listaCorreos.push(user.EntityData.Email.toString());
        }
        return listaCorreos;
    }

    function ValidarCamposObligatorios(listadinamica) {
        bandera = false;
        for (j = 0; j < listadinamica.length; j++) {
            listaBloques = ObtenerValoresGuardarDinamicos(listadinamica[j][1]);
            for (k = 0; k < listaBloques.length - 1; k++) {
                listaEstaticos = listaBloques[k];
                for (l = 0; l < listaEstaticos.length; l++) {
                    listaRegistro = listaEstaticos[l];
                    for (m = 0; m < listaRegistro.length; m++) {
                        if (listaRegistro[m] !== undefined) {
                            if (listaRegistro[m][1] === "") {
                                bandera = true;
                                break;
                            }
                        }
                    }
                }
            }
        }
        for (n = 0; n < listadinamica.length; n++) {
            listaBloques = ObtenerValoresGuardarDinamicos(listadinamica[n][1]);
            listaEstaticos = listaBloques[5];
            for (o = 0; o < listaEstaticos.length; o++) {
                console.log(listaEstaticos[o][1]);
                if (listaEstaticos[o][1] === "") {
                    bandera = true;
                    break;
                }
            }
        }
        return bandera;
    }

    function CrearTablaEnvio(folioGenerado, listaestatica, listadinamica) {
        var tablaEnviar = document.createElement("table");
        tablaEnviar.setAttribute("color", "#FF0000");

        for (i = 0; i < listaestatica.length; i++) {
            var tr = tablaEnviar.insertRow(i);
            var td = tr.insertCell(0);
            td.innerHTML = document.getElementById(listaestatica[i][1]).innerHTML;
            var td2 = tr.insertCell(1);
            td2.innerHTML = listaestatica[i][0];
            tablaEnviar.appendChild(tr);
        }

        for (j = 0; j < listadinamica.length; j++) {

            listaBloques = ObtenerValoresGuardarDinamicos(listadinamica[j][1]);

            listaEstaticos = listaBloques[5];
            for (z = 0; z < listaEstaticos.length; z++) {
                try{
                var tr = tablaEnviar.insertRow(z);
                var td = tr.insertCell(0);
                td.innerHTML = listaEstaticos[z][0];
                var td2 = tr.insertCell(1);
                td2.innerHTML = listaEstaticos[z][1];
                tablaEnviar.appendChild(tr);
                }
                catch (err) { alert(err.message); }
            }

            listaEstaticos = listaBloques[0];
            
            for (l = 0; l < listaEstaticos.length; l++) {
                var tr = tablaEnviar.insertRow(l);
                var td = tr.insertCell(0);
                td.innerHTML = document.getElementById(listaestatica[l][0]);
                
                var td2 = tr.insertCell(1);
                td2.innerHTML = listaestatica[l][1];
                
                tablaEnviar.appendChild(tr);
            }
            
            listaEstaticos = listaBloques[1];
            for (l = 0; l < listaEstaticos.length; l++) {
                var tr = tablaEnviar.insertRow(l);
                var td = tr.insertCell(0);
                td.innerHTML = document.getElementById(listaestatica[l][0]);
                var td2 = tr.insertCell(1);
                td2.innerHTML = listaestatica[l][1];
                
                tablaEnviar.appendChild(tr);
            }

            listaEstaticos = listaBloques[2];
            for (l = 0; l < listaEstaticos.length; l++) {
                var tr = tablaEnviar.insertRow(l);
                var td = tr.insertCell(0);
                td.innerHTML = document.getElementById(listaestatica[l][0]);
                
                var td2 = tr.insertCell(1);
                td2.innerHTML = listaestatica[l][1];
                
                tablaEnviar.appendChild(tr);
            }

            listaEstaticos = listaBloques[3];
            for (l = 0; l < listaEstaticos.length; l++) {
                var tr = tablaEnviar.insertRow(l);
                var td = tr.insertCell(0);
                td.innerHTML = document.getElementById(listaestatica[l][0]);
                
                var td2 = tr.insertCell(1);
                td2.innerHTML = listaestatica[l][1];
                
                tablaEnviar.appendChild(tr);
            }

            listaEstaticos = listaBloques[4];
            for (l = 0; l < listaEstaticos.length; l++) {
                var tr = tablaEnviar.insertRow(l);
                var td = tr.insertCell(0);
                td.innerHTML = document.getElementById(listaestatica[l][0]);
                
                var td2 = tr.insertCell(1);
                td2.innerHTML = listaestatica[l][1];
                
                tablaEnviar.appendChild(tr);
            }
        }
        return tablaEnviar;
    }

</script>