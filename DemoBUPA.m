//
//  DemoBUPA.m
//  Sales Rep App
//
//  Created by IJsbrand van Rijn on 08-02-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import "DemoBUPA.h"

@implementation DemoBUPA
NSString *documentRootPath;
NSMutableArray *bupas;

-(id)init
{
    self = [super init];
    if (self)
    {
        [self createBUPAS];
    }
    return self;
}
-(NSMutableArray*)getDemoBupas
{
    return bupas;
    
}

-(void)createBUPAS
{
    //Create and fill array
    NSMutableArray *temp = [[NSMutableArray alloc]init];
    
    BusinessPartner *temp1 = [[BusinessPartner alloc]initWithSDMDictionary:nil];
    temp1.BusinessPartnerID = @"1";
    temp1.BusinessPartnerType = @"Customer";
    temp1.BusinessPartnerName = @"Albert Heijn ASW";
    temp1.Address.Street = @"Amsterdamsestraatweg";
    temp1.Address.HouseNumber = @"367 A";
    temp1.Address.PostalCode = @"3551 CK";
    temp1.Address.City = @"Utrecht";
    temp1.Address.Country = @"The Netherlands";
    temp1.PhoneNumber.PhoneNumber = @"0302420200";
    temp1.Email.LongURL = @"info@ah.nl";
    temp1.Website.LongURL = @"http://www.ah.nl/";
    temp1.Address.GeoCode.Latitude = @"52.104227";
    temp1.Address.GeoCode.Longitude = @"5.094194";
    temp1.ParentID = @"AH";
    temp1.ContactPersons = [NSMutableArray array];
    [temp addObject:temp1];
    
    ContactPerson *contact1 = [[ContactPerson alloc]initWithSDMDictionary:nil];
    contact1.FirstName =@"John";
    contact1.LastName = @"de Waal";
    contact1.Email.LongURL = @"john.dewaal@ah.nl";
    contact1.PhoneNumber.PhoneNumber = @"";
    contact1.Function = @"";
    contact1.ContactPersonID = @"11";
    contact1.Gender = @"1";
    contact1.Function = @"Store manager";
    
    ContactPerson *contact2 = [[ContactPerson alloc]initWithSDMDictionary:nil];
    contact2.FirstName =@"Diederik";
    contact2.LastName = @"Borst";
    contact2.Email.LongURL = @"diederik.borst@ah.nl";
    contact2.PhoneNumber.PhoneNumber = @"";
    contact2.Function = @"";
    contact2.ContactPersonID = @"12";
    contact2.Gender = @"1";
    contact2.Function = @"Customer Service";
    
    ContactPerson *contact3 = [[ContactPerson alloc]initWithSDMDictionary:nil];
    contact3.FirstName =@"Tess";
    contact3.LastName = @"van Oord";
    contact3.Email.LongURL = @"tess.vanoord@ah.nl";
    contact3.PhoneNumber.PhoneNumber = @"";
    contact3.Function = @"";
    contact3.ContactPersonID =  @"13";
    contact3.Gender = @"2";
    contact3.Function = @"Purchase employee";
    temp1.ContactPersons = [NSMutableArray arrayWithObjects:contact1,contact2,contact3,nil];
    
    
    BusinessPartner *temp2 = [[BusinessPartner alloc]initWithSDMDictionary:nil];
    temp2.BusinessPartnerID = @"2";
    temp2.BusinessPartnerType = @"Customer";
    temp2.BusinessPartnerName = @"Albert Heijn Houten";
    temp2.Address.Street = @"Cardo";
    temp2.Address.HouseNumber = @"12";
    temp2.Address.PostalCode = @"3995 XM";
    temp2.Address.City = @"Houten";
    temp2.Address.Country = @"The Netherlands";
    temp2.PhoneNumber.PhoneNumber = @"0306390411";
    temp2.Email.LongURL = @"info@ah.nl";
    temp2.Website.LongURL = @"http://www.ah.nl/";
    temp2.Address.GeoCode.Latitude = @"52.01774";
    temp2.Address.GeoCode.Longitude = @"5.17781";
    temp2.ParentID = @"AH";
    temp2.ContactPersons = [NSMutableArray array];
    [temp addObject:temp2];
    
    ContactPerson *contact21 = [[ContactPerson alloc]initWithSDMDictionary:nil];
    contact21.FirstName =@"Karel";
    contact21.LastName = @"de Kort";
    contact21.Email.LongURL = @"Karel.dekort@ah.nl";
    contact21.PhoneNumber.PhoneNumber = @"";
    contact21.Function = @"";
    contact21.ContactPersonID =  @"21";
    contact21.Gender = @"1";
    contact21.Function = @"Assistant store manager";
    
    ContactPerson *contact22 = [[ContactPerson alloc]initWithSDMDictionary:nil];
    contact22.FirstName =@"Kees";
    contact22.LastName = @"van der Wal";
    contact22.Email.LongURL = @"kees.vanderwal@ah.nl";
    contact22.PhoneNumber.PhoneNumber = @"";
    contact22.Function = @"";
    contact22.ContactPersonID =  @"22";
    contact22.Gender = @"1";
    contact22.Function = @"Franchise Owner";
    
    ContactPerson *contact23 = [[ContactPerson alloc]initWithSDMDictionary:nil];
    contact23.FirstName =@"Geraldine";
    contact23.LastName = @"Borst";
    contact23.Email.LongURL = @"Geraldine.borst@ah.nl";
    contact23.PhoneNumber.PhoneNumber = @"";
    contact23.Function = @"";
    contact23.ContactPersonID =  @"23";    
    contact23.Gender = @"2";
    contact23.Function = @"Store Manager";
    
    temp2.ContactPersons = [NSMutableArray arrayWithObjects:contact21,contact22,contact23,nil];
    
    BusinessPartner *temp3 = [[BusinessPartner alloc]initWithSDMDictionary:nil];
    temp3.BusinessPartnerID = @"3";
    temp3.BusinessPartnerType = @"Customer";
    temp3.BusinessPartnerName = @"Albert Heijn Katwijk";
    temp3.Address.Street = @"Zeilmakerstraat";
    temp3.Address.HouseNumber = @"2";
    temp3.Address.PostalCode = @"2222 AA";
    temp3.Address.City = @"Katwijk";
    temp3.Address.Country = @"The Netherlands";
    temp3.PhoneNumber.PhoneNumber = @"0714085353";
    temp3.Email.LongURL = @"info@ah.nl";
    temp3.Website.LongURL = @"http://www.ah.nl";
    temp3.Address.GeoCode.Latitude = @"52.20209";
    temp3.Address.GeoCode.Longitude = @"4.42740";
    temp3.ParentID = @"AH";
    temp3.ContactPersons = [NSMutableArray array];
    [temp  addObject:temp3];
    
    ContactPerson *contact31 = [[ContactPerson alloc]initWithSDMDictionary:nil];
    contact31.FirstName =@"Wim";
    contact31.LastName = @"Jansen";
    contact31.Email.LongURL = @"wim.jansen@ah.nl";
    contact31.PhoneNumber.PhoneNumber = @"";
    contact31.Function = @"";
    contact31.ContactPersonID =  @"31";
    contact31.Gender = @"1";
    contact31.Function = @"Purchase Employee";
    
    ContactPerson *contact32 = [[ContactPerson alloc]initWithSDMDictionary:nil];
    contact32.FirstName =@"John";
    contact32.LastName = @"Willemse";
    contact32.Email.LongURL = @"john.willemse@ah.nl";
    contact32.PhoneNumber.PhoneNumber = @"";
    contact32.Function = @"";
    contact32.ContactPersonID =  @"32";    
    contact32.Gender = @"1";
    contact32.Function = @"Store Manager";
    
    ContactPerson *contact33 = [[ContactPerson alloc]initWithSDMDictionary:nil];
    contact33.FirstName =@"Ellen";
    contact33.LastName = @"van Wijk";
    contact33.Email.LongURL = @"ellen.vanwijk@ah.nl";
    contact33.PhoneNumber.PhoneNumber = @"";
    contact33.Function = @"";
    contact33.ContactPersonID =  @"33";    
    contact33.Gender = @"2";
    contact33.Function = @"Customer service employee";
    
    temp3.ContactPersons = [NSMutableArray arrayWithObjects:contact31,contact32,contact33,nil];
    
    BusinessPartner *temp4 = [[BusinessPartner alloc]initWithSDMDictionary:nil];
    temp4.BusinessPartnerID = @"4";
    temp4.BusinessPartnerType = @"Customer";
    temp4.BusinessPartnerName = @"Albert Heijn de Bilt";
    temp4.Address.Street = @"Looydijk";
    temp4.Address.HouseNumber = @"108";
    temp4.Address.PostalCode = @"3732 VH";
    temp4.Address.City = @"De Bilt";
    temp4.Address.Country = @"The Netherlands";
    temp4.PhoneNumber.PhoneNumber = @"0302203433";
    temp4.Email.LongURL = @"info@ah.nl";
    temp4.Website.LongURL = @"http://www.ah.nl";
    temp4.Address.GeoCode.Latitude = @"52.109228";
    temp4.Address.GeoCode.Longitude = @"5.182385";
    temp4.ParentID = @"AH";
    temp4.ContactPersons = [NSMutableArray array];
    [temp  addObject:temp4];
    
    ContactPerson *contact41 = [[ContactPerson alloc]initWithSDMDictionary:nil];
    contact41.FirstName =@"Boudewijn";
    contact41.LastName = @"de Groot";
    contact41.Email.LongURL = @"boudewijn.degroot@ah.nl";
    contact41.PhoneNumber.PhoneNumber = @"";
    contact41.Function = @"";
    contact41.ContactPersonID =  @"41";    ;
    contact41.Gender = @"1";
    contact41.Function = @"Department store head";
    
    
    ContactPerson *contact42 = [[ContactPerson alloc]initWithSDMDictionary:nil];
    contact42.FirstName =@"Jan";
    contact42.LastName = @"Janssen";
    contact42.Email.LongURL = @"jan.janssen@ah.nl";
    contact42.PhoneNumber.PhoneNumber = @"";
    contact42.Function = @"";
    contact42.ContactPersonID =  @"42";
    contact42.Gender = @"1";
    contact42.Function = @"Store Manager";
    
    ContactPerson *contact43 = [[ContactPerson alloc]initWithSDMDictionary:nil];
    contact43.FirstName =@"Wil";
    contact43.LastName = @"de Boer";
    contact43.Email.LongURL = @"wil.deboer@ah.nl";
    contact43.PhoneNumber.PhoneNumber = @"";
    contact43.Function = @"";
    contact43.ContactPersonID =  @"43";    
    contact43.Gender = @"2";
    contact43.Function = @"Customer service employee";
    
    temp4.ContactPersons = [NSMutableArray arrayWithObjects:contact41,contact42,contact43,nil];
    
    BusinessPartner *temp5 = [[BusinessPartner alloc]initWithSDMDictionary:nil];
    temp5.BusinessPartnerID = @"5";
    temp5.BusinessPartnerType = @"Customer";
    temp5.BusinessPartnerName = @"Etos Godebaldkwartier";
    temp5.Address.Street = @"Godebaldkwartier";
    temp5.Address.HouseNumber = @"87";
    temp5.Address.PostalCode = @"3511 DN";
    temp5.Address.City = @"Utrecht";
    temp5.Address.Country = @"The Netherlands";
    temp5.PhoneNumber.PhoneNumber = @"0302343650";
    temp5.Email.LongURL = @"info@etos.nl";
    temp5.Website.LongURL = @"http://www.etos.nl/";
    temp5.Address.GeoCode.Latitude = @"52.08932";
    temp5.Address.GeoCode.Longitude = @"5.11292";
    temp5.ParentID = @"ETOS";
    temp5.ContactPersons = [NSMutableArray array];
    [temp  addObject:temp5];
    
    ContactPerson *contact51 = [[ContactPerson alloc]initWithSDMDictionary:nil];
    contact51.FirstName =@"Julien";
    contact51.LastName = @"Bouwman";
    contact51.Email.LongURL = @"julien.bouwman@etos.nl";
    contact51.PhoneNumber.PhoneNumber = @"";
    contact51.Function = @"";
    contact51.ContactPersonID =  @"51";    
    contact51.Gender = @"1";
    contact51.Function = @"Head cash registers";
    
    ContactPerson *contact52 = [[ContactPerson alloc]initWithSDMDictionary:nil];
    contact52.FirstName =@"Kees";
    contact52.LastName = @"van der Borst";
    contact52.Email.LongURL = @"kees.vanderborst@etos.nl";
    contact52.PhoneNumber.PhoneNumber = @"";
    contact52.Function = @"";
    contact52.ContactPersonID =  @"52";    
    contact52.Gender = @"1";
    contact52.Function = @"Store Manager";
    
    ContactPerson *contact53 = [[ContactPerson alloc]initWithSDMDictionary:nil];
    contact53.FirstName =@"Geraldine";
    contact53.LastName = @"Borst";
    contact53.Email.LongURL = @"geraldine.borst@etos.nl";
    contact53.PhoneNumber.PhoneNumber = @"";
    contact53.Function = @"";
    contact53.ContactPersonID =  @"53";    ;
    contact53.Gender = @"2";
    contact53.Function = @"Assistant store manager";
    
    temp5.ContactPersons = [NSMutableArray arrayWithObjects:contact51,contact52,contact53,nil];
 
    BusinessPartner *temp6 = [[BusinessPartner alloc]initWithSDMDictionary:nil];
    temp6.BusinessPartnerID = @"6";
    temp6.BusinessPartnerType = @"Customer";
    temp6.BusinessPartnerName = @"Etos Katwijk";
    temp6.Address.Street = @"Badstraat";
    temp6.Address.HouseNumber = @"7";
    temp6.Address.PostalCode = @"2225 BL";
    temp6.Address.City = @"Katwijk";
    temp6.Address.Country = @"The Netherlands";
    temp6.PhoneNumber.PhoneNumber = @"0714014617";
    temp6.Email.LongURL = @"info@etos.nl";
    temp6.Website.LongURL = @"http://www.etos.nl/";
    temp6.Address.GeoCode.Latitude = @"52.204318";
    temp6.Address.GeoCode.Longitude = @"4.396103";
    temp6.ParentID = @"ETOS";
    temp6.ContactPersons = [NSMutableArray array];
    [temp addObject:temp6];
    
    ContactPerson *contact61 = [[ContactPerson alloc]initWithSDMDictionary:nil];
    contact61.FirstName =@"John";
    contact61.LastName = @"Pils";
    contact61.Email.LongURL = @"john.pils@etos.nl";
    contact61.PhoneNumber.PhoneNumber = @"";
    contact61.Function = @"";
    contact61.ContactPersonID = @"61";    
    contact61.Gender = @"1";
    contact61.Function = @"Department store employee";
    
    ContactPerson *contact62 = [[ContactPerson alloc]initWithSDMDictionary:nil];
    contact62.FirstName =@"John";
    contact62.LastName = @"Reijnders";
    contact62.Email.LongURL = @"john.reijnders@etos.nl";
    contact62.PhoneNumber.PhoneNumber = @"";
    contact62.Function = @"";
    contact62.ContactPersonID =  @"62";
    contact62.Gender = @"1";
    contact62.Function = @"Office employee";
    
    ContactPerson *contact63 = [[ContactPerson alloc]initWithSDMDictionary:nil];
    contact63.FirstName =@"Ellen";
    contact63.LastName = @"van Wijk";
    contact63.Email.LongURL = @"ellen.vanwijk@etos.nl";
    contact63.PhoneNumber.PhoneNumber = @"";
    contact63.Function = @"";
    contact63.ContactPersonID = @"63";
    contact63.Gender = @"2";
    contact63.Function = @"Store manager";
    
    temp6.ContactPersons = [NSMutableArray arrayWithObjects:contact61,contact62,contact63,nil];
    
    BusinessPartner *temp7 = [[BusinessPartner alloc]initWithSDMDictionary:nil];
    temp7.BusinessPartnerID = @"7";
    temp7.BusinessPartnerType = @"Customer";
    temp7.BusinessPartnerName = @"Etos Nieuwegein";
    temp7.Address.Street = @"Winkelcentrum Galecop";
    temp7.Address.HouseNumber = @"4";
    temp7.Address.PostalCode = @"3437 JV";
    temp7.Address.City = @"Nieuwegein";
    temp7.Address.Country = @"The Netherlands";
    temp7.PhoneNumber.PhoneNumber = @"0306044711";
    temp7.Email.LongURL = @"info@etos.nl";
    temp7.Website.LongURL = @"http://www.etos.nl/";
    temp7.Address.GeoCode.Latitude = @"52.053562";
    temp7.Address.GeoCode.Longitude = @"5.082358";
    temp7.ParentID = @"ETOS";
    temp7.ContactPersons = [NSMutableArray array];
    [temp addObject:temp7];
    
    ContactPerson *contact71 = [[ContactPerson alloc]initWithSDMDictionary:nil];
    contact71.FirstName =@"Tineke";
    contact71.LastName = @"de Kleine";
    contact71.Email.LongURL = @"tineke.dekleine@etos.nl";
    contact71.PhoneNumber.PhoneNumber = @"";
    contact71.Function = @"";
    contact71.ContactPersonID = @"71";
    contact71.Gender = @"2";
    contact71.Function = @"Franchise owner";
    
    ContactPerson *contact72 = [[ContactPerson alloc]initWithSDMDictionary:nil];
    contact72.FirstName =@"Jan";
    contact72.LastName = @"Joker";
    contact72.Email.LongURL = @"jan.joker@etos.nl";
    contact72.PhoneNumber.PhoneNumber = @"";
    contact72.Function = @"";
    contact72.ContactPersonID =  @"72";
    contact72.Gender = @"1";
    contact72.Function = @"Warehouse employee";
    
    ContactPerson *contact73 = [[ContactPerson alloc]initWithSDMDictionary:nil];
    contact73.FirstName =@"Wil";
    contact73.LastName = @"van de Boer";
    contact73.Email.LongURL = @"wil.vandeboer@etos.nl";
    contact73.PhoneNumber.PhoneNumber = @"";
    contact73.Function = @"";
    contact73.ContactPersonID =  @"73";
    contact73.Gender = @"2";
    contact73.Function = @"Assistant store manager";
    
    temp7.ContactPersons = [NSMutableArray arrayWithObjects:contact71,contact72,contact73,nil];
    
    BusinessPartner *temp8 = [[BusinessPartner alloc]initWithSDMDictionary:nil];
    temp8.BusinessPartnerID = @"8";
    temp8.BusinessPartnerType = @"Customer";
    temp8.BusinessPartnerName = @"Bijenkorf Amsterdam";
    temp8.Address.Street = @"Dam";
    temp8.Address.HouseNumber = @"1";
    temp8.Address.PostalCode = @"1012 JS";
    temp8.Address.City = @"Amsterdam";
    temp8.Address.Country = @"The Netherlands";
    temp8.PhoneNumber.PhoneNumber = @"08000818";
    temp8.Email.LongURL = @"info@debijenkorf.nl";
    temp8.Website.LongURL = @"http://www.debijenkorf.nl";
    temp8.Address.GeoCode.Latitude = @"52.373269";
    temp8.Address.GeoCode.Longitude = @"4.893784";
    temp8.ParentID = @"Bijenkorf";
    temp8.ContactPersons = [NSMutableArray array];
    [temp  addObject:temp8];
    
    ContactPerson *contact81 = [[ContactPerson alloc]initWithSDMDictionary:nil];
    contact81.FirstName =@"Anouk";
    contact81.LastName = @"Janssen";
    contact81.Email.LongURL = @"anouk.janssen@debijenkorf.nl";
    contact81.PhoneNumber.PhoneNumber = @"";
    contact81.Function = @"";
    contact81.ContactPersonID =  @"81";
    contact81.Gender = @"2";
    contact81.Function = @"Store Manager";
    
    ContactPerson *contact82 = [[ContactPerson alloc]initWithSDMDictionary:nil];
    contact82.FirstName =@"Harry";
    contact82.LastName = @"Visboer";
    contact82.Email.LongURL = @"harry.visboer@debijenkorf.nl";
    contact82.PhoneNumber.PhoneNumber = @"";
    contact82.Function = @"";
    contact82.ContactPersonID =  @"82";
    contact82.Gender = @"1";
    contact82.Function = @"Assistant store manager";
    
    ContactPerson *contact83 = [[ContactPerson alloc]initWithSDMDictionary:nil];
    contact83.FirstName =@"Cas";
    contact83.LastName = @"Borst";
    contact83.Email.LongURL = @"cas.borst@debijenkorf.nl";
    contact83.PhoneNumber.PhoneNumber = @"";
    contact83.Function = @"";
    contact83.ContactPersonID =  @"83";
    contact83.Gender = @"1";
    contact83.Function = @"Department store employee";
    
    temp8.ContactPersons = [NSMutableArray arrayWithObjects:contact81,contact82,contact83,nil];
    
    BusinessPartner *temp9 = [[BusinessPartner alloc]initWithSDMDictionary:nil];
    temp9.BusinessPartnerID = @"9";
    temp9.BusinessPartnerType = @"Customer";
    temp9.BusinessPartnerName = @"de Bijenkorf Utrecht";
    temp9.Address.Street = @"Sint Jacobsstraat";
    temp9.Address.HouseNumber = @"1";
    temp9.Address.PostalCode = @"3511 BR";
    temp9.Address.City = @"Utrecht";
    temp9.Address.Country = @"The Netherlands";
    temp9.PhoneNumber.PhoneNumber = @"08000818";
    temp9.Email.LongURL = @"info@debijenkorf.nl";
    temp9.Website.LongURL = @"http://www.debijenkorf.nl";
    temp9.Address.GeoCode.Latitude = @"52.093224";
    temp9.Address.GeoCode.Longitude = @"5.114431";
    temp9.ParentID = @"Bijenkorf";
    temp9.ContactPersons = [NSMutableArray array];
    [temp  addObject:temp9];
    
    ContactPerson *contact91 = [[ContactPerson alloc]initWithSDMDictionary:nil];
    contact91.FirstName =@"Thea";
    contact91.LastName = @"van Amersfoort";
    contact91.Email.LongURL = @"thea.vanamersfoorst@debijenkorf.nl";
    contact91.PhoneNumber.PhoneNumber = @"";
    contact91.Function = @"";
    contact91.ContactPersonID = @"91";
    contact91.Gender = @"2";
    contact91.Function = @"Customer service employee";
    
    ContactPerson *contact92 = [[ContactPerson alloc]initWithSDMDictionary:nil];
    contact92.FirstName =@"John";
    contact92.LastName = @"Willemse";
    contact92.Email.LongURL = @"john.willemse@debijenkorf.nl";
    contact92.PhoneNumber.PhoneNumber = @"";
    contact92.Function = @"";
    contact92.ContactPersonID =  @"92";
    contact92.Gender = @"1";
    contact92.Function = @"Store Manager";
    
    ContactPerson *contact93 = [[ContactPerson alloc]initWithSDMDictionary:nil];
    contact93.FirstName =@"Ellen";
    contact93.LastName = @"van Doorn";
    contact93.Email.LongURL = @"ellen.vandoorn@debijenkorf.nl";
    contact93.PhoneNumber.PhoneNumber = @"";
    contact93.Function = @"";
    contact93.ContactPersonID =  @"93";
    contact93.Gender = @"2";
    contact93.Function = @"Office employee";
    
    temp9.ContactPersons = [NSMutableArray arrayWithObjects:contact91,contact92,contact93,nil];
    
    BusinessPartner *temp10 = [[BusinessPartner alloc]initWithSDMDictionary:nil];
    temp10.BusinessPartnerID = @"10";
    temp10.BusinessPartnerType = @"Customer";
    temp10.BusinessPartnerName = @"de Bijenkorf den Haag";
    temp10.Address.Street = @"Gedempte Gracht";
    temp10.Address.HouseNumber = @"28";
    temp10.Address.PostalCode = @"2512 CB";
    temp10.Address.City = @"den Haag";
    temp10.Address.Country = @"The Netherlands";
    temp10.PhoneNumber.PhoneNumber = @"09004466880";
    temp10.Email.LongURL = @"info@debijenkorf.nl";
    temp10.Website.LongURL = @"http://www.debijenkorf.nl/";
    temp10.Address.GeoCode.Latitude = @"52.07676";
    temp10.Address.GeoCode.Longitude = @"4.31449";
    temp10.ParentID = @"Bijenkorf";
    temp10.ContactPersons = [NSMutableArray array];
    [temp  addObject:temp10];
    
    ContactPerson *contact101 = [[ContactPerson alloc]initWithSDMDictionary:nil];
    contact101.FirstName =@"Willeke";
    contact101.LastName = @"van Dijk";
    contact101.Email.LongURL = @"willeke.vandijk@debijenkorf.nl";
    contact101.PhoneNumber.PhoneNumber = @"";
    contact101.Function = @"";
    contact101.ContactPersonID =  @"101";
    contact101.Gender = @"2";
    contact101.Function = @"Assistant store manager";
    
    ContactPerson *contact102 = [[ContactPerson alloc]initWithSDMDictionary:nil];
    contact102.FirstName =@"Jan";
    contact102.LastName = @"van Dijk";
    contact102.Email.LongURL = @"jan.vandijk@debijenkorf.nl";
    contact102.PhoneNumber.PhoneNumber = @"";
    contact102.Function = @"";
    contact102.ContactPersonID = @"102";
    contact102.Gender = @"1";
    contact102.Function = @"Store Manager";
    
    ContactPerson *contact103 = [[ContactPerson alloc]initWithSDMDictionary:nil];
    contact103.FirstName =@"Bea";
    contact103.LastName = @"Boer";
    contact103.Email.LongURL = @"bea.boer@debijenkorf.nl";
    contact103.PhoneNumber.PhoneNumber = @"";
    contact103.Function = @"";
    contact103.ContactPersonID = @"103";
    contact103.Gender = @"2";
    contact103.Function = @"Head department store ";
    
    temp10.ContactPersons = [NSMutableArray arrayWithObjects:contact101,contact102,contact103,nil];
    
    BusinessPartner *temp11 = [[BusinessPartner alloc]initWithSDMDictionary:nil];
    temp11.BusinessPartnerID = @"11";
    temp11.BusinessPartnerType = @"Prospect";
    temp11.BusinessPartnerName = @"C1000 Gert-Jan Snoek";
    temp11.Address.Street = @"Rapenburgerschans";
    temp11.Address.HouseNumber = @"9";
    temp11.Address.PostalCode = @"3432 TN";
    temp11.Address.City = @"Nieuwegein";
    temp11.Address.Country = @"The Netherlands";
    temp11.PhoneNumber.PhoneNumber = @"0306006010";
    temp11.Email.LongURL = @"info@c1000.nl";
    temp11.Website.LongURL = @"http://www.c1000.nl/";
    temp11.Address.GeoCode.Latitude = @"52.01838";
    temp11.Address.GeoCode.Longitude = @"5.09194";
    temp11.ContactPersons = [NSMutableArray array];
    [temp addObject:temp11];
    
    ContactPerson *contact111 = [[ContactPerson alloc]initWithSDMDictionary:nil];
    contact111.FirstName =@"Rien";
    contact111.LastName = @"van Aalst";
    contact111.Email.LongURL = @"rien.vanaalst@c1000.nl";
    contact111.PhoneNumber.PhoneNumber = @"";
    contact111.Function = @"";
    contact111.ContactPersonID =  @"111";
    contact111.Gender = @"1";
    contact111.Function = @"Store Manager";
    
    ContactPerson *contact112 = [[ContactPerson alloc]initWithSDMDictionary:nil];
    contact112.FirstName =@"Dorien";
    contact112.LastName = @"van der Stad";
    contact112.Email.LongURL = @"dorien.vanderstad@c1000.nl";
    contact112.PhoneNumber.PhoneNumber = @"";
    contact112.Function = @"";
    contact112.ContactPersonID =  @"112";
    contact112.Gender = @"2";
    contact112.Function = @"Office employee";
    
    temp11.ContactPersons = [NSMutableArray arrayWithObjects:contact111,contact112,nil];
    
    BusinessPartner *temp12 = [[BusinessPartner alloc]initWithSDMDictionary:nil];
    temp12.BusinessPartnerID = @"12";
    temp12.BusinessPartnerType = @"Prospect";
    temp12.BusinessPartnerName = @"C1000 Hoogzandveld";
    temp12.Address.Street = @"W.C. Hoogzandveld";
    temp12.Address.HouseNumber = @"2";
    temp12.Address.PostalCode = @"3434 EE";
    temp12.Address.City = @"Nieuwegein";
    temp12.Address.Country = @"The Netherlands";
    temp12.PhoneNumber.PhoneNumber = @"0306063200";
    temp12.Email.LongURL = @"info@c1000.nl";
    temp12.Website.LongURL = @"http://www.c1000.nl/";
    temp12.Address.GeoCode.Latitude = @"52.00543";
    temp12.Address.GeoCode.Longitude = @"5.08574";
    temp12.ContactPersons = [NSMutableArray array];
    [temp addObject:temp12];
    
    ContactPerson *contact121 = [[ContactPerson alloc]initWithSDMDictionary:nil];
    contact121.FirstName =@"Theo";
    contact121.LastName = @"Baas";
    contact121.Email.LongURL = @"theo.baas@c1000.nl";
    contact121.PhoneNumber.PhoneNumber = @"";
    contact121.Function = @"";
    contact121.ContactPersonID =  @"121";
    contact121.Gender = @"1";
    contact121.Function = @"Franchise Owner";
    
    ContactPerson *contact122 = [[ContactPerson alloc]initWithSDMDictionary:nil];
    contact122.FirstName =@"Aantje";
    contact122.LastName = @"Overduijn";
    contact122.Email.LongURL = @"aantje.overduijn@c1000.nl";
    contact122.PhoneNumber.PhoneNumber = @"";
    contact122.Function = @"";
    contact122.ContactPersonID =  @"122";
    contact122.Gender = @"2";
    contact122.Function = @"Customer service employee";

    
    temp12.ContactPersons = [NSMutableArray arrayWithObjects:contact121,contact122,nil];
    
    BusinessPartner *temp13 = [[BusinessPartner alloc]initWithSDMDictionary:nil];
    temp13.BusinessPartnerID = @"13";
    temp13.BusinessPartnerType = @"Competitor";
    temp13.BusinessPartnerName = @"Lidl Utrecht";
    temp13.Address.Street = @"Verlengde Houtrakgracht";
    temp13.Address.HouseNumber = @"383";
    temp13.Address.PostalCode = @"3544 EC";
    temp13.Address.City = @"Utrecht";
    temp13.Address.Country = @"The Netherlands";
    temp13.PhoneNumber.PhoneNumber = @"08005435463";
    temp13.Email.LongURL = @"info@lidl.nl";
    temp13.Website.LongURL = @"http://www.lidl.nl";
    temp13.Address.GeoCode.Latitude = @"52.08782";
    temp13.Address.GeoCode.Longitude = @"5.05511";
    temp13.ContactPersons = [NSMutableArray array];
    [temp  addObject:temp13];
    
    BusinessPartner *temp14 = [[BusinessPartner alloc]initWithSDMDictionary:nil];
    temp14.BusinessPartnerID = @"14";
    temp14.BusinessPartnerType = @"Competitor";
    temp14.BusinessPartnerName = @"Lidl Bilthoven";
    temp14.Address.Street = @"Neptunuslaan";
    temp14.Address.HouseNumber = @"13-15";
    temp14.Address.PostalCode = @"3721 LG";
    temp14.Address.City = @"Bilthoven";
    temp14.Address.Country = @"The Netherlands";
    temp14.PhoneNumber.PhoneNumber = @"0800 5435463";
    temp14.Email.LongURL = @"info@lidl.nl";
    temp14.Website.LongURL = @"http://www.lidl.nl";
    temp14.Address.GeoCode.Latitude = @"52.1111676";
    temp14.Address.GeoCode.Longitude = @"5.183731";
    temp14.ContactPersons = [NSMutableArray array];
    [temp  addObject:temp14];
    
    bupas = temp;
    
}

