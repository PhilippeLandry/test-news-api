//
//  ViewController.swift
//  TestNewsApi
//
//  Created by Philippe Landry on 2020-08-31.
//  Copyright © 2020 Philippe Landry. All rights reserved.
//

import UIKit
import RxSwift

class ArticlesViewController: UIViewController {

    @IBOutlet private weak var collectionView: UICollectionView!
    
    @IBOutlet private weak var titleLabel: UILabel!
    
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.titleLabel.text = NSLocalizedString("Parutions Récentes", comment: "")
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
       
        self.setupDatasource()
        
    }
}

extension ArticlesViewController {
    
    func setupDatasource(){
        
        ArticleProvider.shared.articles.asObservable()
               .subscribe(onNext: { _ in
                    self.collectionView.reloadData()
               })
               .disposed(by: disposeBag)
        
        ArticleProvider.shared.reset()
    }
}

extension ArticlesViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        ArticleProvider.shared.articles.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArticleCell", for: indexPath) as! ArticleCell
        let article = ArticleProvider.shared.articles.value[indexPath.row]
        cell.content = ArticleCellViewModel(article: article)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
       return CGSize(width: 100.0, height: 100.0)
    }
}

class ArticleCellViewModel {
    var source: String?
    var title: String?
    var description: String?
    var imageURL: String?
    
    
    init( article: Article) {
        self.source = article.source.name
        self.title = article.title
        self.description = article.description
        self.imageURL = article.urlToImage
    }
    
    
}
