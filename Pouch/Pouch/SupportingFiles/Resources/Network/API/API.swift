//
//  API.swift
//  CullintonsCustomer
//
//  Created by Rakesh Kumar on 03/04/18.
//  Copyright © 2018 Rakesh Kumar. All rights reserved.
//

import UIKit


class API {
    
    //    DEV HOST
    static let imageHost = "http://www.21by90.com/api/"
    static let host = "http://www.21by90.com/api/"
    
    
    static let deviceType = "Ios"
    static let version = (Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String).numeralsOnly.toString
    
    enum DataKey: String {
        case dataKey = "pic"
        case image = "image"
    }
    
    struct Name {
        static let device_token_update = "device_token_update"
        static let get_city = "get_city"
        static let user_image = "user_image"
        static let get_country = "get_country"
        static let mobile_verification = "mobile_verification"
        static let otp_verification = "otp_verification"
        static let user_register = "user_register"
        static let get_quote = "get_quote"
        static let get_user_awards = "get_user_awards"
        static let profile_overview = "profile_overview"
        static let success_report = "success_report"
        static let challenge_overview = "challenge_overview"
        static let successRate = "success_rate"
        static let recentChallenges = "recent_challenges"
        static let pollslisting = "polls_listing"
        static let plans_listing = "plans_listing"
        static let pollsAnswer = "polls_answer"
        static let buy_plan = "buy_plan"
        static let cancel_plan = "cancel_plan"
        static let user_account_delete = "user_account_delete"
        static let logout = "logout"
        static let get_category = "get_category"
        
        
        
        static let challenge_description = "challenge_description"
        static let search_habit = "search_habit"
        static let trendingHabits = "trending_habits"
        static let getTags = "get_tags"
        static let start_challenge = "start_challenge"
        static let searchChallengesbytag = "search_challenges_by_tag"
        
        static let failed_challenge_list = "failed_challenge_list"
        static let active_challenge_list = "active_challenge_list"
        static let complete_challenge_list = "complete_challenge_list"
        static let custom_habits = "custom_habits"
        static let start_custom_challenge = "start_custom_challenge"
        static let upcoming_challenge = "upcoming_challenge"
        static let get_tip = "get_tip"
        static  let challenge_log_list = "challenge_log_list/"
        static let add_challenge_log = "add_challenge_log"
        static let edit_challenge_log = "edit_challenge_log"
        static let log_delete_mood = "log_delete_mood"
        static let log_delete_photo = "log_delete_photo"
        static let log_delete_text_note = "log_delete_text_note"
        static let edit_challenge = "edit_challenge"
        static let page_detail = "page_detail"
        static let get_user_profile = "get_user_profile"
        static let user_ranking = "user_ranking"
        
        static let user_level_rule = "user_level_rule"
        static let user_level_detail = "user_level_detail"
        static let contact = "contact"
        static let userEditProfile = "user_edit_profile"
        
        static let city_leaderboard = "city_leaderboard"
        static let country_leaderboard = "country_leaderboard"
        static let global_leaderboard = "global_leaderboard"
        
        static let earned_awards = "earned_awards"
        static let upcoming_awards = "upcoming_awards"
        static let award_screenshot = "award_screenshot"
        
        static let user_public_profile = "user_public_profile"
        
        static let accountVerifyUserImage = "account_verify_user_image"
        static let accountVerifyRequestStatus = "account_verify_request_status"
        static let accountVerifyRequestCancel = "account_verify_request_cancel"
        static let newMobileVerification = "new_mobile_verification"
        static let newMobileOtpVerification = "new_mobile_otp_verification"
        static let createFeedback = "create_feedback"
        static let getRoadmap = "get_roadmap"
        static let updateNotificationSetting = "update_notification_setting"
        static let getFAQ = "get_faq"
        static let getNotificationSetting = "get_notification_setting"
        
    }
    
    struct keys {
        static let access_token = "access_token"
        static let country_code = "country_code"
        static let phone_no = "phone_no"
        static let otp = "otp"
        static let device_type = "device_type"
        static let device_token = "device_token"
        static let email = "email"
        static let device_id = "device_id"
    }
    
    enum HttpMethod: String {
        case POST = "POST"
        case GET = "GET"
        case PUT = "PUT"
        case DELETE = "DELETE"
    }
    
    struct statusCodes {
        static let INVALID_ACCESS_TOKEN = 401
        static let BAD_REQUEST = 400
        static let UNAUTHORIZED_ACCESS = 401
        static let SHOW_MESSAGE = 201
        static let SHOW_DATA = 1
        static let SLOW_INTERNET_CONNECTION = 999
    }
    
}

struct AlertMessage {
    static let INVALID_ACCESS_TOKEN = "Product is being used on another device"
    static let SERVER_NOT_RESPONDING = "Oops... Network issue, Please try again!"
    //        "Something went wrong while connecting to server!"
    static let NO_INTERNET_CONNECTION = "Unable to connect with the server. Check your internet connection and try again."
    static let pleaseEnter = "Please enter "
    static let invalidEmailId = "Please enter valid email id."
    static let enterEmailId = "Please enter email id."
    static let invalidPassword = "Please enter correct password."
    static let invalidPhoneNumber = "Please enter valid phone."
    static let invalidPasswordLength = "Password must contain atleast 6 characters"
    static let logoutAlert = "Are you sure you want to logout?"
    static let imageWarning = "The image we have showed above is for reference purpose. Actual car could be slightly different."
    static let emptyMessage = " can not be empty."
    static let bookingCreated = "Booking created successfully"
    static let passwordMismatch = "New password and confirm password does not match."
    static let passwordChangedSuccessfully = "Password changed successfully."
    static let pleaseEnterValid = "Please enter valid "
    static let transactionSuccessful = "Your transaction was successful"
    static let PROFILE_SAVED = "Profile has been saved successfully"
}

struct ERROR_MESSAGE {
    static let NO_CAMERA_SUPPORT = "This device does not support camera"
    static let NO_GALLERY_SUPPORT = "Photo library not found in this device."
    static let REJECTED_CAMERA_SUPPORT = "Need permission to open camera"
    static let REJECTED_GALLERY_ACCESS = "Need permission to open Gallery"
    static let SOMETHING_WRONG = "Oops... Network issue, Please try again!"
    //"Something went wrong. Please try again."
    static let NO_INTERNET_CONNECTION = "Unable to connect with the server. Check your internet connection and try again."
    static let SERVER_NOT_RESPONDING = "Oops... Network issue, Please try again!"
    //        "Something went wrong while connecting to server!"
    static let INVALID_ACCESS_TOKEN = "Invalid Access Token"
    static let ALL_FIELDS_MANDATORY = "All Fields Mandatory"
    static let CALLING_NOT_AVAILABLE = "Calling facility not available on this device."
}

