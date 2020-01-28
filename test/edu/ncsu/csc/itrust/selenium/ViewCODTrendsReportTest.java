package edu.ncsu.csc.itrust.selenium;

import java.util.ArrayList;
import java.util.List;

import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.htmlunit.HtmlUnitDriver;
import com.meterware.httpunit.HttpUnitOptions;
import edu.ncsu.csc.itrust.enums.TransactionType;
public class ViewCODTrendsReportTest extends iTrustSeleniumTest{

	private HtmlUnitDriver driver;
	
	@Override
	/**
	 * Sets up the test. Clears the tables then adds necessary data
	 */
	public void setUp() throws Exception {
		super.setUp();
		gen.clearAllTables();
		gen.standardData();
	}

	/**
	 * testInvalidYear
	 * @throws Exception
	 */
	public void testInvalidYear() throws Exception {
		driver = (HtmlUnitDriver)login("9000000000", "pw");
		driver.findElement(By.cssSelector("h2.panel-title")).click();
		driver.findElement(By.linkText("Patient Cause-of-death Trends Report")).click();
		assertEquals("iTrust - View Cause-of-death Trends Report", driver.getTitle());
		driver.findElement(By.name("startYear")).sendKeys("2019");
		driver.findElement(By.name("endYear")).sendKeys("2018");
		driver.findElement(By.name("submit")).click();
		assertTrue(driver.getPageSource().contains("Invalid year"));
    }

    /**
     * HCP 9000000000
     * TODOs
    */
	/**
	 * testViewCODTrendsReport1
	 * @throws Exception
	 */
    public void testViewCODTrendsReport1() throws Exception{
		driver = (HtmlUnitDriver)login("9000000000", "pw");
		driver.findElement(By.cssSelector("h2.panel-title")).click();
		driver.findElement(By.linkText("Patient Cause-of-death Trends Report")).click();
		assertEquals("iTrust - View Cause-of-death Trends Report", driver.getTitle());
		driver.findElement(By.name("startYear")).sendKeys("2019");
		driver.findElement(By.name("endYear")).sendKeys("2019");
		driver.findElement(By.name("submit")).click();
		assertTrue(driver.getPageSource().contains("Cause-of-death Trends Report for hcp"));
		assertTrue(driver.getPageSource().contains("Cause-of-death Trends Report for Female"));
		// WebElement tableElement1 = driver.findElement(By.id("reportList1"));
		// TableElement table1 = new TableElement(tableElement1);
		// assertTrue(tableElement1 != null);
		// WebElement tableElement2 = driver.findElement(By.id("reportList2"));
		// TableElement table2 = new TableElement(tableElement2);
		// assertEquals("Code: 72.00 name: Mumps quantity of deaths: 3", table1.getTableCell(0, 0));
		// assertEquals("Code: 72.00 name: Mumps quantity of deaths: 2", table2.getTableCell(0, 0));
		// assertEquals("Code: 84.50 name: Malaria quantity of deaths: 1", table2.getTableCell(0, 1));
	}
	

	/**
	 * TableElement a helper class for Selenium test htmlunitdriver retrieving
	 * data from tables.
	 */

	private class TableElement {
		List<List<WebElement>> table;
		
		/**
		 * Constructor.
		 * This object will help user to get data from each cell of the table.
		 * @param tableElement The table WebElement.
		 */
		public TableElement(WebElement tableElement) {
			table = new ArrayList<List<WebElement>>();
			List<WebElement> trCollection = tableElement.findElements(By.xpath("tbody/tr"));
			for(WebElement trElement : trCollection){
				List<WebElement> tdCollection = trElement.findElements(By.xpath("td"));
				table.add(tdCollection);
			}
			
		}
		/**
		 * Get data from given row and column cell.
		 * @param row (start from 0)
		 * @param column(start from 0)
		 * @return The WebElement in that given cell.
		 */
		public WebElement getTableCell(int row, int column){
			return table.get(row).get(column);
		}
		
	}

}