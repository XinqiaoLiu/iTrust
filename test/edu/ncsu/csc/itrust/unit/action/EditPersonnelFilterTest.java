package edu.ncsu.csc.itrust.unit.action;
import junit.framework.TestCase;

import org.junit.Test;
import edu.ncsu.csc.itrust.unit.datagenerators.TestDataGenerator;
import edu.ncsu.csc.itrust.beans.PersonnelBean;
import edu.ncsu.csc.itrust.dao.mysql.PersonnelDAO;
import edu.ncsu.csc.itrust.unit.testutils.TestDAOFactory;


public class EditPersonnelFilterTest extends TestCase {
    private PersonnelDAO personnelDAO = TestDAOFactory.getTestInstance().getPersonnelDAO();

    @Override
    protected void setUp() throws Exception {
        TestDataGenerator gen = new TestDataGenerator();
        gen.clearAllTables();
        gen.standardData();
    }

    @Test
    public void testEditPersonnelFilter() throws Exception {
        PersonnelBean p = personnelDAO.getPersonnel(8000000009L);
        p.setFirstName("Person1");
        p.setEmail("blah@blah.com");
        p.setMessageFilter("Andy Programmer,,,,,");
        personnelDAO.editPersonnel(p);
        p = personnelDAO.getPersonnel(8000000009L);
        assertEquals("Person1", p.getFirstName());
        assertEquals("LastUAP", p.getLastName());
        assertEquals("blah@blah.com", p.getEmail());
        assertEquals("Andy Programmer,,,,,", p.getMessageFilter());
    }

    @Test
    public void testEditPersonnelFilter2() throws Exception {
        PersonnelBean p = personnelDAO.getPersonnel(8000000009L);
        p.setFirstName("Person3");
        p.setEmail("blahblah@blah.com");
        p.setMessageFilter("Kelly,,,,,");
        personnelDAO.editPersonnel(p);
        p = personnelDAO.getPersonnel(8000000009L);
        assertEquals("Person3", p.getFirstName());
        assertEquals("LastUAP", p.getLastName());
        assertEquals("blahblah@blah.com", p.getEmail());
        assertEquals("Kelly,,,,,", p.getMessageFilter());
        assertFalse(p.getMessageFilter().equals("Andy Programmer,,,,,"));
    }

    @Test
    public void testEditPersonnelFilter3() throws Exception {
        PersonnelBean p = personnelDAO.getPersonnel(8000000009L);
        p.setFirstName("Person2");
        p.setEmail("blahblahblah@blah.com");
        personnelDAO.editPersonnel(p);
        p = personnelDAO.getPersonnel(8000000009L);
        assertEquals("Person2", p.getFirstName());
        assertEquals("LastUAP", p.getLastName());
        assertEquals("blahblahblah@blah.com", p.getEmail());
        assertTrue(p.getMessageFilter().equals(""));
    }

    @Test
    public void testEditPersonnelException() throws Exception {
        try {
            personnelDAO.editPersonnel(null);
            fail();
        }
        catch(Exception e) {
            // pass
        }
    }

}