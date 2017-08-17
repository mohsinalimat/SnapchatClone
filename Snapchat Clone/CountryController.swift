//
//  CountryController.swift
//  Snapchat Clone
//
//  Created by Michael Lema on 8/16/17.
//  Copyright © 2017 Michael Lema. All rights reserved.
//

import Foundation
import UIKit

class CountryController: UITableViewController {
    static let cellId = "cellId"
    var countryCodes = [CountryCode]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        adjustNavBar()
        tableView.register(countryCell.self, forCellReuseIdentifier: CountryController.cellId)
        
        if let path = Bundle.main.path(forResource: "CountryCodes", ofType: "json") {
            do {
                let jsonData = try NSData(contentsOfFile: path, options: NSData.ReadingOptions.mappedIfSafe) as Data
                do {
                    let areaCode = try JSONDecoder().decode([CountryCode].self, from: jsonData)
                    //print(areaCode)
                    countryCodes = areaCode.sorted { $0.name < $1.name }
                } catch let err {
                    print(err.localizedDescription)
                }
            } catch let err {
                print(err.localizedDescription)
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countryCodes.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CountryController.cellId, for: indexPath) as! countryCell
        let areaCode = NSString(format:"(%@)", countryCodes[indexPath.row].dial_code) as String
        cell.countryLabel.text = countryCodes[indexPath.row].name + " " + areaCode

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        popCurrentView()
    }
    
    //: TODO: Increase navBar height by 20 points
    func adjustNavBar() {
        setUpNavigationBar(leftImage: "BackButton")
        guard let navController = self.navigationController else {
            return
        }
        //: Change back the shadowImage to default
        navController.navigationBar.shadowImage = nil
        navController.navigationBar.isTranslucent = false
        navigationItem.title = "Select Country"
        navController.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.black, NSFontAttributeName: UIFont(name: "Avenir-Medium", size: 20)!]
    }
    
    //: FIXME: - Make the status bar be white
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = true
    }
}

//: MARK: - Cell for table view
class countryCell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    lazy var countryLabel: UILabel = {
        let label = UILabel()
        label.text = "Afghanistan (+93)"
        label.font = UIFont(name: "Avenir Next-Regular", size: 14)
        return label
    }()
    func setUpViews() {
        addSubview(countryLabel)
        addConstraintsWithFormat(format: "H:|-16-[v0]|", views: countryLabel)
        addConstraintsWithFormat(format: "V:|[v0]|", views: countryLabel)
    }
}
