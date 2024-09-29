class APIData {
  static const String domainLink = "https://new.vibersnet.com/";

  static const String domainApiLink = domainLink + "api/";

  // API Link
  static const String loginApi = domainApiLink + "login";
  static const String fbLoginApi = domainApiLink + "fblogin";
  static const String googleLoginApi = domainApiLink + "googlelogin";
  static const String socialLoginApi = domainApiLink + "sociallogin";
  static const String userProfileApi =
      domainApiLink + "userProfile?secret=" + secretKey;
  static const String freeSubscription =
      domainApiLink + "free/subscription?secret=" + secretKey;
  static const String profileApi = domainApiLink + "profile";
  static const String registerApi = domainApiLink + "register";
  static const String allMovies = domainApiLink + "movie?secret=" + secretKey;
  static const String sliderApi = domainApiLink + "slider?secret=" + secretKey;
  static const String allDataApi = domainApiLink + "main?secret=" + secretKey;
  static const String movieTvApi =
      domainApiLink + "movietv?secret=" + secretKey;
  static const String topMenu = domainApiLink + "menu?secret=" + secretKey;
  static Uri verifyOTPApi = Uri.parse(domainApiLink + "verifycode");
  static Uri forgotPasswordApi = Uri.parse(domainApiLink + "forgotpassword");
  static const String resetPasswordApi = domainApiLink + "resetpassword";
  static const String menuDataApi = domainApiLink + "MenuByCategory";
  static const String episodeDataApi = domainApiLink + "episodes/";
  static const String watchListApi =
      domainApiLink + "showwishlist?secret=" + secretKey;
  static const String watchHistory =
      domainApiLink + "watchhistory?secret=" + secretKey;
  static const String addWatchHistory = domainApiLink + "addwatchhistory";
  static const String deleteAllWatchHistory =
      domainApiLink + "delete_watchhistory?secret=" + secretKey;
  static const String deleteWatchHistory =
      domainApiLink + "delete_watchhistory/";
  static const String removeWatchlistMovie = domainApiLink + "removemovie/";
  static const String removeWatchlistSeason = domainApiLink + "removeseason/";
  static const String addWatchlist =
      domainApiLink + "addwishlist?secret=" + secretKey;
  static const String checkWatchlistSeason = domainApiLink + "checkwishlist/S/";
  static const String checkWatchlistMovie = domainApiLink + "checkwishlist/M/";
  static const String homeDataApi = domainApiLink + "home?secret=" + secretKey;
  static const String faq = domainApiLink + "faq?secret=" + secretKey;
  static const String userProfileUpdate =
      domainApiLink + "profileupdate?secret=" + secretKey;
  static const String stripeProfileApi =
      domainApiLink + "stripeprofile?secret=" + secretKey;
  static const String stripeDetailApi =
      domainApiLink + "stripedetail?secret=" + secretKey;
  static const String clientNonceApi =
      domainApiLink + "bttoken?secret=" + secretKey;
  static const String sendPaymentNonceApi =
      domainApiLink + "btpayment?secret=" + secretKey;
  static const String stripeUpdateApi = domainApiLink + "stripeupdate/";
  static const String paypalUpdateApi = domainApiLink + "paypalupdate/";
  static const String sendPaystackDetails =
      domainApiLink + "paystack?secret=" + secretKey;
  static const String applyCouponApi = domainApiLink + "applycoupon";
  static const String showScreensApi =
      domainApiLink + "showscreens?secret=" + secretKey;
  static const String screensProfilesApi =
      domainApiLink + "screenprofile?secret=" + secretKey;
  static const String updateScreensApi =
      domainApiLink + "updatescreen?secret=" + secretKey;
  static const String screenLogOutApi = domainApiLink + "logout";
  static const String couponPaymentApi = domainApiLink + "couponpayment";
  static const String notificationsApi =
      domainApiLink + "notifications?secret=" + secretKey;
  static const String sendRazorDetails =
      domainApiLink + "paystore?secret=" + secretKey;
  static const String postVideosRating =
      domainApiLink + "rating?secret=" + secretKey;
  static const String checkVideosRating = domainApiLink + "checkrating";
  static const String downloadCounter =
      domainApiLink + "downloadcounter?secret=" + secretKey;
  static const String postBlogComment =
      domainApiLink + "addcomment?secret=" + secretKey;
  static const String actorMovies = domainApiLink + "detail/";
  static const String applyGeneralCoupon =
      domainApiLink + "verifycoupon?secret=" + secretKey;
  static const String getCoupons = domainApiLink + "coupon?secret=" + secretKey;
  static const String invoice = domainApiLink + "invoice-download/";
  static const String manualPayments =
      domainApiLink + "manualPayment?secret=" + secretKey;
  static const String storeManualPayments =
      domainApiLink + "store/manualPayment?secret=" + secretKey;
  static const String language =
      domainApiLink + "alllanguage?secret=" + secretKey;
  static const String appUiShorting =
      domainApiLink + "appUiShorting?secret=" + secretKey;
  static const String allUsers = domainApiLink + "allusers?secret=" + secretKey;
  static const String postSubComment =
      domainApiLink + "addreply?secret=" + secretKey;
  static const String audios = domainApiLink + "audio?secret=" + secretKey;
  static const String liveEvents =
      domainApiLink + "liveEvent?secret=" + secretKey;
  static const String countViews =
      domainApiLink + "countView?secret=" + secretKey;
  static const String deleteAccount = domainApiLink + "user/destroy/";
  static const String upiDetails = domainApiLink + "upi-details";
  static const String topData = domainApiLink + "topRated";
  static const String recommendedData =
      domainApiLink + "recomended?secret=" + secretKey;

  // URI Links
  static const String loginImageUri = domainLink + "images/login/";
  static const String logoImageUri = domainLink + "images/logo/";
  static const String landingPageImageUri = domainLink + "images/main-home/";
  static const String movieImageUri = domainLink + "images/movies/thumbnails/";
  static const String movieImageUriPosterMovie =
      domainLink + "images/movies/posters/";
  static const String tvImageUriPosterTv =
      domainLink + "images/tvseries/posters/";
  static const String tvImageUriTv = domainLink + "images/tvseries/thumbnails/";
  static const String profileImageUri = domainLink + "images/user/";
  static const String silderImageUri = domainLink + "images/home_slider/";
  static const String shareSeasonsUri = domainLink + "show/detail/";
  static const String shareMovieUri = domainLink + "movie/detail/";
  static const String blogImageUri = domainLink + "images/blog/";
  static const String menuTabLogoUri = domainLink + "images/menulogos/";
  static const String actorsImages = domainLink + "images/actors/";
  static const String directorsImages = domainLink + "images/directors/";
  static const String appSlider = domainLink + "images/app_slider/";
  static const String episodeThumbnail =
      domainLink + "images/tvseries/episodes/";

  // Replace with your app name
  static const String appName = 'Vibers Net';

  // Replace with your app secret key
  static const String secretKey = "C2VrZuB5yr78fKGJcbPMtS4k6U1DAWePGhNu4Uq8";

  // Replace with your android app id name
  static const String androidAppId = 'ENTER_PACKAGE_NAME_HERE';

  // Replace with your ios app id name
  static const String iosAppId = 'ENTER_PACKAGE_NAME_HERE';

  static const String shareAndroidAppUrl =
      'https://play.google.com/store/apps/details?id=' + '$androidAppId';

  static const String shareIOSAppUrl =
      'https://apps.apple.com/in/app/$appName/id' + '$iosAppId';

  // For notifications
  static const String onSignalAppId = "ENTER_ONE_SIGNAL_APP_ID_HERE";

  // To play google drive video
  static const String googleDriveApi = "ENTER_GOOGLE_DRIVE_API_KEY_HERE";

  // For Player
  static const String tvSeriesPlayer = domainLink + 'watchseason/';
  static const String moviePlayer = domainLink + 'watchmovie/';
  static const String episodePlayer = domainLink + 'watchepisode/';
  static const String trailerPlayer = domainLink + 'movietrailer/';
  static const String tvtrailerPlayer = domainLink + 'tvtrailer/';
  static const String subtitlePlayer = domainLink + 'subtitles/';
  static const String audioFile = domainLink + 'audio/';
  static const String audioThumbnail = domainLink + 'images/audio/thumbnails/';
  static const String audioPoster = domainLink + 'images/audio/posters/';
  static const String liveEventThumbnail =
      domainLink + 'images/events/thumbnails/';
  static const String liveEventPoster = domainLink + 'images/events/posters/';

/* ------ FireBase Settings Start ------ */

/* 
  YOU CAN FIND YOUR FIREBASE DETAILS FOR ANDROID IN "google-services.json"
  AND FOR IOS IN "GoogleService-Info.plist" FILE
*/

  // Firbase keys for ANDROID
  static const String apiKeyAndroid = 'ENTER_APP_FIREBASE_KEY_HERE';
  static const String appIdAndroid = '';
  static const String messagingSenderIdAndroid = '';
  static const String projectIdAndroid = '';
  static const String storageBucketAndroid = '';

  // Firbase keys for IOS
  static const String apiKeyIos = 'ENTER_APP_FIREBASE_KEY_HERE';
  static const String appIdIos = '';
  static const String messagingSenderIdIos = '';
  static const String projectIdIos = '';
  static const String storageBucketIos = '';
  static const String iosBundleId = '';

/* ------ FireBase Settings End ------ */
}
