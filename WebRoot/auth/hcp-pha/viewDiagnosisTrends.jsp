<%@taglib uri="/WEB-INF/tags.tld" prefix="itrust"%>
<%@page errorPage="/auth/exceptionHandler.jsp"%>

<%@page import="edu.ncsu.csc.itrust.action.ViewDiagnosisStatisticsAction"%>
<%@page import="edu.ncsu.csc.itrust.beans.DiagnosisBean"%>
<%@page import="edu.ncsu.csc.itrust.beans.DiagnosisStatisticsBean"%>
<%@page import="edu.ncsu.csc.itrust.exception.FormValidationException"%>

<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="edu.ncsu.csc.itrust.dao.DAOFactory"%>
<%@page import="edu.ncsu.csc.itrust.dao.mysql.DiagnosesDAO"%>


<%
	//log the page view
	loggingAction.logEvent(TransactionType.DIAGNOSIS_TRENDS_VIEW, loggedInMID.longValue(), 0, "");

	ViewDiagnosisStatisticsAction diagnoses = new ViewDiagnosisStatisticsAction(prodDAO);
	DiagnosisStatisticsBean dsBean = null;


	//get form data
	String startDate = request.getParameter("startDate");
	String endDate = request.getParameter("endDate");

	String zipCode = request.getParameter("zipCode");
	if (zipCode == null)
		zipCode = "";

	String icdCode = request.getParameter("icdCode");

	//try to get the statistics. If there's an error, print it. If null is returned, it's the first page load
	try{
		dsBean = diagnoses.getDiagnosisStatistics(startDate, endDate, icdCode, zipCode);
	} catch(FormValidationException e){
		e.printHTML(pageContext.getOut());
	}

	if (startDate == null)
		startDate = "";
	if (endDate == null)
		endDate = "";
	if (icdCode == null)
		icdCode = "";

%>
<br />
<form action="viewDiagnosisStatistics.jsp" method="post" id="formMain">
<input type="hidden" name="viewSelect" value="trends" />
<table class="fTable" align="center" id="diagnosisStatisticsSelectionTable">
	<tr>
		<th colspan="4">Diagnosis Statistics</th>
	</tr>
	<tr class="subHeader">
		<td>Diagnosis:</td>
		<td>
			<select name="icdCode" style="font-size:10" >
			<option value="">-- None Selected --</option>
			<%for(DiagnosisBean diag : diagnoses.getDiagnosisCodes()) { %>
				<%if (diag.getICDCode().equals(icdCode)) { %>
					<option selected="selected" value="<%=diag.getICDCode()%>"><%= StringEscapeUtils.escapeHtml("" + (diag.getICDCode())) %>
					- <%= StringEscapeUtils.escapeHtml("" + (diag.getDescription())) %></option>
				<% } else { %>
					<option value="<%=diag.getICDCode()%>"><%= StringEscapeUtils.escapeHtml("" + (diag.getICDCode())) %>
					- <%= StringEscapeUtils.escapeHtml("" + (diag.getDescription())) %></option>
				<% } %>
			<%}%>
			</select>
		</td>
		<td>Zip Code:</td>
		<td ><input name="zipCode" value="<%= StringEscapeUtils.escapeHtml(zipCode) %>" /></td>
	</tr>
	<tr class="subHeader">
		<td>Start Date:</td>
		<td>
			<input name="startDate" value="<%= StringEscapeUtils.escapeHtml("" + (startDate)) %>" size="10">
			<input type=button value="Select Date" onclick="displayDatePicker('startDate');">
		</td>
		<td>End Date:</td>
		<td>
			<input name="endDate" value="<%= StringEscapeUtils.escapeHtml("" + (endDate)) %>" size="10">
			<input type=button value="Select Date" onclick="displayDatePicker('endDate');">
		</td>
	</tr>
	<tr>
		<td colspan="4" style="text-align: center;"><input type="submit" id="select_diagnosis" value="View Statistics"></td>
	</tr>
</table>

</form>

<br />

