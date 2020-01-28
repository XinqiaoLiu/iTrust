<%@taglib prefix="itrust" uri="/WEB-INF/tags.tld"%>
<%@page errorPage="/auth/exceptionHandler.jsp"%>
<%@page import="java.util.*"%>
<%@page import="java.io.*"%>
<%@page import="org.jfree.chart.ChartFactory"%>
<%@page import="org.jfree.chart.JFreeChart"%>
<%@page import="org.jfree.chart.plot.PlotOrientation"%>
<%@page import="org.jfree.data.category.DefaultCategoryDataset"%>
<%@page import="org.jfree.chart.ChartUtilities"%>
<%@page import="edu.ncsu.csc.itrust.dao.DAOFactory"%>
<%@page import="edu.ncsu.csc.itrust.dao.mysql.AuthDAO"%>
<%@page import="edu.ncsu.csc.itrust.beans.PersonnelBean"%>
<%@page import="edu.ncsu.csc.itrust.beans.TransactionBean"%>
<%@page import="edu.ncsu.csc.itrust.BeanBuilder"%>
<%@page import="edu.ncsu.csc.itrust.exception.FormValidationException"%>
<%@page import="edu.ncsu.csc.itrust.action.ViewTransactionLogsAction"%>
<%@page import="edu.ncsu.csc.itrust.enums.TransactionType"%>


<%@include file="/global.jsp" %>

<%
pageTitle = "iTrust - View Transaction Logs";
%>

<%@include file="/header.jsp" %>

<%
	ViewTransactionLogsAction action = new ViewTransactionLogsAction(prodDAO);
    String loginUser = request.getParameter("login_user");
    String secondaryUser = request.getParameter("secondary_user");
	String startDate = request.getParameter("startdate");
	String endDate = request.getParameter("enddate");
    String transactionType = request.getParameter("transactionType");
 %>

<h2>View Transaction Logs</h2>
<form action = "viewTransactionLogs.jsp" method="post">
    <script> array = ["All roles", "hcp", "lt", "er", "pha", "patient", "admin", "uap", "tester", "prepatient"]; </script> 

    <label for="inputRole1">Login user role</label><br>
    <select name="login_user" id="login_user">
        <script>
            var select = document.getElementById('login_user');
            for (var i=0; i<array.length; i++) { select.options[select.options.length] = new Option(array[i], array[i]);} 
        </script>
    </select>
    <br>

    <label for="inputRole2">Secondary user role</label><br>
    <select name="secondary_user" id="secondary_user">
        <script>
            var select = document.getElementById('secondary_user');
            for (var i=0; i<array.length; i++) { select.options[select.options.length] = new Option(array[i], array[i]);} 
        </script>
    </select>
    <br>

    <label for="startDate">Starting date</label><br>
    <input type = "date" name = "startdate" min="1900-01-01" max="2888-12-31" value="2019-01-01">
    <br>

    <label for="endDate">Ending date</label><br>
    <input type = "date" name = "enddate" min="1900-01-01" max="2888-12-31" value="2019-12-31">
    <br>

    <label for="transactionType">Transaction type</label><br>
    <%
            
    %>
    <select name="transactionType" id="transactionType">
        <option value="0">All transaction types</option>
        <%
            TransactionType[] transactionArray = TransactionType.values();
            for (TransactionType t : transactionArray){
                %> <option value="<%= t.getCode() %>"><%=t.getDescription()%></option> <%
            }
        %>
    </select>
    <br>
    <br>
    
    <input type = "submit" name = "view"  value = "View" >
</form>

