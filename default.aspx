<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="kmismvc._default"  %>
<%@ Import Namespace="GMatrix.KMIS.Core.Negocio" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>KMIS</title>

    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="scripts/tab/tab.css" type="text/css" media="screen" />
    <link href="scripts/jquery/css/jquery-ui.css" rel="stylesheet" />
	<script type="text/javascript" src="Scripts/Validacion.js?I=6"></script>
    <script type="text/javascript" src="scripts/kmvalidacionJS.js?I=1"></script>
    <script src="scripts/Utils/ZeroJs.js?I=1"></script>
    <!-- CSS -->
    <link href="https://framework-gb.cdn.gob.mx/favicon.ico" rel="shortcut icon">
    <link href="https://framework-gb.cdn.gob.mx/assets/styles/main.css" rel="stylesheet">
    <link rel="stylesheet" href="scripts/bootstrap/css/bootstrap-datetimepicker.css" />

    <!-- Respond.js soporte de media queries para Internet Explorer 8 -->
    <!-- ie8.js EventTarget para cada nodo en Internet Explorer 8 -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
      <script src="https://cdnjs.cloudflare.com/ajax/libs/ie8/0.2.2/ie8.js"></script>
    <![endif]-->
</head>
<body id="objBody" runat="server">
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" EnablePartialRendering="true" runat="server" EnableScriptGlobalization="True"/>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
        <script type="text/javascript" src="scripts/jquery/js/jquery-ui.js" charset="utf-8"></script>
        <script src="scripts/bootstrap/js/bootstrap-filestyle.min.js"></script>
        <script src="https://framework-gb.cdn.gob.mx/gobmx.js"></script>
        <script src="https://framework-gb.cdn.gob.mx/assets/scripts/jquery-ui-datepicker.js"></script>
        <script type="text/javascript" src="scripts/moment/js/moment-with-locales.min.js" charset="utf-8"></script>
        <script type="text/javascript" src="scripts/moment/js/locale/es.js" charset="utf-8"></script>
        <script type="text/javascript" src="scripts/bootstrap/js/bootstrap-datetimepicker.min.js" charset="utf-8"></script>
        
        <script type="text/javascript">
            var kmjc = null;
        </script>
        <script type="text/javascript">
            var applicationBaseUrl = '<%= new WebControlBase().ObtenValorConfigSistema("URLHttp") %>';
        </script>
