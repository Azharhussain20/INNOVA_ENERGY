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

struct Times {
    var start : Float
    var end : Float
    var modeType : String
    var image : String
    var duration : Float
}

class CalenderDetailsViewController: BaseViewController {
    
    @IBOutlet weak var colCalenderDays: UICollectionView!
    @IBOutlet weak var colTimeLine: UICollectionView!
    var navigationTitle : String = ""
    var daysData: [Days] = [
        Days(dayName:"Monday".localize(), isSelected: true),
        Days(dayName:"Tuesday".localize(), isSelected: false),
        Days(dayName:"Wednesday".localize(), isSelected: false),
        Days(dayName:"Thursday".localize(), isSelected: false),
        Days(dayName:"Friday".localize(), isSelected: false),
    ]
    var timelineData: [Times] = [
        Times(start:00.00, end: 06.00, modeType : "Antifreeze".localize(), image: "in_antiFreeze", duration : 6.0),
        Times(start:06.00, end: 09.00, modeType : "Night".localize(), image : "in_night", duration : 3.0),
        Times(start:09.00, end: 18.00, modeType : "Echo".localize(), image : "in_eco", duration : 9.0),
        Times(start:18.00, end: 22.00, modeType : "Out".localize(), image : "in_out", duration : 4.0),
        Times(start:22.00, end: 00.00, modeType : "Comfort".localize(), image :"in_confort" , duration : 2.0),
    ]
    
    
    
    let flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return layout
    }()
    
    
    let flowLayoutTimeLine: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 2
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
        colTimeLine.register(UINib(nibName: "TimeLineCell", bundle: nil), forCellWithReuseIdentifier: "TimeLineCell")
        colTimeLine.layer.cornerRadius = 8 // Set the corner radius as needed
        colTimeLine.layer.masksToBounds = true // Ensures the content is clipped to the rounded corners

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
        if collectionView == colCalenderDays{
            return daysData.count
        } else {
            return timelineData.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == colCalenderDays{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DaysCell", for: indexPath) as! DaysCell
            if let firstLetter = daysData[indexPath.row].dayName.first {
                cell.lblDay.text = String(firstLetter)
            }
            cell.lblDay.textColor = daysData[indexPath.row].isSelected ? UIColor.white : appConfig.appColors.btnInActiveTextColor
            cell.lblDay.backgroundColor = daysData[indexPath.row].isSelected ? appConfig.appColors.themeColor : appConfig.appColors.grayFour
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TimeLineCell", for: indexPath) as! TimeLineCell
            let switchCase = self.timelineData[indexPath.row].modeType
            switch switchCase {
            case "Antifreeze".localize() :
                cell.timeView.backgroundColor = appConfig.appColors.antifreeze
            case "Night".localize() :
                cell.timeView.backgroundColor = appConfig.appColors.night
            case "Echo".localize() :
                cell.timeView.backgroundColor = appConfig.appColors.eco
            case "Out".localize() :
                cell.timeView.backgroundColor = appConfig.appColors.outside
            case "Comfort".localize() :
                cell.timeView.backgroundColor = appConfig.appColors.themeColor
            default:
                break;
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == colCalenderDays{
            let width = collectionView.bounds.width
            let numberOfItemsPerRow: CGFloat = CGFloat(daysData.count)
            let spacing: CGFloat = flowLayout.minimumInteritemSpacing
            let availableWidth = width - spacing * (numberOfItemsPerRow)
            let itemDimension = floor(availableWidth / numberOfItemsPerRow)
            return CGSize(width: itemDimension, height: 44.0)
        } else {
            
            let width = UIScreen.main.bounds.width - 60
            let numberOfItemsPerRow: CGFloat = CGFloat(timelineData.count)
            let spacing: CGFloat = flowLayoutTimeLine.minimumInteritemSpacing
            let availableWidth = width - spacing * (numberOfItemsPerRow)
            
            let itemDimension = (self.timelineData[indexPath.row].duration * Float(availableWidth)) / 24

            return CGSize(width: Double(itemDimension), height: 16.0)

            
            
            
//            let width = Float(UIScreen.main.bounds.width - 60)
//            let numberOfItemsPerRow: CGFloat = CGFloat(timelineData.count)
//            let spacing: CGFloat = flowLayout.minimumInteritemSpacing
//            
//            let cellWidth = (self.timelineData[indexPath.row].duration * width) / 24
//
//            
//            return CGSize(width: CGFloat(cellWidth-2.5), height: 16.0)
//
//            
//            flowLayoutTimeLine
//            
//            let cellWidth = (self.timelineData[indexPath.row].duration * width) / 24
//            return CGSize(width: CGFloat(cellWidth), height: 16)
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        for i in 0..<daysData.count {
            daysData[i].isSelected = false
        }
        daysData[indexPath.row].isSelected = true
        colCalenderDays.reloadData()
        
    }
}
