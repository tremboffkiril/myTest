//
//  Main table screen.swift
//  Test Application
//
//  Created by Kiril on 06.05.16.
//  Copyright © 2016 Kiril. All rights reserved.
//

import UIKit
import CoreData


class Main_table_screen: UITableViewController, NSFetchedResultsControllerDelegate {
    
    var countRow = 20
    var text = "Habrapost"
     var refresh : UIRefreshControl!
    
    
    
    var restaurant : Restaurant!
    var restar: [Restaurant] = []
    var fetchResultController : NSFetchedResultsController!
    
    
     var loadMoreStatus = false
    
    @IBOutlet weak var itLogOut: UIBarButtonItem!
    
    @IBAction func logOut(sender: UIBarButtonItem) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    //Массив имен ресторанов
    
    var restaurantsNames = ["Cafe Deadend", "Homei", "Teakha", "Cafe Loisl", "Petite Oyster", "For Kee Restaurant", "Po's Atelier", "Bourke Street Bakery", "Haigh's Chocolate", "Palomino Espresso", "Upstate", "Traif", "Graham Avenue Meats", "Waffle & Wolf", "Five Leaves", "Cafe Lore", "Confessional", "Barrafina", "Donostia", "Royal Oak", "Thai Cafe"]
    
    //Массив ссылок на картинки
    
    var restaurantImages = [
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSuackd5fzJLhH-GVOTId4x93ig3s2YxLxXiK550S1xF9sdvtob",
                            "http://a-a-ah.ru/resize/550x340c/data/place/395/images/4d2db79de20c2575669028.jpg?418bb5d56c8110c2fbf856ac378c935e",
                            "http://typical-moscow.ru/wp-content/uploads/2015/04/text-7061-23641-Sixty3.jpg",
                            "http://bm.img.com.ua/berlin/storage/news/600x500/2/ed/6ecfa72e129397a50a78fd8c542d9ed2.jpg",
                            "http://gid.turtella.ru/img/11/gg7s.jpg",
                            "http://topclub.ua/h/images/reserve/SKYBAR-KIEV_-_32.jpg",
                            "http://retaildesignblog.net/wp-content/uploads/2015/12/Khmeli-Suneli-Restaurant-by-Seventh-Studio-Kiev-Ukraine.jpg",
                            "http://a-a-ah.ru/resize/550x340c/data/place/m1/m1-6/6579/images/4e9ec75dc3dd2491896248.jpg?f7eb31189832161ac616cddb3ba236ee",
                            "http://www.klevo.net/uploads/posts/1167392835_29122006_stil0.jpg",
                            "http://ru2.anyfad.com/items/t1@ec1a9e98-5cfc-4883-ad2b-8f055eb368d8/Samye-dorogie-restorany-mira.jpg",
                            "http://travelgatesweden.se/wp-content/uploads/2009/01/absolut-icebar-stockholm3-bildvisning.jpg",
                            "http://avivas.ru/img/topic/13161/16.jpg",
                            "http://www.restoranoff.ru/images/Novosti_otrasli/Petermann%60s%20Kunststuben.jpg",
                            "http://www.grekomania.ru/images/news/other/big/2160_Grande-Bretagne-Restaurant.jpg",
                            "http://1001doroga.ru/uploads/posts/2010-09/1285653143_res3.jpg",
                            "http://trinixy.ru/pics3/20080118/restorani_09.jpg",
                            "http://findreason.ru/image/data/oformlenie/K-KINGS/tsvetochnoe-oformlenie_otelej_tsvety.jpg",
                            "https://static.cntraveller.ru/media/material/0001/45/thumb_44211_material_big.jpeg",
                            "http://pics.style.rbc.ru/style_pics/media/img/750x500/204442107069744/pr/biutiful_romania.jpg",
                            "http://megawallpapers.ru/albums/userpics/normal_Restoran_v_otele.jpg",
                            "http://img04.rl0.ru/afisha/-x746/s4.afisha.net/MediaStorage/b6b98eb135384d71af12e32ac84b.jpg"]
    
    //Массив локиций ресторанов
    var restaurantLocations = ["Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Sydney", "Sydney", "Sydney", "New York", "New York", "New York", "New York", "New York", "New York", "New York", "London", "London", "London", "London"]
    
    //Массив типов ресторанов
    var restaurantTypes = ["Coffee & Tea Shop", "Cafe", "Tea House", "Austrian / Causual Drink", "French", "Bakery", "Bakery", "Chocolate", "Cafe", "American / Seafood", "American", "American", "Breakfast & Brunch", "Coffee & Tea", "Coffee & Tea", "Latin American", "Spanish", "Spanish", "Spanish", "British", "Thai"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        checkAndSaving()
    
        //Создание конпки Log Out
        let backButton = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: navigationController, action: nil)
        navigationItem.leftBarButtonItem = backButton
        
        
        //Обновления таблицы (refresh Controll)
        
        refresh = UIRefreshControl()
        refresh.attributedTitle = NSAttributedString(string: "Update...")
        refresh.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        tableView.addSubview(refresh)
        
        self.tableView.reloadData()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
         //скрываем navigation bar
        
