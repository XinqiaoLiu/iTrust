<%@page errorPage="/auth/exceptionHandler.jsp"%>

<%@page import="java.util.Date"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="edu.ncsu.csc.itrust.action.EditApptAction"%>
<%@page import="edu.ncsu.csc.itrust.action.EditApptTypeAction"%>
<%@page import="edu.ncsu.csc.itrust.action.ViewMyApptsAction"%>
<%@page import="edu.ncsu.csc.itrust.action.EditRepresentativesAction"%>
<%@page import="edu.ncsu.csc.itrust.action.ViewPersonnelAction"%>
<%@page import="edu.ncsu.csc.itrust.beans.ApptBean"%>
<%@page import="edu.ncsu.csc.itrust.dao.mysql.ApptTypeDAO"%>
<%@page import="edu.ncsu.csc.itrust.beans.PatientBean"%>
<%@page import="edu.ncsu.csc.itrust.beans.PersonnelBean"%>
<%@page import="java.util.List"%>

<%@include file="/global.jsp" %>

<%
pageTitle = "iTrust - View Message";
%>

<%@include file="/header.jsp" %>

<%
	long mid = loggedInMID.longValue();
	ViewMyApptsAction apptAction = new ViewMyApptsAction(prodDAO, loggedInMID.longValue());
	ApptTypeDAO apptTypeDAO = prodDAO.getApptTypeDAO();
	
	if (request.getParameter("patient") != null) {
		String patientParameter = request.getParameter("patient");
		try {
			mid = Long.parseLong(patientParameter);
		} catch (NumberFormatException nfe) {
			response.sendRedirect("viewMyAppts.jsp");
		}
		EditRepresentativesAction representativeAction = new EditRepresentativesAction(prodDAO, loggedInMID.longValue(), String.valueOf(loggedInMID.longValue()));
		List<PatientBean> representees = representativeAction.getRepresented(loggedInMID.longValue());
		boolean isRepresented = (loggedInMID == mid);
		if (!isRepresented) {
			for(PatientBean patientDataBean: representees) {
				if(patientDataBean.getMID() == mid) {
					isRepresented = true;
					break;
				}
			}
		}
		if(!isRepresented) {
			response.sendRedirect("viewMyAppts.jsp");
		}
		session.setAttribute("appts", apptAction.getAppointments(mid));
	}
	
	EditApptAction editAction = new EditApptAction(prodDAO, loggedInMID.longValue());
	ViewMyApptsAction action = new ViewMyApptsAction(prodDAO, mid);
	ApptBean original = null;
	String rating = null;

	if (request.getParameter("apt") != null) {
		String aptParameter = request.getParameter("apt");
		try {
			int apptID = Integer.parseInt(aptParameter);
			original = editAction.getAppt(apptID);
			if (original == null){
				response.sendRedirect("viewMyAppts.jsp");
			}
			if (request.getParameter("rating") != null){
				rating = request.getParameter("rating");
			}
		} catch (NullPointerException npe) {
			response.sendRedirect("viewMyAppts.jsp");
		} catch (NumberFormatException e) {
			response.sendRedirect("viewMyAppts.jsp");
		}
	}
	else {
		response.sendRedirect("viewMyAppts.jsp");
	}
	
	
	if (original != null) {
		EditRepresentativesAction repAction = new EditRepresentativesAction(prodDAO, loggedInMID, ""+loggedInMID);
		List<PatientBean> representees = repAction.getRepresented(loggedInMID.longValue());
		boolean authorized = false;
		for (PatientBean pBean : representees) {
			if (pBean.getMID() == original.getPatient()) {
				authorized = true;
				break;
			}
		}
		
		if (loggedInMID == original.getPatient())
			authorized = true;
		
		if (authorized) {
			Date d = new Date(original.getDate().getTime());
			DateFormat format = new SimpleDateFormat("MM/dd/yyyy hh:mm a");
			
			loggingAction.logEvent(TransactionType.APPOINTMENT_VIEW, loggedInMID, original.getPatient(), "");
		%>
	    <div align="center">
			<div>
				<table>
					<tr>
						<th>Appointment Info</th>
					</tr>
					<tr>
						<td><b>Patient:</b> <%= StringEscapeUtils.escapeHtml("" + ( action.getName(original.getPatient()) )) %></td>
					</tr>
					<tr>
						<td><b>HCP:</b> <%= StringEscapeUtils.escapeHtml("" + ( action.getName(original.getHcp()) )) %></td>
					</tr>
					<tr>
						<td><b>Type:</b> <%= StringEscapeUtils.escapeHtml("" + ( original.getApptType() )) %></td>
					</tr>
					<tr>
						<td><b>Date/Time:</b> <%= StringEscapeUtils.escapeHtml("" + ( format.format(d) )) %></td>
					</tr>
					<tr>
						<td><b>Duration:</b> <%= StringEscapeUtils.escapeHtml("" + ( apptTypeDAO.getApptType(original.getApptType()).getDuration()+" minutes" )) %></td>
					</tr>
				</table>
			</div>
			
			<table>
				<tr>
					<td colspan="2"><b>Comments:</b></td>
				</tr>
				<tr>
					<td colspan="2"><%= StringEscapeUtils.escapeHtml("" + ( (original.getComment()== null)?"No Comment":original.getComment() )) %></td>
				</tr>
			</table>
<%
		if (rating != null){
			String score = request.getParameter("score");
			if (score != null){
				editAction.rate(original, Integer.parseInt(score));
				%><script> 
                    alert("Rating Change Applied!");
                    window.location = 'viewMyAppts.jsp';
                </script><%
%>
				<h1><%= score %></h1>
<%
			}
%>
		<form>
			Please Input your new rating: <br>
			<input type="hidden" id="apt" name="apt" value="<%=request.getParameter("apt")%>">
			<input type="hidden" id="rating" name="rating" value="<%=request.getParameter("score")%>">
			<table>
			<td><div class="form-check form-check-inline">
				<input class="form-check-input" type="radio" name="score" id="score1" value="1">
				<label class="form-check-label" for="score1">1</label>
			</div></td>
			<td><div class="form-check form-check-inline">
				<input class="form-check-input" type="radio" name="score" id="score2" value="2">
				<label class="form-check-label" for="score2">2</label>
			</div></td>
			<td><div class="form-check form-check-inline">
				<input class="form-check-input" type="radio" name="score" id="score3" value="3">
				<label class="form-check-label" for="score3">3</label>
			</div></td>
			<td><div class="form-check form-check-inline">
				<input class="form-check-input" type="radio" name="score" id="score4" value="4">
				<label class="form-check-label" for="score4">4</label>
			</div></td>
			<td><div class="form-check form-check-inline">
				<input class="form-check-input" type="radio" name="score" id="score5" value="5">
				<label class="form-check-label" for="score5">5</label>
			</div></td>
			<table>
			<input type="submit" value="Submit">
		</form>
<%				
		}
%>
	    </div>
<%
		} else {
%>
		<div align=center>
			<span class="iTrustError">You are not authorized to view details of this appointment</span>
		</div>
<%
		}
	}
%>

<%@include file="/footer.jsp" %>
