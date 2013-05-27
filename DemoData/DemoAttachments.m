//
//  DemoAttachments.m
//  Sales Around
//
//  Created by IJsbrand van Rijn on 22-04-13.
//  Copyright (c) 2013 FEXS. All rights reserved.
//

#import "DemoAttachments.h"

@implementation DemoAttachments
+(NSMutableDictionary*)loadNotes
{
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    for(BusinessPartner *bp in [[DemoData getInstance]bupas])
    {
        NSMutableDictionary *notes= [NSMutableDictionary dictionary];
        if([bp.BusinessPartnerName hasPrefix:@"Albert"])
        {
            [notes setObject:@"Van 1-15 juli repen in de bonus" forKey:@"Bonus"];
            if(bp.BusinessPartnerID.integerValue == 1 )
                [notes setObject:@"Artikel codering bespreken" forKey:@"ALERT_%_Codering_%_01-01-1970"];
            if(bp.BusinessPartnerID.integerValue == 4 )
                [notes setObject:@"Oude partij terugnemen" forKey:@"ALERT_%_Retour_%_01-01-1970"];
            
        }
        else if([bp.BusinessPartnerName hasPrefix:@"Etos"])
        {
            [notes setObject:@"Vanaf 1 maart eieren in display bij kassa" forKey:@"Display eitjes"];
            if(bp.BusinessPartnerID.integerValue == 5 )
                [notes setObject:@"Moet problemen rond factuur 1802 bespreken" forKey:@"ALERT_%_Probleemfactuur_%_01-01-1970"];
            if(bp.BusinessPartnerID.integerValue == 6 )
                [notes setObject:@"Artikel codering bespreken" forKey:@"ALERT_%_Codering_%_01-01-1970"];
            if(bp.BusinessPartnerID.integerValue == 7 )
                [notes setObject:@"Oude partij terugnemen" forKey:@"ALERT_%_Retour_%_01-01-1970"];
        }
        else if([bp.BusinessPartnerName hasPrefix:@"de"])
        {
            [notes setObject:@"Paashaas klein in Magazine" forKey:@"Magazine"];
            if(bp.BusinessPartnerID.integerValue == 8 )
                [notes setObject:@"Moet problemen rond factuur 1231 bespreken" forKey:@"ALERT_%_Probleemfactuur_%_01-01-1970"];
            if(bp.BusinessPartnerID.integerValue == 9 )
                [notes setObject:@"Levertijd bespreken" forKey:@"ALERT_%_Levertijd_%_01-01-1970"];
            if(bp.BusinessPartnerID.integerValue == 10 )
                [notes setObject:@"Aanlevertijd bespreken" forKey:@"ALERT_%_Levertijd_%_01-01-1970"];
        }
        else if([bp.BusinessPartnerName hasPrefix:@"C1000"])
        {
            [notes setObject:@"Eerste gesprek met centrale inkoop positief" forKey:@"Kennismaking"];
        }
        [result setObject:notes forKey:bp.BusinessPartnerID];
    }
    return result;
}
+(NSMutableDictionary*)loadPics
{
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    NSMutableDictionary *dicBupa1 = [NSMutableDictionary dictionary];
    [dicBupa1 setObject:[UIImage imageNamed:@"Scheer Front.jpg"] forKey:@"Scheer Front"];
    [dicBupa1 setObject:[UIImage imageNamed:@"Scheer Inside.jpg"] forKey:@"Scheer Inside"];
    [dicBupa1 setObject:[UIImage imageNamed:@"Scheer Tower.jpg"] forKey:@"Scheer Tower"];
    [result setObject:dicBupa1 forKey:@"1"];
    return result;
}

+(NSMutableDictionary*)loadPassphotos
{
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    NSArray *bupas = [[DemoData getInstance]bupas];
    for(BusinessPartner *bupa in bupas)
    {
        for(ContactPerson *cp in bupa.ContactPersons)
        {
            UIImage *passphoto = [UIImage imageNamed:[NSString stringWithFormat:@"%@_%@.png",cp.LastName,cp.ContactPersonID]];
            if(passphoto)
                [result setObject:passphoto forKey:cp.ContactPersonID];
        }
    }
    return result;
}
@end
