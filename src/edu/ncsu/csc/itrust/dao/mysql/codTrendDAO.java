package edu.ncsu.csc.itrust.dao.mysql;

import java.util.List;
import java.util.ArrayList;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Date;
import edu.ncsu.csc.itrust.DBUtil;
import edu.ncsu.csc.itrust.dao.DAOFactory;
import edu.ncsu.csc.itrust.exception.DBException;
import edu.ncsu.csc.itrust.exception.ITrustException;

/**
 * codTrendDAO is for anything that has to do with cause-of-death trends report. 
 * Most methods access the patient table.
 * 
 * DAO stands for Database Access Object. 
 * All DAOs are intended to be reflections of the database, that is,
 * one DAO per table in the database (most of the time). 
 * For more complex sets of queries, extra DAOs are
 * added. DAOs can assume that all data has been validated and is correct.
 * 
 * DAOs should never have setters or any other parameter 
 * to the constructor than a factory. All DAOs should be
 * accessed by DAOFactory (@see {@link DAOFactory}) 
 * and every DAO should have a factory - for obtaining JDBC
 * connections and/or accessing other DAOs.
 */
public class codTrendDAO {
        private DAOFactory factory;

        public codTrendDAO(DAOFactory factory){
            this.factory = factory;
        }

        /**
         * Returns the description of a causes of death associated with the code
         * 
         * @param code code for the icdcodes
         * @return the description of a  causes of death if it exists
         * @throws DBException
         */        
        public String getCODName(String code) throws DBException, ITrustException{
            Connection conn = null;
            PreparedStatement ps = null;
            try {
                conn = factory.getConnection();
				ps = conn.prepareStatement("SELECT Description FROM icdcodes WHERE Code = (?)");
				ps.setString(1, code);
                ResultSet rs = ps.executeQuery();
                String result = null;
                if(rs.next()){
                    result = rs.getString("Description");
                }
                rs.close();
                ps.close();
                return result;
            } catch (SQLException e) {
                
                throw new DBException(e);
            } finally {
                DBUtil.closeConnection(conn, ps);
            }              
        }

        /**
         * Returns the top 2 most common causes of death for all patients during the specified 
         * time period
         * 
         * @param startD Date to begin the search
         * @param endD Date to end the search
         * @return List of patient MID's that are dead according the specified parameters
         * @throws DBException
         */
        public List<String> getTopTwoCODForAll(Date startD, Date endD) throws DBException, ITrustException {
            Connection conn = null;
            PreparedStatement ps = null;
            try {
                conn = factory.getConnection();
                ps = conn.prepareStatement("SELECT DISTINCT CauseOfDeath, COUNT(CauseOfDeath) FROM patients WHERE YEAR(?) <= YEAR(DateOfDeath) AND YEAR(DateOfDeath) <= YEAR(?) GROUP BY CauseOfDeath ORDER BY COUNT(CauseOfDeath) DESC");
				ps.setDate(1, startD);
				ps.setDate(2, endD);
                ResultSet rs = ps.executeQuery();
                int count = 2;
                List<String> rets = new ArrayList<String>();
                while(rs.next() && count > 0){
                    String result = rs.getString("CauseOfDeath");
                    if(result != null){
                        String CODName = getCODName(result);
                        rets.add("Code: " + result + " name: " + CODName + " quantity of deaths: " + rs.getString("COUNT(CauseOfDeath)"));
                        count--;
                    }
                }
                rs.close();
                ps.close();
                return rets;
            } catch (SQLException e) {
                
                throw new DBException(e);
            } finally {
                DBUtil.closeConnection(conn, ps);
            }  
        }

