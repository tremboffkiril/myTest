//
//  ViewController.swift
//  Test Application
//
//  Created by Kiril on 04.05.16.
//  Copyright © 2016 Kiril. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

  
    @IBOutlet weak var tfEnterMail: UITextField!
    @IBOutlet weak var tfEnterPassword: UITextField!
    @IBOutlet weak var bSign: UIButton!
    @IBOutlet weak var bRegister: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBarHidden = true
    }
  
    //Логин и пароль для пропуска в Main Table Screen
    
    let email = "iostallium@gmail.com"
    let password = "ios123"
    
    @IBAction func startSign(sender: UIButton) {
        
        if tfEnterMail.text == email{
            
            if tfEnterPassword.text == password{
                performSegueWithIdentifier("login", sender: nil)
            
            }else{
                
                //Всплывающие алерты, в зависимости от типа некоректности введенных данных
                
                let alert = UIAlertController(title: "Password", message:"Incorrect Password!", preferredStyle: .Alert)
                let cancelAction = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
                
                alert.addAction(cancelAction)
                
                self.presentViewController(alert, animated: true, completion: nil)
            }
            
        }else if tfEnterMail.text == email && tfEnterPassword.text != password{
            
            let alert = UIAlertController(title: "Login", message: "Incorrect Password!", preferredStyle: .Alert)
            let cancelAction = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
        
            alert.addAction(cancelAction)
            
            self.presentViewController(alert, animated: true, completion: nil)
            
        }else if tfEnterMail.text != email && tfEnterPassword.text == password{
            
            let alert = UIAlertController(title: "Login", message: "Incorrect Email!", preferredStyle: .Alert)
            let cancelAction = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
            
            alert.addAction(cancelAction)
            
            self.presentViewController(alert, animated: true, completion: nil)
        
        }else if tfEnterMail.text != email && tfEnterPassword.text != password{
            
            let alert = UIAlertController(title: "Login", message: "Incorrect Email! / Incorrect Password", preferredStyle: .Alert)
            let cancelAction = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
            
            alert.addAction(cancelAction)
            
            self.presentViewController(alert, animated: true, completion: nil)
        
        }else {
            
            let alert = UIAlertController(title: "Login", message: "Incorrect Email!", preferredStyle: .Alert)
            let cancelAction = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
            
            alert.addAction(cancelAction)
            
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
        
       
    }

    @IBAction func startRegister(sender: UIButton) {
        
       /* RestAPIManager.sharedInstance.makeHTTPGetRequest { (json, error) in
            
            if error != nil {
                
                print(error)
                return
            }
         print(json)
            
        }*/
     
       /* let email = tfEnterMail.text!
        let password = tfEnterPassword.text!
        
        RestAPIManager.sharedInstance.register(email, password: password)*/
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

