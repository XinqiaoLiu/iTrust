<%@page errorPage="/auth/exceptionHandler.jsp"%>

<%@page import="java.sql.Date"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="edu.ncsu.csc.itrust.dao.mysql.codTrendDAO"%>
<%@page import="java.lang.Long"%>
<%@page import="java.lang.NumberFormatException"%>
<%@page import="edu.ncsu.csc.itrust.exception.ITrustException"%>
<%@page import="java.lang.IllegalArgumentException"%>
<%@page import="edu.ncsu.csc.itrust.exception.FormValidationException"%>


<%@include file="/global.jsp"%>

<%
	pageTitle = "iTrust - View Cause-of-death Trends Report";
%>

<%@include file="/header.jsp"%>

<%
    String startY = request.getParameter("startYear");
    String endY = request.getParameter("endYear");
    String gender = request.getParameter("patient_gender");
    long hcpID = loggedInMID;

    Date startD = null;
    Date endD = null;

    List<String> reportsForHCP = null;
    List<String> reportsForAll = null;

    if(gender!=null){
        if(Integer.valueOf(startY)>Integer.valueOf(endY) || Integer.valueOf(endY)>=2020 || Integer.valueOf(startY) < 1900){
            %>
            <div align=center>
                <span><%=StringEscapeUtils.escapeHtml("Invalid year")%></span>
            </div>
            <%
        }else{
            startD = Date.valueOf(startY+"-01-01");
            endD = Date.valueOf(endY+"-12-31");
        }
    
        codTrendDAO codT = new codTrendDAO(DAOFactory.getProductionInstance());
    
        if(gender.equals("All")){
            reportsForAll = codT.getTopTwoCODForAll(startD, endD);
            reportsForHCP = codT.getTopTwoCODForAllForHCP(hcpID, startD, endD);
        }else if(gender.equals("Male")){
            reportsForAll = codT.getTopTwoCODForMale(startD, endD);
            reportsForHCP = codT.getTopTwoCODForMaleForHCP(hcpID, startD, endD);
        }else{
            reportsForAll = codT.getTopTwoCODForFemale(startD, endD);
            reportsForHCP = codT.getTopTwoCODForFemaleForHCP(hcpID, startD, endD);        
        }        
    }
%>

<form id="filterform" action="viewCODTrendsReport.jsp">
    <div align=center>
        <h2>Cause-of-death Trends Report</h2>
        <label for="start">Start year:</label>

        <input onchange="singleTimePeriod();" type="number" id="startYear" name="startYear" required="true">

        <label for="end">End year:</label>

        <input onchange="singleTimePeriod();" type="number" id="endYear" name="endYear" required="true">  
    </div>

    <div align=center>

        <label for="gender">Gender:</label>
        <select onchange="singleTimePeriod();" id="patient_gender" name="patient_gender">
            <option></option>
            <option value = "All" selected>All</option>
            <option value = "Male" selected>Male</option>
            <option value = "Female" selected>Female</option>
        </select> 
    </div>
    <div align=center>
        <input onclick = "singleTimePeriod();" type="submit" id="submit" name="submit">
    </div>


    <table class="fTable" id="reportList1" border=1 align="center">
    <%
        if(gender!=null){
            if(reportsForHCP.size() != 0){        
                out.print("<caption><h4>Cause-of-death Trends Report for hcp</h4></caption>");
                for(int i = 0; i < reportsForHCP.size(); i++){
                    out.print("<td>" + reportsForHCP.get(i) + "</td>");
                }
            }            
        }
    
    %>
    </table>
    <table class="fTable" id="reportList2" border=1 align="center">
    <%
        if(gender!=null){
            if(reportsForAll.size() != 0){ 
                out.print("<caption><h4>Cause-of-death Trends Report for " + gender + "</h4></caption>");
                for(int i = 0; i < reportsForAll.size(); i++)
                {
                    out.print("<td>" + reportsForAll.get(i) + "</td>");
                }
            }
        }
    %>
    </table>
</form>
<script type="text/javascript">
function singleTimePeriod() {
    gender = document.getElementsByName("patient_gender");
    startY = document.getElementsByName("startYear");
    endY = document.getElementsByName("endYear");

    // startY = startYNum == null ? "2005" : startY;
    // endY = endY == null ? "2019" : endY;

    // if (startYNum == null || endYNum == null){
    //     alert ("Invalid year");
    // }else{
    //     startY = startYNum;
    //     endY = endYNum;
    // }
}
</script>

<%@include file="/footer.jsp"%>