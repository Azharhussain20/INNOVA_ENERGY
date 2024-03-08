import UIKit
import DropDown

struct Mode {
    let image: String
    let selectedImage: String
    let steps: String
    var isSelected: Bool
}
class DeviceDetailsViewController: BaseViewController, dateRangeSelectionViewControllerDelegate{
    func selectedRanges(from: Date, toDate: Date) {
        self.fromDate = from
        self.toDate = toDate
    }
    
    //------------------------------------------
    //MARK: - Outlets -
    @IBOutlet weak var fanModeView: UIStackView!
    @IBOutlet weak var btnChangeFanSpeed: UIButton!
    @IBOutlet weak var CollectionMode: UICollectionView!
    @IBOutlet var circularRingSlider: SSCircularRingSlider!
    @IBOutlet weak var btnPowerSwitch: UIButton!

    //------------------------------------------
    //MARK: - Class Variables -
    var fromDate = Date()
    var toDate = Date()
    var isInfoVisible : Bool = false
    var modeData: [Mode] = [
        Mode(image: "in_autoMode", selectedImage:"in_autoModeSelected", steps: "Auto".localize(), isSelected: false),
        Mode(image: "in_heatMode", selectedImage:"in_heatModeSelected", steps: "Heat".localize(), isSelected: false),
        Mode(image: "in_coolMode", selectedImage:"in_coolModeSelected", steps: "Cool".localize(), isSelected: false),
        Mode(image: "in_dryMode", selectedImage:"in_dryModeSelected", steps: "Dry".localize(), isSelected: false),
        Mode(image: "in_fanMode", selectedImage:"in_fanModeSelected", steps: "Fan".localize(), isSelected: false),
    ]
    
    let arrValues: [Int] = [Int](0...30)
    let dropDown = DropDown()
    let flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return layout
    }()
    
    //------------------------------------------
    //MARK: - View Life Cycle Methods -
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationSetup()
        setCircularRingSliderColor()
        xibRegisterations()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        configurationDropDown()

    }
    
    //------------------------------------------
    //MARK: - API Methods -
    //------------------------------------------
    //MARK: - Custom Methods -
    func collectionAnimation(_ view: UICollectionView) {
        view.visibleCells.forEach { cell in
            cell.transform = CGAffineTransform(scaleX: 0, y: 0)
            UIView.animate(withDuration: 0.5, delay: 0.1, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.3, options: .curveEaseInOut, animations: {
                cell.transform = .identity
            }, completion: nil)
        }
    }
    
    func configurationDropDown() {
        dropDown.anchorView = btnChangeFanSpeed
        dropDown.dataSource = ["Off".localize(), "Min".localize(), "Max".localize()]
        dropDown.topOffset = CGPoint(x: 0, y: -(dropDown.anchorView?.plainView.bounds.height)! + 16)
        dropDown.cornerRadius = 12.0
        dropDown.dismissMode = .onTap
//        dropDown.width = (dropDown.anchorView?.plainView.bounds.width)! + 20
        dropDown.direction = .bottom
        dropDown.dimmedBackgroundColor = UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.5)
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            if item == "Off".localize() {
                switchOff()
            } else {
                switchOn(withOldTemperature: 22)
            }
            btnChangeFanSpeed.setTitle(item, for: .normal)
        }
        DropDown.appearance().backgroundColor = UIColor.white
        DropDown.appearance().cellHeight = 44.0
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
    
    func switchOff() {
        btnPowerSwitch.isSelected = false
        btnChangeFanSpeed.setTitleColor(appConfig.appColors.btnInActiveTextColor, for: .normal)
        circularRingSlider.setValues(initialValue: arrValues[0].toCGFloat(), minValue: arrValues[0].toCGFloat(), maxValue: arrValues[arrValues.count - 1].toCGFloat())
    }
    
    func switchOn(withOldTemperature : Int) {
        btnPowerSwitch.isSelected = true
        btnChangeFanSpeed.setTitleColor(appConfig.appColors.themeColor, for: .normal)
        circularRingSlider.setValues(initialValue: arrValues[withOldTemperature].toCGFloat(), minValue: arrValues[0].toCGFloat(), maxValue: arrValues[arrValues.count - 1].toCGFloat())
    }
    func navigationSetup() {
        configurationTitleAndBack(title: "Device 1", imageName: "in_leftPrimary")
        backTapped = {
            self.navigationController?.popViewController(animated: true)
        }
        navigationItem.rightBarButtonItems = [getbarButtons(image: "in_gear", setTag: 1)]
    }
    
    func setCircularRingSliderColor() {
        circularRingSlider.delegate = self
        let indexOfValue = 22
        switchOn(withOldTemperature: 22)
        circularRingSlider.setTextLabel(labelFont: UIFont.init(name: "HelveticaNeue-Light", size: 60.0)!, textColor: appConfig.appColors.titleBlack)
        circularRingSlider.setValueTextFieldDelegate(viewController: self)
        circularRingSlider.setArrayValues(labelValues: arrValues, currentIndex: indexOfValue)
        circularRingSlider.setCircluarRingColor(innerCirlce: appConfig.appColors.circleTrack, outerCircle: UIColor.red)
        circularRingSlider.setProgressLayerColor(colors: [appConfig.appColors.gradientOne.cgColor, appConfig.appColors.gradientTwo.cgColor])
        circularRingSlider.setKnobOfSlider(knobSize: 40, knonbImage: UIImage(named: "iconKnobRed")!)
        circularRingSlider.setCircularRingWidth(innerRingWidth: 20, outerRingWidth: 20)
    }
    
    func xibRegisterations() {
        CollectionMode.register(UINib(nibName: "ModeTypesCell", bundle: nil), forCellWithReuseIdentifier: "ModeTypesCell")
    }
    
    //------------------------------------------
    //MARK: - Action Methods -
    @IBAction func btnFanSpeedTapped(_ sender: UIButton) {
        dropDown.show()
    }
    @IBAction func btnPowerSwitchTapped(_ sender: UIButton) {
        if btnPowerSwitch.isSelected {
            switchOff()
        } else {
            switchOn(withOldTemperature: 22)
        }
    }
    
    @objc func btnAlertTapped(sender: UIButton) {
        let initiliazeVC : DeviceSettingsViewController = Utilities.viewController(name: "DeviceSettingsViewController", onStoryboard: "DeviceDetails") as! DeviceSettingsViewController
        initiliazeVC.hidesBottomBarWhenPushed = true
        navigationController!.pushViewController(initiliazeVC, animated: true)
    }
}
//------------------------------------------
//MARK: - Extensions -
extension DeviceDetailsViewController: SSCircularRingSliderDelegate {
    
