//
//  DetailViewController.swift
//  NewsApp
//
//  Created by 김지은 on 2021/09/11.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var ImageMain: UIImageView!
    @IBOutlet weak var LabelMain: UILabel!
    
    var Image: String?
    var Desc: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let img = Image {
            if let data = try? Data(contentsOf: URL(string: img)!) {
                DispatchQueue.main.async {
                    self.ImageMain.image = UIImage(data: data)
                }
            }
        }
        
        if let desc = Desc {
            self.LabelMain.text = desc
        }
    }
}
