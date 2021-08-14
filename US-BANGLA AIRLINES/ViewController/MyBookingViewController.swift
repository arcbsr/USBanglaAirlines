//
//  MyBookingViewController.swift
//  US-BANGLA AIRLINES
//
//  Created by Shahed Mamun on 7/8/21.
//  Copyright © 2021 usbangla. All rights reserved.
//
import UIKit


class MyBookingViewController: UIViewController {
    @IBOutlet weak var noDataMessageLabel: UILabel!{
        didSet{
            noDataMessageLabel.textColor = CustomColor.primaryColor
            noDataMessageLabel.isHidden = true
        }
    }
    @IBOutlet weak var titleLabel: UILabel!{
        didSet{
            titleLabel.textColor = CustomColor.secondaryColor
        }
    }
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.dataSource = self
            tableView.delegate = self
            tableView.separatorStyle = .none
            tableView.estimatedRowHeight = 100
            tableView.rowHeight = UITableView.automaticDimension
            //            let headerView = UIView()
            //            headerView.frame.size.height = 8
            //            headerView.backgroundColor = .clear
            //            tableView.tableHeaderView = headerView
            //            let footerView = UIView()
            //            footerView.frame.size.height = 8
            //            footerView.backgroundColor = .clear
            //            tableView.tableFooterView = footerView
        }
    }
    
    var pnrArray = [String]()
    var amountArray = [String]()
    var statusArray = [String]()
    var dateArray = [String]()
    var fromCityArray = [String]()
    var toCityArray = [String]()
    var isOneWayArray = [Bool]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "My Booking"
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.isHidden = true
    }
    
    func loadData(){
        // shwo recent item first (so reverse the arrays)
        pnrArray = UserDefaults.standard.object(forKey: "pnrArray") as? [String] ?? [String]()
        pnrArray.reverse()
        amountArray = UserDefaults.standard.object(forKey: "amountArray") as? [String] ?? [String]()
        amountArray.reverse()
        statusArray = UserDefaults.standard.object(forKey: "statusArray") as? [String] ?? [String]()
        statusArray.reverse()
        dateArray = UserDefaults.standard.object(forKey: "dateArray") as? [String] ?? [String]()
        dateArray.reverse()
        fromCityArray = UserDefaults.standard.object(forKey: "fromCityArray") as? [String] ?? [String]()
        fromCityArray.reverse()
        toCityArray = UserDefaults.standard.object(forKey: "toCityArray") as? [String] ?? [String]()
        toCityArray.reverse()
        isOneWayArray = UserDefaults.standard.object(forKey: "isOneWayArray") as? [Bool] ?? [Bool]()
        isOneWayArray.reverse()
        
        if pnrArray.isEmpty{
            noDataMessageLabel.isHidden = false
        }else{
            tableView.reloadData()
        }
    }
    
}


extension MyBookingViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pnrArray.count
    }
    
    //    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //        return 94
    //    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyBookingCell") as! MyBookingCell
        cell.selectionStyle = .none
        if indexPath.row < pnrArray.count{
            cell.pnrLabel.text = "PNR: \(pnrArray[indexPath.row])"
        }
        if indexPath.row < fromCityArray.count{
            cell.fromCityLabel.text = fromCityArray[indexPath.row]
        }
        if indexPath.row < toCityArray.count{
            cell.toCityLabel.text = toCityArray[indexPath.row]
        }
        if indexPath.row < statusArray.count{
            cell.statusLabel.text = statusArray[indexPath.row]
        }
        if indexPath.row < amountArray.count{
            cell.amountLabel.text = "AMOUNT: \(amountArray[indexPath.row])"
        }
        
        if indexPath.row < dateArray.count{
            cell.dateLabel.text = "DATE: \(dateArray[indexPath.row])"
        }
        
        if indexPath.row < isOneWayArray.count{
            if isOneWayArray[indexPath.row]{
                cell.flightDirectionImageView.image = UIImage(named: "ic_one_way")
            }else{
                cell.flightDirectionImageView.image = UIImage(named: "ic_return")
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
