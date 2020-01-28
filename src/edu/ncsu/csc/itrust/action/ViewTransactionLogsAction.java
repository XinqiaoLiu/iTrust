package edu.ncsu.csc.itrust.action;

import java.util.List;
import java.util.Date;
import java.text.SimpleDateFormat;
import edu.ncsu.csc.itrust.beans.TransactionBean;
import edu.ncsu.csc.itrust.dao.DAOFactory;
import edu.ncsu.csc.itrust.dao.mysql.TransactionDAO;


/**
 * 
 * Action class for viewTransactionLogs.jsp
 *
 */
public class ViewTransactionLogsAction {
	private TransactionDAO transactionDAO;

	/**
	 * Set up defaults
	 * @param factory The DAOFactory used to create the DAOs used in this action.
	 * @param loggedInMID The MID of the person viewing the report.
	 */
	public ViewTransactionLogsAction(DAOFactory factory) {
		transactionDAO = factory.getTransactionDAO();
	}

	public List<TransactionBean> view(String loginUser, String secondaryUser, String startDate, String endDate, int transactionType) throws Exception {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		List<TransactionBean> list = transactionDAO.getFilteredLogs(loginUser, secondaryUser, format.parse(startDate), format.parse(endDate), transactionType);
		return list;
	}

	public boolean validateDates(String startDate, String endDate){
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		try{
			Date start = format.parse(startDate);
			Date end = format.parse(endDate);
			return end.compareTo(start) > 0;
		} catch(Exception e){
			return false;
		}
	}
}
