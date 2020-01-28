package edu.ncsu.csc.itrust.selenium;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.htmlunit.HtmlUnitDriver;

/**
 * Test class for preregister into iTrust.
 */
public class PreregisterTest extends iTrustSeleniumTest {
	/*
	 * The URL for iTrust, change as needed
	 */
	/** ADDRESS */
	public static final String ADDRESS = "http://localhost:8080/iTrust/";

	/**
	 * Set up for testing.
	 */
	protected void setUp() throws Exception {
		super.setUp();
		gen.clearAllTables();
		// gen.standardData();
		// turn off htmlunit warnings
		java.util.logging.Logger.getLogger("com.gargoylesoftware.htmlunit").setLevel(java.util.logging.Level.OFF);
		java.util.logging.Logger.getLogger("org.apache.http").setLevel(java.util.logging.Level.OFF);
	}

	public void testPreregisterGUI() throws Exception {
		HtmlUnitDriver driver = new HtmlUnitDriver();
		driver.get(ADDRESS);
		driver.findElement(By.name("pre-registerNav")).click();
		driver.get(ADDRESS + "/util/preregister.jsp");
		assertEquals("iTrust - New patient pre-registration", driver.getTitle());
	}

	public void testRegisterUser() throws Exception {
		WebDriver driver = new HtmlUnitDriver();
		driver.get(ADDRESS + "/util/preregister.jsp");
		assertEquals("iTrust - New patient pre-registration", driver.getTitle());
		WebElement firstName = driver.findElement(By.name("firstName"));
		firstName.sendKeys("French");
		WebElement lastName = driver.findElement(By.name("lastName"));
		lastName.sendKeys("Toast");
		WebElement email = driver.findElement(By.name("email"));
		email.sendKeys("abcd@illinois.edu");
		WebElement password = driver.findElement(By.name("password"));
		password.sendKeys("password");
		WebElement validatePassword = driver.findElement(By.name("validatePassword"));
		validatePassword.sendKeys("password");
		driver.findElement(By.xpath("//button[contains(text(), 'Register')]")).submit();
		WebElement message = driver.findElement(By.xpath("//h4[contains(text(), 'Register complete')]"));
		assertNotNull(message); 
		
		driver = login("1", "password");
		System.out.println(driver.getTitle());
		assertEquals("iTrust - Prepatient Home", driver.getTitle());
	}
}