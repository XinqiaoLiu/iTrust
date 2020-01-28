package edu.ncsu.csc.itrust.unit.action;

import junit.framework.TestCase;

import java.util.List;

import edu.ncsu.csc.itrust.action.ViewTransactionLogsAction;
import edu.ncsu.csc.itrust.beans.TransactionBean;
import edu.ncsu.csc.itrust.dao.DAOFactory;
import edu.ncsu.csc.itrust.dao.mysql.AuthDAO;
import edu.ncsu.csc.itrust.dao.mysql.PatientDAO;
import edu.ncsu.csc.itrust.unit.datagenerators.TestDataGenerator;
import edu.ncsu.csc.itrust.unit.testutils.TestDAOFactory;


public class ViewTransactionLogsActionTest extends TestCase {
    private DAOFactory factory = TestDAOFactory.getTestInstance();
    private TestDataGenerator gen;
    private ViewTransactionLogsAction action;

    @Override
    protected void setUp() throws Exception {
        super.setUp();
		gen = new TestDataGenerator();
		gen.clearAllTables();
        gen.standardData();
        gen.transactionLog();
        
        action = new ViewTransactionLogsAction(factory);
    }

    public void testValidateDates() throws Exception{
        assertFalse(action.validateDates(null, null));
        assertFalse(action.validateDates("naSddd", "naSddd"));
        assertFalse(action.validateDates("2019-01-01", "2019-01-01"));
        assertFalse(action.validateDates("2019-12-31", "2019-01-01"));
        assertTrue(action.validateDates("2019-01-01", "2019-12-31"));
    }

    public void testView() throws Exception{
        List<TransactionBean> list = action.view("admin", "patient", "2007-01-01", "2007-12-31", 1900);
        assertEquals(2, list.size());
        list = action.view("admin", "patient", "2007-01-01", "2007-06-23", 1900);
        assertEquals(1, list.size());
        list = action.view("All roles", "All roles", "2007-01-01", "2007-06-23", 0);
        // for (TransactionBean t : list){
        //     System.out.println(t.getAddedInfo());
        // }
        assertEquals(23, list.size());
    }

    
}