//
//  DeviceSettingsViewController.swift
//  Innova
//
//  Created by Azhar - M1 on 05/03/24.
//

import UIKit
struct Information {
    let title: String
    let value: String
}
class DeviceSettingsViewController: BaseViewController {
    
    //------------------------------------------
    //MARK: - Outlets -
    @IBOutlet weak var tblInformationHeight: NSLayoutConstraint!
    @IBOutlet weak var tblInformation: UITableView!
    @IBOutlet weak var txtDevice: UITextField!
    @IBOutlet weak var txtRoom: UITextField!
    
    //------------------------------------------
    //MARK: - Class Variables -
    var estimatedHeightOflabel : CGFloat = 0
    var informationData: [Information] = [
        Information(title: "Serial Product".localize(), value:"IN12345678"),
        Information(title: "Producer".localize(), value:"Innova"),
        Information(title: "Firmware version".localize(), value:"2.0.0"),
        Information(title: "Product type".localize(), value:"Condizionatore"),
    ]
    
    //------------------------------------------
    //MARK: - View Life Cycle Methods -
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationSetup()
        xibRegistrations()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        calculateInstructionTextHeight()
    }
    
    //------------------------------------------
    //MARK: - Custom Methods -
    func calculateInstructionTextHeight() {
        if #available(iOS 11.0, *) {
            let text = "If you believe that the temperature set by the device is not accurate, you can adjust it here. The device currently detects 22°C; set the temperature measured by another thermometer.".localize()
            let font = UIFont(name: "HelveticaNeue-Regular", size: 16)
            let width: CGFloat = UIScreen.main.bounds.width - 24
            estimatedHeightOflabel = textHeight(text: text, font: font!, width: width)
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                let bottomSafeArea = windowScene.windows.first?.safeAreaInsets.bottom ?? 0
                estimatedHeightOflabel = estimatedHeightOflabel + bottomSafeArea + 234
            }
        } else {
            estimatedHeightOflabel = estimatedHeightOflabel + 234
        }
    }
    
    func navigationSetup() {
        configurationTitleAndBack(title: "Avanzate", imageName: "in_leftPrimary")
        backTapped = {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func textHeight(text: String, font: UIFont, width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = text.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(boundingBox.height)
    }
    
    func xibRegistrations() {
        tblInformation.register(UINib(nibName: "InformationCell", bundle: nil), forCellReuseIdentifier: "InformationCell")
        tblInformationHeight.constant = CGFloat(informationData.count) * 44.0
    }
    
    //------------------------------------------
    //MARK: - API Methods -
    
    //------------------------------------------
    //MARK: - Action Methods -
    @IBAction func btnDeviceResetTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func btnTrueTemperatureTapped(_ sender: UIButton) {
        let initiliazeVC : TemperatureManagerViewController = Utilities.viewController(name: "TemperatureManagerViewController", onStoryboard: "DeviceDetails") as! TemperatureManagerViewController
        if let sheet = initiliazeVC.sheetPresentationController {
            if #available(iOS 16.0, *) {
                sheet.detents = [.custom { [self] context in
                    estimatedHeightOflabel
                }]
            } else {
                sheet.detents = [.medium()]
            }
            sheet.preferredCornerRadius = 16.0
            sheet.prefersGrabberVisible = true
        }
        present(initiliazeVC, animated: true)
    }
    @IBAction func btnRemoveDeviceTapped(_ sender: Any) {
        
    }
}

//------------------------------------------
//MARK: - TableView Delegate Methods -
extension DeviceSettingsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return informationData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InformationCell", for: indexPath) as! InformationCell
        let indexData = informationData[indexPath.row]
        cell.lblTitle.text = indexData.title
        cell.lblValue.text = indexData.value
        if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
            cell.seperator.isHidden = true
        } else {
            cell.seperator.isHidden = false
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
}
