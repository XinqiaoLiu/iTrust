<%@page errorPage="/auth/exceptionHandler.jsp"%>
<%@page import="edu.ncsu.csc.itrust.beans.PersonnelBean"%>
<%@page import="edu.ncsu.csc.itrust.dao.mysql.PersonnelDAO"%>
<%@page import="edu.ncsu.csc.itrust.action.ViewVisitedHCPsAction"%>
<%@page import="edu.ncsu.csc.itrust.action.ViewMyMessagesAction"%>
<%@page import="java.util.List"%>


<%@include file="/global.jsp" %>

<%
pageTitle = "iTrust - Rating Information";
PersonnelDAO personnelDAO = prodDAO.getPersonnelDAO();
List<PersonnelBean> visits = personnelDAO.getAllHcp();
ViewMyMessagesAction rateAction;
%>

<%@include file="/header.jsp" %>
<div align=center>
    <table class="table">
        <thead>
            <tr>
                <th scope="col">Doctor Name</th>
                <th scope="col">Rating</th>
            </tr>
        </thead>
        <tbody>
            <% for (PersonnelBean visit : visits) { 
                    rateAction = new ViewMyMessagesAction(prodDAO, visit.getMID());
                    String mes;
                    if(rateAction.getHcpRating() != 0){
                        mes = String.valueOf(rateAction.getHcpRating()) + " / 5";
                    } else {
                        mes = "No Rating";
                    }
                    %>
                <tr>
                    <td><%=visit.getFullName()%></td>
                    <td><%=mes%></td>
                </tr>
            <% } %>
        </tbody>
    </table>
</div>

<%@include file="/footer.jsp" %>