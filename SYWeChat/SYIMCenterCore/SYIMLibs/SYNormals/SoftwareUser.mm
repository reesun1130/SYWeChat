/**
 * This file is part of the SYIMKit Framework.
 * (c) Ree Sun <ree.sun.cn@hotmail.com || 1507602555@qq.com>
 *
 * For more information, please view SYIMKit (https://github.com/reesun1130/SYIMKit)
 */

#import "SoftwareUser.h"
#import "SYMainHeader.h"

@implementation SoftwareUser

- (id)init
{
    if (self = [super init])
    {
        _userType = UserTypeStudent;
    }
    
    return self;
}

- (instancetype)copyWithZone:(NSZone *)zone
{
    SoftwareUser *theCopy = [[[self class] allocWithZone:zone] init];
    [theCopy setApplyTime:[self.ApplyTime copy]];
    [theCopy setClassType:[self.ClassType copy]];
    [theCopy setCreateBy:[self.CreateBy copy]];
    [theCopy setCreateOn:[self.CreateOn copy]];
    [theCopy setEndTime:[self.EndTime copy]];
    [theCopy setExaminationSchool:[self.ExaminationSchool copy]];
    [theCopy setExaminationYear:[self.ExaminationYear copy]];
    [theCopy setIsdelete:[self.Isdelete copy]];
    [theCopy setNotes:[self.Notes copy]];
    [theCopy setOriginalReceipt:[self.OriginalReceipt copy]];
    [theCopy setPayMonet:[self.PayMonet copy]];
    [theCopy setProfessional:[self.Professional copy]];
    [theCopy setProfessionalExamCourse:[self.ProfessionalExamCourse copy]];
    [theCopy setRenewReceipt:[self.RenewReceipt copy]];
    [theCopy setSId:[self.SId copy]];
    [theCopy setSex:[self.Sex copy]];
    [theCopy setStartTime:[self.StartTime copy]];
    [theCopy setStudentName:[self.StudentName copy]];
    [theCopy setStudentState:[self.StudentState copy]];
    [theCopy setTelephone:[self.Telephone copy]];
    [theCopy setTrainingDays:[self.TrainingDays copy]];
    [theCopy setTrainingSite:[self.TrainingSite copy]];
    [theCopy setUndergraduateProgram:[self.UndergraduateProgram copy]];
    [theCopy setUndergraduateSchool:[self.UndergraduateSchool copy]];
    [theCopy setUserId:[self.UserId copy]];
    [theCopy setWeixin:[self.Weixin copy]];
    [theCopy setCertificate:[self.certificate copy]];
    
    return theCopy;
}

- (instancetype)mutableCopyWithZone:(NSZone *)zone
{
    SoftwareUser *theCopy = [[[self class] allocWithZone:zone] init];  // use designated initializer
    
    [theCopy setApplyTime:[self.ApplyTime copy]];
    [theCopy setClassType:[self.ClassType copy]];
    [theCopy setCreateBy:[self.CreateBy copy]];
    [theCopy setCreateOn:[self.CreateOn copy]];
    [theCopy setEndTime:[self.EndTime copy]];
    [theCopy setExaminationSchool:[self.ExaminationSchool copy]];
    [theCopy setExaminationYear:[self.ExaminationYear copy]];
    [theCopy setIsdelete:[self.Isdelete copy]];
    [theCopy setNotes:[self.Notes copy]];
    [theCopy setOriginalReceipt:[self.OriginalReceipt copy]];
    [theCopy setPayMonet:[self.PayMonet copy]];
    [theCopy setProfessional:[self.Professional copy]];
    [theCopy setProfessionalExamCourse:[self.ProfessionalExamCourse copy]];
    [theCopy setRenewReceipt:[self.RenewReceipt copy]];
    [theCopy setSId:[self.SId copy]];
    [theCopy setSex:[self.Sex copy]];
    [theCopy setStartTime:[self.StartTime copy]];
    [theCopy setStudentName:[self.StudentName copy]];
    [theCopy setStudentState:[self.StudentState copy]];
    [theCopy setTelephone:[self.Telephone copy]];
    [theCopy setTrainingDays:[self.TrainingDays copy]];
    [theCopy setTrainingSite:[self.TrainingSite copy]];
    [theCopy setUndergraduateProgram:[self.UndergraduateProgram copy]];
    [theCopy setUndergraduateSchool:[self.UndergraduateSchool copy]];
    [theCopy setUserId:[self.UserId copy]];
    [theCopy setWeixin:[self.Weixin copy]];
    [theCopy setCertificate:[self.certificate copy]];
    
    return theCopy;
}

- (BOOL)isUserGenderNan
{
    return [self.Sex intValue] == 1;
}

- (NSString *)getUserIdNoSuffix
{
	return [[_UserId componentsSeparatedByString:@"@"] objectAtIndex:0];
}

- (NSString *)createRelateRandAudioPath
{
	return [NSString stringWithFormat:@"Audio/%@/%lu-%d.amr", self.UserId, time(NULL), arc4random()%1000];
}

- (NSString *)createRelateRandPicPath
{
	return [NSString stringWithFormat:@"Pic/%@/%lu-%d.jpg", self.UserId, time(NULL), arc4random()%1000];
}


- (NSString *)createRelatePicPath:(NSString *)name
{
	return [NSString stringWithFormat:@"Pic/%@/%lu_%@", self.UserId, time(NULL), name];
}

- (NSString *)createPcenterTopBgPicPath
{
    return [kDocumentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_topBg.jpg",self.UserId]];
}

- (NSString *)createPcenterHeaderBgPicPath
{
    return [kDocumentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_headerBg.jpg",self.UserId]];
}

@end