        self.navigationController?.navigationBarHidden = false
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return restar.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //Создаем кастомную ячейку
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! MyCell
        
        cell.imRestaurants.image = nil
        
        
        
        //работа с ссылочними картинками
        
        if let link = NSURL(string: restar[indexPath.row].imageName!){
            
            ImageLoader.sharedLoader.imageForUrl(String(link), completionHandler: { (image, url) in
                
                if image != nil{
                    cell.imRestaurants.image = image
                }
            })
        }
        else{
            
            cell.imRestaurants?.image = UIImage(named: restar[indexPath.row].imageName!)
        }
        
        
        //присвоение всем элементам экрана их значений
        
        cell.lName?.text = restar[indexPath.row].name
        cell.lType?.text = restar[indexPath.row].type
        cell.lLocation?.text = restar[indexPath.row].location
        
        
        //округляем картинки
        cell.imRestaurants.layer.cornerRadius = CGRectGetHeight(cell.imRestaurants.frame) / 2
        cell.imRestaurants.clipsToBounds = true
        
        
        
        cell.bDellCell.tag = indexPath.row
        cell.bDellCell.addTarget(self, action: #selector(deleteCell(_:)), forControlEvents: .TouchUpInside)
        
        cell.bDouble.tag = indexPath.row
        cell.bDouble.addTarget(self, action: #selector(addCloneCell(_:)), forControlEvents: .TouchUpInside)
        
        return cell
    }
    
    //метод для удаления ячейки
    
    func deleteCell(sender: UIButton){
        
        
        let appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let context : NSManagedObjectContext = appDel.managedObjectContext
        
        let request = NSFetchRequest(entityName: "Restaurant")
        request.returnsObjectsAsFaults = false
        
        var results = try? context.executeFetchRequest(request)
        
        results!.removeAtIndex(sender.tag)
        restar.removeAtIndex(sender.tag)
        
        do{
            try context.save()
        }catch _{
        
        }
        
        self.tableView.deleteRowsAtIndexPaths([NSIndexPath(forRow: sender.tag, inSection: 0)], withRowAnimation: .Automatic)
        self.tableView.reloadData()
        
    }
    
    //метод для клонирования ячейки
    
    func addCloneCell(sender: UIButton){
        
        restar.append(restar[sender.tag])
        
        let newIndex = NSIndexPath(forRow: sender.tag, inSection: 0)
        let indexes = [newIndex]
        
        //Запись данных в Core Data
        
        let appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context : NSManagedObjectContext = appDel.managedObjectContext
        
        let request = NSFetchRequest(entityName: "Restaurant")
        
        request.returnsObjectsAsFaults = false
        
        let newRestar = NSEntityDescription.insertNewObjectForEntityForName("Restaurant", inManagedObjectContext: context)
        newRestar.setValue(restar[sender.tag].name, forKey: "name")
        newRestar.setValue(restar[sender.tag].imageName, forKey: "imageName")
        newRestar.setValue(restar[sender.tag].type, forKey: "type")
        newRestar.setValue(restar[sender.tag].location, forKey: "location")
        newRestar.setValue(restar.count - 1, forKey: "id")
        
        do {
            try context.save()
        }
        catch _ {
        }

        self.tableView.insertRowsAtIndexPaths(indexes, withRowAnimation: .Automatic)
        self.tableView.reloadData()
    }
    
    
    //метод для проверки на наличие данных Core Data
    func checkAndSaving(){
    
        let appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context : NSManagedObjectContext = appDel.managedObjectContext
        
        let request = NSFetchRequest(entityName: "Restaurant")
        
        request.returnsObjectsAsFaults = false
        let results = try? context.executeFetchRequest(request)
 
        if results?.count > 0 {
            
            restar = results as! [Restaurant]
            
        }else{
        
            print("\(results!.count) - results count")
            
                for (index, _) in restaurantsNames.enumerate(){
                    
                    let newRestar = NSEntityDescription.insertNewObjectForEntityForName("Restaurant", inManagedObjectContext: context)
                    newRestar.setValue(restaurantsNames[index], forKey: "name")
                    newRestar.setValue(restaurantImages[index], forKey: "imageName")
                    newRestar.setValue(restaurantTypes[index], forKey: "type")
                    newRestar.setValue(restaurantLocations[index], forKey: "location")
                    newRestar.setValue(index, forKey: "id")
                  
                    do {
                        try context.save()
                    }
                        catch _ {
                    }
                }
            
                checkAndSaving()
            }
    }
    
    //методы для обновления drag таблицы
    
    
    func refresh(sender:AnyObject) {
        refreshBegin("Refresh",
                     refreshEnd: {(x:Int) -> () in
                        self.tableView.reloadData()
                        self.refresh.endRefreshing()
        })
    }
    
    func refreshBegin(newtext:String, refreshEnd:(Int) -> ()) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            print("refreshing")
            self.text = newtext
            sleep(2)
            
            dispatch_async(dispatch_get_main_queue()) {
                refreshEnd(0)
            }
        }
    }
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "RESTAURANTS"
    }
    
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
     if editingStyle == .Delete {
     // Delete the row from the data source
     tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
     } else if editingStyle == .Insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
