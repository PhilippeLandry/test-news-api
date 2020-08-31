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
    
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        ArticleProvider.shared.articles.asObservable()
        .subscribe(onNext: {
          [unowned self] articles in

        })
        .disposed(by: disposeBag) //3

        
        ArticleProvider.shared.reset()
        
    }


}

