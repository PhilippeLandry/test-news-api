//
//  ArticleCell.swift
//  TestNewsApi
//
//  Created by Philippe Landry on 2020-08-31.
//  Copyright © 2020 Philippe Landry. All rights reserved.
//

import UIKit
import Alamofire


class ArticleCell: UICollectionViewCell {
    
    @IBOutlet private weak var imageView: UIImageView!
    
    @IBOutlet private weak var sourceLabel: UILabel!
    
    @IBOutlet private weak var titleLabel: UILabel!
    
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    var requestedImage: String?
    
    override func awakeFromNib() {
        self.imageView.layer.cornerRadius = 10.0
    }
    
    var content : ArticleCellViewModel? {
        didSet {
            self.sourceLabel.text = content?.source
            self.titleLabel.text = content?.title
            self.descriptionLabel.text = content?.description
            self.imageView.image = nil
            guard let url = content?.imageURL else { return }

            AF.request(url).responseData { (response) in
                guard
                    response.error == nil,
                    let data = response.data,
                    response.request?.description == self.content?.imageURL
                    else { return }
                self.imageView.image = UIImage(data: data)
            }
        }
    }
    
}