-(void)addBupa:(BusinessPartner*)bupa
{
    [bupas addObject:bupa];
}

-(void)addContact:(ContactPerson*)cont toBUPA:(NSString*)bupaID
{
    for (BusinessPartner *bp in bupas)
    {
        if([bp.BusinessPartnerID isEqualToString:bupaID])
            [bp.ContactPersons addObject:cont];
    }
}

-(NSMutableArray*)createNodes
{
    NSArray *temp = [[DemoData getInstance]bupas];
    
    BusinessPartnerParent *parent1 = [[BusinessPartnerParent alloc]initWithSDMDictionary:nil];
    parent1.BusinessPartnerName = @"Albert Heijn";
    parent1.BusinessPartnerParentID = @"AH";
    

    parent1.BusinessPartners = [NSMutableArray arrayWithObjects:[(BusinessPartner*)[temp objectAtIndex:0]BusinessPartnerID],[(BusinessPartner*)[temp objectAtIndex:1]BusinessPartnerID],[(BusinessPartner*)[temp objectAtIndex:2]BusinessPartnerID],[(BusinessPartner*)[temp objectAtIndex:3]BusinessPartnerID],nil];
    
    BusinessPartnerParent *parent2 = [[BusinessPartnerParent alloc]initWithSDMDictionary:nil];
    parent2.BusinessPartnerName = @"Etos";
    parent2.BusinessPartnerParentID = @"ETOS";
    parent2.BusinessPartners = [NSMutableArray arrayWithObjects:[(BusinessPartner*)[temp objectAtIndex:4]BusinessPartnerID],[(BusinessPartner*)[temp objectAtIndex:5]BusinessPartnerID],[(BusinessPartner*)[temp objectAtIndex:6]BusinessPartnerID],nil];
    
    BusinessPartnerParent *parent3 = [[BusinessPartnerParent alloc]initWithSDMDictionary:nil];
    parent3.BusinessPartnerName = @"de Bijenkorf";
    parent3.BusinessPartnerParentID = @"Bijenkorf";
    parent3.BusinessPartners = [NSMutableArray arrayWithObjects:[(BusinessPartner*)[temp objectAtIndex:7]BusinessPartnerID],[(BusinessPartner*)[temp objectAtIndex:8]BusinessPartnerID],[(BusinessPartner*)[temp objectAtIndex:9]BusinessPartnerID],nil];
    
    return [NSArray arrayWithObjects:parent1,parent2,parent3,nil];
}



@end
