package edu.ncsu.csc.itrust.action;

import edu.ncsu.csc.itrust.beans.HealthRecord;
import edu.ncsu.csc.itrust.beans.PatientBean;
import edu.ncsu.csc.itrust.dao.DAOFactory;
import edu.ncsu.csc.itrust.dao.mysql.AuthDAO;
import edu.ncsu.csc.itrust.dao.mysql.HealthRecordsDAO;
import edu.ncsu.csc.itrust.dao.mysql.PatientDAO;
import edu.ncsu.csc.itrust.exception.DBException;

import edu.ncsu.csc.itrust.enums.Role;

public class AddPreregisterPatientAction {
    private HealthRecordsDAO hrDAO;
    private PatientDAO patientDAO;
    private AuthDAO authDAO;

    /**
     * The typical constructor. To be implemented
     */
    public AddPreregisterPatientAction(DAOFactory factory) {
        this.hrDAO = factory.getHealthRecordsDAO();
        this.patientDAO = factory.getPatientDAO();
        this.authDAO = factory.getAuthDAO();
    }

    public boolean validatePassword(String a, String b) {
        /* when Page refreshed */
        if (a == null) {
            return true;
        }
        return a.equals(b);
    }

    public boolean validateEmail(String email) throws DBException {
        return !patientDAO.checkEmailExists(email);
    }
    
    public long addUser(PatientBean p, Double height, Double weight,
        int smoker) throws DBException {
        long mid = patientDAO.addEmptyPatient();
        p.setMID(mid);
        System.out.println(p.getDateOfDeactivationStr());
        authDAO.addUser(mid, Role.PREPATIENT, p.getPassword());
        patientDAO.editPatient(p, p.getMID());

        HealthRecord newRecord = new HealthRecord();
        newRecord.setPatientID(mid);
        newRecord.setHeight(height);
        newRecord.setWeight(weight);
        newRecord.setSmoker(smoker);
        newRecord.setOfficeVisitDateStr("00/00/0000");
        hrDAO.add(newRecord);
        return mid;
    }
}