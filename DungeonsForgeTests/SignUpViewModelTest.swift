//
//  SignUpViewModelTest.swift
//  DungeonsForgeTests
//
//  Created by Nicole Scholtz on 2023/05/02.
//

@testable import DungeonsForge
import XCTest

final class SignUpViewModelTest: XCTestCase {
    
    var viewModelToTest: SignUpViewModel?

    override func setUpWithError() throws {}

    override func tearDownWithError() throws {}

    func testSignUpSuccess() throws {
        class TestDelegate: SignUpViewModelDelegate {
            func signUpFailed() {
                XCTAssert(false)
            }
            
            func signUpSuccess() {
                XCTAssert(true)
            }
        }
        let testDelegate = TestDelegate()
        viewModelToTest = SignUpViewModel(delegate: testDelegate)
        viewModelToTest?.signUp(username: "Selda", password: "123", email: "selda@jhb.co.za")
        XCTAssert(true)
    }
    
    func testSignUpFailure() throws {
        class TestDelegate: SignUpViewModelDelegate {
            func signUpSuccess() {
                XCTAssert(false)
            }
            
            func signUpFailed() {
                XCTAssert(true)
            }
        }
        let testDelegate = TestDelegate()
        viewModelToTest = SignUpViewModel(delegate: testDelegate)
        viewModelToTest?.signUp(username: "Selda", password: "123", email: "selda.co")
        XCTAssert(true)
    }
    

}


