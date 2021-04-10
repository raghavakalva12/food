//
//  ViewController.swift
//  food
//
//  Created by Raghava on 09/04/21.
//  Copyright © 2021 Raghava. All rights reserved.
//

import UIKit
import youtube_ios_player_helper

class ViewController: UIViewController {
    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var recIn: UILabel!
    @IBOutlet weak var resName: UILabel!
    @IBOutlet weak var recCat: UILabel!
    @IBOutlet var videoPlayer:YTPlayerView!
    var meal : [[String:Any]]!
     var imageData:Data!
    override func viewDidLoad() {
        super.viewDidLoad()
        meal = fetchData()
        print("done")
   var imageURL = meal[0]["strMealThumb"]! as! String
   imageURL = imageURL.replacingOccurrences(of: "", with: "%20")
   print("URL:",imageURL)
   do{imageData = try Data(contentsOf: URL(string: imageURL)!)
    foodImage.image = UIImage(data: imageData)}
    catch{print("failed to fetch image")}
        var tempImage = UIImage(data: imageData)
        var foodName = meal[0]["strMeal"] as! String
        var foodcat = meal[0]["strCategory"] as! String
        var foodInt = meal[0]["strInstructions"] as! String
        var foodVideo = meal[0]["strYoutube"] as! String
        resName.text! += foodName
        recCat.text! += foodcat
        recIn.text! += foodInt
        let range = foodVideo.index(foodVideo.startIndex,offsetBy: 32)..<foodVideo.endIndex
        print(foodVideo[range])
        print(foodVideo)
        let foodVideoLink = foodVideo[range]
        videoPlayer.load(withVideoId: "\(foodVideoLink)")
     }
    //for fetching data from url
    func fetchData() -> [[String : Any]] {
        var meal:[[String : Any]]!
        var URLReqObj = URLRequest(url:URL(string:"https://www.themealdb.com/api/json/v1/1/random.php")!)
        let dataTaskObj = URLSession.shared.dataTask(with: URLReqObj) { (data, response, error) in
            do{
                print("started serialzing")
                let output = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as![String:Any]
                let temp = output["meals"]
                meal = temp as? [[String : Any]]
            }
            catch
            {
             print("data has not found")
            }
        }
        dataTaskObj.resume()
        while meal == nil
        {}
        print("returned value")
    return meal
    }
    
    @IBAction func saveButton(_ sender: Any) {
        print("save button pressed")
        var tempImage = UIImage(data: imageData)
        var foodName = meal[0]["strMeal"] as! String
        var foodcat = meal[0]["strCategory"] as! String
        var foodInt = meal[0]["strInstructions"] as! String
        var foodVideo = meal[0]["strYoutube"] as! String
        resName.text! += foodName
        recCat.text! += foodcat
        recIn.text! += foodInt
        let range = foodVideo.index(foodVideo.startIndex,offsetBy: 32)..<foodVideo.endIndex
        print(foodVideo[range])
        print(foodVideo)
        let foodVideoLink = foodVideo[range]
        let dict = ["foodName":foodName,"foodInt":foodInt,"foodVideo":foodVideoLink] as! NSDictionary
        print(dict)
        if let ping = tempImage?.pngData()
        {
            DataManager.instance.saveData(receivedData: dict, at: ping)
        }
        
    }
}

