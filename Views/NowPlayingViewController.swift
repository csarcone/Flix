//
//  NowPlayingViewController.swift
//  Flix
//
//  Created by Christina S. on 9/26/18.
//  Copyright © 2018 Christina S. All rights reserved.
//

import UIKit
import AlamofireImage

class NowPlayingViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    var movies: [[String: Any]] = []
    var refreshControl: UIRefreshControl!
    
    //  @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMovies()
        self.tableView.rowHeight=225
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector (NowPlayingViewController.didPullToRefresh(_:)), for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        
        tableView.dataSource = self
        //Self in this case is the view controller
        tableView.rowHeight = 225
        
    }
    
    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl){
        fetchMovies()
        
    }
    //For network request
    func fetchMovies(){
    let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
    let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)

        
        // Makes a network request to get updated data
        // Updates the tableView with the new data
        // Hides the RefreshControl
        func refreshControlAction(_ refreshControl: UIRefreshControl) {
            
            // ... Create the URLRequest `myRequest` ...
            
            // Configure session so that completion handler is executed on main UI thread
            let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
            let task: URLSessionDataTask = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
                
                // ... Use the new data to update the data source ...
                
                // Reload the tableView now that there is new data
                self.tableView.reloadData()
                
                // Tell the refreshControl to stop spinning
                refreshControl.endRefreshing()
            }
            task.resume()
        }
        
    let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
    let task = session.dataTask(with: request) { (data, response, error) in
        if let error = error{
            print(error.localizedDescription)
        } else if let data=data{
            let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
            let movies = dataDictionary["results"] as! [[String:Any]]
            self.movies = movies
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }
        
        }

            //This will run when the network request returns
            
        task.resume()
            
            
    }
    
    func tableView(_ tableVIew: UITableView, numberOfRowsInSection section: Int) ->
        Int {
            return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        
        
        let movie = movies[indexPath.row]
        let title = movie["title"] as! String
        let overview = movie["overview"] as! String
        cell.titleLabel.text = title
        cell.overviewLabel.text = overview
        
        let posterPathString = movie["poster_path"] as! String
        let baseURLString = "https://image.tmdb.org/t/p/w500"
        
        let posterURL = URL(string: baseURLString + posterPathString)!
        cell.posterImageView.af_setImage(withURL: posterURL)
        
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        //Dispose of any resources that can be recreated.
    }
    
}
