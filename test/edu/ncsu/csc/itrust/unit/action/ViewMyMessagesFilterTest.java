package edu.ncsu.csc.itrust.unit.action;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.List;

import edu.ncsu.csc.itrust.action.ViewMyMessagesAction;
import edu.ncsu.csc.itrust.beans.MessageBean;
import edu.ncsu.csc.itrust.dao.DAOFactory;
import edu.ncsu.csc.itrust.dao.mysql.MessageDAO;
import edu.ncsu.csc.itrust.exception.DBException;
import edu.ncsu.csc.itrust.exception.FormValidationException;
import edu.ncsu.csc.itrust.exception.ITrustException;
import edu.ncsu.csc.itrust.unit.datagenerators.TestDataGenerator;
import edu.ncsu.csc.itrust.unit.testutils.EvilDAOFactory;
import edu.ncsu.csc.itrust.unit.testutils.TestDAOFactory;
import junit.framework.TestCase;

public class ViewMyMessagesFilterTest extends TestCase {

    private ViewMyMessagesAction action;
    private DAOFactory factory;
    private long mId = 2L;

    @Override
    protected void setUp() throws Exception {
        super.setUp();

        TestDataGenerator gen = new TestDataGenerator();
        gen.clearAllTables();
        gen.standardData();

        this.factory = TestDAOFactory.getTestInstance();
        this.action = new ViewMyMessagesAction(this.factory, this.mId);
    }

    /**
     * testValidateAndCreateFilter
     */
    public void testValidateAndCreateFilter() {
        String valid = action.validateAndCreateFilter("Random Person,Appointment,Appointment,Lab,01/01/2010,01/31/2010");
        assertEquals(valid, "Random Person,Appointment,Appointment,Lab,01/01/2010,01/31/2010");
    }

}