<%
    if (startDate != null && endDate != null){
        if (action.validateDates(startDate, endDate)){
            List<TransactionBean> logList = action.view(loginUser, secondaryUser,startDate, endDate, Integer.parseInt(transactionType));
            %> <h4>Total <%=logList.size()%> transactions found.</h4> <%
            Map<String, Integer> logUser_logs = new HashMap<>();
            Map<String, Integer> secUser_logs = new HashMap<>();
            Map<String, Integer> month_logs = new TreeMap<>();
            Map<String, Integer> tranType_logs = new HashMap<>();
            if (logList.size() != 0){
%>
<table class="fTable" align="center">
	<tr>
		<th colspan="6">Filtered Transaction Logs</th>
	</tr>
	<tr class="subHeader">
		<th>Logged-in user role</th>
		<th>Secondary user role</th>
		<th>Transaction code</th>
        <th>Transaction name</th>
		<th>Additional Information</th>
        <th>Timestamp</th>
	</tr>
<%
                String tempLogUser = "";
                String tempSecUser = "";
                String tempTran = "";
                String tempTranDes = "";
                String tempAddInfo = "";
                String tempTimestamp = "";

                for (TransactionBean logEntry : logList){
                    tempLogUser = authDAO.getRoleFromMID(logEntry.getLoggedInMID());
                    tempSecUser = authDAO.getRoleFromMID(logEntry.getSecondaryMID());
                    tempTran = Integer.toString(logEntry.getTransactionType().getCode());
                    tempTranDes = logEntry.getTransactionType().getDescription();
                    tempAddInfo = logEntry.getAddedInfo();
                    tempTimestamp = logEntry.getTimeLogged().toString();

                    logUser_logs.put(tempLogUser, logUser_logs.getOrDefault(tempLogUser, 0) + 1);
                    secUser_logs.put(tempSecUser, secUser_logs.getOrDefault(tempSecUser, 0) + 1);
                    month_logs.put(tempTimestamp.substring(0,7), month_logs.getOrDefault(tempTimestamp.substring(0,7), 0) + 1);
                    tranType_logs.put(tempTran, tranType_logs.getOrDefault(tempTran, 0) + 1);

%>
                    <tr>
                        <td align="center"><%= StringEscapeUtils.escapeHtml("" + (tempLogUser)) %></td>
                        <td align="center"><%= StringEscapeUtils.escapeHtml("" + (tempSecUser)) %></td>
                        <td align="center"><%= StringEscapeUtils.escapeHtml("" + (tempTran)) %></td>
                        <td align="center"><%= StringEscapeUtils.escapeHtml("" + (tempTranDes)) %></td>
                        <td align="center"><%= StringEscapeUtils.escapeHtml("" + (tempAddInfo)) %></td>
                        <td align="center"><%= StringEscapeUtils.escapeHtml("" + (tempTimestamp)) %></td>
                    </tr>
<%
                }
                // Reference: https://developers.google.com/chart/image/docs/gallery/chart_gall
                String prefix = "https://chart.apis.google.com/chart?cht=bvs&chs=200x300&chco=0000FF88&chxt=x,y&chbh=20,15,20&chds=0,40&chxr=1,0,40";
                if (logUser_logs.size() <= 3) { prefix += "&chma=60,60";}
                String chartTitle = "&chtt=Logs+per+Logged-in+Role";
                String barValues = "&chd=t:";
                String barEntries = "&chxl=0:";
                int maxValue = 0;
                for (String key : logUser_logs.keySet()) {
                    maxValue = Math.max(maxValue, logUser_logs.get(key));
                    barValues += logUser_logs.get(key) + ",";
                    barEntries += "|" + key;
                }
                String yAxisRange = "&chxr=1,0," + Integer.toString((int)(maxValue/10 + 1)*10);
                String yScaling = "&chds=0," + Integer.toString((int)(maxValue/10 + 1)*10);
                barValues = barValues.substring(0, barValues.length() - 1);
                String link = prefix + chartTitle + yAxisRange + yScaling + barValues + barEntries;
%> 
</table>
                <br><img src=<%=link%> alt="logUser_logs" height="300" width="200" align="center">
<%
                prefix = "https://chart.apis.google.com/chart?cht=bvs&chs=200x300&chco=0000FF88&chxt=x,y&chbh=20,15,20&chds=0,50&chxr=1,0,50";
                if (secUser_logs.size() <= 3) { prefix += "&chma=60,60";}
                chartTitle = "&chtt=Logs+per+Secondary+Role";
                barValues = "&chd=t:";
                barEntries = "&chxl=0:";
                maxValue = 0;
                for (String key : secUser_logs.keySet()) {
                    maxValue = Math.max(maxValue, secUser_logs.get(key));
                    barValues += secUser_logs.get(key) + ",";
                    barEntries += "|" + key;
                }
                yAxisRange = "&chxr=1,0," + Integer.toString((int)(maxValue/10 + 1)*10);
                yScaling = "&chds=0," + Integer.toString((int)(maxValue/10 + 1)*10);
                barValues = barValues.substring(0, barValues.length() - 1);
                link = prefix + chartTitle + yAxisRange + yScaling + barValues + barEntries;
%>
                <br><img src=<%=link%> alt="secUser_logs" height="300" width="200" align="center">
<%
                prefix = "https://chart.apis.google.com/chart?cht=bvs&chs=650x300&chco=0000FF88&chxt=x,y&chbh=20,30,20&chds=0,35&chxr=1,0,35";
                if (month_logs.size() <= 3) { prefix += "&chma=60,60";}
                chartTitle = "&chtt=Logs+per+Month";
                barValues = "&chd=t:";;
                barEntries = "&chxl=0:";
                maxValue = 0;
                for (String key : month_logs.keySet()) {
                    maxValue = Math.max(maxValue, month_logs.get(key));
                    barValues += month_logs.get(key) + ",";
                    barEntries += "|" + key;
                }
                yAxisRange = "&chxr=1,0," + Integer.toString((int)(maxValue/10 + 1)*10);
                yScaling = "&chds=0," + Integer.toString((int)(maxValue/10 + 1)*10);
                barValues = barValues.substring(0, barValues.length() - 1);
                link = prefix + chartTitle + yAxisRange + yScaling + barValues + barEntries;
%>
                <br><img src=<%=link%> alt="month_logs" height="300" width="650" align="center">
<%
                prefix = "https://chart.apis.google.com/chart?cht=bvs&chs=600x300&chco=0000FF88&chxt=x,y&chbh=20,15,20";
                if (tranType_logs.size() <= 3) { prefix += "&chma=70,70";}
                chartTitle = "&chtt=Logs+per+Transaction+Type";
                barValues = "&chd=t:";;
                barEntries = "&chxl=0:";
                maxValue = 0;
                for (String key : tranType_logs.keySet()) {
                    maxValue = Math.max(maxValue, tranType_logs.get(key));
                    barValues += tranType_logs.get(key) + ",";
                    barEntries += "|" + key;
                }
                yAxisRange = "&chxr=1,0," + Integer.toString((int)(maxValue/10 + 1)*10);
                yScaling = "&chds=0," + Integer.toString((int)(maxValue/10 + 1)*10);
                barValues = barValues.substring(0, barValues.length() - 1);
                link = prefix + chartTitle + yAxisRange + yScaling + barValues + barEntries;
%>
                <br><img src=<%=link%> alt="tranType_logs" height="300" width="600" align="center" id="img4">
<%
            }
        } else {
            %> <h4>Invalid date input!</h4> <%
        }
    }
%>



<%@include file="/footer.jsp" %>
