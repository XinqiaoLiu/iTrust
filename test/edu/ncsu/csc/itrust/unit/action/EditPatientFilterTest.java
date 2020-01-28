package edu.ncsu.csc.itrust.unit.action;
import org.junit.Test;
import junit.framework.TestCase;
import edu.ncsu.csc.itrust.action.EditPatientAction;
import edu.ncsu.csc.itrust.beans.PatientBean;
import edu.ncsu.csc.itrust.dao.DAOFactory;
import edu.ncsu.csc.itrust.dao.mysql.AuthDAO;
import edu.ncsu.csc.itrust.dao.mysql.PatientDAO;
import edu.ncsu.csc.itrust.exception.ITrustException;
import edu.ncsu.csc.itrust.unit.datagenerators.TestDataGenerator;
import edu.ncsu.csc.itrust.unit.testutils.TestDAOFactory;
import edu.ncsu.csc.itrust.exception.FormValidationException;



import edu.ncsu.csc.itrust.enums.Ethnicity;
import edu.ncsu.csc.itrust.enums.Gender;


public class EditPatientFilterTest extends TestCase {
    PatientDAO patientDAO = TestDAOFactory.getTestInstance().getPatientDAO();
    TestDataGenerator gen = new TestDataGenerator();

    @Override
    protected void setUp() throws Exception {
        gen.clearAllTables();
        gen.standardData();
    }

    @Test
    public void testEditPatientFilter() throws Exception {
        PatientBean p = patientDAO.getPatient(2);
        p.setFirstName("Person2");
        p.setEmail("another email");
        p.setEmergencyName("another emergency person");
        p.setTopicalNotes("some topical notes");
        p.setDateOfBirthStr("05/20/1984");
        p.setDateOfDeactivationStr("05/21/1984");
        p.setMessageFilter("Kelly,,,,,");
        patientDAO.editPatient(p, 9000000003L);

        p = patientDAO.getPatient(2);
        assertEquals("Kelly,,,,,", p.getMessageFilter());
        assertEquals("Person2", p.getFirstName());
        assertEquals("Programmer", p.getLastName());
        assertEquals("another email", p.getEmail());
        assertEquals("another emergency person", p.getEmergencyName());
        assertEquals("some topical notes", p.getTopicalNotes());
        assertEquals("05/20/1984", p.getDateOfBirthStr());
        assertEquals("05/21/1984", p.getDateOfDeactivationStr());
        assertEquals("250.10", p.getCauseOfDeath());
        assertEquals("344 Bob Street", p.getStreetAddress1());
        assertEquals("", p.getStreetAddress2());
        assertEquals("Raleigh", p.getCity());
        assertEquals("NC", p.getState());
        assertEquals("27607", p.getZip());
        assertEquals("555-555-5555", p.getPhone());
        assertEquals("555-555-5551", p.getEmergencyPhone());
        assertEquals("IC", p.getIcName());
        assertEquals("Street1", p.getIcAddress1());
        assertEquals("Street2", p.getIcAddress2());
        assertEquals("City", p.getIcCity());
        assertEquals("PA", p.getIcState());
        assertEquals("19003-2715", p.getIcZip());
        assertEquals("555-555-5555", p.getIcPhone());
        assertEquals("1", p.getIcID());
        assertEquals("1", p.getMotherMID());
        assertEquals("0", p.getFatherMID());
        assertEquals("O-", p.getBloodType().getName());
        assertEquals(Ethnicity.Caucasian, p.getEthnicity());
        assertEquals(Gender.Male, p.getGender());
    }

