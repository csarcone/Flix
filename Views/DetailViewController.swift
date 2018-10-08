//
//  DetailViewController.swift
//  Flix
//
//  Created by Christina S. on 10/6/18.
//  Copyright © 2018 Christina S. All rights reserved.
//

import UIKit

enum MovieKeys{
    static let title = "title"
    static let backdropPath = "backdrop_path"
    static let posterPathString = "poster_path"
}

class DetailViewController: UIViewController {
    
    
    @IBOutlet var backDropImageView: UIImageView!
    
    @IBOutlet var posterImageView: UIImageView!
    
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var releaseDateLabel: UILabel!
    
    @IBOutlet var overviewLabel: UILabel!
    
    var movie: [String: Any]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let movie = movie{
            titleLabel.text = movie[MovieKeys.title] as? String
            
            releaseDateLabel.text = movie["release_date"] as? String
            
            overviewLabel.text = movie["overview"] as? String
            
            let backDropPathString = movie[MovieKeys.backdropPath] as! String
            
            let posterPathString = movie[MovieKeys.posterPathString] as! String
            
            let baseURLString = "https://image.tmdb.org/t/p/w500"
            
            let backDropURL = URL(string: baseURLString + backDropPathString)!
            backDropImageView.af_setImage(withURL: backDropURL)
            
            let posterPathURL = URL(string: baseURLString + posterPathString)!
            posterImageView.af_setImage(withURL: posterPathURL)
        }
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
