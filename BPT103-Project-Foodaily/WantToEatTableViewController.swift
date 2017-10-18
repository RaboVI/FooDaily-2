//
//  WantToEatTableViewController.swift
//  BPT103-Project-Foodaily
//
//  Created by Hong Shih on 2017/10/16.
//  Copyright © 2017年 RaboLu. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class WantToEatTableViewController: UITableViewController {
    
    let dataMnager = FakeDataManager.shared
    
    let wantToEatReload = "wantToEatReload"

    var wantToEat = [Dictionary<String, String>]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "Akrobat", size: 18)!,NSAttributedStringKey.foregroundColor: #colorLiteral(red: 0.1921568627, green: 0.3137254902, blue: 0.3490196078, alpha: 1)]
        
        // 新建一個leftBarButtonItem
        let backBtn = UIBarButtonItem.init(image: UIImage(named: "back.png"), style: .plain, target: self, action: #selector(pop))
        self.navigationItem.leftBarButtonItem = backBtn
        
        // 取消線條的顏色
        tableView.separatorColor = UIColor.clear
        
        //
        view.backgroundColor = #colorLiteral(red: 0.9837865233, green: 0.9933264852, blue: 0.7701260448, alpha: 1)
    }
    
    // Pop回上一頁
    @objc func pop() {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
    
        return dataMnager.wantToEatArray.count // 待修改
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 91
    }
    
    @IBAction func addWantToEatBtn(_ sender: UIButton) {
        
        NotificationCenter.default.addObserver(self, selector: #selector(refresh), name: NSNotification.Name(wantToEatReload), object: nil)
        
        let addWantToEatStoryboard = UIStoryboard.init(name: "AddWantToEat", bundle: .main)
        let vc = addWantToEatStoryboard.instantiateViewController(withIdentifier: "AddWantToEatViewController")
        
        vc.modalPresentationStyle = .overCurrentContext
        
        present(vc, animated: true, completion: nil)
    }
    
    @objc func refresh() {
        NotificationCenter.default.removeObserver(self)
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! WantToEatTableViewCell

        // Configure the cell...
        cell.titleLabel.text = dataMnager.wantToEatArray[indexPath.row]["ShopName"]
        cell.remarkLabel.text = dataMnager.wantToEatArray[indexPath.row]["RemarkText"]
        cell.backgroundColor = UIColor.clear
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "WantToEatContentViewController") as? WantToEatContentViewController {
            vc.modalPresentationStyle = .overCurrentContext
            vc.indexPath = indexPath.row
            present(vc, animated: true, completion: nil)
        }
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