    func controlValueUpdated(value: Int) {
        print("current control value\(value)")
        if value <= 0 {
            btnChangeFanSpeed.setTitle("Off".localize(), for: .normal)

        } else {
            btnChangeFanSpeed.setTitle((dropDown.selectedItem == nil) ? "Off".localize() : dropDown.selectedItem , for: .normal)

        }
    }
    
}

//------------------------------------------
//MARK: - Collection Delegates -
extension DeviceDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return modeData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ModeTypesCell", for: indexPath) as! ModeTypesCell
        cell.lblMode.text = modeData[indexPath.row].steps
        if modeData[indexPath.row].isSelected {
            cell.imgMode.image = UIImage(named: modeData[indexPath.row].selectedImage)
            cell.lblMode.textColor = appConfig.appColors.themeColor
        } else {
            cell.imgMode.image = UIImage(named: modeData[indexPath.row].image)
            cell.lblMode.textColor = appConfig.appColors.btnInActiveTextColor
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let width = collectionView.bounds.width
        let numberOfItemsPerRow: CGFloat = 5
        let spacing: CGFloat = flowLayout.minimumInteritemSpacing
        let availableWidth = width - spacing * (numberOfItemsPerRow)
        let itemDimension = floor(availableWidth / numberOfItemsPerRow)
        return CGSize(width: itemDimension, height: UIScreen.main.bounds.size.height * 0.105634)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        for i in 0..<modeData.count {
            modeData[i].isSelected = false
        }
        modeData[indexPath.row].isSelected = true
        CollectionMode.reloadData()
        
        let initiliazeVC : ModeManagerViewController = Utilities.viewController(name: "ModeManagerViewController", onStoryboard: "DeviceDetails") as! ModeManagerViewController
        initiliazeVC.delegate = self
        initiliazeVC.fromDate = fromDate
        initiliazeVC.toDate = toDate
        let sheet = initiliazeVC.sheetPresentationController
        sheet?.preferredCornerRadius = 16.0
        sheet?.prefersGrabberVisible = true
        let multiplier = 0.40
        if #available(iOS 16.0, *) {
            let fraction = UISheetPresentationController.Detent.custom { context in
                314.0
            }
            sheet?.detents = [fraction]
        } else {
            sheet?.detents = [.medium()]
        }
        present(initiliazeVC, animated: true, completion: nil)
    }
}
//------------------------------------------
//MARK: - Timezone conversion -
extension Date {
    func convertToTimeZone(timeZone: TimeZone) -> Date {
        let seconds = TimeInterval(timeZone.secondsFromGMT(for: self))
        return Date(timeInterval: seconds, since: self)
    }
}
