package com.selenium.learn;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;


public class HelloSelenium {

WebDriver driver;
String url = "http://localhost:8100/";

@Before
public void setUp() {
//Set the key/value property according to the browser you are using.
System.setProperty("webdriver.chrome.driver","/home/maxime/selenium_setup/chromedriver");
 
//Open browser instance
driver = new ChromeDriver();

//Open the AUT
driver.get(url);
}
 
@Test
public void test() throws InterruptedException {
//Fetch the page title
String pageTitle = driver.getTitle();
String at = "EPI CORON";

if(pageTitle.equalsIgnoreCase(at)) {
	System.out.println("Test Succcesful");
} else {
	System.out.println("Test failed");
}
 
//Hey EPI CORON
driver.findElement(By.id("email")).sendKeys("aszymoni0@furl.net");
Thread.sleep(3000);
driver.findElement(By.id("password")).sendKeys("password");
Thread.sleep(2000); 
driver.findElement(By.name("btnK")).click();
Thread.sleep(5000);

}
 
@After
public void tearDown() {
//Close the browser
driver.close();

}
}