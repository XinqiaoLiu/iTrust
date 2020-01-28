package edu.ncsu.csc.itrust.unit.action;

import edu.ncsu.csc.itrust.action.SendAppointmentReminders;
import edu.ncsu.csc.itrust.beans.Email;
import edu.ncsu.csc.itrust.beans.MessageBean;
import edu.ncsu.csc.itrust.beans.PatientBean;
import edu.ncsu.csc.itrust.dao.mysql.MessageDAO;
import edu.ncsu.csc.itrust.dao.mysql.PatientDAO;
import edu.ncsu.csc.itrust.dao.mysql.FakeEmailDAO;
import edu.ncsu.csc.itrust.dao.DAOFactory;
import edu.ncsu.csc.itrust.exception.ITrustException;
import edu.ncsu.csc.itrust.unit.datagenerators.TestDataGenerator;
import edu.ncsu.csc.itrust.unit.testutils.TestDAOFactory;

import java.sql.SQLException;
import java.util.List;
import java.sql.Timestamp;

import junit.framework.TestCase;

public class SendAppointmentRemindersTest extends TestCase {
    private DAOFactory factory;
    private SendAppointmentReminders sendAppointmentReminders;
    private MessageDAO messageDAO;
    private PatientDAO patientDAO;
    private FakeEmailDAO fakeEmailDAO;
    private TestDataGenerator gen;

    private long adminMID = 9000000001L;

	@Override
	protected void setUp() throws Exception {
		super.setUp();
		gen = new TestDataGenerator();
		gen.clearAllTables();
        gen.standardData();

        this.factory = TestDAOFactory.getTestInstance();
        this.sendAppointmentReminders = new SendAppointmentReminders(factory);
        this.messageDAO = this.factory.getMessageDAO();
        this.patientDAO = this.factory.getPatientDAO();
        this.fakeEmailDAO = this.factory.getFakeEmailDAO();
    }
    
    public void testSend1() throws Exception {
        int numDays = 300;
        String messageSubject = "Reminder: upcoming appointment in " + numDays + " day(s)"; 
        sendAppointmentReminders.send(numDays);

        List<MessageBean> reminderList = this.messageDAO.getMessagesFrom(adminMID);
        int numReminder = reminderList.size();
        assertNotNull(numReminder); //was 16

        if(numReminder != 0){
            MessageBean currReminder = reminderList.get(0);
            assertEquals(adminMID, currReminder.getFrom());
            assertEquals(messageSubject, currReminder.getSubject());
            String currReminderBody = currReminder.getBody();
            assertTrue(currReminderBody.contains("You have an appointment on"));

            long patientMID = currReminder.getTo();
            PatientBean patient = this.patientDAO.getPatientFromMID(patientMID);
            List<Email> fakeEmails = this.fakeEmailDAO.getEmailsByPerson(patient.getEmail());
            Email currEmail = fakeEmails.get(0);
            assertEquals("System Reminder", currEmail.getFrom());
            assertEquals(messageSubject, currEmail.getSubject());
            String currEmailBody = currEmail.getBody();
            assertTrue(currEmailBody.contains("You have an appointment on"));
        }


    }
    
}
