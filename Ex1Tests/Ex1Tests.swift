////
////  Ex1Tests.swift
////  Ex1Tests
////
////  Created by Trương Duy Tân on 05/06/2023.
////
//
//import XCTest
//import Quick
//import Nimble
//import Mockingbird
//
////@testable import AddLibrary
//
//class TestEx1Test: QuickSpec {
//        override class func spec() {
//            describe("Login"){
//                /**
//                 Bước 1.  Tạo instance của LoginPresenter
//                 */
//                var sut:LoginPresenter!
//                
//                var loginDisplayMock:LoginDisplayMock!
//
//                /**Sẽ chạy trước test case*/
//                
//                beforeEach {
//                    loginDisplayMock = mock(LoginDisplay.self)
//                    sut = LoginPresenterImpl(controller: loginDisplayMock)
//                }
//                
//                /**
//                 Group lại các test case
//                 **/
//                context("Login form validate"){
//                    it("check username empty")
//                    {
//                        /**
//                         input : username rỗng
//                         action. : .login(username,password)
//                         
//                        */
//                        
//                        //input
//                        let username = ""
//                        
//                        //action
//                        sut.login(username: username, password: "Test")
//                        
//                        ///expect
//                        verify(loginDisplayMock.validateFailure(messing: "User is required")).wasCalled()
//                    }
//                }
//            }
//        }
//    }