<% if (dsBean != null) { %>



<table class="fTable" align="center" id="diagnosisStatisticsTable">
<tr>
	<th>Diagnosis code</th>
	<th>Complete Zip</th>
	<th>Cases in Zip</th>
	<th>Cases in Region</th>
	<th>Start Date</th>
	<th>End Date</th>
</tr>
<tr style="text-align:center;">
	<td><%= icdCode %></td>
	<td><%= zipCode %></td>
	<td><%= dsBean.getZipStats() %></td>
	<td><%= dsBean.getRegionStats() %></td>
	<td><%= startDate %></td>
	<td><%= endDate %></td>
</tr>

</table>

<br />


<%
//	long diagnosescount = 0;
	Date curDate = dsBean.getStartDate();
	Calendar cal = Calendar.getInstance();
	cal.setTime(curDate);
	cal.add(Calendar.HOUR, -24*7);
	Date week1start = cal.getTime();
	DateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy");
  String strDate = dateFormat.format(week1start);
	//String endDate = dateFormat.format(curDate);
	DiagnosisStatisticsBean week1 = diagnoses.getDiagnosisStatistics(strDate, startDate, icdCode, zipCode);
	//DiagnosisStatisticsBean dbWeek = diagnosesDAO.getDiagnosisCounts(icdCode, zipCode, startDate, endDate);
	String prefix = "https://chart.apis.google.com/chart?cht=bvs&chs=600x300&chco=0000FF88&chxt=x,y&chbh=20,15,20";
	String chartTitle = "&chtt=Cases+one+week+from+start";
	String barEntries = "&chxl=0:|region|state|country";
	String barValues = "&chd=t:";
	barValues +=  Long.toString(week1.getZipStats()) + ",";
	barValues +=  Long.toString(week1.getRegionStats()) + ",";
	/*for (int i = 0; i < 99999; i++){
	//	String eye = Integer.toString(i);
		DiagnosisStatisticsBean itr = diagnoses.getDiagnosisStatistics(strDate, startDate, icdCode, String.format("%05d", i));
		diagnosescount += itr.getRegionStats();
	}*/
	//barValues += Long.toString(diagnosescount);
	barValues +=  Long.toString(week1.getRegionStats());
	// barValues += Long.toString(dbWeek.getCountForWeekOf(icdCode,);
	String link = prefix + chartTitle + barValues + barEntries;
%>

<br><img src=<%=link%> alt="img1" height="300" width="600">

<%

//	DateFormat newEndDate = new SimpleDateFormat("MM/dd/yyyy");
//	String endDate_ = dateFormat.format(newEndDate);
	curDate = week1.getStartDate();
	cal.setTime(curDate);
	cal.add(Calendar.HOUR, -24*7);
	Date week2start = cal.getTime();
	String str2Date = dateFormat.format(week2start);
	DiagnosisStatisticsBean week2 = diagnoses.getDiagnosisStatistics(str2Date, strDate, icdCode, zipCode);

	prefix = "https://chart.apis.google.com/chart?cht=bvs&chs=600x300&chco=0000FF88&chxt=x,y&chbh=20,15,20";
	chartTitle = "&chtt=Cases+two+weeks+from+start";
	barEntries = "&chxl=0:|region|state|country";
	barValues = "&chd=t:";
	barValues +=  Long.toString(week2.getZipStats()) + ",";
	barValues +=  Long.toString(week2.getRegionStats()) + ",";
	barValues +=  Long.toString(week2.getRegionStats());
	link = prefix + chartTitle + barValues + barEntries;
%>

<br><img src=<%=link%> alt="img1" height="300" width="600">

<%

//	DateFormat newEndDate = new SimpleDateFormat("MM/dd/yyyy");
//	String endDate_ = dateFormat.format(newEndDate);
	curDate = week2.getStartDate();
	cal.setTime(curDate);
	cal.add(Calendar.HOUR, -24*7);
	Date week3start = cal.getTime();
	String str3Date = dateFormat.format(week3start);
	DiagnosisStatisticsBean week3 = diagnoses.getDiagnosisStatistics(str3Date, str2Date, icdCode, zipCode);

	prefix = "https://chart.apis.google.com/chart?cht=bvs&chs=600x300&chco=0000FF88&chxt=x,y&chbh=20,15,20";
	chartTitle = "&chtt=Cases+three+weeks+from+start";
	barEntries = "&chxl=0:|region|state|country";
	barValues = "&chd=t:";
	barValues +=  Long.toString(week3.getZipStats()) + ",";
	barValues +=  Long.toString(week3.getRegionStats()) + ",";
	barValues +=  Long.toString(week3.getRegionStats());
	link = prefix + chartTitle + barValues + barEntries;
%>

<br><img src=<%=link%> alt="img1" height="300" width="600">

<%

//	DateFormat newEndDate = new SimpleDateFormat("MM/dd/yyyy");
//	String endDate_ = dateFormat.format(newEndDate);
	curDate = week3.getStartDate();
	cal.setTime(curDate);
	cal.add(Calendar.HOUR, -24*7);
	Date week4start = cal.getTime();
	String str4Date = dateFormat.format(week4start);
	DiagnosisStatisticsBean week4 = diagnoses.getDiagnosisStatistics(str4Date, str3Date, icdCode, zipCode);

	prefix = "https://chart.apis.google.com/chart?cht=bvs&chs=600x300&chco=0000FF88&chxt=x,y&chbh=20,15,20";
	chartTitle = "&chtt=Cases+four+weeks+from+start";
	barEntries = "&chxl=0:|region|state|country";
	barValues = "&chd=t:";
	barValues +=  Long.toString(week4.getZipStats()) + ",";
	barValues +=  Long.toString(week4.getRegionStats()) + ",";
	barValues +=  Long.toString(week4.getRegionStats());
	link = prefix + chartTitle + barValues + barEntries;
%>

<br><img src=<%=link%> alt="img1" height="300" width="600">

<%
//	DateFormat newEndDate = new SimpleDateFormat("MM/dd/yyyy");
//	String endDate_ = dateFormat.format(newEndDate);
	curDate = week4.getStartDate();
	cal.setTime(curDate);
	cal.add(Calendar.HOUR, -24*7);
	Date week5start = cal.getTime();
	String str5Date = dateFormat.format(week5start);
	DiagnosisStatisticsBean week5 = diagnoses.getDiagnosisStatistics(str5Date, str4Date, icdCode, zipCode);

	prefix = "https://chart.apis.google.com/chart?cht=bvs&chs=600x300&chco=0000FF88&chxt=x,y&chbh=20,15,20";
	chartTitle = "&chtt=Cases+five+weeks+from+start";
	barEntries = "&chxl=0:|region|state|country";
	barValues = "&chd=t:";
	barValues +=  Long.toString(week5.getZipStats()) + ",";
	barValues +=  Long.toString(week5.getRegionStats()) + ",";
	barValues +=  Long.toString(week5.getRegionStats());
	link = prefix + chartTitle + barValues + barEntries;
%>

<br><img src=<%=link%> alt="img1" height="300" width="600">

<%
//	DateFormat newEndDate = new SimpleDateFormat("MM/dd/yyyy");
//	String endDate_ = dateFormat.format(newEndDate);
	curDate = week5.getStartDate();
	cal.setTime(curDate);
	cal.add(Calendar.HOUR, -24*7);
	Date week6start = cal.getTime();
	String str6Date = dateFormat.format(week6start);
	DiagnosisStatisticsBean week6 = diagnoses.getDiagnosisStatistics(str6Date, str5Date, icdCode, zipCode);

	prefix = "https://chart.apis.google.com/chart?cht=bvs&chs=600x300&chco=0000FF88&chxt=x,y&chbh=20,15,20";
	chartTitle = "&chtt=Cases+six+weeks+from+start";
	barEntries = "&chxl=0:|region|state|country";
	barValues = "&chd=t:";
	barValues +=  Long.toString(week6.getZipStats()) + ",";
	barValues +=  Long.toString(week6.getRegionStats()) + ",";
	barValues +=  Long.toString(week6.getRegionStats());
	link = prefix + chartTitle + barValues + barEntries;
%>

<br><img src=<%=link%> alt="img1" height="300" width="600">


<%
//	DateFormat newEndDate = new SimpleDateFormat("MM/dd/yyyy");
//	String endDate_ = dateFormat.format(newEndDate);
	curDate = week6.getStartDate();
	cal.setTime(curDate);
	cal.add(Calendar.HOUR, -24*7);
	Date week7start = cal.getTime();
	String str7Date = dateFormat.format(week7start);
	DiagnosisStatisticsBean week7 = diagnoses.getDiagnosisStatistics(str7Date, str6Date, icdCode, zipCode);

	prefix = "https://chart.apis.google.com/chart?cht=bvs&chs=600x300&chco=0000FF88&chxt=x,y&chbh=20,15,20";
	chartTitle = "&chtt=Cases+seven+weeks+from+start";
	barEntries = "&chxl=0:|region|state|country";
	barValues = "&chd=t:";
	barValues +=  Long.toString(week7.getZipStats()) + ",";
	barValues +=  Long.toString(week7.getRegionStats()) + ",";
	barValues +=  Long.toString(week7.getRegionStats());
	link = prefix + chartTitle + barValues + barEntries;
%>

<br><img src=<%=link%> alt="img1" height="300" width="600">

<%
//	DateFormat newEndDate = new SimpleDateFormat("MM/dd/yyyy");
//	String endDate_ = dateFormat.format(newEndDate);
	curDate = week7.getStartDate();
	cal.setTime(curDate);
	cal.add(Calendar.HOUR, -24*7);
	Date week8start = cal.getTime();
	String str8Date = dateFormat.format(week8start);
	DiagnosisStatisticsBean week8 = diagnoses.getDiagnosisStatistics(str8Date, str7Date, icdCode, zipCode);

	prefix = "https://chart.apis.google.com/chart?cht=bvs&chs=600x300&chco=0000FF88&chxt=x,y&chbh=20,15,20";
	chartTitle = "&chtt=Cases+eight+weeks+from+start";
	barEntries = "&chxl=0:|region|state|country";
	barValues = "&chd=t:";
	barValues +=  Long.toString(week8.getZipStats()) + ",";
	barValues +=  Long.toString(week8.getRegionStats()) + ",";
	barValues +=  Long.toString(week8.getRegionStats());
	link = prefix + chartTitle + barValues + barEntries;
%>

<br><img src=<%=link%> alt="img1" height="300" width="600">

<% } %>
<br />
<br />
