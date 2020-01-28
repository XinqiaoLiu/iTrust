package edu.ncsu.csc.itrust.unit.action;

import junit.framework.TestCase;

import edu.ncsu.csc.itrust.action.AddPreregisterPatientAction;
import edu.ncsu.csc.itrust.beans.PatientBean;
import edu.ncsu.csc.itrust.dao.DAOFactory;
import edu.ncsu.csc.itrust.dao.mysql.AuthDAO;
import edu.ncsu.csc.itrust.dao.mysql.PatientDAO;
import edu.ncsu.csc.itrust.unit.datagenerators.TestDataGenerator;
import edu.ncsu.csc.itrust.unit.testutils.TestDAOFactory;

public class AddPreregisterPatientActionTest extends TestCase {
    private DAOFactory factory = TestDAOFactory.getTestInstance();
    private TestDataGenerator gen;
    private AddPreregisterPatientAction action;

    @Override
    protected void setUp() throws Exception {
        gen = new TestDataGenerator();
		
		gen.transactionLog();
        gen.hcp0();
        action = new AddPreregisterPatientAction(factory);
    }
    public void testValidateEmail() throws Exception{
        assertTrue(action.validateEmail("neuron@illinois.edu"));
    }

    public void testValidatePassword() throws Exception{
        assertTrue(action.validatePassword(null, null));
        assertTrue(action.validatePassword("naSddd", "naSddd"));
        assertFalse(action.validatePassword("naSddd", null));
    }

    public void testAddUser() throws Exception{
        AuthDAO authDAO = factory.getAuthDAO();
        PatientDAO patientDAO = factory.getPatientDAO();
        PatientBean p = new PatientBean();
        p.setEmail("test@test.edu");
        p.setCity("Paris");
        p.setLastName("Park");
        p.setFirstName("Sunny");
        p.setPassword("password");

        long mid = action.addUser(p, 0.0, 0.0, 4);

        assertTrue(authDAO.checkUserExists(mid));
        assertEquals(p.getFullName(), authDAO.getUserName(mid)); 
        assertTrue(patientDAO.checkPatientExists(mid));
        
        assertFalse(action.validateEmail("test@test.edu"));
    }
}