import UIKit
import MovikaSDK

class ViewController: UIViewController {
  
  @IBOutlet weak var activatyIndicator: UIActivityIndicatorView!{
    didSet {
      activatyIndicator.isHidden = false
      activatyIndicator.startAnimating()
    }
  }
  
  @IBOutlet weak var stackView: UIStackView!{
    didSet {
      stackView.isHidden = true
    }
  }
  
  @IBOutlet weak var resumeBtn: UIButton!{
    didSet {
      resumeBtn.isHidden = true
    }
  }
  
  private var manifest: GameManifest?
  private var defaultPlayerRepository = DefaultPlayerRepository()
  private let manifestUrl = "SET_MOVIE_URL"
  private let movieId = "100"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let downloader = DefaultGameManifestDownloader()
    
    downloader.load(movie: Movie(id: movieId, manifestUrl: manifestUrl)) {[weak self] manifest, error  in
      guard let self = self else { return }
      self.activatyIndicator.isHidden = true
      self.stackView.isHidden = false
      self.resumeBtn.isHidden = !self.defaultPlayerRepository.isGameSaved(movieId: self.movieId)
      if let error = error {
        self.show(message: error.localizedDescription)
      } else {
        self.manifest = manifest
      }
    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.resumeBtn.isHidden = !self.defaultPlayerRepository.isGameSaved(movieId: self.movieId)
  }
  
  private func show(message: String)  {
    let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
    self.present(alert, animated: true, completion: nil)
  }
  
  
  private func showPlayer(starFormGamePoint: Bool) {
    guard  let manifest = manifest else {
      show(message: "Manifest not found")
      return
    }
    
    let vc = PlayerViewController()
    vc.modalPresentationStyle = .fullScreen
    self.show(vc, sender: nil)
    let config = PlayerConfiguration(startFromSavePoint: starFormGamePoint,
                                     loopMode: false,
                                     showSaveIndicator: true,
                                     isRewindEnable: true,
                                     isShowTimeline: false,
                                     isDisableImmediately: false)
    

    vc.isShowDebugView = true
    vc.mkplayer.setup(manifest: manifest, config: config)
    vc.mkplayer.play()
  }
  
  
  @IBAction func start(_ sender: Any) {
    showPlayer(starFormGamePoint: false)
  }
  
  @IBAction func resume(_ sender: Any) {
    showPlayer(starFormGamePoint: true)
  }
}
