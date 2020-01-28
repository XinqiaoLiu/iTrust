package edu.ncsu.csc.itrust.selenium;

import java.sql.Timestamp;
import java.util.Date;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import org.junit.Before;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.htmlunit.HtmlUnitDriver;
import org.openqa.selenium.support.ui.Select;
import edu.ncsu.csc.itrust.enums.TransactionType;
import org.openqa.selenium.JavascriptExecutor;	


public class ViewTransactionLogsTest extends iTrustSeleniumTest {
    private HtmlUnitDriver driver;

    
	/**
	 * Sets up the test. Clears the tables then adds necessary data
	 */
    @Override
	public void setUp() throws Exception {
		super.setUp();
		gen.clearAllTables();
		gen.standardData();
    }
    
    public void testAdminMainFlow() throws Exception {
        driver = (HtmlUnitDriver)login("9000000001", "pw");
        driver.setJavascriptEnabled(true);
        driver.findElement(By.cssSelector("h2.panel-title")).click();
        driver.findElement(By.linkText("View Transaction Logs")).click();
        assertEquals("iTrust - View Transaction Logs", driver.getTitle());
        Select dropdown = new Select(driver.findElement(By.name("login_user")));
        dropdown.selectByValue("admin");
        Select dropdown2 = new Select(driver.findElement(By.name("secondary_user")));
        dropdown2.selectByValue("patient");
        Select dropdown3 = new Select(driver.findElement(By.name("transactionType")));
        dropdown3.selectByValue("1900");
        driver.findElement(By.name("startdate")).clear();
        driver.findElement(By.name("startdate")).sendKeys("2007-01-01");
        driver.findElement(By.name("enddate")).clear();
        driver.findElement(By.name("enddate")).sendKeys("2007-06-23");
        driver.findElement(By.cssSelector("input[name='view']")).submit();
        assertTrue(driver.getPageSource().contains("Total 1 transactions found."));
        
        WebElement cell = driver.findElement(By.xpath("//*[@id=\"iTrustContent\"]/table/tbody/tr[3]/td[4]"));
        assertEquals("View prescription report", cell.getText());
        cell = driver.findElement(By.xpath("//*[@id=\"iTrustContent\"]/table/tbody/tr[3]/td[6]"));
        assertEquals("2007-06-22 06:54:59.0", cell.getText());        
    }
    
    public void testTesterMainFlow() throws Exception {
        driver = (HtmlUnitDriver)login("9999999999", "pw");
        driver.setJavascriptEnabled(true);
        driver.findElement(By.cssSelector("h2.panel-title")).click();
        driver.findElement(By.linkText("View Transaction Logs")).click();
        assertEquals("iTrust - View Transaction Logs", driver.getTitle());
        Select dropdown = new Select(driver.findElement(By.name("login_user")));
        dropdown.selectByValue("admin");
        Select dropdown2 = new Select(driver.findElement(By.name("secondary_user")));
        dropdown2.selectByValue("patient");
        Select dropdown3 = new Select(driver.findElement(By.name("transactionType")));
        dropdown3.selectByValue("1900");
        driver.findElement(By.name("startdate")).clear();
        driver.findElement(By.name("startdate")).sendKeys("2007-01-01");
        driver.findElement(By.name("enddate")).clear();
        driver.findElement(By.name("enddate")).sendKeys("2007-06-23");
        driver.findElement(By.cssSelector("input[name='view']")).submit();
        assertTrue(driver.getPageSource().contains("Total 1 transactions found."));
        
        WebElement cell = driver.findElement(By.xpath("//*[@id=\"iTrustContent\"]/table/tbody/tr[3]/td[4]"));
        assertEquals("View prescription report", cell.getText());
        cell = driver.findElement(By.xpath("//*[@id=\"iTrustContent\"]/table/tbody/tr[3]/td[6]"));
        assertEquals("2007-06-22 06:54:59.0", cell.getText());        
    }
    
    public void testAdminInvalidDate() throws Exception {
        driver = (HtmlUnitDriver)login("9000000001", "pw");
        driver.setJavascriptEnabled(true);
        driver.findElement(By.cssSelector("h2.panel-title")).click();
        driver.findElement(By.linkText("View Transaction Logs")).click();
        assertEquals("iTrust - View Transaction Logs", driver.getTitle());
        driver.findElement(By.name("startdate")).clear();
        driver.findElement(By.name("startdate")).sendKeys("2007-01-01");
        driver.findElement(By.name("enddate")).clear();
        driver.findElement(By.name("enddate")).sendKeys("2006-06-23");
        driver.findElement(By.cssSelector("input[name='view']")).submit();
        assertTrue(driver.getPageSource().contains("Invalid date input!"));  
    }

}