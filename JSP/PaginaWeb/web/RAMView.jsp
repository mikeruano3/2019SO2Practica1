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
            
            var updateInterval = 600;
            var intervalo;
            var cola = [];
            $( document ).ready(function() {
                intervalo =  setInterval(funcionIntervalor, updateInterval);
            });

            var funcionIntervalor = function(){
                $.ajax({
                    url:"/PaginaWeb/Mem",
                    type: 'GET',
                    // DATOS PARA MANDAR AL SERVIDOR
                    data: {
                        "tipo": "VACIO"
                    },
                    dataType: 'json',
                    success : function(data){
                                                
                        /**** CODIGO PARA MOSTRAR EL USO DEL CPU ****/
                        
                        var MemTotal = 0, MemFree = 0, MemAvailable = 0, Buffers = 0;
                        var librePorc = 0;
                        try{
                            //cpuinfo = JSON.parse(data);
                            var meminfo = data;
                            MemTotal = meminfo.MemTotal;
                            MemFree = meminfo.MemFree;
                            MemAvailable = meminfo.MemAvailable;
                            Buffers = meminfo.Buffers;
                            
                            var PorcMem = (MemTotal-MemFree)*100/MemTotal;
                            var KBMem = MemTotal-MemFree;
                            //alert(idled+ ", "+CPU_Percentage);
                            document.getElementById("usadoPorc").innerHTML = "Porcentaje: " + PorcMem + "%";
                            document.getElementById("usadoKB").innerHTML = "Memoria Usada: " + KBMem + " KB";
                            document.getElementById("memTotal").innerHTML = "Memoria Total: " + MemTotal + " KB";
                            cola.push(PorcMem);
                            
                        }catch(err){
                            console.log(err);
                        }
                        
                        /********************************************/
                    },
                    error: function(XMLHttpRequest, textStatus, errorThrown) {
                        //clearInterval(intervalo);
                    }
                });
            };
            
            //$.plot($("#placeholder"), [ [[0, 0], [1, 1]] ], { yaxis: { max: 1 } });

            var totalPoints = 300;

            function getRandomData() {

                var puntoerror = 50;
                  if(cola.length > 0){
                       puntoerror = cola[cola.length-1];
                   }	 
                if (cola.length > 0)
                    cola = cola.slice(1); //quitar el ultimo
                    //pedazo desde la posicion 1

                // Do a random walk
                /*
                while (data.length < totalPoints) {

                    var prev = data.length > 0 ? data[data.length - 1] : 50,
                        y = prev + Math.random() * 10 - 5;

                    if (y < 0) {
                        y = 0;
                    } else if (y > 100) {
                        y = 100;
                    }  

                    data.push(y);
                }*/
               
                while (cola.length < totalPoints) {
                    cola.push(puntoerror);
                }
                // Zip the generated y values with the x values

                var res = [];
                for (var i = 0; i < cola.length; ++i) {
                    res.push([i, cola[i]]);
                }
                return res;
            }

            function puntosInicio() {
                var res = [];
                for (var i = 0; i < totalPoints; ++i) {
                    res.push([i, 0]);
                }
                return res;
            }

            // Set up the control widget


            $("#updateInterval").val(updateInterval).change(function () {
                var v = $(this).val();
                if (v && !isNaN(+v)) {
                    updateInterval = +v;
                    if (updateInterval < 1) {
                        updateInterval = 1;
                    } else if (updateInterval > 2000) {
                        updateInterval = 2000;
                    }
                    clearInterval(intervalo);
                    intervalo =  setInterval(funcionIntervalor, updateInterval);
                    $(this).val("" + updateInterval);
                }
            });

            var plot = $.plot("#placeholder", [ puntosInicio() ], {
                series: {
                    shadowSize: 10	// Drawing is faster without shadows
                },
                yaxis: {
                    min: 0,
                    max: 100
                },
                xaxis: {
                    show: false
                }
            });

            function update() {
                plot.setData([getRandomData()]);

                // Since the axes don't change, we don't need to call plot.setupGrid()

                plot.draw();
                setTimeout(update, updateInterval);
            }

            update();
            // Add the Flot version string to the footer
            $("#footer").prepend("Flot " + $.plot.version + " &ndash; ");
});
 
        </script>
        
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Uso del CPU</title>
    </head>
    <body>
        <h1>Memoria Usada</h1>
            <div id="content"></div>
               <h3 id="usadoKB"> </h3>
               <h3 id="usadoPorc"> </h3>
               <h3 id="memTotal"> </h3>
               
               <div id="placeholder" style="width:800px;height:600px"></div>
               
               <input id="updateInterval" type="text" value="" style="text-align: right" width:5em>
                   
               </input>
    </body>
</html>
