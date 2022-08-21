//
//  Settings View Controller.swift
//  Prework
//
//  Created by Jonathan Ballona Sanchez on 10/12/21.
//

import UIKit


class Settings_View_Controller: UIViewController {
    
    let defaults = UserDefaults.standard
    
    // tipDefault Sliders that change the value of the main page
    @IBOutlet weak var excellentTipPercentageControl: UISlider!
    @IBOutlet weak var goodTipPercentageControl: UISlider!
    @IBOutlet weak var badTipPercentageControl: UISlider!
    
    //temp theme will store the newer theme that will then be sent to the settings in UserDefaults
    @IBOutlet weak var tempTheme: UILabel!
    //will be the values that are displayed in the settings page
    @IBOutlet weak var excellentTipReadOut: UILabel!
    @IBOutlet weak var goodTipReadOut: UILabel!
    @IBOutlet weak var badTipReadOut: UILabel!
    
    // will be the segments of the background in settings page
    @IBOutlet weak var themeColorBackground: UILabel!
    @IBOutlet weak var tipSliderColorBackground: UILabel!
    
    
    
    
    
    override func viewDidLoad() {
        //this is loaded when the app starts up
        super.viewDidLoad()
        themeColorBackground.layer.masksToBounds = true
        themeColorBackground.layer.cornerRadius = 20
        tipSliderColorBackground.layer.masksToBounds = true
        tipSliderColorBackground.layer.cornerRadius = 20
        tempTheme.text = defaults.string(forKey: "backCol")!
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //EVERY TIME the user is back on this viewcontroller
        
        //the current values of each tip category is loaded from USERDEFAULTS
        excellentTipReadOut.text = (String)(defaults.float(forKey: "excellentTipPercentage") * 100.0) + "%"
        goodTipReadOut.text = (String)(defaults.float(forKey: "goodTipPercentage") * 100.0) + "%"
        badTipReadOut.text = (String)(defaults.float(forKey: "badTipPercentage") * 100.0) + "%"
        
        
        
        //using the function call .setValue for the sliders, we set the value loaded from USERDEFAULTS
        excellentTipPercentageControl.setValue(defaults.float(forKey: "excellentTipPercentage"), animated: false)
        goodTipPercentageControl.setValue(defaults.float(forKey: "goodTipPercentage"), animated: false)
        badTipPercentageControl.setValue(defaults.float(forKey: "badTipPercentage"), animated: false)

        
        // This is a good place to retrieve the default tip percentage from UserDefaults
        // and use it to update the tip amount
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("view did appear of tipSetting Controller")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("view will disappear of tipSetting Controller")
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("view did disappear of tipSetting Controller")
    }
    
    
    
    @IBAction func setThemeToSpring(_ sender: Any) {
        //changes the label for the theme to spring
        tempTheme.text = "spring"
        //updates the USERDEFAULTS to store the new theme setting
        defaults.setValue(tempTheme.text, forKey: "backCol")
        //synchronizes the USERDEFAULTS across all viewcontrollers
        defaults.synchronize()
    }
    @IBAction func setThemeToSummer(_ sender: Any) {
        //changes the label for the theme to summer
        tempTheme.text = "summer"
        //updates the USERDEFAULTS to store the new theme setting
        defaults.setValue(tempTheme.text, forKey: "backCol")
        defaults.synchronize()
    }
    @IBAction func setThemeToFall(_ sender: Any) {
        //changes the label for the theme to fall
        tempTheme.text = "fall"
        //updates the USERDEFAULTS to store the new theme setting
        defaults.setValue(tempTheme.text, forKey: "backCol")
        //synchronizes the USERDEFAULTS across all viewcontrollers
        defaults.synchronize()
    }
    
    @IBAction func updateExcellentTipPercentage(_ sender: Any) {
        //obtains the local current value of excellentTipPercentageControl using slider property .value
        var currentExcellentTipPercentage = (excellentTipPercentageControl.value)
        // rounds the float up to a readable whole value
        currentExcellentTipPercentage = (Float)((Int)(currentExcellentTipPercentage * 100)) / 100.0
        
        
        //Updates the displayed excellent tip with proper formating
        excellentTipReadOut.text = String(format: "%.f", currentExcellentTipPercentage*100) + "%"
        //updates the USERDEFAULTS to the local new excellent tip percentage
        defaults.setValue(currentExcellentTipPercentage, forKey: "excellentTipPercentage")
        //synchronizes the USERDEFAULTS across all viewcontrollers
        defaults.synchronize()
    }
    
    @IBAction func updateGoodTipPercentage(_ sender: Any) {
        //obtains the local current value of baddTipPercentageControl using slider property .value
        var currentGoodTipPercentage = goodTipPercentageControl.value
        // rounds the float up to a readable whole value
        currentGoodTipPercentage = (Float)((Int)(currentGoodTipPercentage * 100)) / 100.0
        
        //Updates the displayed good tip with proper formating
        goodTipReadOut.text = String(format: "%.f", currentGoodTipPercentage*100) + "%"
        //updates the USERDEFAULTS to the local new good tip percentage
        defaults.setValue(currentGoodTipPercentage, forKey: "goodTipPercentage")
        //synchronizes the USERDEFAULTS across all viewcontrollers
        defaults.synchronize()
        
    }
    
    @IBAction func updateBadTipPercentage(_ sender: Any) {
        //obtains the local current value of badTipPercentageControl using slider property .value
        var currentBadTipPercentage = badTipPercentageControl.value
        // rounds the float up to a readable whole value
        currentBadTipPercentage = (Float)((Int)(currentBadTipPercentage * 100)) / 100.0
        
        //Updates the displayed bad tip with proper formating
        badTipReadOut.text = String(format: "%.f", currentBadTipPercentage*100.0) + "%"
        //updates the USERDEFAULTS to the local new bad tip percentage
        defaults.setValue(currentBadTipPercentage, forKey: "badTipPercentage")
        //synchronizes the USERDEFAULTS across all viewcontrollers
        defaults.synchronize()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