    @Test
    public void testEditPatientFilter2() throws Exception {
        PatientBean p = patientDAO.getPatient(2);
        p.setFirstName("Person1");
        p.setEmail("another email");
        p.setEmergencyName("another emergency person");
        p.setTopicalNotes("some topical notes");
        p.setDateOfBirthStr("05/20/1984");
        p.setDateOfDeactivationStr("05/21/1984");
        p.setMessageFilter("Kelly,,,,,");
        patientDAO.editPatient(p, 9000000003L);

        p = patientDAO.getPatient(2);
        assertFalse(p.getMessageFilter().equals("Andy,,,,,"));
        assertEquals("Person1", p.getFirstName());
        assertEquals("Programmer", p.getLastName());
        assertEquals("another email", p.getEmail());
        assertEquals("another emergency person", p.getEmergencyName());
        assertEquals("some topical notes", p.getTopicalNotes());
        assertEquals("05/20/1984", p.getDateOfBirthStr());
        assertEquals("05/21/1984", p.getDateOfDeactivationStr());
        assertEquals("250.10", p.getCauseOfDeath());
        assertEquals("344 Bob Street", p.getStreetAddress1());
        assertEquals("", p.getStreetAddress2());
        assertEquals("Raleigh", p.getCity());
        assertEquals("NC", p.getState());
        assertEquals("27607", p.getZip());
        assertEquals("555-555-5555", p.getPhone());
        assertEquals("555-555-5551", p.getEmergencyPhone());
        assertEquals("IC", p.getIcName());
        assertEquals("Street1", p.getIcAddress1());
        assertEquals("Street2", p.getIcAddress2());
        assertEquals("City", p.getIcCity());
        assertEquals("PA", p.getIcState());
        assertEquals("19003-2715", p.getIcZip());
        assertEquals("555-555-5555", p.getIcPhone());
        assertEquals("1", p.getIcID());
        assertEquals("1", p.getMotherMID());
        assertEquals("0", p.getFatherMID());
        assertEquals("O-", p.getBloodType().getName());
        assertEquals(Ethnicity.Caucasian, p.getEthnicity());
        assertEquals(Gender.Male, p.getGender());
    }

    @Test
    public void testEditPatientFilter3() throws Exception {
        PatientBean p = patientDAO.getPatient(2);
        p.setFirstName("Person1");
        p.setEmail("another email");
        p.setEmergencyName("another emergency person");
        p.setTopicalNotes("some topical notes");
        p.setDateOfBirthStr("05/20/1984");
        p.setDateOfDeactivationStr("05/21/1984");
        patientDAO.editPatient(p, 9000000003L);

        p = patientDAO.getPatient(2);

        assertTrue(p.getMessageFilter().equals(""));
        assertEquals("Person1", p.getFirstName());
        assertEquals("Programmer", p.getLastName());
        assertEquals("another email", p.getEmail());
        assertEquals("another emergency person", p.getEmergencyName());
        assertEquals("some topical notes", p.getTopicalNotes());
        assertEquals("05/20/1984", p.getDateOfBirthStr());
        assertEquals("05/21/1984", p.getDateOfDeactivationStr());
        assertEquals("250.10", p.getCauseOfDeath());
        assertEquals("344 Bob Street", p.getStreetAddress1());
        assertEquals("", p.getStreetAddress2());
        assertEquals("Raleigh", p.getCity());
        assertEquals("NC", p.getState());
        assertEquals("27607", p.getZip());
        assertEquals("555-555-5555", p.getPhone());
        assertEquals("555-555-5551", p.getEmergencyPhone());
        assertEquals("IC", p.getIcName());
        assertEquals("Street1", p.getIcAddress1());
        assertEquals("Street2", p.getIcAddress2());
        assertEquals("City", p.getIcCity());
        assertEquals("PA", p.getIcState());
        assertEquals("19003-2715", p.getIcZip());
        assertEquals("555-555-5555", p.getIcPhone());
        assertEquals("1", p.getIcID());
        assertEquals("1", p.getMotherMID());
        assertEquals("0", p.getFatherMID());
        assertEquals("O-", p.getBloodType().getName());
        assertEquals(Ethnicity.Caucasian, p.getEthnicity());
        assertEquals(Gender.Male, p.getGender());
    }

    @Test
    public void testEditPatientException() throws Exception {
        try {
            patientDAO.editPatient(null, 0);
            fail();
        }
        catch(Exception e) {
            // pass
        }
    }
}