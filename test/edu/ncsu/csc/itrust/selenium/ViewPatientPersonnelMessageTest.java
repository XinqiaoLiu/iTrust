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

public class ViewPatientPersonnelMessageTest extends iTrustSeleniumTest{
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

    public void testPatientMessageSort() throws Exception{
        driver = (HtmlUnitDriver)login("1","pw");
        driver.setJavascriptEnabled(true);
        driver.findElement(By.cssSelector("h2.panel-title")).click();
        driver.findElement(By.linkText("Message Outbox")).click();
        assertEquals("iTrust - View My Sent Messages", driver.getTitle());
        Select dropdown = new Select(driver.findElement(By.name("sortby")));
        dropdown.selectByValue("name");
        Select dropdown2 = new Select(driver.findElement(By.name("sorthow")));
        dropdown2.selectByValue("asce");
        driver.findElement(By.cssSelector("input[name='sort']")).submit();
        WebElement cell = driver.findElement(By.xpath("//*[@id=\"iTrustContent\"]/div/table/tbody/tr[2]/td[1]"));
        assertEquals("Random Person", cell.getText());
    }

    public void testPersonnelMessageSort() throws Exception{
        driver = (HtmlUnitDriver)login("9000000000","pw");
        driver.setJavascriptEnabled(true);
        driver.findElement(By.cssSelector("h2.panel-title")).click();
        driver.findElement(By.linkText("Message Inbox")).click();
        assertEquals("iTrust - View My Message", driver.getTitle());
        Select dropdown = new Select(driver.findElement(By.name("sortby")));
        dropdown.selectByValue("name");
        Select dropdown2 = new Select(driver.findElement(By.name("sorthow")));
        dropdown2.selectByValue("asce");
        driver.findElement(By.cssSelector("input[name='sort']")).submit();
        WebElement cell = driver.findElement(By.xpath("//*[@id=\"iTrustContent\"]/div/table/tbody/tr[2]/td[1]"));
        assertEquals("Random Person", cell.getText());
    }


}