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

// Injection de dépendance à la mitaine (simplement retourner 5 résultats au lieu de 20)
class NewsAPIServiceTest: NewsAPIService {
    override init(){
        super.init()
        self.maxArticles = 5
    }
    
}


class TestNewsApiTests: XCTestCase {
    private let disposeBag = DisposeBag()
   
    func testArticleCount() throws {
        
        ArticleProvider.shared = ArticleProvider(service: NewsAPIServiceTest())
        
        let expectation = self.expectation(description: "fetch posts")
        ArticleProvider.shared.articles.asObservable()
                      .subscribe(onNext: { _ in
                        if ArticleProvider.shared.articles.value.count == 5 {
                                XCTAssert(true, "Pass")
                                expectation.fulfill()
                        }
                      })
                      .disposed(by: disposeBag)
        ArticleProvider.shared.reset()
        self.waitForExpectations(timeout: 150.0, handler: nil)
    }

    

}
