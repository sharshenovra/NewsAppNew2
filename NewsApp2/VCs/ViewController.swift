import UIKit
import SnapKit
import Kingfisher


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var news: [NewsModel] = []
    var articles: [Articles] = []
    
    private lazy var newsTableView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    private lazy var firstView: UIView = {
        let view = UIView()
        return view
    }()
    
    func downloadJSON(completed: @escaping([Articles]) -> ()) {
        let url = URL(string: "https://newsapi.org/v2/top-headlines?language=ru&apiKey=37c24cd29815413593bb9c9c942cd59f")
        
        URLSession.shared.dataTask(with: url!) { (data, urlResponse, error) in
            if error == nil {
                do {
                    var response = try JSONDecoder().decode(NewsModel.self, from: data!)
                    dump(response)
                    DispatchQueue.main.async {
                        completed(response.list)
                    }
                } catch {
                    print("JSON Error")
                }
            }
        }.resume()
        
    }
    
    struct Cells {
        static let newsCell = "NewsCell"
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        160
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return articles.count
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = newsTableView.dequeueReusableCell(withIdentifier: Cells.newsCell) as! NewsCell
        let model = articles[indexPath.row]
        
        cell.newsTitle.text = model.title!
        cell.newsDescriptions.text = model.description!
        let url = URL(string: articles[indexPath.row].urlToImage ?? "")
        cell.newsImage.kf.setImage(with: url)
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            newsTableView.beginUpdates()
            articles.remove(at: indexPath.row)
            newsTableView.deleteRows(at: [indexPath], with: .fade)
            
            newsTableView.endUpdates()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rootVC = DetailedNewsVC()
        let navVC = UINavigationController(rootViewController: rootVC)
        rootVC.DetailedTitle.text = articles[indexPath.row].title!
        rootVC.DetailedDescription.text = articles[indexPath.row].description!
        let url = URL(string: articles[indexPath.row].urlToImage ?? "")
        rootVC.DetailedPhoto.kf.setImage(with: url)
        present(navVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Новости"

        setupViews()
        setupSubViews()
        }
    
    private func setupSubViews(){
        view.addSubview(firstView)
        firstView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        firstView.addSubview(newsTableView)
        newsTableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    private func setupViews(){
        newsTableView.register(NewsCell.self, forCellReuseIdentifier: Cells.newsCell)
        downloadJSON { data in
            self.articles = data
            self.newsTableView.reloadData()
        }
    }
}

