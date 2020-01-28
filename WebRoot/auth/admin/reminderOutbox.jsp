<%@taglib prefix="itrust" uri="/WEB-INF/tags.tld"%>
<%@page errorPage="/auth/exceptionHandler.jsp"%>
<%@page import="edu.ncsu.csc.itrust.BeanBuilder"%>
<%@page import="edu.ncsu.csc.itrust.action.ViewMyMessagesAction"%>
<%@page import="edu.ncsu.csc.itrust.beans.MessageBean"%>
<%@page import="java.util.*"%>

<%@include file="/global.jsp" %>

<%
pageTitle = "iTrust - View Reminders";
%>

<%@include file="/header.jsp" %>

<h2>View Reminders</h2>

<%
        loggingAction.logEvent(TransactionType.OUTBOX_VIEW,9000000001L,9000000001L,"");
        ViewMyMessagesAction view_action = new ViewMyMessagesAction(prodDAO,9000000001L);
  		List<MessageBean> message = view_action.getAllMySentMessagesTimeAscending();
		session.setAttribute("reminders", message);
%>
  <table>
    <tr>
        <th>subject</th>
        <th>recipient</th>
        <th>timestamp</th>
    </tr>
<%	int index = 0; %>
<%for (MessageBean single_message : message){%>
    <tr>
      <td> <%=single_message.getSubject() %> </td>
      <td> <%=single_message.getTo() %> </td>
      <td> <%=single_message.getSentDate() %> </td>
	  <td><a href="readReminder.jsp?read=<%= index %>">Read</a></td>
    </tr>
<%   index++;
	}
%>
  </table>
 <%
        if(message.size()==0){ %>
        <p> No reminders send !</p>
<% } %>
  <%@include file="/footer.jsp" %>



