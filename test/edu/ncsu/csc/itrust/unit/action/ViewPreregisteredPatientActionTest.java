package edu.ncsu.csc.itrust.unit.action;

import java.util.List;

import edu.ncsu.csc.itrust.action.ViewPreregisteredPatientAction;
import edu.ncsu.csc.itrust.beans.PatientBean;
import edu.ncsu.csc.itrust.dao.DAOFactory;
import edu.ncsu.csc.itrust.unit.datagenerators.TestDataGenerator;
import edu.ncsu.csc.itrust.unit.testutils.TestDAOFactory;
import junit.framework.TestCase;

public class ViewPreregisteredPatientActionTest extends TestCase{
    private DAOFactory factory = TestDAOFactory.getTestInstance();
    private TestDataGenerator gen = new TestDataGenerator();
    private ViewPreregisteredPatientAction action;

    @Override
    protected void setUp() throws Exception{
        action = new ViewPreregisteredPatientAction(factory, 9000000000L);
		gen.clearAllTables();
		gen.standardData();
    }

    /**
	 * testGetPrepatient
	 * @throws Exception
	 */
    public void testGetPrepatient(){
        List<PatientBean> pplist = action.getPrepatient();
        assertEquals(1, pplist.size());
        assertEquals(411, pplist.get(0).getMID());
    }

    /**
	 * testGetPrepatient
	 * @throws Exception
	 */
    public void testActivatePrepatient(){
        assertTrue(action.activatePrepatient(411));
        List<PatientBean> pplist = action.getPrepatient();
        assertEquals(0, pplist.size());
    }

    /**
	 * testDeactivatePatient
	 * @throws Exception
	 */
    public void testDeactivatePatient(){
        assertTrue(action.deactivatePrepatient(411));
        List<PatientBean> pplist = action.getPrepatient();
        assertEquals(0, pplist.size());
    }


} 