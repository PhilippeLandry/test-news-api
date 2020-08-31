//
//  NewsAPIService.swift
//  TestNewsApi
//
//  Created by Philippe Landry on 2020-08-31.
//  Copyright © 2020 Philippe Landry. All rights reserved.
//

import Alamofire

struct Source: Decodable {
    let name: String
}

struct Article: Decodable {
    let source: Source
    let title: String
    let description: String
    let urlToImage: String
}

struct Articles: Decodable {
    let status: String
    let articles: [Article]
}

class NewsAPIService {
    func fetchArticles(_ completed: @escaping ([Article]) -> Void) {    // &from=2020-08-15
       AF.request("https://newsapi.org/v2/everything?q=bitcoin&sortBy=publishedAt&apiKey=43ba39aafcb34a1a87e6fc61d3a857c9&pageSize=20")
       .validate()
       .responseDecodable(of: Articles.self) { (response) in
        guard let result = response.value, result.status == "ok" else { return }
        completed(result.articles)
       }
    }
}



