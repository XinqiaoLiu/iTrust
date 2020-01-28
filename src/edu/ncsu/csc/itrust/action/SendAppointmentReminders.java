package edu.ncsu.csc.itrust.action;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.sql.Timestamp;
import java.util.Calendar;
import java.util.Date;
import java.util.ArrayList;
import java.util.List;

import edu.ncsu.csc.itrust.DBUtil;
import edu.ncsu.csc.itrust.EmailUtil;
import edu.ncsu.csc.itrust.beans.Email;
import edu.ncsu.csc.itrust.beans.MessageBean;
import edu.ncsu.csc.itrust.beans.PatientBean;
import edu.ncsu.csc.itrust.beans.PersonnelBean;
import edu.ncsu.csc.itrust.beans.ApptBean;
import edu.ncsu.csc.itrust.dao.DAOFactory;
import edu.ncsu.csc.itrust.dao.mysql.MessageDAO;
import edu.ncsu.csc.itrust.dao.mysql.PatientDAO;
import edu.ncsu.csc.itrust.dao.mysql.PersonnelDAO;
import edu.ncsu.csc.itrust.dao.mysql.FakeEmailDAO;
import edu.ncsu.csc.itrust.dao.mysql.ApptDAO;
import edu.ncsu.csc.itrust.exception.DBException;
import edu.ncsu.csc.itrust.exception.FormValidationException;
import edu.ncsu.csc.itrust.exception.ITrustException;
import edu.ncsu.csc.itrust.validate.EMailValidator;
import edu.ncsu.csc.itrust.validate.MessageValidator;
import edu.ncsu.csc.itrust.enums.TransactionType;

public class SendAppointmentReminders{
  private long adminMID;
  private DAOFactory prodDAO;
  private MessageDAO messageDAO;
  private FakeEmailDAO fakeEmailDAO;
  private ApptDAO apptDAO;
  private PatientDAO patientDAO;
  private PersonnelDAO personnelDAO;
  private EventLoggingAction logger;  

  /**
	 * Sets up defaults
	 * @param f The DAOFactory used to create the DAOs used in this action.
	 */
  public SendAppointmentReminders(DAOFactory f){
    this.prodDAO = f;
    this.adminMID = 9000000001L;
    this.messageDAO = f.getMessageDAO();
    this.fakeEmailDAO = f.getFakeEmailDAO();
    this.apptDAO = f.getApptDAO();
    this.patientDAO = f.getPatientDAO();
    this.personnelDAO = f.getPersonnelDAO();
    this.logger = new EventLoggingAction(f);
  }

  /**
	 * Sends appointment reminder message
   * @param numDays The num of days within which the appointment reminder should be sent.
   * @throws Exception
	 */
  public void send(int numDays) throws Exception, SQLException, ITrustException{
    List<ApptBean> appts = this.apptDAO.getUpcomingAppointmentForReminder(numDays);
    int numOfAppts = appts.size();

    for(int i = 0; i < numOfAppts; i++){
      ApptBean aAppt = appts.get(i);
      PatientBean aPatient = this.patientDAO.getPatientFromMID(aAppt.getPatient());

      long apptPatient = aAppt.getPatient();
    
      long apptHcp = aAppt.getHcp();
      Timestamp apptDate = aAppt.getDate();
      String doctor = personnelDAO.getName(apptHcp);

      String subject = "Reminder: upcoming appointment in " + numDays + " day(s)";
      String body = "You have an appointment on " + apptDate.toString() + " with Dr. " + doctor;

      Calendar calendar = Calendar.getInstance();
      calendar.setTime(new Date());
      Date currD = calendar.getTime();
      Timestamp currTime = new Timestamp(currD.getTime());

      MessageBean mb = new MessageBean();
      mb.setTo(apptPatient);
      mb.setFrom(this.adminMID);
      mb.setSubject(subject);
      mb.setBody(body);
      mb.setSentDate(currTime);

      this.messageDAO.addMessage(mb);

      List<String> toAddr = new ArrayList<String>();
      String patientEmail = aPatient.getEmail();
      toAddr.add(patientEmail);

      Email e = new Email();;
      e.setToList(toAddr);
      e.setFrom("System Reminder");
      e.setSubject(subject);
      e.setBody(body);
      e.setTimeAdded(currTime);

      this.fakeEmailDAO.sendEmailRecord(e);

      logger.logEvent(TransactionType.MESSAGE_SEND, this.adminMID, aPatient.getMID(), "Send Appointment Reminder message");
    }
  }

}
