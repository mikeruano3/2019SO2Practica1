<%-- 
    Document   : RAMView
    Created on : 22/02/2019, 03:26:33 PM
    Author     : miguel
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <script type="text/javascript" src="jstyle/bootstrap.js"></script>
        <script type="text/javascript" src="jstyle/bootstrap.min.js"></script>
        <script type="text/javascript" src="jstyle/jquery-3.3.1.min.js"></script>
        <script type="text/javascript" src="jstyle/jquery.flot.js"></script>
        <link rel="stylesheet" href="estilo/style.css">
        <script type="text/javascript">
           $(function() {
    
    $( document ).ready(function() {
        recogerValordesdeServidor();
    });
    function recogerValordesdeServidor() {
         var funcionIntervalor = function(){
            $.ajax({
                url:"/PaginaWeb/Procesos",
                type: 'GET',
                // DATOS PARA MANDAR AL SERVIDOR
                data: {
                    "tipo": "VACIO"
                },
                dataType: 'json',
                success : function(data){
                        var i, jk, html, iteml, memxproc;
                        html = "";
                        document.getElementById("listado").innerHTML = "";
                        var total = 0;
                        var lista = data.lista;
                        
                        var EnEjecucion = 0, Suspendido = 0, Ininterrumpido = 0, Detenido = 0, Zombie = 0;
                        for (jk = 0; jk < lista.length - 1; jk++){
                            var num = parseFloat(lista[jk].MEM);
                            if(num === NaN){
                                total = total + 0;
                            }else{
                                total = total + parseFloat(lista[jk].MEM);
                            }
                            
                            if(lista[jk].STATUS === "RUNNING"){
                                    EnEjecucion++;
                            }
                            if(lista[jk].STATUS === "INTERRUPTIBLE"){
                                    Suspendido++;
                            }
                            if(lista[jk].STATUS === "UNINTERRUPTIBLE"){
                                    Ininterrumpido++;
                            }
                            if(lista[jk].STATUS === "STOPPED"){
                                    Detenido++;
                            }
                            if(lista[jk].STATUS === "ZOMBIE" || lista[jk].STATUS === "SWAPPING"){
                                    Zombie++;
                            }
                            
                        }
                        for (i = 0; i < lista.length - 1; i++) {
                            var num1 = parseFloat(lista[i].MEM);
                            if (num1 === NaN){
                                num1 = 0;
                            }
                            html += "<tr>";
                            html  += '<td>' +lista[i].NAME + '</td>';
                            html  += '<td>' + lista[i].USER + '</td>';
                            html  += '<td>' + lista[i].PID + '</td>';
                            html  += '<td>' + lista[i].STATUS + '</td>';
                            html  += '<td>' + num1 + '</td>';
                            html  += '<td>' + lista[i].CPU + '</td>';
                            html  += '<td><a class="btn btn-danger" href="/PaginaWeb/Matar?processid='+ lista[i].PID+'">Matar</a></td>';
                            html += '</tr>';
                        }
                        document.getElementById("listado").innerHTML = html;
                        
                        document.getElementById("Total").innerHTML = "Total: " + lista.length;                
                        document.getElementById("EnEjecucion").innerHTML = "EnEjecucion: " + EnEjecucion;
                        document.getElementById("Suspendido").innerHTML = "Suspendido: " + Suspendido;
                        document.getElementById("Ininterrumpido").innerHTML = "Ininterrumpido: " + Ininterrumpido;
                        document.getElementById("Detenido").innerHTML = "Detenido: " + Detenido;
                        document.getElementById("Zombie").innerHTML = "Zombie: " + EnEjecucion;
                    
                },
                error: function(XMLHttpRequest, textStatus, errorThrown) {
                    //clearInterval(intervalo);
                }
            });

        };
        intervalo =  setInterval(funcionIntervalor, 1000);
    }
});
        </script>
        
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Uso del CPU</title>
    </head>
    <body>
        <h1>Procesos</h1>
            <h3 id="Total"> </h3>
            <h3 id="EnEjecucion"> </h3>
            <h3 id="Suspendido"> </h3>
            <h3 id="Ininterrumpido"> </h3>
            <h3 id="Detenido"> </h3>
            <h3 id="Zombie"> </h3>
        <h2>Listado de Procesos</h2>
            <div class="table table-responsive"></div>
                
            <table>
                <thead>
                    <tr>
                        <th> Nombre </th>
                        <th> Usuario </th>
                        <th> Pid </th>
                        <th> Estado </th>
                        <th> RAM </th>
                        <th> CPU </th>
                        <th> Accion </th>
                    </tr>
                </thead>
                <tbody id="listado">
                    
                </tbody>
            </table>
    </body>
</html>
