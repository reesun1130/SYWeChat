/**
 * This file is part of the SYIMKit Framework.
 * (c) Ree Sun <ree.sun.cn@hotmail.com || 1507602555@qq.com>
 *
 * For more information, please view SYIMKit (https://github.com/reesun1130/SYIMKit)
 */

#import <SYCore/SYObjectBase.h>

//（1:学生  2:班主任  3:教研老师）
typedef NS_ENUM(NSInteger, UserType) {
    UserTypeStudent = 1,
    UserTypeBanZhuRen,
    UserTypeJiaoYanLaoShi
};

@interface SoftwareUser : SYObjectBase

@property (nonatomic, copy) NSString *ApplyTime;
@property (nonatomic, copy) NSString *ClassType;
@property (nonatomic, copy) NSString *CreateBy;
@property (nonatomic, copy) NSString *CreateOn;
@property (nonatomic, copy) NSString *EndTime;
@property (nonatomic, copy) NSString *ExaminationSchool;
@property (nonatomic, copy) NSString *ExaminationYear;
@property (nonatomic, copy) NSString *Isdelete;
@property (nonatomic, copy) NSString *Notes;
@property (nonatomic, copy) NSString *OriginalReceipt;
@property (nonatomic, copy) NSString *PayMonet;
@property (nonatomic, copy) NSString *Photo;
@property (nonatomic, copy) NSString *Professional;
@property (nonatomic, copy) NSString *ProfessionalExamCourse;
@property (nonatomic, copy) NSString *RenewReceipt;
@property (nonatomic, copy) NSString *SId;
@property (nonatomic, copy) NSString *Sex;
@property (nonatomic, copy) NSString *StartTime;
@property (nonatomic, copy) NSString *StudentName;
@property (nonatomic, copy) NSString *StudentState;
@property (nonatomic, copy) NSString *Telephone;
@property (nonatomic, copy) NSString *TrainingDays;
@property (nonatomic, copy) NSString *TrainingSite;
@property (nonatomic, copy) NSString *UndergraduateProgram;
@property (nonatomic, copy) NSString *UndergraduateSchool;
@property (nonatomic, copy) NSString *UserId;
@property (nonatomic, copy) NSString *Weixin;
@property (nonatomic, copy) NSString *certificate;

@property (nonatomic, copy) NSString *TargetProfessionalName;   // 目标院校名称
@property (nonatomic, copy) NSString *TargetProfessional1Name;  // 目标院校名称
@property (nonatomic, copy) NSString *TargetProfessional2Name;  // 目标院校名称
@property (nonatomic, copy) NSString *TargetProfessionalId;     // 专业1级
@property (nonatomic, copy) NSString *TargetProfessionalId1;    // 专业2级
@property (nonatomic, copy) NSString *TargetProfessionalId2;    // 专业3级
@property (nonatomic, copy) NSString *TargetSchoolId;
@property (nonatomic, copy) NSString *TargetSchoolName;

@property (nonatomic, assign) UserType userType;

//- (BOOL)isChatRoom;
//- (BOOL)isFrendAddCenter;
- (NSString *)getUserIdNoSuffix; //获取无后缀用户名

- (NSString *)createRelateRandAudioPath;
- (NSString *)createRelateRandPicPath;
- (NSString *)createRelatePicPath:(NSString *)name;

- (NSString *)createPcenterTopBgPicPath;
- (NSString *)createPcenterHeaderBgPicPath;

- (BOOL)isUserGenderNan;

@end
