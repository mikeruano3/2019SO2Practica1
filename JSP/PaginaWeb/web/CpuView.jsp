<%-- 
    Document   : CpuView
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
                    url:"/PaginaWeb/Cpu",
                    type: 'GET',
                    // DATOS PARA MANDAR AL SERVIDOR
                    data: {
                        "tipo": "VACIO"
                    },
                    dataType: 'json',
                    success : function(data){
                        if(data.tipo === "NORMAL"){
                            var i, html, iteml;
                        }
                        
                        
                        /**** CODIGO PARA MOSTRAR EL USO DEL CPU ****/
                        
                        var USER = 0, NICE = 0, SYSTEM = 0, IDLE = 0, IOWAIT = 0;
                        var IRQ = 0, SOFTIRQ = 0, STEAL = 0, GUEST = 0, GUESTNICE = 0, PORCALCULADO = 0;
                        var totald = 0, idled = 0, CPU_Percentage = 0;
                        
                        try{
                            //cpuinfo = JSON.parse(data);
                            cpuinfo = data;
                            USER = cpuinfo.USER;
                            NICE = cpuinfo.NICE;
                            SYSTEM = cpuinfo.SYSTEM;
                            IDLE = cpuinfo.IDLE;
                            IOWAIT = cpuinfo.IOWAIT;
                            IRQ = cpuinfo.IRQ;
                            SOFTIRQ = cpuinfo.SOFTIRQ;
                            STEAL = cpuinfo.STEAL;
                            GUEST = cpuinfo.GUEST;
                            GUESTNICE = cpuinfo.GUESTNICE;
                            PORCALCULADO = cpuinfo.PORCALCULADO;

                            var CPU_Percentage = ((USER+NICE+SYSTEM+IDLE+IOWAIT+IRQ+SOFTIRQ+STEAL)-(IDLE + IOWAIT)) / (USER+NICE+SYSTEM+IDLE+IOWAIT+IRQ+SOFTIRQ+STEAL)*100;
                            if(CPU_Percentage === 0){
                                tipo = "ERROR";
                                console.log("ERROR");
                            }
                            idled = IDLE;
                            //alert(idled+ ", "+CPU_Percentage);
                            document.getElementById("usadoPorc").innerHTML = "Porcentaje: " + CPU_Percentage + "%";
                            cola.push(CPU_Percentage);
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
                       puntoerror = cola[0];
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
                    shadowSize: 0	// Drawing is faster without shadows
                },
                yaxis: {
                    min: 20,
                    max: 60
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
        <h1>CPU Usado</h1>
            <div id="content"></div>
               <h3 id="usadoKB"> </h3>
               <h3 id="usadoPorc"> </h3>
               
               <div id="placeholder" style="width:800px;height:600px"></div>
               
               <input id="updateInterval" type="text" value="" style="text-align: right" width:5em>
                   
               </input>
    </body>
</html>
