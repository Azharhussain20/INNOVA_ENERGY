import UIKit
protocol dateRangeSelectionViewControllerDelegate {
    func selectedRanges(from: Date, toDate :Date)
}
class ModeManagerViewController: UIViewController {
    
    //------------------------------------------
    //MARK: - Outlets -
    @IBOutlet weak var toPicker: UIDatePicker!
    @IBOutlet weak var fromPicker: UIDatePicker!
    
    //------------------------------------------
    //MARK: - Class Variables -
    var overlayView: UIView!
    var fromDate = Date()
    var toDate = Date()
    var delegate: dateRangeSelectionViewControllerDelegate?
    
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
    
    //------------------------------------------
    //MARK: - View Life Cycle Methods -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialisePickers()
    }
    
    //------------------------------------------
    //MARK: - Custom Delegate Methods -
    @objc func fromTimePickerValueChanged(sender: UIDatePicker) {
        toPicker.minimumDate = sender.date
        toPicker.isUserInteractionEnabled = true
        fromDate = sender.date
    }
    
    @objc func toTimePickerValueChanged(sender: UIDatePicker) {
        toDate = sender.date
    }
    
    //------------------------------------------
    //MARK: - Action Methods -
    @IBAction func btnCancelTapped(_ sender: UIButton) {
        showConfirmationAlert()
    }
    
    @IBAction func btnConfirmTapped(_ sender: UIButton) {
        delegate?.selectedRanges(from: fromDate, toDate: toDate)
        dismiss(animated: true)
    }
    //------------------------------------------
    //MARK: - Custom Methods -
    func initialisePickers() {
        fromPicker.tag = 0
        toPicker.tag = 1
        setPickers(picker: toPicker)
        setPickers(picker: fromPicker)
    }
    func setPickers(picker: UIDatePicker){
        picker.datePickerMode = .time
        picker.minimumDate = fromDate
        toPicker.setDate(toDate, animated: true)
        fromPicker.setDate(fromDate, animated: true)
        let customLocale = Locale(identifier: "en_GB")
        picker.locale = customLocale
        if picker.tag == 0 {
            picker.addTarget(self, action: #selector(fromTimePickerValueChanged), for: .valueChanged)
        } else {
            picker.addTarget(self, action: #selector(toTimePickerValueChanged), for: .valueChanged)
            picker.isUserInteractionEnabled = false
        }
    }

    func showConfirmationAlert() {
        let alertController = UIAlertController(title: "Return to the program?".localize(), message: "By clicking on confirm the device will return to following the original program set in the currently active calendar.".localize(), preferredStyle: .actionSheet)
        
        let Annulla = UIAlertAction(title: "Cancel".localize(), style: .default) { _ in
            self.dismiss(animated: true)
        }
        alertController.addAction(Annulla)
        
        let Conferma = UIAlertAction(title: "Confirm".localize(), style: .default) { _ in
            self.delegate?.selectedRanges(from: Date(), toDate: Date())
            self.dismiss(animated: true)
        }
        Conferma.setValue(UIColor(red: 0.0/255.0, green: 131.0/255.0, blue: 117.0/255.0, alpha: 1), forKey: "titleTextColor")
        alertController.addAction(Conferma)
        
        present(alertController, animated: true, completion: nil)
    }
}
