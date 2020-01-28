package edu.ncsu.csc.itrust.selenium;

import org.junit.Before;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.htmlunit.HtmlUnitDriver;

import edu.ncsu.csc.itrust.selenium.iTrustSeleniumTest;

public class PrepatientActivationTest extends iTrustSeleniumTest{
    private WebDriver driver;
    
    @Before
    protected void setUp() throws Exception {
        super.setUp();
		gen.clearAllTables();
        gen.standardData();
        driver = new HtmlUnitDriver();
    }
    
    public void testActivate() throws Exception {
        driver = login("9000000000", "pw");
        assertEquals("iTrust - HCP Home", driver.getTitle());

        WebElement element = driver.findElement(By.linkText("All Pre-registered Patients"));
		element.click();
        assertTrue(driver.getPageSource().contains("Donkey John"));
        assertTrue(driver.getPageSource().contains("prepatient@gmail.com"));

        element = driver.findElement(By.xpath("//*[@id='activationForm0']/input[3]"));
        element.click();

        element = driver.findElement(By.linkText("All Pre-registered Patients"));
		element.click();
        assertFalse(driver.getPageSource().contains("prepatient@gmail.com"));
    }

    public void testPreregisterPreq() throws Exception {
		final HtmlUnitDriver driver = new HtmlUnitDriver();
		driver.get(ADDRESS);
		driver.findElement(By.name("pre-registerNav")).click();
		driver.get(ADDRESS + "/util/preregister.jsp");
		assertEquals("iTrust - New patient pre-registration", driver.getTitle());
    }
}