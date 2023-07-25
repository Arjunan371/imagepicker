import UIKit

class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var imgg: UIImageView!
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var lbl: UILabel!
    var array:[UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lbl.text = ""
        imgg.layer.cornerRadius = imgg.frame.width/2
        imgg.isUserInteractionEnabled = true

                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))

                imgg.addGestureRecognizer(tapGesture)
   
    }
    @objc func imageViewTapped() {
        let pic = UIImagePickerController()
        pic.delegate = self
        let alert = UIAlertController(title: "Photo source", message: "choose a source", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "camera", style: .default, handler: {(action:UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                pic.sourceType = .camera
                self.present(pic, animated: true,completion: nil)
            }else{
                print("camera not available")
            }
        
        }))
        alert.addAction(UIAlertAction(title: "photo library", style: .default, handler: {(action:UIAlertAction) in
            pic.sourceType = .photoLibrary
            self.present(pic, animated: true,completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "cancel", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func selectImage(_ sender: Any) {
        let pic = UIImagePickerController()
        pic.delegate = self
        let alert = UIAlertController(title: "Photo source", message: "choose a source", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "camera", style: .default, handler: {(action:UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                pic.sourceType = .camera
                self.present(pic, animated: true,completion: nil)
            }else{
                print("camera not available")
            }
        
        }))
        alert.addAction(UIAlertAction(title: "photo library", style: .default, handler: {(action:UIAlertAction) in
            pic.sourceType = .photoLibrary
            self.present(pic, animated: true,completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "cancel", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        array.append(image)
        self.table.reloadData()
        if let imageData = image.jpegData(compressionQuality: 1.0) {
                        let imageSize = imageData.count
                        
                        // Format the size using ByteCountFormatter
                        let formatter = ByteCountFormatter()
                        formatter.allowedUnits = [.useKB, .useMB]
                        formatter.countStyle = .file
                        let formattedSize = formatter.string(fromByteCount: Int64(imageSize))
                        
                        print("Selected image size: \(formattedSize)")
            lbl.text = formattedSize
                    }
        imgg.image = image

        picker.dismiss(animated: true,completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true,completion: nil)
    }
}
extension ViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "one") as! imagepickTableViewCell
        cell.imaepic.image = array[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
}
