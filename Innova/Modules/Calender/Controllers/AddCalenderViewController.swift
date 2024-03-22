//
//  AddCalenderViewController.swift
//  Innova
//
//  Created by Azhar - M1 on 22/03/24.
//

import UIKit

class AddCalenderViewController:  BaseViewController {
    
    //------------------------------------------
    //MARK: - Outlets -
    @IBOutlet weak var btnSaveCalender: GreenThemeButton!
    @IBOutlet weak var txtPositionName: UITextField!
    //------------------------------------------
    //MARK: - Class Variables -
    //------------------------------------------
    //MARK: - Memory Management -
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    deinit
    {
        
    }
    //MARK: - View Life Cycle Methods -
    override func viewDidLoad() {
        super.viewDidLoad()
        initialiseViews()
        navigationSetup()
    }
    
    //------------------------------------------
    //MARK: - API Methods -
    
    //------------------------------------------
    //MARK: - Custom Methods -
    func initialiseViews() {
        btnSaveCalender.isValidate = false
        btnSaveCalender.updateButtonAppearance()
    }
    
    func navigationSetup() {
        configurationTitleAndBack(title: "Add a calendar".localize(), imageName: "in_leftPrimary")
        backTapped = {
            self.navigationController?.popViewController(animated: true)
        }
        btnSaveCalender.touchUpInside = {
            isCalenderAdded = true
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    //------------------------------------------
    //MARK: - Action Methods -
   
}
//------------------------------------------
//MARK: - TextField Delegate -
extension AddCalenderViewController : UITextFieldDelegate{
    func textFieldDidChangeSelection(_ textField: UITextField) {
        btnSaveCalender.isValidate = !textField.text!.isEmpty
        btnSaveCalender.updateButtonAppearance()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
