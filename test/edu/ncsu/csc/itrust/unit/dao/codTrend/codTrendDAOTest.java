package edu.ncsu.csc.itrust.unit.dao.codTrend;

import java.sql.Date;
import java.util.List;

import edu.ncsu.csc.itrust.dao.DAOFactory;
import edu.ncsu.csc.itrust.dao.mysql.codTrendDAO;
import edu.ncsu.csc.itrust.unit.datagenerators.TestDataGenerator;
import edu.ncsu.csc.itrust.unit.testutils.TestDAOFactory;
import junit.framework.TestCase;

public class codTrendDAOTest extends TestCase {
        private DAOFactory factory = TestDAOFactory.getTestInstance();
        private TestDataGenerator gen = new TestDataGenerator();
        private codTrendDAO codT;

        @Override
        protected void setUp() throws Exception {
                codT = new codTrendDAO(factory);
                gen.clearAllTables();       
                gen.standardData();
        }

        public void testGetTwoMostCODForAllPatients() throws Exception {
                List<String> list = codT.getTopTwoCODForAll(Date.valueOf("2019-11-19"), Date.valueOf("2019-11-27"));
                assertEquals(2, list.size());
                assertTrue(list.get(0).contains("4"));
                assertTrue(list.get(0).contains("84.50"));
                assertTrue(list.get(0).contains("Malaria"));
                assertTrue(list.get(1).contains("3"));
                assertTrue(list.get(1).contains("72.00"));
                assertTrue(list.get(1).contains("Mumps"));
        }

        public void testGetTwoMostCODForAllPatientsForHCP() throws Exception {
                List<String> list = codT.getTopTwoCODForAllForHCP(9000000000L, Date.valueOf("2019-11-19"), Date.valueOf("2019-11-27"));
                assertEquals(2, list.size());
                assertTrue(list.get(1).contains("2"));
                assertTrue(list.get(1).contains("84.50"));
                assertTrue(list.get(1).contains("Malaria"));
                assertTrue(list.get(0).contains("3"));
                assertTrue(list.get(0).contains("72.00"));
                assertTrue(list.get(0).contains("Mumps"));
        }        

        public void testGetTwoMostCODForAllMalePatients() throws Exception {
                List<String> list = codT.getTopTwoCODForMale(Date.valueOf("2019-11-19"), Date.valueOf("2019-11-27"));
                assertEquals(2, list.size());
                assertTrue(list.get(0).contains("3"));
                assertTrue(list.get(0).contains("84.50"));
                assertTrue(list.get(0).contains("Malaria"));
                assertTrue(list.get(1).contains("1"));
                assertTrue(list.get(1).contains("72.00"));
                assertTrue(list.get(1).contains("Mumps"));
        }

        public void testGetTwoMostCODForAllMalePatientsForHCP() throws Exception {
                List<String> list = codT.getTopTwoCODForMaleForHCP(9000000000L, Date.valueOf("2019-11-19"), Date.valueOf("2019-11-27"));
                assertEquals(2, list.size());
                assertTrue(list.get(0).contains("2"));
                assertTrue(list.get(0).contains("84.50"));
                assertTrue(list.get(0).contains("Malaria"));
                assertTrue(list.get(1).contains("1"));
                assertTrue(list.get(1).contains("72.00"));
                assertTrue(list.get(1).contains("Mumps"));
        }

        public void testGetTwoMostCODForAllFemalePatients() throws Exception {
                List<String> list = codT.getTopTwoCODForFemale(Date.valueOf("2019-11-19"), Date.valueOf("2019-11-27"));
                assertEquals(2, list.size());
                assertTrue(list.get(1).contains("1"));
                assertTrue(list.get(1).contains("84.50"));
                assertTrue(list.get(1).contains("Malaria"));
                assertTrue(list.get(0).contains("2"));
                assertTrue(list.get(0).contains("72.00"));
                assertTrue(list.get(0).contains("Mumps"));
        }

        public void testGetTwoMostCODForAllFemalePatientsForHCP() throws Exception {
            List<String> list = codT.getTopTwoCODForFemaleForHCP(9000000000L, Date.valueOf("2019-11-19"), Date.valueOf("2019-11-27"));
            assertEquals(1, list.size());
            assertTrue(list.get(0).contains("2"));
            assertTrue(list.get(0).contains("72.00"));
            assertTrue(list.get(0).contains("Mumps"));
        }

}