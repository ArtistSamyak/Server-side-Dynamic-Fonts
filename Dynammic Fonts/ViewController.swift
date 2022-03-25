//
//  ViewController.swift
//  Dynammic Fonts
//
//  Created by Samyak Pawar on 25/03/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var displayLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let fontURL = URL(string: "http://fonts.gstatic.com/s/alumnisans/v9/nwpHtKqkOwdO2aOIwhWudEWpx_zq_Xna-Xd95uhQqFsJ3C8qng.ttf")
        FileDownloader.loadFileAsync(url: fontURL!) { (path, error) in
            print("Font .ttf File downloaded to : \(path!)")
            let font = self.getFont(path: path!)
            self.displayLabel.font = font
        }
    }
    
    private func getFont(path: String) -> UIFont? {
        
        guard let fontFile = NSData(contentsOfFile: path)
        else {
            print("Font file not found?")
            return nil
        }

        guard let provider = CGDataProvider(data: fontFile)
        else {
            print("Failed to create DataProvider")
            return nil
        }

        let font = CGFont(provider)!
        let error: UnsafeMutablePointer<Unmanaged<CFError>?>? = nil

        guard CTFontManagerRegisterGraphicsFont(font, error) else {
            guard
                let unError = error?.pointee?.takeUnretainedValue(),
                let description = CFErrorCopyDescription(unError)
            else {
                print("Unknown error")
                return nil
            }
            print(description)
            
        }
        
        let fontName = String(font.fullName!)
        
        return UIFont(name: fontName, size: 20)
    }
    

}

