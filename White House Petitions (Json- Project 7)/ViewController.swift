//
//  ViewController.swift
//  White House Petitions (Json- Project 7)
//
//  Created by Fernando on /12/1118.
//  Copyright © 2018 eFePe. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var petitions = [Petition]()
    var whiteHouseURL = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        performSelector(inBackground: #selector(fetchJson), with: nil)
        
    }
    
    @objc func fetchJson(){
        
        if navigationController?.tabBarItem.tag == 0 {
            whiteHouseURL = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
            navigationItem.title = "Most Recent"
            
        } else {
            whiteHouseURL = "https://api.whitehouse.gov/v1/petitions.json?signatureCountFloor=10000&limit=100"
            navigationItem.title = "Most Signed"
        }
        
        if let url = URL(string: whiteHouseURL) {
                if let data = try? Data(contentsOf: url) {
                    parseJson(json: data)
                   // print(data) //get rid of
                    return
            }
        }
        performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
        
    }
    
    func parseJson(json: Data) {
        
        let decoder = JSONDecoder()
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            print(jsonPetitions)
            petitions = jsonPetitions.results
            tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
        } else {
            performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
        }
    }
    
    // MARK: - Error Handler
    
    @objc func showError(){
        let alertError = UIAlertController(title: "Loading error", message: "There was a problem loading the feed", preferredStyle: .alert)
        alertError.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertError, animated: true)
    }
    

    
    //MARK: - Table Data Source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = petitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        
        return cell
     }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = DetailViewController()
        detailViewController.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    //MARK: - Memory Warning Stuff
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

