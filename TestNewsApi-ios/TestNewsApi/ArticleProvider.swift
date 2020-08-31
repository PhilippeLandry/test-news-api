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
    
    static var shared = ArticleProvider(service:NewsAPIService())
    
    let service : INewsServiceAPI
    
    // Injection de dépendance faite à la mitaine
    init(service:INewsServiceAPI) {
        self.service = service
    }
    let articles: BehaviorRelay<[Article]> = BehaviorRelay(value: [])
    
    func reset(){
        service.fetchArticles { (result) in
            self.articles.accept(result)
        }
    }
}
