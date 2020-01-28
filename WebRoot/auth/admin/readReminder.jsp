<%@taglib prefix="itrust" uri="/WEB-INF/tags.tld"%>
<%@page errorPage="/auth/exceptionHandler.jsp"%>
<%@page import="edu.ncsu.csc.itrust.BeanBuilder"%>
<%@page import="edu.ncsu.csc.itrust.action.ViewMyMessagesAction"%>
<%@page import="edu.ncsu.csc.itrust.beans.MessageBean"%>
<%@page import="java.util.*"%>

<%@include file="/global.jsp" %>

<%
pageTitle = "iTrust - Read Reminder Message";
%>

<%@include file="/header.jsp" %>
<%
    loggingAction.logEvent(TransactionType.OUTBOX_VIEW, loggedInMID.longValue(),0,"");
    ViewMyMessagesAction action = new ViewMyMessagesAction(prodDAO,loggedInMID.longValue());
    MessageBean target_reminder = null;
    String msg_para = request.getParameter("read");
    int msg_idx = 0;
    List<MessageBean> reminders = (List<MessageBean>)session.getAttribute("reminders");
    if(msg_para!=null){
        try{
            msg_idx = Integer.parseInt(msg_para);
        }
        catch (NumberFormatException e){
            response.sendRedirect("reminderOutbox.jsp");
        }
        if(msg_idx>reminders.size() || msg_idx<0 || reminders==null){
            msg_idx = 0;
            response.sendRedirect("reminderOutbox.jsp");
        }
        target_reminder = (MessageBean)(reminders.get(msg_idx));
        session.setAttribute("reminder",target_reminder);
    }
    else{
        response.sendRedirect("reminderOutbox.jsp");
    }
%>
  <table>
    <tr>
        <th>subject</th>
        <th>recipient name</th>
        <th>timestamp</th>
    </tr>

    <tr>
        <td> <%=target_reminder.getSubject() %> </td>
        <td> <%=action.getName(target_reminder.getTo()) %> </td>
        <td> <%=target_reminder.getSentDate() %> </td>
    </tr>
  </table>
  <p>
    <%=target_reminder.getBody() %>
  </p>


  <%@include file="/footer.jsp" %>
