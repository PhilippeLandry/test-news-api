//
//  TestNewsApiTests.swift
//  TestNewsApiTests
//
//  Created by Philippe Landry on 2020-08-31.
//  Copyright © 2020 Philippe Landry. All rights reserved.
//

import XCTest
import RxSwift
@testable import TestNewsApi

class TestNewsApiTests: XCTestCase {
    private let disposeBag = DisposeBag()
   
    func testArticleCount() throws {
        let expectation = self.expectation(description: "fetch posts")
        ArticleProvider.shared.articles.asObservable()
                      .subscribe(onNext: { _ in
                        if ArticleProvider.shared.articles.value.count == 20 {
                                XCTAssert(true, "Pass")
                                expectation.fulfill()
                        }
                      })
                      .disposed(by: disposeBag)
               
        self.waitForExpectations(timeout: 15.0, handler: nil)
    }

    

}
