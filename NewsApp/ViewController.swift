//
//  ViewController.swift
//  NewsApp
//
//  Created by 김지은 on 2021/09/11.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var TableViewMain: UITableView!
    var jNewsData: Array<Dictionary<String, Any>>?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let news = jNewsData {
            return news.count
        }
        else {
            return  0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableViewMain.dequeueReusableCell(withIdentifier: "TableCellType1", for: indexPath) as! TableCellType1
        
        if let news = jNewsData {
            if let rowNews = news[indexPath.row] as? Dictionary<String, Any> {
                if let title = rowNews["title"] as? String {
                    cell.LabelText.text = title
                }
            }
        }
        
        return cell
    }
    
    func getNews() {
        let task = URLSession.shared.dataTask(with: URL(string: "https://newsapi.org/v2/top-headlines?country=kr&apiKey=c60de1c446ce4b2c86e2a0a73d51f5cd")!) { data, resp, error in
            if let jsonData = data {
                do {
                    let newsData = try JSONSerialization.jsonObject(with: jsonData, options: []) as! Dictionary<String, Any>
                    let articles = newsData["articles"] as! Array<Dictionary<String, Any>>
                    self.jNewsData = articles
                    
                    DispatchQueue.main.async {
                        self.TableViewMain.reloadData()
                    }
                }
                catch {}
            }
        }
        
        task.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let id = segue.identifier, "DataSeg" == id {
            if let controller = segue.destination as? DetailViewController {
                if let news = jNewsData {
                    if let indexPath = TableViewMain.indexPathForSelectedRow {
                        if let rowNews = news[indexPath.row] as? Dictionary<String, Any> {
                            if let urlToimg = rowNews["urlToImage"] as? String {
                                controller.Image = urlToimg
                            }
                            
                            if let desc = rowNews["description"] as? String {
                                controller.Desc = desc
                            }
                        }
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        TableViewMain.dataSource = self
        TableViewMain.delegate = self
        
        getNews()
    }

}