<a id="divTop">  </a>
        <!-- Contenido -->
        <main class="main">
            <nav id="divBarra" runat="server"></nav>
            <!-- Div para el mensaje de alerta -->
            <div id="divAlertaPadre" class="hidden">
                <br /><br />
                <div id="divAlerta" class="alert alert-danger">
                </div>
            </div>
            <div id="divModulo"></div>
            <div class="container" id="divContenido" runat="server">
                <img src="images/core/cargando_grande.gif" style="display:none; width:400px; text-align:center;" id="imgEspera" name="imgEspera" align="center" />
                <div style="display:none;">
                    <ol class="breadcrumb">
                        <li><a href="#"><i class="icon icon-home"></i></a></li>
                        <li><a href="#">Inicio</a></li>
                        <li class="active">Archivo</li>
                    </ol>
                </div>
            </div>
        </main>

        <div class="modal fade" id="divModal" name="divModal" role="dialog" aria-labelledby="gridSystemModalLabel">
          <div class="modal-dialog">
            <div class="modal-content">
              <div class="modal-header">
                <h4 class="modal-title"><span id="lblTituloModal" name="lblTituloModal">KMIS</span> <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button></h4>
              </div>
              <div class="modal-body">
                <iframe id="frmModal" name="frmModal" width="100%" frameborder="0" style=""></iframe>
                <ol id="divModalContenido" name="divModalContenido" style="width:100%;"></ol>
              </div>
            </div><!-- /.modal-content -->
          </div><!-- /.modal-dialog -->
        </div><!-- /.modal -->
        <div style="display:none;">
            <asp:TextBox ID="txtMVCPath" runat="server"></asp:TextBox>
            <asp:TextBox ID="txtMVCID" runat="server"></asp:TextBox>
            <input type="text" id="txtIDUrl" name="txtIDUrl" value="<%=Request.QueryString["ID"] %>" />
            <input type="text" id="txtSes" name="txtSes" value="00:<%=Session.Timeout-1 %>:59" />
        </div>
    </form>

    <script type="text/javascript">
        //Precargamos la imagen
        var idUs = '<%=Session["Usuario"] != null ? Session["Usuario"].ToString() : "" %>';
        var strTOrig = '';
        var objImagen = new Image();
        objImagen.src = "images/core/cargando.gif";
        //Cargamos los datos cuando el browser este listo
        $gmx(document).ready(function () {
            kmjc = $;
            //kmjc = $.noConflict();
            var strMVCPath = document.getElementById('<%=txtMVCPath.ClientID%>').value;
            var strMVCID = document.getElementById('<%=txtMVCID.ClientID%>').value;
            var strPta = '<%=Request.QueryString["Pta"] %>';
            var arrPath = strMVCPath.split('|');
            var arrID = strMVCID.split('|');
            for (i = 0; i < arrPath.length; i++) {
                kmjc("#div" + arrID[i]).load(arrPath[i] + "?id=" + arrID[i] + "&IDUrl=" + document.getElementById("txtIDUrl").value + "&Pta=" + strPta);
            }
            Reloj();
            //MandaAcuse();
        });

        function MandaAcuse() {
            var strURL = window.location.href;
            if (strURL.indexOf("IDRec") >= 0) {
                strURL = strURL.split('?')[1];
                var arrID = strURL.split('&');
                for (i = 0; i < arrID.length; i++) {
                    if (arrID[i].indexOf("Pta") >= 0) {
                        var strID = arrID[i].split('=')[1];
                        strID = strID.replace("IDRec|", "");
                        var sRuta = 'procesoRecibo/MostrarReciboProceso/?GUIDProceso=' + strID + '&pGUIDModulo=divModulo';
                        AbrirModalIndexMVC('Modulo', sRuta);
                    }
                }
            }
        }
        function AbrirModalIndex2(Titulo, RutaEditar, RutaPadre, GUIDElemento, GUIDModulo, GUIDIdioma) {
            var strURL = "km/Editar.aspx?RutaEditar=" + RutaEditar + "&RutaPadre=" + RutaPadre + "&GUIDModulo=" + GUIDModulo + "&GUIDIdioma=" + GUIDIdioma + "&GUIDElemento=" + GUIDElemento;
            AbrirModalIndex(Titulo, strURL);
        }


        function AbrirModalIndex(pstrTitulo, pstrURL) {
            document.getElementById("frmModal").src = "";
            kmjc("#divModal").find('.modal-body').css('height', $(window).height() * .9);
            kmjc("#divModal").find('.modal-dialog').css('width', $(window).width() * .95);
            kmjc("#frmModal").css('height', $(window).height() * .8);
            //$("#divModal").css('width', $(window).width() * .9);
            document.getElementById("lblTituloModal").innerHTML = pstrTitulo;
            if (pstrURL.indexOf("?") >= 0)
                pstrURL += "&IDUrl=" + document.getElementById("txtIDUrl").value;
            else
                pstrURL += "?IDUrl=" + document.getElementById("txtIDUrl").value;
            document.getElementById("frmModal").src = pstrURL;
            //kmjc("#divModalContenido").load(pstrURL);
            kmjc("#divModal").modal("show");
        }

        function AbrirModalIndexMVC(pstrGUID, pstrURL) {
            alert("Wtf");
            document.getElementById("imgEspera").style.display = "";
            document.getElementById("div" + pstrGUID).innerHTML = "";
            if (pstrURL.indexOf("?") >= 0)
                pstrURL += "&IDUrl=" + document.getElementById("txtIDUrl").value;
            else
                pstrURL += "?IDUrl=" + document.getElementById("txtIDUrl").value;
            $("#div" + pstrGUID).load(pstrURL, function () {
                document.getElementById("imgEspera").style.display = "none";
            });
            //kmjc("#div" + pstrGUID).load(pstrURL);
        }

        function OcultaDetalle() {
            document.getElementById("frmModal").src = "";
            kmjc("#divModal").modal("hide");
        }
        function OcultaDetalleRefresca(pstrFuncion) {
            OcultaDetalle();
            if (pstrFuncion != "")
                setTimeout(pstrFuncion, 1);
            else
                window.location.href = window.location.href;
        }

        function CerrarSesion() {
            window.location.href = "LogOut.aspx";
        }

        

        //funciones para la validación de formatos
        function EstadoBoton(pstrID, blnEstado) {
            if (blnEstado)
                document.getElementById(pstrID).style.display = "";
            else
                document.getElementById(pstrID).style.display = "none";
        }
        function ValidarRequerido(pstrBotonEvento) {
            var strCamMen = "";
            var strCampoID = "";
            var strCampoIDQuitar = "";
            var strSep = "";
            var strSepID = "";
            var strSepIDQuitar = "";
            var blnRegreso = true;
            var strDivMensaje = "divAlerta";
            var strDivMensajePadre = "divAlertaPadre";
            if (document.getElementById(strDivMensaje + "GP") != null) {
                strDivMensaje = "divAlertaGP";
                strDivMensajePadre = "divAlertaPadreGP";
            }
  
            try {
                //mnavarro: para controles rtb en plantillas html
                var strControles = "";
                //Tomamos todos los nodos requeridos
                var arrCaja = $("h6");
                //Concatenamos los valores
                for (i = 0; i < arrCaja.length; i++)
                    if (arrCaja[i].innerHTML != "")
                        strControles += "," + arrCaja[i].innerHTML;
                //Si al menos traemos un control.
                if (strControles != "") {
                    //Si tiene texto esta caja entonces significa que se deben verificar requeridos
                    var colControles = strControles.split(",");
                    var objControlValidar = null;
                    //var objEtiqReq = null;

                    for (i = 0; i <= colControles.length - 1; i++) {
                        if (colControles[i] != "") {
                            //Tomamos el control que vamos a validar
                            objControlValidar = document.getElementById(colControles[i].split("|")[0]);
                            //Verificamos si este campo tiene valor
                            if (objControlValidar != null && objControlValidar.value == "") {
                                blnRegreso = false;
                                strCamMen += strSep + colControles[i].split("|")[1];
                                strCampoID += strSepID + colControles[i].split("|")[0]
                                strSep = ", ";
                                strSepID = "|";
                            }
                            else {
                                strCampoIDQuitar += strSepIDQuitar + colControles[i].split("|")[0];
                                strSepIDQuitar = "|";
                            }
                        }
                    }
                }
                else
                    blnRegreso = true;
            }
            catch (objError) {
                blnRegreso = false;
                alert(objError.description);
            }
            MensajeAlerta(false, strDivMensajePadre, strDivMensaje, "", "");
            //Quitamos los que ya esten llenos
            var arrCQuitar = strCampoIDQuitar.split('|');
            for (a = 0; a < arrCQuitar.length; a++) {
                var sIdCont = "gmCont" + arrCQuitar[a].split('_')[2];
                if (document.getElementById(sIdCont))
                    kmjc("#" + sIdCont).removeClass("form-group has-error has-feedback");
                sIdCont = "divTReq" + arrCQuitar[a].split('_')[2];
                if (document.getElementById(sIdCont))
                    document.getElementById(sIdCont).style.display = "none";
            }
            if (blnRegreso == false) {
                EstadoBoton(pstrBotonEvento, true);
                //Agregamos el codigo para marcar los requeridos
                var arrMensaje = strCamMen.split('|');
                var arrControl = strCampoID.split('|');
                for (i = 0; i < arrControl.length; i++) {
                    //Recorremos para poner la clase
                    var sIdCont = "gmCont" + arrControl[i].split('_')[2];
                    if (document.getElementById(sIdCont))
                        kmjc("#" + sIdCont).addClass("form-group has-error has-feedback");
                    sIdCont = "divTReq" + arrControl[i].split('_')[2];
                    if (document.getElementById(sIdCont))
                        document.getElementById(sIdCont).style.display = "";
                }
                //Enviamos mensaje
                MensajeAlerta(true, strDivMensajePadre, strDivMensaje, "Los datos marcados con asterisco (*) son requeridos: " + strCamMen, "divTop");
            }
            if (!blnRegreso)
                EstadoBoton(pstrBotonEvento, true);

            return blnRegreso;
        }

        function MensajeAlerta(blnMostrar, strDivContenedor, strDivMensaje, strMensaje, strFoco) {
            document.getElementById(strDivMensaje).innerHTML = "<span class=\"close\" aria-label=\"cerrar\" title=\"cerrar\" onclick=\"javascript:MensajeAlerta(false, '" + strDivContenedor + "', '" + strDivMensaje + "', '" + strMensaje + "', '" + strFoco + "')\">×</span>" + strMensaje;
            //Mostramos u ocultamos
            if(blnMostrar==false)
                kmjc("#" + strDivContenedor).addClass("hidden");
            else
                kmjc("#" + strDivContenedor).removeClass("hidden");
            //Colocamos foco
            if (strFoco != "")
            {
                window.location.hash = "#gral";
                window.location.hash = "#" + strFoco;
            }
            else
                window.scrollTo(0, 0);      //Dirigimos al inicio de la pagina
        }

        function RemimensionaIframe(pstrIframe) {
            $("#" + pstrIframe).load(function () {
                var intTotal = (this.contentWindow.document.body.offsetHeight * 1) + 200;
                this.style.height = intTotal + 'px';
            })
        }


        function Cerrar() {
            window.location.href = "logout.aspx";
        }
        function Reloj() {
            var txt;
            txt = document.getElementById("txtSes").value;
            if (idUs != "" && idUs != "2" && txt != "") {
                if (strTOrig == "")
                    strTOrig = txt;
                var Cadena = txt.split(":");

                var intHora = parseInt(Cadena[0]);
                var intMin = parseInt(Cadena[1]);
                var intSeg = parseInt(Cadena[2]);

                if (intSeg == 0 && intMin > 0) {
                    intSeg = 59;
                    if (intMin == 0) {
                        intMin = 59;
                        intHora--;
                    }
                    else
                        intMin--;
                }
                else
                    intSeg--;

                document.getElementById("txtSes").value = intHora + ":" + intMin + ":" + intSeg;

                if (intSeg == -10 && intMin == 0 && intHora == 0)
                    Cerrar();
                else
                    setTimeout("Reloj()", 1000);
            }
        }
        function ReiniciarConteo() {
            document.getElementById("txtSes").value = strTOrig;
        }



    </script>
    <script type="text/javascript">
        $(document).keypress(function (e) {
            return !(e.which === 13
                && e.target.tagName.toUpperCase() !== "TEXTAREA"
                && e.target.id !== "txtLogin" 
                && e.target.id !== "txtPassword");
        });
    </script>
</body>
</html>
