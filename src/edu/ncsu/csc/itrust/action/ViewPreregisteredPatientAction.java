package edu.ncsu.csc.itrust.action;

import java.util.List;

import edu.ncsu.csc.itrust.beans.PatientBean;
import edu.ncsu.csc.itrust.dao.DAOFactory;
import edu.ncsu.csc.itrust.dao.mysql.PatientDAO;
import edu.ncsu.csc.itrust.exception.DBException;

/**
 * 
 * Action class for viewPreregisteredPatient.jsp
 *
 */
public class ViewPreregisteredPatientAction {
    private long loggedInMID;
    private PatientDAO patientDao;
    private List<PatientBean> prepatients;
    /**
	 * Set up defaults
	 * @param factory The DAOFactory used to create the DAOs used in this action.
	 * @param loggedInMID The MID of the person viewing the office visits.
	 */
    public ViewPreregisteredPatientAction(DAOFactory factory, long loggedInMID) {
        this.loggedInMID = loggedInMID;
        this.patientDao = factory.getPatientDAO();
    }

    /**
     * Get the list of all pre-registered patient
     * 
     * @return the list of patients an HCP has had office visits with
     * @throws DBException
     */
    public List<PatientBean> getPrepatient(){
        try{
            prepatients = patientDao.getAllPrepatients();
        } catch (DBException e){
            
        }
        return prepatients;
    }

    /**
     * Activate specific Prepatient
     * 
     * @return the list of patients an HCP has had office visits with
     * @throws DBException
     */
    public boolean activatePrepatient(long prepatientMID){
        boolean result = false;
        try{
            result = patientDao.changeRole(prepatientMID, "patient");
        } catch (DBException e){
            
        }
        return result;
    }

    /**
     * Deactivate specific Prepatient
     * 
     * @return the list of patients an HCP has had office visits with
     * @throws DBException
     */
    public boolean deactivatePrepatient(long prepatientMID){
        boolean result = false;
        try{
            result = patientDao.deletePatient(prepatientMID);
        } catch (DBException e){
            
        }
        return result;
    }
}