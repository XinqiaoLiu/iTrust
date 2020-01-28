<%@page errorPage="/auth/exceptionHandler.jsp"%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="edu.ncsu.csc.itrust.beans.PatientBean"%>
<%@page import="edu.ncsu.csc.itrust.action.ViewPreregisteredPatientAction"%>

<%@include file="/global.jsp" %>

<%
pageTitle = "iTrust - Template";
%>

<%@include file="/header.jsp" %>

<%
    ViewPreregisteredPatientAction action = new ViewPreregisteredPatientAction(prodDAO, loggedInMID.longValue());
    List<PatientBean> prepatients = action.getPrepatient();
    if (request.getParameter("index") != null) {
        long MID = prepatients.get(Integer.valueOf(request.getParameter("index"))).getMID();
        if(request.getParameter("actionType").equals("Activate")){
            boolean result = action.activatePrepatient(MID);
            if(result){
                session.setAttribute("pid", Long.toString(MID));
                loggingAction.logEvent(TransactionType.PREPATIENT_ACTIVATE, loggedInMID, MID, "");
                %><script> 
                    alert("Activation Sucess! Navigate to editor");
                    window.location = 'editPatient.jsp';
                </script><%
            } else {
                %><script> alert("Something went wrong");</script><%
            }
        } else if(request.getParameter("actionType").equals("Deactivate")){
            boolean result = action.deactivatePrepatient(MID);
            if(result){
                loggingAction.logEvent(TransactionType.PREPATIENT_DEACTIVATE, loggedInMID, MID, "");
                %><script> 
                    alert("Prepatient Sucessful Deactivate");
                    window.location = 'viewPreregisteredPatient.jsp';
                </script><%
            } else {
                %><script> alert("Something went wrong");</script><%
            }
        }
    }
%>
<table class="display fTable" id="prepatientList" align="center">
    <thead>
        <tr class="">
            <th>Patient</th>
            <th>email</th>
            <th>Activate Patient</th>
            <th>Deactivate Patient</th>
        </tr>
    </thead>
    <tbody>
        <%
            List<PatientBean> patients = prepatients;
            int index = 0;
		    for (PatientBean bean : prepatients) {
	    %>
        <tr>
		<td >
			<a href="editPHR.jsp?patient=<%= StringEscapeUtils.escapeHtml("" + (index)) %>">
		
		
			<%= StringEscapeUtils.escapeHtml("" + (bean.getFullName())) %>
		
		
			</a>
			</td>
		<td ><%= StringEscapeUtils.escapeHtml("" + (bean.getEmail())) %></td>
		<td >
            <form id="<%="activationForm" + String.valueOf(index)%>">
                <input type="hidden" name="index" value="<%=index%>">
                <input type="hidden" id="actionType" name="actionType" value="Activate">
                <input type="submit" value="Activate" name="activationButton">
            </form>
        </td>
        <td>
            <form id="<%="DeactivationForm" + String.valueOf(index)%>">
                <input type="hidden" name="index" value="<%=index%>">
                <input type="hidden" id="actionType" name="actionType" value="Deactivate">
                <input type="submit" value="Deactivate" name="activationButton">
            </form>
		</td>
	    </tr>
        <%
            index ++;
		}
        session.setAttribute("patients", patients);
	    %>
    </tbody>
</table>

<%@include file="/footer.jsp" %>