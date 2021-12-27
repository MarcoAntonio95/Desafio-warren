//
//  LoginFlowUITests.swift
//  AppUITests
//
//  Created by Marco Antonio on 25/12/21.
//  Copyright © 2021 Warren. All rights reserved.
//

import XCTest

class LoginFlowUITests: XCTestCase {
    let app = XCUIApplication()
    var initialLoginButton: XCUIElement!
    var emailLoginTextField: XCUIElement!
    var passwordTextField: XCUIElement!
    var loginButton: XCUIElement!
    
    override func setUp() {
        self.app.launch()
        self.initialLoginButton = self.app.buttons["Login!"]
        self.emailLoginTextField = self.app.textFields["emailTextfield"]
        self.passwordTextField = self.app.secureTextFields["passwordTextfield"]
        self.loginButton = self.app.buttons["loginButton"]
    }
    
    func testLoginViewLayout(){
        XCTAssertTrue(self.initialLoginButton.exists,"The 'Login!' button is hidden")
        XCTAssertTrue(self.initialLoginButton.isEnabled,"The 'Login!' button can't be tapped")
       
        self.initialLoginButton.tap()
        
        XCTAssertTrue(self.emailLoginTextField.exists,"The 'Email' textfield is hidden")
        XCTAssertTrue(self.emailLoginTextField.isEnabled,"The 'Email' textfield can't be tapped")
        
        XCTAssertTrue(self.passwordTextField.exists,"The 'Password' textfield is hidden")
        XCTAssertTrue(self.passwordTextField.isEnabled,"The 'Password' textfield can't be tapped")
        
        XCTAssertTrue(self.loginButton.exists,"The 'Login' button is hidden")
    }
    
    func testFillTextfields(){
        self.initialLoginButton.tap()
        
        emailLoginTextField.tap()
        emailLoginTextField.typeText("mobile_test@warrenbrasil.com")
        let emailValue = self.emailLoginTextField.value as! String
        XCTAssertEqual(emailValue, "mobile_test@warrenbrasil.com","The 'Email' textfield can't be filled")
        
        self.passwordTextField.tap()
        self.passwordTextField.typeText("Warren123!\n")
    }
    
    func testEnableLoginButtonWhenFillTextfields(){
        self.initialLoginButton.tap()
        
        emailLoginTextField.tap()
        emailLoginTextField.typeText("mobile_test@warrenbrasil.com")
        let emailValue = self.emailLoginTextField.value as! String
        XCTAssertEqual(emailValue, "mobile_test@warrenbrasil.com","The 'Email' textfield can't be filled")
        
        self.passwordTextField.tap()
        self.passwordTextField.typeText("Warren123!\n")
        
        XCTAssertTrue(self.loginButton.isEnabled,"The 'Login' button can't be tapped")
    }
    
    func testAppleGuidelines(){
        XCTAssertTrue(self.initialLoginButton.frame.height >= 30,"The 'Login!' button does not conform to Apple Human Interface Guidelines")
        XCTAssertTrue(self.initialLoginButton.frame.width >= 120,"The 'Login!' button does not conform to Apple Human Interface Guidelines")
        
        self.initialLoginButton.tap()
        
        XCTAssertTrue(self.emailLoginTextField.frame.height >= 30,"The 'Email:' textfield does not conform to Apple Human Interface Guidelines")
        XCTAssertTrue(self.emailLoginTextField.frame.width >= 120,"The 'Email:' textfield does not conform to Apple Human Interface Guidelines")
        
        XCTAssertTrue(self.passwordTextField.frame.height >= 30,"The 'Password:' textfield does not conform to Apple Human Interface Guidelines")
        XCTAssertTrue(self.passwordTextField.frame.width >= 120,"The 'Password:' textfield does not conform to Apple Human Interface Guidelines")
        
        XCTAssertTrue(self.loginButton.frame.height >= 30,"The 'Login' button does not conform to Apple Human Interface Guidelines")
        XCTAssertTrue(self.loginButton.frame.width >= 120,"The 'Login' button does not conform to Apple Human Interface Guidelines")
    }
}
