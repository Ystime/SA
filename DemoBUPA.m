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
    temp1.BusinessPartnerName = @"Scheer Management";
    temp1.Address.Street = @"Lage Biezenweg";
    temp1.Address.HouseNumber = @"5C";
    temp1.Address.PostalCode = @"4131 LV";
    temp1.Address.City = @"Vianen";
    temp1.Address.Country = @"The Netherlands";
    temp1.PhoneNumber.PhoneNumber = @"0714071130";
    temp1.Email.URL = @"info@scheer-management.com";
    temp1.Address.GeoCode.Latitude = [NSNumber numberWithFloat:51.981230];
    temp1.Address.GeoCode.Longitude = [NSNumber numberWithFloat:5.093582];
    [temp addObject:temp1];
    
    BusinessPartner *temp2 = [[BusinessPartner alloc]initWithSDMDictionary:nil];
    temp2.BusinessPartnerID = @"2";
    temp2.BusinessPartnerType = @"Customer";
    temp2.BusinessPartnerName = @"NL4B";
    temp2.Address.Street = @"Huizermaatweg";
    temp2.Address.HouseNumber = @"30";
    temp2.Address.PostalCode = @"1276 LJ";
    temp2.Address.City = @"Huizen";
    temp2.Address.Country = @"The Netherlands";
    temp2.PhoneNumber.PhoneNumber = @"035 525 6003";
    temp2.Email.URL = @"info@nl4b.com";
    temp2.Address.GeoCode.Latitude = [NSNumber numberWithFloat:52.296871];
    temp2.Address.GeoCode.Longitude = [NSNumber numberWithFloat:5.252835];
    [temp addObject:temp2];
    
    BusinessPartner *temp3 = [[BusinessPartner alloc]initWithSDMDictionary:nil];
    temp3.BusinessPartnerID = @"3";
    temp3.BusinessPartnerType = @"Prospect";
    temp3.BusinessPartnerName = @"SAP Nederland";
    temp3.Address.Street = @"Amerikastraat";
    temp3.Address.HouseNumber = @"10";
    temp3.Address.PostalCode = @"5232 BE";
    temp3.Address.City = @"Den Bosch";
    temp3.Address.Country = @"The Netherlands";
    temp3.PhoneNumber.PhoneNumber = @"0736457500";
    temp3.Email.URL = @"info@sap.com";
    temp3.Address.GeoCode.Latitude = [NSNumber numberWithFloat:51.712427];
    temp3.Address.GeoCode.Longitude = [NSNumber numberWithFloat:5.339744];
    [temp  addObject:temp3];
    
    BusinessPartner *temp4 = [[BusinessPartner alloc]initWithSDMDictionary:nil];
    temp4.BusinessPartnerID = @"4";
    temp4.BusinessPartnerType = @"Prospect";
    temp4.BusinessPartnerName = @"Stichting ARIS - Gebruikers Nederland";
    temp4.Address.Street = @"Wilhelmina Druckerweg";
    temp4.Address.HouseNumber = @"17";
    temp4.Address.PostalCode = @"4105 EP";
    temp4.Address.City = @"Culemborg";
    temp4.Address.Country = @"The Netherlands";
    temp4.PhoneNumber.PhoneNumber = @"";
    temp4.Email.URL = @"info@arisgebruikers.nl";
    temp4.Address.GeoCode.Latitude = [NSNumber numberWithFloat:51.946419];
    temp4.Address.GeoCode.Longitude = [NSNumber numberWithFloat:5.205779];
    [temp  addObject:temp4];
    
    BusinessPartner *temp5 = [[BusinessPartner alloc]initWithSDMDictionary:nil];
    temp5.BusinessPartnerID = @"5";
    temp5.BusinessPartnerType = @"Competitor";
    temp5.BusinessPartnerName = @"e2e technologies Ltd.";
    temp5.Address.Street = @"Lautengartenstrasse";
    temp5.Address.HouseNumber = @"12";
    temp5.Address.PostalCode = @"4502";
    temp5.Address.City = @"Basel";
    temp5.Address.Country = @"Schweiz";
    temp5.PhoneNumber.PhoneNumber = @"";
    temp5.Email.URL = @"info@e2ebridge.com";
    temp5.Address.GeoCode.Latitude = [NSNumber numberWithFloat:47.552910];
    temp5.Address.GeoCode.Longitude = [NSNumber numberWithFloat:7.596393];
    [temp  addObject:temp5];
    bupas = temp;
    
    [self createDemoContacts];
}

-(void)createDemoContacts
{
    ContactPerson *contact1 = [[ContactPerson alloc]initWithSDMDictionary:nil];
    contact1.FirstName =@"Jaap";
    contact1.LastName = @"de Groot";
    contact1.Email.URL = @"j.degroot@info.nl";
    contact1.PhoneNumber.PhoneNumber = @"+31638472601";
    
    ContactPerson *contact2 = [[ContactPerson alloc]initWithSDMDictionary:nil];
    contact2.FirstName =@"Elise";
    contact2.LastName = @"de Zwart";
    contact2.Email.URL = @"e.dezwart@info.com";
    contact2.PhoneNumber.PhoneNumber = @"+31714065892";
    
    for(BusinessPartner *bp in bupas)
    {
        bp.ContactPersons = [[NSMutableArray alloc]initWithObjects:contact1,contact2, nil];
    }
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





@end
