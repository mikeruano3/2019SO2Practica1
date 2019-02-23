<%-- 
    Document   : procesos
    Created on : 9/02/2019, 01:37:31 AM
    Author     : miguel
--%>


<%@page import="com.google.gson.Gson"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.InputStream"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page import="java.util.List" %>
<%@ page import="java.io.FileReader" %>
<%@ page import="java.util.Iterator" %>
<%@page import="java.text.ParseException"%>
<%@page import="java.io.IOException"%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
        <%
            BufferedReader br = new BufferedReader(new FileReader("/proc/procesos_201503666"));
            try {
                StringBuilder sb = new StringBuilder();
                String line = br.readLine();

                while (line != null) {
                    sb.append(line);
                    sb.append(System.lineSeparator());
                    line = br.readLine();
                }
                String everything = sb.toString();
                out.print(everything);
                Gson gson = new Gson();
            }catch(Exception e){
                out.print(e);
            } finally {
                br.close();
            }
        %>
    </body>
</html>
