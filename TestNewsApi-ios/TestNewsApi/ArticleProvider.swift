//
//  ArticleProvider.swift
//  TestNewsApi
//
//  Created by Philippe Landry on 2020-08-31.
//  Copyright © 2020 Philippe Landry. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ArticleProvider {
    static let shared = ArticleProvider()
    let articles: BehaviorRelay<[Article]> = BehaviorRelay(value: [])
    let service = NewsAPIService()
    func reset(){
        service.fetchArticles { (result) in
            self.articles.accept(result)
        }
    }
}
