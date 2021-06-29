//
//  HomeViewController.swift
//  SoftFact
//
//  Created by Магжан Бекетов on 14.04.2021.
//
import iCarousel
import UIKit

class HomeViewController: UIViewController {
    
    
    private let table : UITableView = {
        let table = UITableView(frame: .zero , style: .grouped)
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.register(CollectionTableViewCell.self, forCellReuseIdentifier: CollectionTableViewCell.identifier)
        return table
    }()
    
    private var models = [CellModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpModels()
        
        view.addSubview(table)
        table.tableHeaderView = createTableHeader()
        table.delegate = self
        table.dataSource = self        
      
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        table.frame = view.bounds
    }
    
    private func createTableHeader() -> UIView? {
        
        let myCarousel : iCarousel = {
            let view = iCarousel()
            view.type = .rotary
            
            view.autoscroll = -0.3
            
            return view
        }()
        myCarousel.dataSource = self
        myCarousel.frame = CGRect(x: 0,
                                  y: 55,
                                  width: view.frame.size.width,
                                  height:400)
    return myCarousel
    }
}


extension HomeViewController : iCarouselDataSource {
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        return 3
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 55, width: self.view.frame.size.width / 2, height: 400 ))
        view.backgroundColor = .red
        
        let imageView = UIImageView(frame: view.bounds )
        view.addSubview(imageView)
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "imageForCarousel_\(index + 1)")
        
        return view
    }
    
    
}


extension HomeViewController : UITableViewDelegate , UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch models[section] {
        case .list(let models) : return models.count
        case .collectionView( _, _) : return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch models[indexPath.section] {
        case .list(let models) :
            let model = models[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            
            cell.textLabel?.text = model.title
            return cell
        case .collectionView(let models, _) :
            let cell = tableView.dequeueReusableCell(withIdentifier: CollectionTableViewCell.identifier, for: indexPath) as! CollectionTableViewCell
            
            cell.configure(with: models)
            cell.delegate = self
            return cell
            
            
        }

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("did select normal list item \(indexPath)")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch models[indexPath.section] {
        case .list(_) : return 50
        case .collectionView( _, let rows) : return 180 * CGFloat(rows)
        }
    }
}


extension HomeViewController {
    
    private func setUpModels() {
        models.append(.collectionView(models: [
            CollectionTableCellModel(title: "Comedy", imageName: "comedy"),
            CollectionTableCellModel(title: "Fantastic", imageName: "fantastic"),
            CollectionTableCellModel(title: "Horror", imageName: "horror"),
            CollectionTableCellModel(title: "Adventure", imageName: "adventure"),
            CollectionTableCellModel(title: "Crime & Gangster", imageName: "crime"),
            CollectionTableCellModel(title: "War", imageName: "war"),
        ], rows: 2))
        models.append(.list(models: [
        ListCellModel(title: "First film"),
            ListCellModel(title: "second film"),
            ListCellModel(title: "third film"),
            ListCellModel(title: "Fourth film"),
            ListCellModel(title: "Fifth film")
            
        ]))
    }
}

extension HomeViewController : CollectionTableViewCellDelegate {

    
    func didSelectItem(with model: CollectionTableCellModel) {
        print("taped genre \(model.title)")
    
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)

        if let vc = storyboard.instantiateViewController(withIdentifier: "FilmsTableViewController") as? FilmsTableViewController{

            vc.titleOfPage = model.title
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
}

