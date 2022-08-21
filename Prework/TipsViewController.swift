//
//  ViewController.swift
//  Prework
//
//  Created by Jonathan Ballona Sanchez on 10/10/21.
//

import UIKit

class TipsViewController: UIViewController {
    
    let defaults = UserDefaults.standard
    
    var theme = ""
    
    //outlets that will change other values
    @IBOutlet weak var billAmountTextField: UITextField!
    @IBOutlet weak var splitCountTextField: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    //outlets that will just display updated information
    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var suggestedTipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    //outlets of labels that are used as sections to be colored and background
    @IBOutlet weak var billAmountSectionBackground: UILabel!
    @IBOutlet weak var tipAdjustmentSectionBackground: UILabel!
    @IBOutlet weak var finalInfoSectionBackground: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ViewDidLoad in TipsViewController")
        
        //some inital setup when the app is first launched which includes applying a theme
        changeTheme()
        self.title = "Tip Calculator"
        
        //changes the keyboard types to a number pad for billAmounTextfield and splitCountTextField
        billAmountTextField.keyboardType = UIKeyboardType.numberPad
        splitCountTextField.keyboardType = UIKeyboardType.numberPad
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear in TipsViewController")
        // This is a good place to retrieve the default tip percentage from UserDefaults
        // and use it to update the tip amount
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("view did appear in TipsViewController")
        billAmountTextField.keyboardType = UIKeyboardType.numberPad
        splitCountTextField.keyboardType = UIKeyboardType.numberPad
        //the badTipPercentage, goodTipPercentage, excellentTipPercentage will all be pulled from USERDEFAULTS
        //updated accordingly
        let segmentedTipValue_Zero = (defaults.string(forKey: "badTipPercentage") ?? "0.15")
        let segmentedTipValue_One = (defaults.string(forKey: "goodTipPercentage") ?? "0.18")
        let segmentedTipValue_Two = (defaults.string(forKey: "excellentTipPercentage") ?? "0.20")
        
        //updates the values displayed for the tipControl segments
        tipControl.setTitle(segmentedTipValue_Zero, forSegmentAt: 0)
        tipControl.setTitle(segmentedTipValue_One, forSegmentAt: 1)
        tipControl.setTitle(segmentedTipValue_Two, forSegmentAt: 2)
        
        
        //visual adjustment to make the color segments for the themes to be rounded
        billAmountSectionBackground.layer.masksToBounds = true
        billAmountSectionBackground.layer.cornerRadius = 20
        tipAdjustmentSectionBackground.layer.masksToBounds = true
        tipAdjustmentSectionBackground.layer.cornerRadius = 20
        finalInfoSectionBackground.layer.masksToBounds = true
        finalInfoSectionBackground.layer.cornerRadius = 20
        changeTheme()
        calculateTip(animated)
        
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("view will disappear in ViewTipsController")
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("view did disappear in ViewTipsController")
    }
    
    
    @IBAction func calculateTip(_ sender: Any) {
        let bill = Double(billAmountTextField.text!) ?? 0
        
        //fetches the tipPercentages frofm UserDefaults
        let tipPercentageOne = (Double)(defaults.string(forKey: "badTipPercentage") ?? "0.15")
        let tipPercentageTwo = (Double)(defaults.string(forKey: "goodTipPercentage") ?? "0.18")
        let tipPercentageThree = (Double)(defaults.string(forKey: "excellentTipPercentage") ?? "0.20")
        
        //the tipPercentages array values are updated
        let tipPercentages = [tipPercentageOne, tipPercentageTwo, tipPercentageThree]
        //current tip percentage is determined by the selected segment from tip control
        let currentTipPercentage = (Double)(tipPercentages[tipControl.selectedSegmentIndex] ?? 0.0)
        
        // initial tip and bill are calculated before split
        let tip = bill * currentTipPercentage
        let total = tip + bill
        
        //based on the splitCount, the amount of people are determined so that a single person knows how much to pay
        var people = Double(splitCountTextField.text!) ?? 0
        people = people + 1
        
        let finalTip = tip/people
        let finalTotal = total/people
        
        //the suggested tip is updated and displayed
        suggestedTipLabel.text = String(format: "%.2f",(currentTipPercentage*100)) + "%"
        
        //the tipAmountLabel and totalLabel is updated to the final tip
        tipAmountLabel.text = String(format: "$%.2f", finalTip)
        totalLabel.text = String(format: "$%.2f", finalTotal)
    }
    
    func changeTheme(){
        //gets the current and most updated theme from UserDefaults
        theme = defaults.string(forKey: "backCol") ?? "fall"
        
        
        //the following values will determine the background theme elements
        var backGround_Red = CGFloat(0)
        var backGround_Green = CGFloat(0)
        var backGround_Blue = CGFloat(0)
        
        var sections_Red = CGFloat(0)
        var sections_Green = CGFloat(0)
        var sections_Blue = CGFloat(0)
        
        //the rgb values of each background segment will be set here
        if (theme == "fall"){
            backGround_Red = CGFloat(256)
            backGround_Green = CGFloat(211)
            backGround_Blue = CGFloat(182)
            
            sections_Red = CGFloat(222)
            sections_Green = CGFloat(188)
            sections_Blue = CGFloat(162)
            
            
        }else if( theme == "summer"){

            backGround_Red = CGFloat(253)
            backGround_Green = CGFloat(253)
            backGround_Blue = CGFloat(150)
            
            sections_Red = CGFloat(240)
            sections_Green = CGFloat(152)
            sections_Blue = CGFloat(74)
            

        }else if (theme == "spring"){
            
            backGround_Red = CGFloat(168)
            backGround_Green = CGFloat(230)
            backGround_Blue = CGFloat(207)
            
            sections_Red = CGFloat(144)
            sections_Green = CGFloat(201)
            sections_Blue = CGFloat(184)
            
        }
        
        //the rgb values for the background color elements are updated, thus displayed
        self.view.backgroundColor = UIColor(red: backGround_Red/256, green: backGround_Green/256, blue: backGround_Blue/256, alpha: 1)
        billAmountSectionBackground.backgroundColor = UIColor(red: sections_Red/256, green: sections_Green/256, blue: sections_Blue/256, alpha: 1)
        tipAdjustmentSectionBackground.backgroundColor = UIColor(red: sections_Red/256, green: sections_Green/256, blue: sections_Blue/256, alpha: 1)
        finalInfoSectionBackground.backgroundColor = UIColor(red: sections_Red/256, green: sections_Green/256, blue: sections_Blue/256, alpha: 1)
        
    }
    
    
    

}

