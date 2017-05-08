//
//  ViewController.swift
//  Assignment1
//
//  Created by Darshan Patil on 9/16/16.
//  Copyright © 2016 Darshan Patil. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    //Input text fields
    @IBOutlet weak var PayRateTextField: UITextField!
    
    @IBOutlet weak var OTRateTextField: UITextField!
    
    @IBOutlet weak var HoursTextField: UITextField!
    
    @IBOutlet weak var TaxRateTextField: UITextField!
    
    @IBOutlet weak var OtherDeductionsTextField: UITextField!
    //output text fields
    @IBOutlet weak var OTHourlyRateTextField: UITextField!
    
    @IBOutlet weak var OTHoursTextField: UITextField!
    
    @IBOutlet weak var GrossPayTextField: UITextField!
    
    @IBOutlet weak var TotalTaxesTextField: UITextField!
    
    @IBOutlet weak var PayCheckTextField: UITextField!
    //button action function
    @IBAction func buttonPressed(sender: UIButton) {
        
        //storing the values entered in the input fields into local variables
        var payRate = Double(PayRateTextField.text!)
        var otRate = Double(OTRateTextField.text!)
        var hours = Double(HoursTextField.text!)
        var taxRate = Double(TaxRateTextField.text!)
        var otherDeductions = Double(OtherDeductionsTextField.text!)
        
        //assigning default values if input text fields empty
        if PayRateTextField.text!.isEmpty{
            payRate = 7.25
        }
        if OTRateTextField.text!.isEmpty{
            otRate = 1.50
        }
        if HoursTextField.text!.isEmpty{
            hours = 0
        }
        if TaxRateTextField.text!.isEmpty{
            taxRate = 0.12
        }
        if OtherDeductionsTextField.text!.isEmpty{
            otherDeductions = 0.00
        }
        
        //variables to store calculated values which will be formatted and set to output text fields
        var overTimeHourlyRate = 0.0
        var otHours = 0.0
        var grossPay = 0.0
        
        //checking whether input hours is greater than 40, if yes then calculate the over time rate and amount
        if hours <= 40{
            otHours = 0
            grossPay = hours! * payRate!
        }
        else{
            overTimeHourlyRate = payRate! * otRate!
            otHours = hours! - 40
            grossPay = 40 * payRate! + otHours * overTimeHourlyRate
        }
        
        //calculating total taxes and paycheck amount
        let totTaxes = grossPay * taxRate!
        let payCheck = grossPay - totTaxes - otherDeductions!
        
        //using number formatter to format output values to currency
        let formatter = NSNumberFormatter()
        formatter.locale = NSLocale.currentLocale()
        formatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        
        //variables to store formatted values
        let formatted_grossPay = formatter.stringFromNumber(grossPay)!
        let formatted_totalTax = formatter.stringFromNumber(totTaxes)!
        let formatted_payCheck = formatter.stringFromNumber(payCheck)!
        let formatted_otHourlyRate = formatter.stringFromNumber(overTimeHourlyRate)!
        
        //to disable keyboard after all button pressed
        self.view.endEditing(true)
        
        //displaying the calculated amounts to respective output text fields
        OTHourlyRateTextField.text = String(formatted_otHourlyRate)
        OTHoursTextField.text = String(otHours)
        GrossPayTextField.text = String(formatted_grossPay)
        TotalTaxesTextField.text = String(formatted_totalTax)
        PayCheckTextField.text = String(formatted_payCheck)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.PayRateTextField.delegate = self
        self.OTRateTextField.delegate = self
        self.HoursTextField.delegate = self
        self.TaxRateTextField.delegate = self
        self.OtherDeductionsTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
    
    //keyboard handling
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //function to check/avoid extra dots in input fields
    func textField(textField: UITextField,shouldChangeCharactersInRange range: NSRange,replacementString string: String) -> Bool
    {
        textField.delegate = self
        
        let countdots = textField.text!.componentsSeparatedByString(".").count - 1
        
        if countdots > 0 && string == "."
        {
            return false
        }
        return true
    }
}

