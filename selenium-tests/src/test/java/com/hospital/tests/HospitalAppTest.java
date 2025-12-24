package com.hospital.tests;

import org.junit.jupiter.api.MethodOrderer;
import org.junit.jupiter.api.Order;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestMethodOrder;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.CsvSource;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

import java.time.Duration;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
public class HospitalAppTest extends BaseTest {

    // Update this URL to point to your actual application
    private static final String BASE_URL = "http://localhost:3000";
    private static final String LOGIN_URL = BASE_URL + "/#/login";

    /**
     * Test Case 1: Valid Login
     */
    @Test
    @Order(1)
    void testLogin() {
        driver.get(LOGIN_URL);

        WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(10));
        
        // Locate login elements
        // Note: Replace these locators with actual IDs or CSS selectors from your app
        WebElement emailField = wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("email")));
        WebElement passwordField = driver.findElement(By.id("password"));
        WebElement loginButton = driver.findElement(By.id("loginBtn")); // or By.cssSelector("button[type='submit']")

        // Assertion: Verify fields are visible
        assertTrue(emailField.isDisplayed(), "Email field should be visible");
        assertTrue(passwordField.isDisplayed(), "Password field should be visible");

        // Action: Login
        emailField.sendKeys("admin@hospital.com");
        passwordField.sendKeys("password");
        loginButton.click();

        // Assertion: Verify successful login
        // Check for URL change or Dashboard element
        WebElement dashboard = wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("dashboard-content"))); 
        assertTrue(dashboard.isDisplayed(), "Dashboard should be visible after login");
    }

    /**
     * Test Case 2: Negative Login Scenarios
     */
    @ParameterizedTest
    @Order(2)
    @CsvSource({
        "admin@hospital.com, wrongpassword",
        "invalid@email.com, password",
        ", password",
        "admin@hospital.com, "
    })
    void testLoginNegative(String email, String password) {
        driver.get(LOGIN_URL);
        WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(5));

        WebElement emailField = wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("email")));
        WebElement passwordField = driver.findElement(By.id("password"));
        WebElement loginButton = driver.findElement(By.id("loginBtn"));

        if (email != null) emailField.sendKeys(email);
        if (password != null) passwordField.sendKeys(password);
        
        loginButton.click();

        // Assertion: Verify error message
        WebElement errorMessage = wait.until(ExpectedConditions.visibilityOfElementLocated(By.cssSelector(".alert-danger")));
        assertTrue(errorMessage.isDisplayed(), "Error message should be displayed");
    }

    /**
     * Test Case 3: Navigation
     */
    @Test
    @Order(3)
    void testNavigation() {
        // Pre-requisite: User must be logged in
        testLogin(); 

        WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(10));

        // Action: Navigate to Patients page
        WebElement patientsLink = wait.until(ExpectedConditions.elementToBeClickable(By.linkText("Patients")));
        patientsLink.click();

        // Assertion: Verify Page Title or URL
        wait.until(ExpectedConditions.urlContains("/patients"));
        assertTrue(driver.getCurrentUrl().contains("patients"), "URL should contain 'patients'");
    }

    /**
     * Test Case 4: CRUD Operations (Create, Read, Update, Delete)
     */
    @Test
    @Order(4)
    void testPatientCRUD() {
        // Pre-requisite: Login and go to Patients page
        testNavigation(); 

        WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(10));

        // --- CREATE ---
        WebElement addBtn = wait.until(ExpectedConditions.elementToBeClickable(By.id("btn-add-patient")));
        addBtn.click();

        WebElement nameInput = wait.until(ExpectedConditions.visibilityOfElementLocated(By.name("name")));
        nameInput.sendKeys("Test Patient");
        driver.findElement(By.name("address")).sendKeys("123 Test St");
        driver.findElement(By.cssSelector("button[type='submit']")).click();

        // Verify creation
        WebElement successMsg = wait.until(ExpectedConditions.visibilityOfElementLocated(By.className("alert-success")));
        assertTrue(successMsg.isDisplayed(), "Success message should be displayed");

        // --- READ ---
        // Verify the new record is valid in the table
        WebElement record = driver.findElement(By.xpath("//td[contains(text(), 'Test Patient')]"));
        assertTrue(record.isDisplayed(), "New record should be visible in the table");

        // --- UPDATE ---
        WebElement editBtn = driver.findElement(By.xpath("//tr[td[contains(text(),'Test Patient')]]//button[contains(@class,'btn-edit')]"));
        editBtn.click();

        WebElement nameEdit = wait.until(ExpectedConditions.visibilityOfElementLocated(By.name("name")));
        nameEdit.clear();
        nameEdit.sendKeys("Test Patient Updated");
        driver.findElement(By.cssSelector("button[type='submit']")).click();
        
        // Verify update
        wait.until(ExpectedConditions.visibilityOfElementLocated(By.xpath("//td[contains(text(), 'Test Patient Updated')]")));

        // --- DELETE ---
        WebElement deleteBtn = driver.findElement(By.xpath("//tr[td[contains(text(),'Test Patient Updated')]]//button[contains(@class,'btn-delete')]"));
        deleteBtn.click();

        // Confirm deletion in modal
        WebElement confirmBtn = wait.until(ExpectedConditions.elementToBeClickable(By.id("btn-confirm-delete")));
        confirmBtn.click();

        // Verify deletion
        wait.until(ExpectedConditions.invisibilityOfElementLocated(By.xpath("//td[contains(text(), 'Test Patient Updated')]")));
    }
}
