package edu.ncsu.csc.itrust.unit.dao.labprocedure;

import java.util.List;
import java.sql.SQLException;

import junit.framework.TestCase;
import edu.ncsu.csc.itrust.beans.LabProcedureBean;
import edu.ncsu.csc.itrust.dao.mysql.LabProcedureDAO;
import edu.ncsu.csc.itrust.exception.DBException;
import edu.ncsu.csc.itrust.unit.datagenerators.TestDataGenerator;
import edu.ncsu.csc.itrust.unit.testutils.TestDAOFactory;

public class GetHCPPendingCountTest extends TestCase {
	private LabProcedureDAO lpDAO = TestDAOFactory.getTestInstance().getLabProcedureDAO();
	private TestDataGenerator gen;

	@Override
	protected void setUp() throws Exception {
		gen = new TestDataGenerator();
		gen.clearAllTables();
		gen.officeVisit7();
	}

	public void testGetHCPPendingCount() throws Exception {
		int count = lpDAO.getHCPPendingCount(9000000005L);
		assertEquals(0, count);
	}

	// public void testGetHCPPendingCountInvalidMid() throws Exception {
	// 	try {
	// 		lpDAO.getHCPPendingCount(-1);
	// 		fail();
	// 	} catch (DBException e) {
	// 		assertEquals("HCP id cannot be null", e.getExtendedMessage());
	// 	}
	// }
}