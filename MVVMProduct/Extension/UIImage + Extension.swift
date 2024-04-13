//
//  UIImage + Extension.swift
//  MVVMProduct
//
//  Created by ajay kumar on 12/04/24.
//

import UIKit
import Kingfisher

extension UIImageView{
    
    func setImage(with urlString: String){
        guard let url = URL.init(string: urlString) else{
            return
        }
        let resources = ImageResource(downloadURL: url, cacheKey: urlString)
        kf.indicatorType = .activity
        kf.setImage(with: resources)
    }
}
