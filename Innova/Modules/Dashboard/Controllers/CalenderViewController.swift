import UIKit
var isCalenderAdded : Bool = false
class CalenderViewController: UIViewController, segmentSelectionIndexDelegate {
    
    
    //------------------------------------------
    //MARK: - Outlets -
    @IBOutlet weak var emptyCalenderView: UIView!
    @IBOutlet weak var btnAddCalender: GreenBackGroundPlus!
    @IBOutlet weak var innovaSegmentation: customInnovaSegmentation!
    @IBOutlet weak var tblSeasons: UITableView!
    @IBOutlet weak var tblSeasonHeight: NSLayoutConstraint!
    
    @IBOutlet weak var tblPreset: UITableView!
    @IBOutlet weak var tblPresetHeight: NSLayoutConstraint!

    
   
    //------------------------------------------
    //MARK: - Class Variables -
    var seasonData: [(text: String, isSelected: Bool, info : String)] = [
        ("Spring".localize(), true, "Pertaining to spring, the season that follows winter and precedes summer.".localize()),
        ("Summer".localize(), false, "Pertaining to summer, the warmest season of the year.".localize()),
        ("Autumnal".localize(), false, "Pertaining to autumn/fall, the season that follows summer and precedes winter.".localize()),
        ("Winter".localize(), false, "Pertaining to winter, the coldest season of the year.".localize()),
        ("On holiday".localize(), false, "To be in a period of rest or leisure away from home, during a vacation.".localize())
    ]
    
    var presetData: [(text: String, image : String)] = [
        ("Antifreeze".localize(), "in_antiFreeze"),
        ("Night".localize(), "in_night"),
        ("Echo".localize(), "in_eco"),
        ("Out".localize(), "in_out"),
        ("Comfort".localize(), "in_confort")
    ]
    
    //------------------------------------------
    //MARK: - Memory Management -
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    deinit {
        
    }
    //------------------------------------------
    //MARK: - View Life Cycle Methods -
    override func viewDidLoad() {
        xibRegistrations()
        self.navigationSetup()
    }
    
    func xibRegistrations() {
        tblSeasons.register(UINib(nibName: "SeasonsCell", bundle: nil), forCellReuseIdentifier: "SeasonsCell")
        tblSeasonHeight.constant = CGFloat(seasonData.count) * 72.0
        
        tblPreset.register(UINib(nibName: "PresetCell", bundle: nil), forCellReuseIdentifier: "PresetCell")
        tblPresetHeight.constant = CGFloat(presetData.count) * 56.0
        
        self.innovaSegmentation.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.temporaryHiddenShow()
    }
    
    
    //------------------------------------------
    //MARK: - API Methods -
    
    //------------------------------------------
    //MARK: - Custom Methods -
    
    func navigationSetup() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: returnCustomView())
        navigationController?.hideHairline()
        self.btnAddCalender.touchUpInside = {
            let initiliazeVC : AddCalenderViewController = Utilities.viewController(name: "AddCalenderViewController", onStoryboard: "Calendar") as! AddCalenderViewController
            initiliazeVC.hidesBottomBarWhenPushed = true
            self.navigationController!.pushViewController(initiliazeVC, animated: true)
        }
    }
    
    func returnCustomView() -> UIView {
        let dynamicLabelText: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width / 2, height: 44))
        dynamicLabelText.text = "Calendaring".localize()
        dynamicLabelText.font = UIFont(name: "HelveticaNeue-Medium", size: 24)
        dynamicLabelText.textColor = UIColor.titleBlack
        return dynamicLabelText
    }

    func temporaryHiddenShow(){
        self.emptyCalenderView.isHidden = isCalenderAdded  ? true : false
        self.tblSeasons.isHidden = isCalenderAdded ? self.innovaSegmentation.isCalenderSelected ? false : true : true
        self.tblPreset.isHidden = isCalenderAdded ? self.innovaSegmentation.isCalenderSelected ? true : false : true
        self.btnAddCalender.isHidden = self.innovaSegmentation.isCalenderSelected  ? false : true
    }

    //------------------------------------------
    //MARK: - Custom Delegate Method -
    func didselectedSegmentIndex(index: Int) {
        self.temporaryHiddenShow()
    }
    //------------------------------------------
    //MARK: - Action Methods -
    
    
    //------------------------------------------
    //MARK: - Collection Delegates -
    
}


//------------------------------------------
//MARK: - TableView Delegate Methods -
extension CalenderViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == tblSeasons {
            let cell : SeasonsCell = tblSeasons.dequeueReusableCell(withIdentifier: "SeasonsCell") as! SeasonsCell
            cell.lblSeasonName.text = seasonData[indexPath.row].text
            if seasonData[indexPath.row].isSelected {
                cell.imgCheckMark.isHidden = false
            } else {
                cell.imgCheckMark.isHidden = true
            }
            cell.touchupInfo = {
                showAlert(title: self.seasonData[indexPath.row].text, message: self.seasonData[indexPath.row].info, type: .oneButton(title: "Ok".localize(), style: .default, handler: {
                }), viewController: self)

            }
            return cell

        } else {
            let cell : PresetCell = tblPreset.dequeueReusableCell(withIdentifier: "PresetCell") as! PresetCell
            cell.lblName.text = presetData[indexPath.row].text
            cell.imgPresetIcon.image = UIImage(named: presetData[indexPath.row].image)
            return cell

        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tblSeasons {
            return seasonData.count

        } else {
            return presetData.count

        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == tblSeasons {
            return 72.0
        } else {
            return 56.0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == tblSeasons {
            seasonData.indices.forEach { index in
                seasonData[index].isSelected = index == indexPath.item
            }
            tblSeasons.reloadData()
            
            
            let initiliazeVC : CalenderDetailsViewController = Utilities.viewController(name: "CalenderDetailsViewController", onStoryboard: "Calendar") as! CalenderDetailsViewController
            initiliazeVC.navigationTitle = seasonData[indexPath.row].text
            self.navigationController!.pushViewController(initiliazeVC, animated: true)

        } else {
        }

    }
}
