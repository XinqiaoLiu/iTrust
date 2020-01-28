package edu.ncsu.csc.itrust.selenium;

import org.junit.Before;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.htmlunit.HtmlUnitDriver;

public class RatingTest extends iTrustSeleniumTest{

    @Before
    public void setUp() throws Exception {
	    // Create a new instance of the driver
	    //driver = new HtmlUnitDriver();
		super.setUp();
		gen.clearAllTables();
        gen.standardData();
    }

    public void testHCPRating() throws Exception {
        // HCP 9000000000 logs in
        WebDriver driver = (HtmlUnitDriver)login("9000000000", "pw");
        assertTrue(driver.getTitle().contains("iTrust - HCP Home"));
        assertTrue(driver.getPageSource().contains("No rating yet"));
    }

    public void testRateAppointmentAndHCPInfo() throws Exception {
        WebDriver driver = login("1", "pw"); //log in as Random Person
        assertEquals("iTrust - Patient Home", driver.getTitle());
        
        WebElement element = driver.findElement(By.linkText("View My Appointments"));
		element.click();
        assertEquals("iTrust - View My Messages", driver.getTitle());
        
        element = driver.findElement(By.xpath("//*[@id='iTrustContent']/div/table/tbody/tr[2]/td[6]/a"));
        element.click();

        assertTrue(driver.getPageSource().contains("Please Input your new rating:"));
        element = driver.findElement(By.xpath("//*[@id='score5']"));
        element.click();

        element = driver.findElement(By.cssSelector("input[value='Submit']"));
        element.submit();

        // Test HCP
        assertEquals("iTrust - View Message", driver.getTitle());
        driver.close();
        driver = login("9000000000", "pw");
        assertEquals("iTrust - HCP Home", driver.getTitle());
        assertTrue(driver.getPageSource().contains("Rating: 5.0"));

        // Check if rating apers on reqeust
        driver.close();
        driver = login("1", "pw");
        element = driver.findElement(By.linkText("Appointment Requests"));
		element.click();
        assertEquals("iTrust - Appointment Requests", driver.getTitle());
        assertTrue(driver.getPageSource().contains("Request an Appointment"));
    }

    public void testAdminUI() throws Exception {
        WebDriver driver = login("9000000001", "pw");
        assertEquals("iTrust - Admin Home", driver.getTitle());
        
        WebElement element = driver.findElement(By.linkText("Rating Information"));
        element.click();
        assertTrue(driver.getPageSource().contains("Kelly Doctor"));
        assertTrue(driver.getPageSource().contains("No Rating"));	
    }
}