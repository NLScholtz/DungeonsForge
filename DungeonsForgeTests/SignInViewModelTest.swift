//
//  SignInViewModelTest.swift
//  DungeonsForgeTests
//
//  Created by Nicole Scholtz on 2023/05/02.
//

@testable import DungeonsForge
import XCTest

final class SignInViewModelTest: XCTestCase {
    
    var viewModelToTest: SignInViewModel?

    override func setUpWithError() throws {}

    override func tearDownWithError() throws {}
    
    func testSignInSuccess() throws {
        class TestDelegate: SignInViewModelDelegate {
            func signInFailed() {
                XCTAssert(false)
            }
            
            func signInSuccess() {
                XCTAssert(true)
            }
        }
        let testDelegate = TestDelegate()
        viewModelToTest = SignInViewModel(delegate: testDelegate)
        viewModelToTest?.signIn(username: "Admin", password: "TestPass123")
        XCTAssert(true)
    }
    
    func testSignInFailure() throws {
        class TestDelegate: SignInViewModelDelegate {
            func signInFailed() {
                XCTAssert(true)
            }
            
            func signInSuccess() {
                XCTAssert(false)
            }
        }
        let testDelegate = TestDelegate()
        viewModelToTest = SignInViewModel(delegate: testDelegate)
        viewModelToTest?.signIn(username: "Admin1", password: "TestPass123")
        XCTAssert(true)
    }
}

