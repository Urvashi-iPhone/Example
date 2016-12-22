//
//  Constant.h
//  Runmileapp
//
//  Created by Tecksky Techonologies on 9/2/16.
//  Copyright © 2016 Tecksky Techonologies. All rights reserved.
//

#ifndef Constant_h
#define Constant_h

#define baseurl @"http://runmile.com/api/web/v1/"

#define AddOnurl @"user/adon"

#define Signup1url @"user/register1"
#define Signup2url @"user/register2"
#define loginurl @"user/login"
#define Editprofileurl @"user/edit-account"


#define hireSearchurl @"trip/search"
#define HireInquiry @"trip/inquiry"
#define tripPostRequest @"trip/post-request"

#define VehicleSearchurl @"vehicle/search"
#define VehicleInquiry @"vehicle/inquiry"
#define vehiclePostRequest @"vehicle/post-request"

#define TransportSearchurl @"profile/search"
#define TransportReviewurl @"profile/review"

#define BuyPartsSearchurl @"parts/search"
#define BuyPartsInquiry @"parts/inquiry"
#define PartsPostRequest @"parts/post-request"

#define ContactUsurl @"contact"

#define Insuranceurl @"insurance"

#define Financeurl @"finance"
#define forgotpassurl @"user/forgot-password"

#define SellVehicleurl @"vehicle"
#define SellPartsurl @"parts"

#define ManageVehicleurl @"vehicle/manage"
#define ManagePartsurl @"parts/manage"
#define ManageTripurl @"trip/manage"

#define CreateVehicleurl @"vehicle"
#define CreatePartsurl @"parts"
#define CreateHireurl @"trip"

#define EditVehicleurl @"vehicle/edit"
#define EditPartsurl @"parts/edit"
#define EditTripurl @"trip/edit"

#define DeleteVehicleurl @"vehicle/delete"
#define DeletePartsurl @"parts/delete"
#define DeleteTripurl @"trip/delete"

#define ChangePassurl @"user/change_password"

#define Filterurl @"user/sorting"

#define GoogleSearchAPI @"https://maps.googleapis.com/maps/api/place/autocomplete/json?input=%@&types=geocode&sensor=false&key=AIzaSyBEQouslAJ77Ybd-zGhfsIdNE21igskgU4"


//Regex

#define REGEX_TEXTFIELD_LIMIT @"^[A-Za-z0-9]{1}+[A-Za-z0-9 .]{1,}"
#define REGEX_EMAIL @"[A-Z0-9a-z._%+-]{3,}+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
#define REGEX_PASSWORD_LIMIT @"[A-Za-z0-9]{6,20}"
#define REGEX_TEXTVIEW @"[\\S ]{3,}"
#define REGEX_NUMBER @"^[0-9]{1,}"
#define REGEX_PHONE_NUMBER @"^[0-9]{10}"
//only 4letter #define REGEX_MAKE_YEAR @"^[0-9]{4}"
#define REGEX_MAKE_YEAR @"^[19-20]{1}[0-9]{2}"
#define REGEX_FLOAT @"[+-]?([0-9]*[.])?[0-9]+"
#define REGEX_DATE @"[0-9\\-]*"

#endif /* Constant_h */

