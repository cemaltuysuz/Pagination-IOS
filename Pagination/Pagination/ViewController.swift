//
//  ViewController.swift
//  Pagination
//
//  Created by cemal tüysüz on 23.03.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var albumsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData(artistId: "0TnOYISbd1XYRBk9myaseg", limit: 10, offset: 0)
    }
        
    func fetchData(artistId:String, limit:Int, offset:Int){
        
        var url = "https://api.spotify.com/v1/artists/\(artistId)/albums?include_groups=single&market=ES&limit=\(limit)"
        if offset > 0 {
            url += "&offset=\(offset)"
        }
        
        Resource<AlbumsResponse>().fetchData(urlString: url, completion: { (result:Result<AlbumsResponse,Error>) in
            switch result {
            case .success(let success):
                for index in success.items {
                    print(index.name)
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        })
    }


}