        /**
         * Returns the top 2 most common causes of death for all patients during the specified 
         * time period for certain HCP
         * 
         * @param hcpid HCP ID
         * @param startD Date to begin the search
         * @param endD Date to end the search
         * @return List of patient MID's that are dead according the specified parameters
         * @throws DBException
         */
        public List<String> getTopTwoCODForAllForHCP(long hcpid, Date startD, Date endD) throws DBException, ITrustException {
            Connection conn = null;
            PreparedStatement ps = null;
            try {
                conn = factory.getConnection();
                ps = conn.prepareStatement("SELECT DISTINCT CauseOfDeath, COUNT(CauseOfDeath) " + 
                                                "FROM patients INNER JOIN declaredhcp " + 
                                                "ON declaredhcp.HCPID = ? " + 
                                                "AND declaredhcp.patientID = patients.MID " + 
                                                "WHERE CauseOfDeath AND YEAR(?) <= YEAR(DateOfDeath) " +
                                                "AND YEAR(DateOfDeath) <= YEAR(?) " + 
                                                "GROUP BY CauseOfDeath " + 
                                                "ORDER BY COUNT(CauseOfDeath) DESC");
                ps.setLong(1, hcpid);                                                
				ps.setDate(2, startD);
				ps.setDate(3, endD);
                ResultSet rs = ps.executeQuery();
                int count = 2;
                List<String> rets = new ArrayList<String>();
                while(rs.next() && count > 0){
                    String result = rs.getString("CauseOfDeath");
                    if(result != null){
                        String CODName = getCODName(result);
                        rets.add("Code: " + result + " name: " + CODName + " quantity of deaths: " + rs.getString("COUNT(CauseOfDeath)"));
                        count--;
                    }
                }
                rs.close();
                ps.close();
                return rets;
            } catch (SQLException e) {
                
                throw new DBException(e);
            } finally {
                DBUtil.closeConnection(conn, ps);
            }  
        }

        /**
         * Returns the top 2 most common causes of death for male patients during the specified 
         * time period
         * 
         * @param startD Date to begin the search
         * @param endD Date to end the search
         * @return List of patient MID's that are dead according the specified parameters
         * @throws DBException
         */        
        public List<String> getTopTwoCODForMale(Date startD, Date endD) throws DBException, ITrustException {
            Connection conn = null;
            PreparedStatement ps = null;
            try {
                conn = factory.getConnection();
				ps = conn.prepareStatement("SELECT DISTINCT CauseOfDeath, COUNT(CauseOfDeath) FROM patients WHERE YEAR(?) <= YEAR(DateOfDeath) AND YEAR(DateOfDeath) <= YEAR(?) AND Gender = ? GROUP BY CauseOfDeath ORDER BY COUNT(CauseOfDeath) DESC");
				ps.setDate(1, startD);
                ps.setDate(2, endD);
                ps.setString(3, "Male");
                ResultSet rs = ps.executeQuery();
                int count = 2;
                List<String> rets = new ArrayList<String>();
                while(rs.next() && count > 0){
                    String result = rs.getString("CauseOfDeath");
                    if(result != null){
                        String CODName = getCODName(result);
                        rets.add("Code: " + result + " name: " + CODName + " quantity of deaths: " + rs.getString("COUNT(CauseOfDeath)"));
                        count--;
                    }
                }
                rs.close();
                ps.close();
                return rets;
            } catch (SQLException e) {
                
                throw new DBException(e);
            } finally {
                DBUtil.closeConnection(conn, ps);
            }  
        }

        /**
         * Returns the top 2 most common causes of death for male patients during the specified 
         * time period for certain HCP
         * 
         * @param hcpid HCP ID
         * @param startD Date to begin the search
         * @param endD Date to end the search
         * @return List of patient MID's that are dead according the specified parameters
         * @throws DBException
         */
        public List<String> getTopTwoCODForMaleForHCP(long hcpid, Date startD, Date endD) throws DBException, ITrustException {
            Connection conn = null;
            PreparedStatement ps = null;
            try {
                conn = factory.getConnection();
                ps = conn.prepareStatement("SELECT DISTINCT CauseOfDeath, COUNT(CauseOfDeath) " + 
                                                "FROM patients INNER JOIN declaredhcp " + 
                                                "ON declaredhcp.HCPID = ? " + 
                                                "AND declaredhcp.patientID = patients.MID " + 
                                                "WHERE CauseOfDeath AND YEAR(?) <= YEAR(DateOfDeath) " +
                                                "AND YEAR(DateOfDeath) <= YEAR(?) AND Gender = ? " + 
                                                "GROUP BY CauseOfDeath " + 
                                                "ORDER BY COUNT(CauseOfDeath) DESC");
                ps.setLong(1, hcpid);                                                
				ps.setDate(2, startD);
                ps.setDate(3, endD);
                ps.setString(4, "Male");
                ResultSet rs = ps.executeQuery();
                int count = 2;
                List<String> rets = new ArrayList<String>();
                while(rs.next() && count > 0){
                    String result = rs.getString("CauseOfDeath");
                    if(result != null){
                        String CODName = getCODName(result);
                        rets.add("Code: " + result + " name: " + CODName + " quantity of deaths: " + rs.getString("COUNT(CauseOfDeath)"));
                        count--;
                    }
                }
                rs.close();
                ps.close();
                return rets;
            } catch (SQLException e) {
                
                throw new DBException(e);
            } finally {
                DBUtil.closeConnection(conn, ps);
            }  
        }

