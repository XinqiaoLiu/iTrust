<%@taglib prefix="itrust" uri="/WEB-INF/tags.tld"%>
<%@page errorPage="/auth/exceptionHandler.jsp"%>
<%@page import="edu.ncsu.csc.itrust.dao.DAOFactory"%>
<%@page import="edu.ncsu.csc.itrust.beans.PersonnelBean"%>
<%@page import="edu.ncsu.csc.itrust.BeanBuilder"%>
<%@page import="edu.ncsu.csc.itrust.exception.FormValidationException"%>
<%@page import="edu.ncsu.csc.itrust.action.SendAppointmentReminders"%>


<%@include file="/global.jsp" %>

<%
pageTitle = "iTrust - Send Reminders";
%>

<%@include file="/header.jsp" %>

<%
	boolean formIsFilled = request.getParameter("nDays") != null;


	if (formIsFilled) {
      int nDays = Integer.parseInt(request.getParameter("nDays"));
      SendAppointmentReminders r = new SendAppointmentReminders(prodDAO);
      r.send(nDays);

	}
%>


<h2>Send Reminders</h2>
<b>Enter the number of reminder-in-advance days</b>
<form action = "sendAppointmentReminders.jsp" method="post">
<input type = "number" name = "nDays" required = "true">
<input type = "submit" name = "send"  value = "Send" >
</form>
<%@include file="/footer.jsp" %>
