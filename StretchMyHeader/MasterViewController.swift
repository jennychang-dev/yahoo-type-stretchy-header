import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var objects = [Any]()
    var cell = TableViewCell()
    var news = [NewsItem]()
    let kTableHeaderHeight = 150.0
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.leftBarButtonItem = editButtonItem
        self.navigationController?.isNavigationBarHidden = true
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
        navigationItem.rightBarButtonItem = addButton
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        
        tableView.tableHeaderView = nil
            
//            UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: (tableView.frame.height)/3))
        
        guard let header = tableView.tableHeaderView else {
            fatalError("no header view 😱")
        }
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: header.frame.width, height: header.frame.height))
        imageView.image = UIImage(named: "bg-header")
        header.addSubview(imageView)
        
        setUpDefaultNewsHeadlines()
    }
    
    func setUpHeaderLayout() {
        
        
    }
    
    func setUpDefaultNewsHeadlines() {
        
        let n1 = NewsItem(category: NewsItem.Region.World, headline: "Climate change protests, divestments meet fossil fuels realities")
        let n2 = NewsItem(category: NewsItem.Region.Europe, headline: "Scotland's 'Yes' leader says independence vote is 'once in a lifetime'")
        let n3 = NewsItem(category: NewsItem.Region.MiddleEast, headline: "Airstrikes boost Islamic State, FBI director warns more hostages possible")
        let n4 = NewsItem(category: NewsItem.Region.Africa, headline: "Nigeria says 70 dead in building collapse; questions S. Africa victim claim")
        let n5 = NewsItem(category: NewsItem.Region.AsiaPacific, headline: "Airstrikes boost Islamic State, FBI director warns more hostages possible")
        let n6 = NewsItem(category: NewsItem.Region.Americas, headline: "Officials: FBI is tracking 100 Americans who fought alongside IS in Syria")
        let n7 = NewsItem(category: NewsItem.Region.World, headline: "South Africa in $40 billion deal for Russian nuclear reactors")
        let n8 = NewsItem(category: NewsItem.Region.Europe, headline: "One million babies' created by EU student exchanges")
        
        news.append(contentsOf: [n1, n2, n3, n4, n5, n6, n7, n8])
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @objc
    func insertNewObject(_ sender: Any) {
        objects.insert(NSDate(), at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let object = objects[indexPath.row] as! NSDate
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell

        let new = news[indexPath.row]
        cell.categoryLabel.text = new.category.convertRegionToString()
        cell.categoryLabel.textColor = new.category.assignColourToEachRegion()
        cell.headlineLabel.text = new.headline
        
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            objects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }

    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    


}