        /**
         * Returns the top 2 most common causes of death for female patients during the specified 
         * time period
         * 
         * @param startD Date to begin the search
         * @param endD Date to end the search
         * @return List of patient MID's that are dead according the specified parameters
         * @throws DBException
         */   
        public List<String> getTopTwoCODForFemale(Date startD, Date endD) throws DBException, ITrustException {
            Connection conn = null;
            PreparedStatement ps = null;
            try {
                conn = factory.getConnection();
				ps = conn.prepareStatement("SELECT DISTINCT CauseOfDeath, COUNT(CauseOfDeath) FROM patients WHERE YEAR(?) <= YEAR(DateOfDeath) AND YEAR(DateOfDeath) <= YEAR(?) AND Gender = ? GROUP BY CauseOfDeath ORDER BY COUNT(CauseOfDeath) DESC");
				ps.setDate(1, startD);
                ps.setDate(2, endD);
                ps.setString(3, "Female");
                ResultSet rs = ps.executeQuery();
                int count = 2;
                List<String> rets = new ArrayList<String>();
                while(rs.next() && count > 0){
                    String result = rs.getString("CauseOfDeath");
                    if(result != null){
                        String CODName = getCODName(result);
                        rets.add("Code: " + result + " name: " + CODName + " quantity of deaths: " + rs.getString("COUNT(CauseOfDeath)"));
                        count--;
                    }
                }
                rs.close();
                ps.close();
                return rets;
            } catch (SQLException e) {
                
                throw new DBException(e);
            } finally {
                DBUtil.closeConnection(conn, ps);
            }  
        }

       /**
         * Returns the top 2 most common causes of death for female patients during the specified 
         * time period for certain HCP
         * 
         * @param hcpid HCP ID
         * @param startD Date to begin the search
         * @param endD Date to end the search
         * @return List of patient MID's that are dead according the specified parameters
         * @throws DBException
         */
        public List<String> getTopTwoCODForFemaleForHCP(long hcpid, Date startD, Date endD) throws DBException, ITrustException {
            Connection conn = null;
            PreparedStatement ps = null;
            try {
                conn = factory.getConnection();
                ps = conn.prepareStatement("SELECT DISTINCT CauseOfDeath, COUNT(CauseOfDeath) " + 
                                                "FROM patients INNER JOIN declaredhcp " + 
                                                "ON declaredhcp.HCPID = ? " + 
                                                "AND declaredhcp.patientID = patients.MID " + 
                                                "WHERE CauseOfDeath AND YEAR(?) <= YEAR(DateOfDeath) " +
                                                "AND YEAR(DateOfDeath) <= YEAR(?) AND Gender = ? " + 
                                                "GROUP BY CauseOfDeath " + 
                                                "ORDER BY COUNT(CauseOfDeath) DESC");
                ps.setLong(1, hcpid);                                                
				ps.setDate(2, startD);
                ps.setDate(3, endD);
                ps.setString(4, "Female");
                ResultSet rs = ps.executeQuery();
                int count = 2;
                List<String> rets = new ArrayList<String>();
                while(rs.next() && count > 0){
                    String result = rs.getString("CauseOfDeath");
                    if(result != null){
                        String CODName = getCODName(result);
                        rets.add("Code: " + result + " name: " + CODName + " quantity of deaths: " + rs.getString("COUNT(CauseOfDeath)"));
                        count--;
                    }
                }
                rs.close();
                ps.close();
                return rets;
            } catch (SQLException e) {
                
                throw new DBException(e);
            } finally {
                DBUtil.closeConnection(conn, ps);
            }  
        }

}

