//
//  CalenderDetailsViewController.swift
//  Innova
//
//  Created by Azhar - M1 on 22/03/24.
//

import UIKit
struct Days {
    var dayName : String
    var isSelected: Bool
}
class CalenderDetailsViewController: BaseViewController {
    
    @IBOutlet weak var colCalenderDays: UICollectionView!

    var navigationTitle : String = ""
    var daysData: [Days] = [
        Days(dayName:"Monday".localize(), isSelected: true),
        Days(dayName:"Tuesday".localize(), isSelected: false),
        Days(dayName:"Wednesday".localize(), isSelected: false),
        Days(dayName:"Thursday".localize(), isSelected: false),
        Days(dayName:"Friday".localize(), isSelected: false),
    ]
    let flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return layout
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        xibRegisterations()
        navigationSetup()

    }
    func xibRegisterations() {
        colCalenderDays.register(UINib(nibName: "DaysCell", bundle: nil), forCellWithReuseIdentifier: "DaysCell")
    }
    
    func navigationSetup() {
        configurationTitleAndBack(title: navigationTitle, imageName: "in_leftPrimary")
        backTapped = {
            self.navigationController?.popViewController(animated: true)
        }
        navigationItem.rightBarButtonItems = [getbarButtons(image: "in_menuDots", setTag: 1)]
    }
    
    func getbarButtons(image: String, setTag: Int) -> UIBarButtonItem {
        let button: UIButton = UIButton(type: UIButton.ButtonType.custom)
        button.setImage(UIImage(named: image), for: UIControl.State.normal)
        button.addTarget(self, action: #selector(btnAlertTapped), for: UIControl.Event.touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        button.tag = setTag
        let barButton = UIBarButtonItem(customView: button)
        return barButton
    }
    
    @objc func btnAlertTapped(sender: UIButton) {
        if sender.tag == 0 {
        } else if sender.tag == 1 {
//            let initiliazeVC: HomeSettings = Utilities.viewController(name: "HomeSettings", onStoryboard: "Settings") as! HomeSettings
//            initiliazeVC.hidesBottomBarWhenPushed = true
//            navigationController!.pushViewController(initiliazeVC, animated: true)
        } else {

        }
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
//------------------------------------------
//MARK: - Collection Delegates -
extension CalenderDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return daysData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DaysCell", for: indexPath) as! DaysCell
        if let firstLetter = daysData[indexPath.row].dayName.first {
            cell.lblDay.text = String(firstLetter)
        }
        cell.lblDay.textColor = daysData[indexPath.row].isSelected ? UIColor.white : appConfig.appColors.btnInActiveTextColor
        cell.lblDay.backgroundColor = daysData[indexPath.row].isSelected ? appConfig.appColors.themeColor : appConfig.appColors.grayFour
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let numberOfItemsPerRow: CGFloat = CGFloat(daysData.count)
        let spacing: CGFloat = flowLayout.minimumInteritemSpacing
        let availableWidth = width - spacing * (numberOfItemsPerRow)
        let itemDimension = floor(availableWidth / numberOfItemsPerRow)
        return CGSize(width: itemDimension, height: 44.0)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        for i in 0..<daysData.count {
            daysData[i].isSelected = false
        }
        daysData[indexPath.row].isSelected = true
        colCalenderDays.reloadData()
        
    }
}
