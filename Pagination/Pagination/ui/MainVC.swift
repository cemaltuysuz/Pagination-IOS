//
//  ViewController.swift
//  Pagination
//
//  Created by cemal tüysüz on 23.03.2022.
//

import UIKit

class MainVC: UIViewController {

    @IBOutlet weak var albumsTableView: UITableView!
    private var pendingRequestWorkItem: DispatchWorkItem?
    
    var albums:[Item]?
    
    let pageLimit = 30
    var offset:Int?
    let artistId = "0TnOYISbd1XYRBk9myaseg"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup(){
        albumsTableView.register(UINib(nibName: "TableViewLoadDataCell", bundle: nil), forCellReuseIdentifier: "myLoadCell")
        albumsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        albumsTableView.delegate = self
        albumsTableView.dataSource = self
        fetchData(artistId: artistId, limit: pageLimit, offset: offset ?? 0)
    }
}


// MARK: - UITableView
extension MainVC : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return SectionType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = SectionType(rawValue: section) else { return 0 }
        
        switch section {
        case .BASIC_VIEW:
            return albums?.count ?? 0
        case .LOAD_VIEW:
            let stat = (albums?.count ?? 0) >= pageLimit
            return stat ? 1 : 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = SectionType(rawValue: indexPath.section) else { return UITableViewCell() }
        let current = albums?[indexPath.row].name ?? ""
        
        switch section {
        case .BASIC_VIEW:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = current
            print("item : \(indexPath.row)")
            return cell
        case .LOAD_VIEW:
            let cell = tableView.dequeueReusableCell(withIdentifier: "myLoadCell", for: indexPath)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let section = SectionType(rawValue: indexPath.section) else { return }
        guard !(albums?.isEmpty ?? true) else { return }
        
        if section == .LOAD_VIEW {
            (cell as! TableViewLoadDataCell).indicator.startAnimating()
            fetchData(artistId: artistId, limit: pageLimit, offset: albums!.count)
        }
    }
}


// MARK: - Pagination Actions
extension MainVC  {
    func fetchData(artistId:String, limit:Int, offset:Int){
        
        var url = "https://api.spotify.com/v1/artists/\(artistId)/albums?include_groups=single&market=ES&limit=\(limit)"
        
        if offset > 0 {
            url += "&offset=\(offset)"
        }
        
        Resource<AlbumsResponse>().fetchData(urlString: url, completion: { (result:Result<AlbumsResponse,Error>) in
            switch result {
            case .success(let success):
                print("Başarılı ! gelen item sayısı : \(success.items.count)")
                self.updateData(albums: success.items)
            case .failure(let failure):
                self.dismissLoadView()
                print(failure.localizedDescription)
            }
        })
    }
    
    func updateData(albums:[Item]) {
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else {return}
            if  albums.count > 0 {
                if strongSelf.albums == nil {
                    strongSelf.albums = [Item]()
                }
                strongSelf.albums! += albums
                strongSelf.albumsTableView.reloadData()
            }
        }
    }
    
    func dismissLoadView(){
        DispatchQueue.main.async {
            self.pendingRequestWorkItem?.cancel()
            let workItem = DispatchWorkItem{[weak self] in
                if let albums = self?.albums {
                    let last = IndexPath(row: albums.count - 1, section: SectionType.BASIC_VIEW.rawValue)
                    self?.albumsTableView.scrollToRow(at: last, at: .bottom, animated: true)
                }
            }
            
            self.pendingRequestWorkItem = workItem
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1500), execute: workItem)
        }
    }
}

// MARK: - Section Type

enum SectionType : Int, CaseIterable {
    case BASIC_VIEW
    case LOAD_VIEW
}









