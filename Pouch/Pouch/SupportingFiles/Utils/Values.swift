//
//  Values.swift
//  juglo
//
//  Created by apple on 08/06/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit


typealias JSON = [String: Any]

struct AppStrings {
    
    static let account = "Account"
    static let editProfile = "Edit Profile"
    static let privacy = "Privacy"
    static let notification = "Notification"
    static let notifications = "Notifications"
    static let appNotifications = "App Notifications"
    static let more = "More"
    static let language = "Language"
    static let country = "Country"
    static let emailAddress = "Email Address"
    static let firstName = "First Name"
    static let lastName = "Last Name"
    static let save = "Save"
    static let settings = "Settings"
    static let enterEmail = "Enter a Email"
    static let enterLastName = "Enter a Last Name"
    static let enterFirstName = "Enter a First Name"
    static let title = "Vacation World"
    static let tollFree = "Toll Free Number: 1800 532 2060"
    static let dinnerType = "Food Voucher"
    static let backgroundImage = "membership_bg_img"
    static let code = "Your Code: MA000567"
    static let rsOff = "Rs \nOFF"
    static let hotelName = "This is non transferable coupon"
    static let coupon = "Coupon_ic"
    static let notificationOnDesc = "Notification are on."
    static let notificationOffDesc = "Notifications are off, we recommend to enable this to get email, sms notifications of any new rewards and offers."
    static let appNotificationOnDesc = "App notification are on."
    static let appNotificationOffDesc = "Notifications are off, we recommend to enable this to get all notifications of any new rewards and offers."
    static let infoDesc = "We need your mobile number for OTP verification to make your account secure. Also, we recommended to use your primary mobile number for registration which you used while opting for a service with card issuer. We use this to securely connect with card vendor to sync the status of your cards so that all your cards are up to date."
    static let otpDescText = "We have sent you a 6 digit one time passcode on your mobile number"
}

struct Messages {
    static let enterEmail = "Please enter your Email ID"
    static let enterValidEmail = "Please enter valid Email ID"
    static let enterPassword = "Please enter your password"
    static let enterConPassword = "Please enter confirm password"
    static let conValidPassword = "Password should be 6 character long"
    static let bothPasswordNotSame = "Password and confirm password are not same"
    static let validPassword = "Password should be 6 characters long"
    static let enterValidPassword = "Please enter valid password"
    static let enterFirstName = "Enter your first name"
    static let enterLastName = "Enter your last name"
    static let enterPhone = "Enter your phone number"
    static let changePasswrodDesc = "Please enter the new password and confirm new password"
    
    
    static let mediaAddedSuccessfully = "Media added successfully"
    static let documentAddedSuccessfully = "Document added successfully"
    static let areYouSureYouWantToDeleteThisGroup = "Are you sure,\nYou want to delete this group?"
    static let areYouSureYouWantToDeleteThisComment = "Are you sure,\nYou want to delete this comment?"
    static let mediaNotAvailable = "Media not available!"
    static let feedsNotAvailable = "Feeds not available"
    static let noEventMeetingAreFound = "No Events & Meetings \nare found!"
    static let areYouSureYouWantToSubmitThisTask = "Are you sure you want to mark this task completed"
    static let areYouSureYouWantToClearAllNotifications = "Are you sure you want to clear all notifications"
    static let thisPollIsFinishedPleaseCheckResult = "This poll is finished, please check result."
    static let areYouSureYouWantToDeleteThisExpense = "Are you sure you want to delete this expense?"
    static let meetingMissedMesage = "Oops, You missed this Meeting!"
    static let eventMissedMesage = "Oops, You missed this Event!"
    static let pleaseAddYourWorkProfileBeforeSharing = "Please add your work profile before share."
    static let noDataFound = "No data found!"
    
}

struct ErrorMessage {
    static let enterValidFirstName = "Enter valid first name."
    static let enterValidLastName = "Enter valid last name."
    static let enterValidMoblie = "Enter your mobile number."
    static let enterValidEmail = "Enter your valid email."
    static let enterValidPassword = "Enter valid password."
    static let enterValidOtp = "Enter valid OTP"
    static let enterPhoneNumber = "Enter your phone number"
    static let enterPasswordConfirmPasswordSame = "Enter password and confirm password same."
    static let wrongPaymentInformation = "Wrong payment information. Please try again."
    static let pleaseEnterYourOrdeId = "Please enter your order Id!"
    static let nameIsRequired = "Name is required"
    static let messageIsRequired = "Message is required"
    static let enterValidProfileName = "Enter valid profile name."
    static let selectProductToReturn = "Select product to return"
    static let selectAnyContactForInvite = "Please select at least one contact to Invite"
    static let wrongFileSize = "Accepted file size upto 20mb"
    static let selectLocationOnMap = "Please select location on map"
    static let enterQuestion = "Please ask a question..."
    static let selectStartDate = "Select start date"
    static let selectStartTime = "Select start time"
    static let selectEndTime = "Select end time"
    static let selectEndDate = "Select end date"
    static let enterTitle = "Please enter title"
    static let enterFullName = "Enter full name"
    static let enterEmailId = "Enter email"
    static let enterCorrectEmailId = "Enter correct email"
    static let enterDescription = "Enter description"
    static let addMoreOptions = "Please add more options"
    static let usernameNotAvailable = "Username not available"
    static let pleaseEnterEventTitle = "Please enter Event title"
    static let fileAlreadySaved = "File already saved."
    static let pdfSuccessfullySaved = "PDF successfully saved!"
    static let pdfCouldNotBeSaved = "Pdf could not be saved"
    static let businessDomainHaveWrongFormat = "Business Email ID wrong format"
    static let contactNoIsInvalid = "Contact no is invalid"
    static let websiteLinkHaveWrongFormat = "Website URL wrong format."
    static let pleaseEnterTaskTitle = "Please enter task title"
    static let userNameShouldContainMimum3Characters = "User name should contain minimum 3 characters"
}

extension Int {
    var toString: String {
        return "\(self)"
    }
}

